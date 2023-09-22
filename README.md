# Docker Init (with templates!)

Sample implementation of generic templates for the [Docker Init](https://docs.docker.com/engine/reference/commandline/init/) command.

## Usage

Download the binary compiled for your architecture (Linux, Windows or Mac OS) from [**Releases**](https://github.com/aborroy/docker-init-with-templates/releases).

>> You may rename the binary to `fake-docker`, all the following samples are using this command name by default.

Using `-h` flag provides detail on the use of the different commands available:

```bash
$ ./fake-docker init -h
Init Command

Usage:
  docker init [flags]
  docker init [command]

Available Commands:
  catalog     Catalog Command

Flags:
  -d, --directory string     Local Directory containing templates to be used
  -h, --help                 help for init
  -o, --output string        Local Directory to write produced files
  -p, --prompt stringArray   Property=Value list containing prompt values
  -t, --template string      Name of the template to be used

Use "docker init [command] --help" for more information about a command.
```

```bash
$ ./fake-docker init catalog -h
Catalog Command

Usage:
  docker init catalog [flags]

Flags:
  -h, --help              help for catalog
  -t, --template string   Name of the template to get details
```

## Testing sample template

Use included `alfresco` template by using the `-t` flag:

```bash
$ ./fake-docker init -t alfresco
✔ 7.4
✔ postgres
✔ Yes
✔ Yes
✔ None
What is the name of your server?: localhost
```

Docker assets will be produced by default in `output` folder:

```bash
$ tree output
output
├── README.md
├── compose.yaml
├── db
│   └── compose.yaml
├── legacy-ui
│   └── compose.yaml
├── messaging
│   └── compose.yaml
├── proxy
│   └── compose.yaml
├── repo
│   └── compose.yaml
├── search
│   └── compose.yaml
├── transform
│   └── compose.yaml
└── ui
    └── compose.yaml
```

Alfresco can be tested using a regular Docker command:

```bash
$ cd output
$ docker compose up
````

## Creating your own template

Templates can be created using [text/template](https://pkg.go.dev/text/template) format.

In addition to Docker assets, a file named `prompts.yaml` must be located in template root folder. This file includes options to be gathered from user interaction or retrieved as command line parameters.

Every option must be specified as select or prompt according following syntax.

### Select

```yaml
<id>
    label: <label>
    options:
      - <option1>
      - ...
      - <optionN>
```

For instance:

```yaml
Volumes:
  label: Which container volume method do you want to use?
  options:
    - None
    - Native
    - Bind
```

### Prompt

```yaml
<id>
    label: <label>
    default: <value>
```

For instance:

```yaml
Server:
  label: What is the name of your server?
  default: localhost
```