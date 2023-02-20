import sys

from google.cloud import storage

bucket_name = sys.argv[1]
blob_name = sys.argv[2]
dest_path = sys.argv[3]

client = storage.Client()
bucket = client.get_bucket(bucket_name)
blob = bucket.blob(blob_name)

with open(dest_path + "/" + blob_name.split("/")[-1], "wb") as f:
    blob.download_to_file(f)
