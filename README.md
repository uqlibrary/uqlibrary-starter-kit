# UQLibrary Starter Kit


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
 
bin/condeship_testing.sh sets up testing configuration before deployment, it will update template.wct.conf.json to include all tests for all custom components and 
 update remote browsers list depending on which branch is being deployed.
