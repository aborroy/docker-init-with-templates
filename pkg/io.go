package pkg

import (
	"io"
	"os"
	"path/filepath"
	"strings"
)

const TemplateExtension string = ".tpl"

func GetTemplatesInPathHierarchy(path string) ([]string, error) {
	var paths []string
	err := filepath.Walk(path, func(path string, info os.FileInfo, err error) error {
		if err != nil {
			return err
		}
		if !info.IsDir() && strings.HasSuffix(info.Name(), TemplateExtension) {
			paths = append(paths, path)
		}
		return nil
	})
	if err != nil {
		return nil, err
	}
	return paths, nil
}

func CreateOutputFile(outputRoot string, outputFile string, templateName string) (io.Writer, string, error) {
	position := strings.Index(outputFile, "/"+templateName+"/")
	outputFile = outputFile[position+len("/"+templateName+"/"):]
	os.MkdirAll(filepath.Dir(outputRoot+"/"+outputFile), os.ModePerm)
	f, err := os.Create(strings.TrimSuffix(outputRoot+"/"+outputFile, TemplateExtension))
	if err != nil {
		return nil, "", err
	}
	return f, f.Name(), nil
}

func VerifyOutputFile(filePath string) error {
	folder := filepath.Dir(filePath)
	file, err := os.Open(filePath)
	if err != nil {
		return err
	}
	stat, err := file.Stat()
	if err != nil {
		return err
	}
	if stat.Size() == 0 {
		err := os.Remove(filePath)
		if err != nil {
			return err
		}
		empty, err := IsEmpty(folder)
		if err != nil {
			return err
		}
		if empty {
			os.Remove(folder)
		}
	}
	return nil
}

func IsEmpty(name string) (bool, error) {
	f, err := os.Open(name)
	if err != nil {
		return false, err
	}
	defer f.Close()

	_, err = f.Readdirnames(1)
	if err == io.EOF {
		return true, nil
	}
	return false, err
}
