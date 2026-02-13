#!/bin/bash

###############################################################################
# Author: Abhishek Veeramalla
# Version: v0.0.1

# Script to automate the process of listing all the resources in an AWS account
#
# Below are the services that are supported by this script:
# 1. EC2
# 2. RDS
# 3. S3
# 4. CloudFront
# 5. VPC
# 6. IAM
# 7. Route53
# 8. CloudWatch
# 9. CloudFormation
# 10. Lambda
# 11. SNS
# 12. SQS
# 13. DynamoDB
# 14. VPC
# 15. EBS
#
# The script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
#
# Usage: ./aws_resource_list.sh  <aws_region> <aws_service>
# Example: ./aws_resource_list.sh us-east-1 ec2
#############################################################################


# Check if the required number of arguments are passed
if [ $# -ne 2 ]; then
    echo "Usage: ./aws_resource_list.sh  <aws_region> <aws_service>"
    echo "Example: ./aws_resource_list.sh us-east-1 ec2"
=======
# Usage: ./aws_resource_list_test.sh <region> <service_name>
# Example: ./aws_resource_list_test.sh us-east-1 EC2
# To modify the services, edit the GLOBAL_SERVICES and REGIONAL_SERVICES arrays below
###############################################################################################

# check if the correct number of arguments are passed
if [ "$#" -ne 2 ]; then
    echo "Usage: ./aws_resource_list_test.sh <region> <service_name>"
>>>>>>> 7b40a34 (changed small errors in the scripting)
    exit 1
fi

# Assign the arguments to variables and convert the service to lowercase
aws_region=$1
aws_service=(echo "$2" | tr '[:upper:]' '[:lower:]')

# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install the AWS CLI and try again."
    exit 1
fi

<<<<<<< HEAD
# Check if the AWS CLI is configured
=======
#Assign the arguments to variables and convert the service to lowercase
region=$1
service_name=$2

# Check if the aws cli is configured
>>>>>>> 7b40a34 (changed small errors in the scripting)
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure the AWS CLI and try again."
    exit 1
fi

<<<<<<< HEAD
# List the resources based on the service
case $aws_service in
    ec2)
        echo "Listing EC2 Instances in $aws_region"
        aws ec2 describe-instances --region $aws_region
        ;;
    rds)
        echo "Listing RDS Instances in $aws_region"
        aws rds describe-db-instances --region $aws_region
        ;;
    s3)
        echo "Listing S3 Buckets in $aws_region"
        aws s3api list-buckets --region $aws_region
        ;;
    cloudfront)
        echo "Listing CloudFront Distributions in $aws_region"
        aws cloudfront list-distributions --region $aws_region
        ;;
    vpc)
        echo "Listing VPCs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region
        ;;
    iam)
        echo "Listing IAM Users in $aws_region"
        aws iam list-users --region $aws_region
        ;;
    route53)
        echo "Listing Route53 Hosted Zones in $aws_region"
        aws route53 list-hosted-zones --region $aws_region
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarms in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region
        ;;
    cloudformation)
        echo "Listing CloudFormation Stacks in $aws_region"
        aws cloudformation describe-stacks --region $aws_region
        ;;
    lambda)
        echo "Listing Lambda Functions in $aws_region"
        aws lambda list-functions --region $aws_region
        ;;
    sns)
        echo "Listing SNS Topics in $aws_region"
        aws sns list-topics --region $aws_region
        ;;
    sqs)
        echo "Listing SQS Queues in $aws_region"
        aws sqs list-queues --region $aws_region
        ;;
    dynamodb)
        echo "Listing DynamoDB Tables in $aws_region"
        aws dynamodb list-tables --region $aws_region
        ;;
    ebs)
        echo "Listing EBS Volumes in $aws_region"
        aws ec2 describe-volumes --region $aws_region
=======
# Execute cli command based on the service name
case $service_name in
    "EC2")
        aws ec2 describe-instances --region $region --query 'Reservations[*].Instances[*].InstanceId' --output table
        ;;
    "DynamoDB")
        aws dynamodb list-tables --region $region --output table
        ;;
    "Lambda")
        aws lambda list-functions --region $region --query 'Functions[*].FunctionName' --output table
        ;;
    "RDS")
        aws rds describe-db-instances --region $region --query 'DBInstances[*].DBInstanceIdentifier' --output table
        ;;
    "EBS")
        aws ec2 describe-volumes --region $region --query 'Volumes[*].VolumeId' --output table
        ;;
    "CloudWatch")
        aws cloudwatch list-metrics --region $region --query 'Metrics[*].Namespace' --output table
        ;;
    "SNS")
        aws sns list-topics --region $region --query 'Topics[*].TopicArn' --output table
        ;;
    "SQS")
        aws sqs list-queues --region $region --query 'QueueUrls[*]' --output table
        ;;
    "VPC")
        aws ec2 describe-vpcs --region $region --query 'Vpcs[*].VpcId' --output table
        ;;
    "CloudFormation")
        aws cloudformation list-stacks --region $region --query 'StackSummaries[*].StackName' --output table
>>>>>>> 7b40a34 (changed small errors in the scripting)
        ;;
    *)
        echo "Invalid service. Please enter a valid service."
        exit 1
<<<<<<< HEAD
        ;;
=======
>>>>>>> 7b40a34 (changed small errors in the scripting)
esac
