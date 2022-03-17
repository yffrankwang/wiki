## install

### ubuntu
> curl https://cli-assets.heroku.com/install-ubuntu.sh | sh

### Login
> heroku login

### Init
> git init
> heroku git:remote -a APP

### Clone
> heroku git:clone -a APP

### Deploy
> git push heroku master

### Stack
> heroku stack
> heroku stack:set heroku-18

### Open
> heroku open

### List Apps
> heroku apps

### Set default apps
> export HEROKU_APP=appname

### Run bash
> heroku run bash -a APP

### Remove cache
> heroku plugins:install https://github.com/heroku/heroku-repo.git
> heroku repo:purge_cache -a APP

### Restart
> heroku restart -a APP

### Logging
https://devcenter.heroku.com/articles/logging

> heroku logs -a APP
> heroku logs -a APP -n 200
> heroku logs -a APP --tail

### PostgreSQL
https://devcenter.heroku.com/articles/heroku-postgresql#using-the-cli

> heroku pg:info
> heroku pg:psql

### WebRunner
https://devcenter.heroku.com/articles/java-webapp-runner

### Config Environment Var
https://devcenter.heroku.com/articles/config-vars

> heroku config
> heroku config:get GITHUB_USERNAME
> heroku config:set GITHUB_USERNAME=joesmith
> heroku config:unset GITHUB_USERNAME

