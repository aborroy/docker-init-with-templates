package main

import (
	"embed"

	"github.com/aborroy/docker-init-with-templates/cmd/docker"
	"github.com/aborroy/docker-init-with-templates/pkg"
)

//go:embed all:templates
var templateFs embed.FS

func main() {
	pkg.TemplateFs = templateFs
	docker.TemplateFs = templateFs
	docker.Execute()
}
