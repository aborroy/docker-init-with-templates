package docker

import (
	"path/filepath"
	"strings"
	"text/template"

	"github.com/aborroy/docker-init-with-templates/pkg"
	"github.com/spf13/cobra"
)

// Defaults
const TemplateRootPath string = "templates"
const OutputRootPath string = "output"

// Parameters mapping
var templateName string
var templateDirectory string
var outputDirectory string
var cmdPromptValues []string

// Utility functions for expression evaluation in templates
var templateFuncs = template.FuncMap{
	"contains": strings.Contains,
}

var initCmd = &cobra.Command{
	Use:   "init",
	Short: "Init Command",
	Run: func(cmd *cobra.Command, args []string) {

		var templateRoot = TemplateRootPath
		if templateDirectory != "" {
			templateRoot = templateDirectory
		}

		var outputRoot = OutputRootPath
		if outputDirectory != "" {
			outputRoot = outputDirectory
		}

		var defaultPromptValues map[string]string = make(map[string]string)
		for _, v := range cmdPromptValues {
			prop := strings.Split(v, "=")
			defaultPromptValues[prop[0]] = prop[1]
		}
		promptValues := pkg.GetPromptValues(templateRoot, templateName, defaultPromptValues)

		templateList, err := pkg.GetTemplatesInPathHierarchy(templateRoot + "/" + templateName)
		if err != nil {
			panic(err)
		}

		for _, t := range templateList {
			f, filename, err := pkg.CreateOutputFile(outputRoot, t, templateName)
			if err != nil {
				panic(err)
			}
			name := filepath.Base(t)
			tpl := template.Must(template.New(name).Funcs(templateFuncs).ParseFiles(t))
			err = tpl.ExecuteTemplate(f, name, promptValues)
			if err != nil {
				panic(err)
			}
			err = pkg.VerifyOutputFile(filename)
			if err != nil {
				panic(err)
			}
		}

	},
}

func init() {
	rootCmd.AddCommand(initCmd)
	initCmd.Flags().StringVarP(&templateName, "template", "t", "", "Name of the template to be used")
	initCmd.Flags().StringVarP(&templateDirectory, "directory", "d", "", "Local Directory containing templates to be used")
	initCmd.Flags().StringVarP(&outputDirectory, "output", "o", "", "Local Directory to write produced files")
	initCmd.Flags().StringArrayVarP(&cmdPromptValues, "prompt", "p", nil, "Property=Value list containing prompt values")
	initCmd.MarkFlagRequired("template")
}
