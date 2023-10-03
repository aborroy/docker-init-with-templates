package pkg

import "slices"

var Allowed = []string{".env.tpl", ".dockerignore.tpl"}

func IsAllowedHiddenFile(name string) bool {
	return slices.Contains(Allowed, name)
}
