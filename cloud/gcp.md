### update
	gcloud components update

### info
	gcloud info

### auth
	gcloud auth list
	gcloud config set account <account_email>

###  active service account
	gcloud auth activate-service-account --key-file client-secret.json
	gcloud config set project <project_name>

### deploy
	gcloud app deploy app.yaml --log-http --verbosity=debug

