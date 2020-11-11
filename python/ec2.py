#!/usr/bin/env python

import boto3

# credentials
ACCESS_KEY = ""
SECRET_KEY = ""


####################################################################
AMI_ID = "ami-0885b1f6bd170450c"        # ami_id region us-east-1
INSTANCE_TYPE = "t2.micro"

client = boto3.client('ec2',
    aws_access_key_id=ACCESS_KEY,
    aws_secret_access_key=SECRET_KEY,
    region_name='us-east-1'
    )

response = client.run_instances(
    ImageId=AMI_ID,
    InstanceType=INSTANCE_TYPE,
#    KeyName='string',
    MaxCount=1,
    MinCount=1,
#    Monitoring={
#        'Enabled': True|False
#    },
#    SecurityGroupIds=[
#        'string',
#    ],
    SecurityGroups=[
        'default',
    ],
#    SubnetId='string',
    UserData=open("install_script.sh").read(),
#    IamInstanceProfile={
#        'Arn': 'string',
#        'Name': 'string'
#    },
#    InstanceInitiatedShutdownBehavior='stop'|'terminate',
#    PrivateIpAddress='string',
    TagSpecifications=[
        {
            'ResourceType': 'instance',
            'Tags': [
                {
                    'Key': 'user',
                    'Value': 'boto3',
                }
            ]
        }
    ]
)

#print(response)
out = response['Instances'][0]['InstanceId']
print(out)