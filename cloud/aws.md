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
