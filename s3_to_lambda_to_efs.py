import boto3
import os
import time

s3_client = boto3.client('s3')
efs_client = boto3.client('efs')

def get_filesystem_id(efs_mount_path):
    efs = boto3.client('efs')
    
    # Split the mount path to extract the file system ID
    parts = efs_mount_path.split('/')
    file_system_id = parts[2]
    
    # Verify the file system ID
    try:
        response = efs.describe_file_systems(FileSystemId=file_system_id)
        if response['FileSystems']:
            return file_system_id
        else:
            raise ValueError(f"File system {file_system_id} not found")
    except Exception as e:
        print(f"Error getting file system ID: {str(e)}")
        raise

def lambda_handler(event, context):
    try:
        start_time = time.time()
        for record in event['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']

            print(f"Processing file: s3://{bucket}/{key}")

            # Get EFS file path
            destination_path = os.path.join('/mnt/efs', key)

            # Directly upload file from S3 to EFS using EFS API
            with open(f's3://{bucket}/{key}', 'rb') as s3_file:
                efs_client.put_object(
                    FileSystemId=get_filesystem_id('/mnt/efs'),
                    Body=s3_file,
                    Key=key
                )
            print(f"File copied to EFS: {destination_path}")

            # Calculate elapsed time
            elapsed_time = time.time() - start_time
            print(f"Time taken to process {key}: {elapsed_time:.2f} seconds")

    except Exception as e:
        # Log the error with details (consider using CloudWatch Logs)
        print(f"Error processing file: {str(e)}")

    print('File processing completed')
