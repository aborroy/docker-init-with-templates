# Docker Init (with templates!)

Sample implementation of generic templates for the [Docker Init](https://docs.docker.com/engine/reference/commandline/init/) command.

## Usage

Download the binary compiled for your architecture (Linux, Windows or Mac OS) from [**Releases**](https://github.com/aborroy/docker-init-with-templates/releases).

>> You may rename the binary to `fake-docker`, all the following samples are using this command name by default.

Using `-h` flag provides detail on the use of the different commands available.

**Init**

`Init` command produces Docker assets using a selected `template`.

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

**Init Catalog**

`Init Catalog` provides information relative to existing templates, reading from default inner `templates` folder or available in external `directory`

```bash
$ ./fake-docker init catalog -h
Catalog Command

Usage:
  docker init catalog [flags]

Flags:
  -d, --directory string  Local Directory containing templates to be used
  -h, --help              help for catalog
  -t, --template string   Name of the template to get details
```

## Testing default templates

Default templates are provided in project's [templates](templates) folder.

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
```

## Testing external templates

The project includes a sample for external templates definition in folder [_samples](_samples).

Use included `nginx-golang-db` template from external directory by using following flags:

```bash
$ ./fake-docker init -d _samples -t nginx-golang-db
✔ postgres
```

Docker assets will be produced by default in `output` folder:

```bash
$ tree output
output
├── README.md
├── backend
│   ├── Dockerfile
│   ├── go.mod
│   ├── go.sum
│   └── main.go
├── compose.yaml
├── db
│   └── password.txt
└── proxy
    └── nginx.conf
```

It can be tested using a regular Docker command:

```bash
$ cd output
$ docker compose up --build
```

>> Review generated `README.md` file in `output` folder for additional testing instructions.

## Creating your own template

A Docker Init template is composed by a root folder that contains a set of `.tpl` files. The name of the template is given by this root folder name.

Templates, with `.tpl` extension, can be created using [text/template](https://pkg.go.dev/text/template) format.

In addition to Docker assets, a file named `prompts.yaml` must be located in template root folder. This file includes options to be gathered from user interaction or retrieved as command line parameters.

Every option must be specified as select or prompt according following syntax.

### Select

```yaml
<id>
    label: <label>
    multiple: true | false
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

By default, `multiple` is set to `false`. If more than one option is allowed to be chosen, add the `multiple: true` node. Selected values will be stored as a single string, separated with commas.

### Prompt

```yaml
<id>
    label: <label>
    default: <value>
    password: true | false
```

For instance:

```yaml
Server:
  label: What is the name of your server?
  default: localhost
```

By default, `password` is set to `false`. If user typing should be screened as an asterisk string, add the `password: true` node.

### Conditional

The prompt is enabled only when a boolean `condition` is met. The condition can include any of the previous prompts as identifier and the expression is evaluated following [goval](https://github.com/maja42/goval) rules.

```yaml
<id>
    label: <label>
    [options | default]: ...
    condition: <value>
```

For instance:

```yaml
MessagingUser:
   label: Choose the user name for your ActiveMQ user
   condition: Messaging=="Yes" && MessagingCredentials=="Yes"
   default: admin
```

### Template Folder structure

As a sample, following folder hierarchy would be defining the template `service`:

```bash
service
├── README.md.tpl
├── compose.yaml.tpl
├── prompts.yaml
└── proxy
    └── nginx.conf.tpl
```

>> Note that `prompts.yaml` is the only file that doesn't include the template extension `.tpl`