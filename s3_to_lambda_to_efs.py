import boto3
import os
import shutil
import time

s3 = boto3.client('s3')

# Set the EFS mount path
efs_mount_path = '/mnt/efs'

def lambda_handler(event, context):
    try:
        start_time = time.time()
        for record in event['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']

            print(f"Processing file: s3://{bucket}/{key}")

            # Download the file from S3 to the /tmp directory
            tmp_path = f'/tmp/{os.path.basename(key)}'
            s3.download_file(bucket, key, tmp_path)
            print(f"File downloaded to /tmp: {tmp_path}")

            # Ensure the EFS directory exists
            efs_dir = os.path.dirname(os.path.join(efs_mount_path, key))
            if not os.path.exists(efs_dir):
                os.makedirs(efs_dir)
                print(f"Created EFS directory: {efs_dir}")

            # Copy the file from /tmp to EFS
            destination_path = os.path.join(efs_mount_path, key)
            shutil.copy(tmp_path, destination_path)
            print(f"File copied to EFS: {destination_path}")

            elapsed_time = time.time() - start_time
            print(f"Time taken to process {key}: {elapsed_time:.2f} seconds")

    except Exception as e:
        print(f"Error: {str(e)}")

    print('File processing completed')
