package pkg

import (
	"fmt"
	"os"
	"reflect"

	"github.com/hashicorp/go-bexpr"
	"github.com/manifoldco/promptui"
	orderedmap "github.com/wk8/go-ordered-map/v2"
	"gopkg.in/yaml.v3"
)

type Prompt struct {
	Label     string   `yaml:"label"`
	Default   string   `yaml:"default"`
	Condition string   `yaml:"condition"`
	Options   []string `yaml:"options"`
}

func PromptGetSelect(prompt Prompt) string {
	index := -1
	var result string
	var err error

	for index < 0 {
		p := promptui.Select{
			Label:    prompt.Label,
			Items:    prompt.Options,
			HideHelp: true,
		}

		index, result, err = p.Run()

		if index == -1 {
			prompt.Options = append(prompt.Options, result)
		}
	}

	if err != nil {
		fmt.Printf("Prompt failed %v\n", err)
		os.Exit(1)
	}

	return result
}

func PromptGetInput(prompt Prompt) string {
	p := promptui.Prompt{
		Label:   prompt.Label,
		Default: prompt.Default,
	}

	result, err := p.Run()

	if err != nil {
		fmt.Printf("Prompt failed %v\n", err)
		os.Exit(1)
	}

	return result
}

func mapToStruct(m map[string]interface{}) reflect.Value {
	var structFields []reflect.StructField
	for k, v := range m {
		sf := reflect.StructField{
			Name: k,
			Type: reflect.TypeOf(v),
		}
		structFields = append(structFields, sf)
	}
	structType := reflect.StructOf(structFields)
	return reflect.New(structType)
}

func setStructValues(sr reflect.Value, m map[string]interface{}) {
	for k, v := range m {
		sr.Elem().FieldByName(k).SetString(fmt.Sprintf("%v", v))
	}
}

func IsPromptVisible(expression string, values map[string]interface{}) bool {
	var visible bool = true
	if expression != "" {
		eval, err := bexpr.CreateEvaluator(expression)
		if err != nil {
			fmt.Printf("Failed to create evaluator for expression %q: %v\n", expression, err)
			return false
		}
		visible, err = eval.Evaluate(values)
		if err != nil {
			fmt.Printf("Failed to run evaluation of expression %q: %v\n", expression, err)
			return false
		}
	}
	return visible
}

func GetPromptValues(templateRootPath string, template string, cmdPromptValues map[string]string) reflect.Value {

	file, err := os.ReadFile(templateRootPath + "/" + template + "/prompts.yaml")
	if err != nil {
		panic(err)
	}

	data := orderedmap.New[string, Prompt]()
	if err := yaml.Unmarshal(file, &data); err != nil {
		panic(err)
	}

	m := make(map[string]interface{})
	for pair := data.Oldest(); pair != nil; pair = pair.Next() {
		if cmdPromptValues[pair.Key] != "" {
			m[pair.Key] = cmdPromptValues[pair.Key]
		} else {
			var result string
			visible := IsPromptVisible(pair.Value.Condition, m)
			if visible {
				if pair.Value.Options != nil {
					result = PromptGetSelect(pair.Value)
				} else {
					result = PromptGetInput(pair.Value)
				}
				m[pair.Key] = result
			}
		}
	}

	promptValues := mapToStruct(m)
	setStructValues(promptValues, m)
	return promptValues
}
