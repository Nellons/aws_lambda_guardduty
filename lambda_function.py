import json
import boto3
import os

def handler(event, context):
    # Initialize Boto3 clients
    guardduty = boto3.client('guardduty')
    sns = boto3.client('sns')
    
    # Get the GuardDuty detector ID
    detector_id = os.environ['DETECTOR_ID']
    
    # Fetch GuardDuty findings
    findings_response = guardduty.list_findings(DetectorId=detector_id)
    finding_ids = findings_response['FindingIds']
    
    # If there are findings, fetch the details
    if finding_ids:
        findings_details = guardduty.get_findings(DetectorId=detector_id, FindingIds=finding_ids)
        
        # Format the findings for the SNS message
        findings_message = json.dumps(findings_details, indent=2)
        # Publish the findings to SNS
        sns_response = sns.publish(
            TopicArn=os.environ['SNS_TOPIC_ARN'],
            Message=findings_message,
            Subject='GuardDuty Findings Alert'
        )
        
        return {
            'statusCode': 200,
            'body': json.dumps('SNS notification sent successfully!')
        }
    else:
        return {
            'statusCode': 200,
            'body': json.dumps('No GuardDuty findings at this time.')
        }