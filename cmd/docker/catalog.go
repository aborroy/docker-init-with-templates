package docker

import (
	"fmt"
	"io/fs"
	"log"
	"os"

	"github.com/aborroy/docker-init-with-templates/pkg"
	"github.com/spf13/cobra"
)

var catalogCmd = &cobra.Command{
	Use:   "catalog",
	Short: "Catalog Command",
	Run: func(cmd *cobra.Command, args []string) {

		if templateName == "" {
			files, err := fs.ReadDir(TemplateFs, TemplateRootPath)
			if err != nil {
				log.Fatal(err)
			}
			for _, f := range files {
				if !pkg.IsHidden(f.Name()) {
					fmt.Println(f.Name())
				}
			}
			if templateDirectory != "" {
				files, err := os.ReadDir(templateDirectory)
				if err != nil {
					log.Fatal(err)
				}
				for _, f := range files {
					if !pkg.IsHidden(f.Name()) {
						fmt.Println(f.Name())
					}
				}
			}
		} else {
			body, err := fs.ReadFile(TemplateFs, TemplateRootPath+"/"+templateName+"/prompts.yaml")
			if err != nil {
				if templateDirectory == "" {
					log.Fatalf("unable to read file: %v", err)
				} else {
					body, err = os.ReadFile(templateDirectory + "/" + templateName + "/prompts.yaml")
					if err != nil {
						log.Fatalf("unable to read file: %v", err)
					}
				}

			}
			fmt.Println(string(body))
		}

	},
}

func init() {
	initCmd.AddCommand(catalogCmd)
	catalogCmd.Flags().StringVarP(&templateName, "template", "t", "", "Name of the template to get details")
	catalogCmd.Flags().StringVarP(&templateDirectory, "directory", "d", "", "Local Directory containing templates to be used")
}
