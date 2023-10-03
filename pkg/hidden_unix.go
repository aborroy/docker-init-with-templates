//go:build !windows
// +build !windows

package pkg

const dotCharacter = 46

func IsHidden(path string) bool {
	return path[0] == dotCharacter && !IsAllowedHiddenFile(path)
}
