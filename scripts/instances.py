#!/bin/python3
import boto3
import sys

try:
    nregion = sys.argv[1]

except:
    print ("Example: ./instances.py region")
    sys.exit(1)

endpoint_url = "http://localhost:4566"

client = boto3.client('ec2', endpoint_url=endpoint_url, region_name=nregion)
responsedx = client.describe_instances()
for v in responsedx['Reservations']:
 for printout in v['Instances']:
  for printname in printout['Tags']: 
    Filters=[
        {
            'Name': 'tag:Name'
        }
    ]
    print([printname['Value'],printout['PrivateIpAddress']])