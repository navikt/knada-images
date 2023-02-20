import sys
import os
import boto3
from dataverk_vault import api as vault_api

vault_api.set_secrets_as_envs()

bucket_name = sys.argv[1]
blob_name = sys.argv[2]
dest_path = sys.argv[3]

s3 = boto3.resource(
    service_name='s3',
    aws_access_key_id=os.environ["S3_ACCESS_KEY"],
    aws_secret_access_key=os.environ["S3_SECRET_KEY"],
    verify=os.getenv('REQUESTS_CA_BUNDLE'),
    endpoint_url=os.environ["S3_HOST"]
)

s3.meta.client.download_file(bucket_name, blob_name, dest_path + "/" + blob_name.split("/")[-1])
