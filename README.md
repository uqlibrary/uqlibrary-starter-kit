# UQLibrary Starter Kit

experimental application template forked from https://github.com/PolymerElements/polymer-starter-kit

## Getting started

Please, read getting started guide for https://github.com/PolymerElements/polymer-starter-kit

## Styling

Coming soon...

## Development

Coming soon...

## Testing

### Local testing 

Follow instructions from https://github.com/Polymer/web-component-tester
Default testing configuration is set in wct.conf.json
Testing of application runs with vulcanized version of elements, run gulp default command first.

```shell
# will generate dist folder with ready to deploy/vulcanized files
gulp

# run tests on local browsers
gulp test:local

# run tests on sauce
gulp test:remote
```

### Deployment testing
 
Automated tests are triggered during deployment. Script bin/codeship_testing.sh sets up testing configuration before deployment, it updates template.wct.conf.json to include all tests for all custom components and 
 updates remote browsers list depending on which branch is being deployed.


## Deployment

Each app is deployed using codeship.io. The script bin/codeship.sh is run on codeship.io to update aws configuration, then gulp tasks run to build and publish app to AWS S3.

Codeship builds are triggered automatically on every push to GitHub.

Each branch is monitored and deploys to a separate subdirectory with that branch name, eg /v1/staging/app, /v1/uat/app. 
Except for production which goes directly into the /v1/ directory e.g. /v1/app.
 