package pkg

import (
	"fmt"
	"io/fs"
	"os"
	"reflect"
	"strings"

	"github.com/AlecAivazis/survey/v2"
	"github.com/maja42/goval"
	orderedmap "github.com/wk8/go-ordered-map/v2"
	"gopkg.in/yaml.v3"
)

type Prompt struct {
	Label     string   `yaml:"label"`
	Default   string   `yaml:"default"`
	Condition string   `yaml:"condition"`
	Multiple  bool     `yaml:"multiple"`
	Password  bool     `yaml:"password"`
	Options   []string `yaml:"options"`
}

func PromptGetSelect(prompt Prompt) string {
	var result string
	p := &survey.Select{
		Message: prompt.Label,
		Options: prompt.Options,
	}
	survey.AskOne(p, &result)
	return result
}

func PromptGetInput(prompt Prompt) string {
	var result string
	var p survey.Prompt
	if prompt.Password {
		p = &survey.Password{
			Message: prompt.Label,
		}

	} else {
		p = &survey.Input{
			Message: prompt.Label,
			Default: prompt.Default,
		}
	}
	survey.AskOne(p, &result)
	if prompt.Password && result == "" {
		result = prompt.Default
	}
	return result
}

func PromptGetMultiSelect(prompt Prompt) string {
	res := []string{}
	p := &survey.MultiSelect{
		Message: prompt.Label,
		Options: prompt.Options,
	}
	survey.AskOne(p, &res)
	return strings.Join(res, ",")
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
		evaluator := goval.NewEvaluator()
		result, err := evaluator.Evaluate(expression, values, nil)
		if err != nil {
			fmt.Printf("Failed to create evaluator for expression %q: %v\n", expression, err)
			return false
		}
		if reflect.TypeOf(result).Kind() != reflect.Bool {
			fmt.Printf("Expecting boolean result for expression %q, but found %s", expression, reflect.TypeOf(result))
			return false
		} else {
			return reflect.ValueOf(result).Interface().(bool)
		}
	}
	return visible
}

func GetPromptValues(templateRootPath string, template string, cmdPromptValues map[string]string) reflect.Value {

	// Read prompt file from embed FS or external FS
	file, err := fs.ReadFile(TemplateFs, templateRootPath+"/"+template+"/prompts.yaml")
	if err != nil {
		file, err = os.ReadFile(templateRootPath + "/" + template + "/prompts.yaml")
		if err != nil {
			panic(err)
		}
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
					if pair.Value.Multiple {
						result = PromptGetMultiSelect(pair.Value)
					} else {
						result = PromptGetSelect(pair.Value)
					}
				} else {
					result = PromptGetInput(pair.Value)
				}
				m[pair.Key] = result
			} else {
				if pair.Value.Default != "" {
					m[pair.Key] = pair.Value.Default
				}
			}
		}
	}

	promptValues := mapToStruct(m)
	setStructValues(promptValues, m)
	return promptValues
}
