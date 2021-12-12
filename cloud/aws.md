### upload certificate from cloudfront
	aws iam upload-server-certificate --server-certificate-name xxx.cloudfront --certificate-body file://xxx.server.cer  --private-key file://xxx.key --certificate-chain file://xxx.chain.cer --path /cloudfront/test/

### S3 IAM Policy
	{
		"Version": "2012-10-17",
		"Statement": [
			{
				"Action": ["s3:ListAllMyBuckets", "s3:GetBucketLocation"],
				"Effect": "Allow",
				"Resource": "arn:aws:s3:::*"
			},
			{
				"Effect": "Allow",
				"Action": [
					"s3:*"
				],
				"Resource": [
					"arn:aws:s3:::<bucket name>",
					"arn:aws:s3:::<bucket name>/*"
				]
			}
		]
	}

## new ssh user

	sudo adduser new_user --disabled-password
	sudo usermod -a -G wheel new_user
	sudo su - new_user
	mkdir .ssh
	chmod 700 .ssh
	cd .ssh
	ssh-keygen -t rsa -m PEM -b 2048
	mv id_rsa.pub authorized_keys
	chmod 600 authorized_keys

download .ssh/id_rsa and save it to private-key.pem

