from pathlib import Path

import boto3

'''
Empty S3 bucket

This script expects the bucket name to be in the vars.tfvars file 
in the terraform directory in the following format:

<tfvar_key> = "<bucket_name>"
'''

def main():
    tfvar_key = 's3_staging_bucket_name'
    tfvar_file_path = Path.cwd() / 'terraform' / 'vars.tfvars'

    with open(tfvar_file_path, 'r') as f:
        contents = f.readlines()

    bucket_name = None
    for line in contents:
        if line.startswith(tfvar_key):
            bucket_name = line.split('=')[1].strip().replace('"','')

    if bucket_name is None:
        raise Exception(f'Bucket name not found in {tfvar_file_path}.')

    print(f'Emptying the bucket {bucket_name}...')

    s3 = boto3.resource('s3')
    bucket = s3.Bucket(bucket_name)
    bucket.object_versions.delete()

    # bucket.delete()

if __name__ == '__main__':
    main()