# Cloud Foundry Keycloak Buildpack *forked from* Cloud Foundry Java Buildpack

The `keycloak-buildpack` is a [Cloud Foundry][] buildpack for running Keycloak standalone server.  

## Usage
To use this buildpack specify the URI of the repository when pushing an application to Cloud Foundry:

```bash
$ cf push <APP-NAME> -p <ARTIFACT> -b https://github.com/kirmerzlikin/keycloak-buildpack
```

## Implementation Info
Main functionality is placed in the [lib/java_buildpack/container/keycloak.rb](https://github.com/kirmerzlikin/keycloak-buildpack/blob/master/lib/java_buildpack/container/keycloak.rb)
 
## License
This buildpack is released under version 2.0 of the [Apache License][].

[Apache License]: http://www.apache.org/licenses/LICENSE-2.0
[Cloud Foundry]: http://www.cloudfoundry.org