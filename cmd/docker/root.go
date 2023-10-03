package docker

import (
	"embed"
	"fmt"
	"os"

	"github.com/spf13/cobra"
)

var TemplateFs embed.FS

var rootCmd = &cobra.Command{
	Use:   "docker",
	Short: "docker - a fake CLI to support Init command extension",
	Run: func(cmd *cobra.Command, args []string) {
	},
}

func Execute() {
	if err := rootCmd.Execute(); err != nil {
		fmt.Fprintf(os.Stderr, "Whoops. There was an error while executing your CLI '%s'", err)
		os.Exit(1)
	}
}
