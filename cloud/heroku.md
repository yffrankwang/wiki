### Login
> heroku login

### Init
> git init
> heroku git:remote -a APP

### Clone
> heroku git:clone -a APP

### Deploy
> git push heroku master

### Open
> heroku open

### List Apps
> heroku apps

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
