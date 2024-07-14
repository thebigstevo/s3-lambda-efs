import boto3
import os
import tempfile
import shutil

s3_client = boto3.client('s3')
efs_client = boto3.client('efs')

def lambda_handler(event, context):
    try:
        for record in event['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']

            print(f"Processing file: s3://{bucket}/{key}")

            # Download S3 object to a temporary file
            with tempfile.NamedTemporaryFile(delete=False) as temp_file:
                s3_client.download_file(bucket, key, temp_file.name)

                # Copy the file to EFS
                destination_path = os.path.join('/mnt/efs', key)
                shutil.copy2(temp_file.name, destination_path)
                print(f"File copied to EFS: {destination_path}")

                # Clean up the temporary file
                os.remove(temp_file.name)

    except Exception as e:
        print(f"Error processing file: {str(e)}")
        raise

    print('File processing completed')
