import boto3
import os
import time
import tempfile
import shutil
from botocore.exceptions import ClientError

s3_client = boto3.client('s3')

def lambda_handler(event, context):
    try:
        start_time = time.time()
        for record in event['Records']:
            bucket = record['s3']['bucket']['name']
            key = record['s3']['object']['key']

            print(f"Processing file: s3://{bucket}/{key}")

            # Get EFS file path
            destination_path = os.path.join('/mnt/efs', key)

            try:
                # Check if the S3 object exists
                s3_client.head_object(Bucket=bucket, Key=key)

                # Download S3 object to a temporary file
                with tempfile.NamedTemporaryFile(delete=False) as temp_file:
                    s3_client.download_file(bucket, key, temp_file.name)

                    # Create the destination directory if it does not exist
                    os.makedirs(os.path.dirname(destination_path), exist_ok=True)

                    # Copy the temporary file to the EFS mount
                    shutil.copy2(temp_file.name, destination_path)
                    print(f"File copied to EFS: {destination_path}")

                    # Clean up the temporary file
                    os.remove(temp_file.name)

            except ClientError as e:
                if e.response['Error']['Code'] == '404' or e.response['Error']['Code'] == 'NoSuchKey':
                    print(f"File not found: s3://{bucket}/{key}")
                elif e.response['Error']['Code'] == 'AccessDenied':
                    print(f"Access denied for file: s3://{bucket}/{key}")
                else:
                    print(f"Error processing file: s3://{bucket}/{key}, Error: {str(e)}")
                    raise e
            except Exception as e:
                print(f"Error copying file to EFS: {str(e)}")
                raise e

            # Calculate elapsed time
            elapsed_time = time.time() - start_time
            print(f"Time taken to process {key}: {elapsed_time:.2f} seconds")

    except Exception as e:
        # Log the error with details (consider using CloudWatch Logs)
        print(f"Error processing file: {str(e)}")

    print('File processing completed')
