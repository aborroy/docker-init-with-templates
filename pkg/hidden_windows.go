//go:build windows
// +build windows

package pkg

import (
	"log"
	"path/filepath"
	"syscall"
)

const dotCharacter = 46

func IsHidden(path string) bool {
	if path[0] == dotCharacter {
		return true
	}

	absPath, err := filepath.Abs(path)
	if err != nil {
		log.Fatal(err)
	}

	pointer, err := syscall.UTF16PtrFromString(`\\?\` + absPath)
	if err != nil {
		log.Fatal(err)
	}

	attributes, err := syscall.GetFileAttributes(pointer)
	if err != nil {
		log.Fatal(err)
	}

	return attributes&syscall.FILE_ATTRIBUTE_HIDDEN != 0
}
