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
# 14. EBS
#
# The script will prompt the user to enter the AWS region and the service for which the resources need to be listed.
#
# Usage: ./aws_resource_list.sh
# The script will prompt for the AWS region and service.
#############################################################################

# Check if the AWS CLI is installed
if ! command -v aws &> /dev/null; then
    echo "AWS CLI is not installed. Please install the AWS CLI and try again."
    exit 1
fi

# Check if the AWS CLI is configured
if [ ! -d ~/.aws ]; then
    echo "AWS CLI is not configured. Please configure the AWS CLI and try again."
    exit 1
fi

# Prompt the user for AWS region and service
echo "Enter the AWS region:"
read aws_region
echo "Enter the AWS service (e.g., ec2, rds, s3, etc.):"
read aws_service_input
aws_service=$(echo $aws_service_input | tr '[:upper:]' '[:lower:]')

# List the resources based on the service
case $aws_service in
    ec2)
        echo "Listing EC2 Instance IDs in $aws_region"
        aws ec2 describe-instances --region $aws_region --query 'Reservations[*].Instances[*].InstanceId' --output table
        ;;
    rds)
        echo "Listing RDS Instance Identifiers in $aws_region"
        aws rds describe-db-instances --region $aws_region --query 'DBInstances[*].DBInstanceIdentifier' --output table
        ;;
    s3)
        echo "Listing S3 Bucket Names"
        aws s3api list-buckets --query 'Buckets[*].Name' --output table
        ;;
    cloudfront)
        echo "Listing CloudFront Distribution IDs"
        aws cloudfront list-distributions --query 'DistributionList.Items[*].Id' --output table
        ;;
    vpc)
        echo "Listing VPC IDs in $aws_region"
        aws ec2 describe-vpcs --region $aws_region --query 'Vpcs[*].VpcId' --output table
        ;;
    iam)
        echo "Listing IAM User Names"
        aws iam list-users --query 'Users[*].UserName' --output table
        ;;
    route53)
        echo "Listing Route53 Hosted Zone Names"
        aws route53 list-hosted-zones --query 'HostedZones[*].Name' --output table
        ;;
    cloudwatch)
        echo "Listing CloudWatch Alarm Names in $aws_region"
        aws cloudwatch describe-alarms --region $aws_region --query 'MetricAlarms[*].AlarmName' --output table
        ;;
    cloudformation)
        echo "Listing CloudFormation Stack Names in $aws_region"
        aws cloudformation describe-stacks --region $aws_region --query 'Stacks[*].StackName' --output table
        ;;
    lambda)
        echo "Listing Lambda Function Names in $aws_region"
        aws lambda list-functions --region $aws_region --query 'Functions[*].FunctionName' --output table
        ;;
    sns)
        echo "Listing SNS Topic ARNs in $aws_region"
        aws sns list-topics --region $aws_region --query 'Topics[*].TopicArn' --output table
        ;;
    sqs)
        echo "Listing SQS Queue URLs in $aws_region"
        aws sqs list-queues --region $aws_region --query 'QueueUrls[*]' --output table
        ;;
    dynamodb)
        echo "Listing DynamoDB Table Names in $aws_region"
        aws dynamodb list-tables --region $aws_region --query 'TableNames[*]' --output table
        ;;
    ebs)
        echo "Listing EBS Volume IDs in $aws_region"
        aws ec2 describe-volumes --region $aws_region --query 'Volumes[*].VolumeId' --output table
        ;;
    *)
        echo "Invalid service. Supported services: ec2, rds, s3, cloudfront, vpc, iam, route53, cloudwatch, cloudformation, lambda, sns, sqs, dynamodb, ebs"
        exit 1
        ;;
esac