{{- if eq .Database "mariadb"}}
github.com/felixge/httpsnoop v1.0.1 h1:lvB5Jl89CsZtGIWuTcDM1E/vkVs49/Ml7JJe07l8SPQ=
github.com/felixge/httpsnoop v1.0.1/go.mod h1:m8KPJKqk1gH5J9DgRY2ASl2lWCfGKXixSwevea8zH2U=
github.com/go-sql-driver/mysql v1.6.0 h1:BCTh4TKNUYmOmMUcQ3IipzF5prigylS7XXjEkfCHuOE=
github.com/go-sql-driver/mysql v1.6.0/go.mod h1:DCzpHaOWr8IXmIStZouvnhqoel9Qv2LBy8hT2VhHyBg=
github.com/gorilla/handlers v1.5.1 h1:9lRY6j8DEeeBT10CvO9hGW0gmky0BprnvDI5vfhUHH4=
github.com/gorilla/handlers v1.5.1/go.mod h1:t8XrUpc4KVXb7HGyJ4/cEnwQiaxrX/hz1Zv/4g96P1Q=
github.com/gorilla/mux v1.8.0 h1:i40aqfkR1h2SlN9hojwV5ZA91wcXFOvkdNIeFDP5koI=
github.com/gorilla/mux v1.8.0/go.mod h1:DVbg23sWSpFRCP0SfiEN6jmj59UnW/n46BH5rLB71So=
{{- end}}
{{- if eq .Database "postgres"}}
github.com/gorilla/context v1.1.1 h1:AWwleXJkX/nhcU9bZSnZoi3h/qGYqQAGhq6zZe/aQW8=
github.com/gorilla/context v1.1.1/go.mod h1:kBGZzfjB9CEq2AlWe17Uuf7NDRt0dE0s8S51q0aT7Yg=
github.com/gorilla/handlers v1.3.0 h1:tsg9qP3mjt1h4Roxp+M1paRjrVBfPSOpBuVclh6YluI=
github.com/gorilla/handlers v1.3.0/go.mod h1:Qkdc/uu4tH4g6mTK6auzZ766c4CA0Ng8+o/OAirnOIQ=
github.com/gorilla/mux v1.6.2 h1:Pgr17XVTNXAk3q/r4CpKzC5xBM/qW1uVLV+IhRZpIIk=
github.com/gorilla/mux v1.6.2/go.mod h1:1lud6UwP+6orDFRuTfBEV8e9/aOM/c4fVVCaMa2zaAs=
github.com/lib/pq v1.10.3 h1:v9QZf2Sn6AmjXtQeFpdoq/eaNtYP6IN+7lcrygsIAtg=
github.com/lib/pq v1.10.3/go.mod h1:AlVN5x4E4T544tWzH6hKfbfQvm3HdbOxrmggDNAPY9o=
{{- end}}