#!/bin/bash

# This script will list all the resources in the AWS account
# Author: Jabeed
# Version: v0.0.1
#
# Following are the supported AWS services by the script
# 1. EC2
# 2. S3
# 3. RDS
# 4. DynamoDB
# 5. Lambda
# 6. EBS
# 7. CloudFront
# 8. CloudWatch
# 9. SNS
# 10. SQS
# 11. VPC
# 12. Route53
# 13. CloudFormation
# 14. IAM

# Usage: ./aws_resource_list_test.sh <region> <service_name>
# Example: ./aws_resource_list_test.sh us-east-1 EC2
# To modify the services, edit the GLOBAL_SERVICES and REGIONAL_SERVICES arrays below
###############################################################################################

# check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <region> <service_name>"
    exit 1
fi

#Check if aws cli is installed
if ! command -v aws &> /dev/null
then
    echo "aws cli could not be found. Please install aws cli to run this script."
    exit
fi

# Check if the aws cli is configured
if [ ! -d ~/.aws ]; then
    echo "aws cli is not configured. Please configure aws cli to run this script."
    exit 1
fi

# Execute cli command based on the service name
case $2 in
    "EC2")
        aws ec2 describe-instances --region $1 --query 'Reservations[*].Instances[*].InstanceId' --output table
        ;;
    "DynamoDB")
        aws dynamodb list-tables --region $1 --output table
        ;;
    "Lambda")
        aws lambda list-functions --region $1 --query 'Functions[*].FunctionName' --output table
        ;;
    "RDS")
        aws rds describe-db-instances --region $1 --query 'DBInstances[*].DBInstanceIdentifier' --output table
        ;;
    "EBS")
        aws ec2 describe-volumes --region $1 --query 'Volumes[*].VolumeId' --output table
        ;;
    "CloudWatch")
        aws cloudwatch list-metrics --region $1 --query 'Metrics[*].Namespace' --output table
        ;;
    "SNS")
        aws sns list-topics --region $1 --query 'Topics[*].TopicArn' --output table
        ;;
    "SQS")
        aws sqs list-queues --region $1 --query 'QueueUrls[*]' --output table
        ;;
    "VPC")
        aws ec2 describe-vpcs --region $1 --query 'Vpcs[*].VpcId' --output table
        ;;
    "CloudFormation")
        aws cloudformation list-stacks --region $1 --query 'StackSummaries[*].StackName' --output table
        ;;
    *)
        echo "Service not supported. Please choose from the following services: EC2, DynamoDB, Lambda, RDS, EBS, CloudWatch, SNS, SQS, VPC, CloudFormation"
        exit 1
esac