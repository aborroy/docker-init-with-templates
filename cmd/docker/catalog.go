package docker

import (
	"fmt"
	"log"
	"os"

	"github.com/spf13/cobra"
)

var catalogCmd = &cobra.Command{
	Use:   "catalog",
	Short: "Catalog Command",
	Run: func(cmd *cobra.Command, args []string) {

		if templateName == "" {
			files, err := os.ReadDir("templates")
			if err != nil {
				log.Fatal(err)
			}
			for _, f := range files {
				fmt.Println(f.Name())
			}
		} else {
			body, err := os.ReadFile("templates/" + templateName + "/prompts.yaml")
			if err != nil {
				log.Fatalf("unable to read file: %v", err)
			}
			fmt.Println(string(body))
		}

	},
}

func init() {
	initCmd.AddCommand(catalogCmd)
	catalogCmd.Flags().StringVarP(&templateName, "template", "t", "", "Name of the template to get details")
}
