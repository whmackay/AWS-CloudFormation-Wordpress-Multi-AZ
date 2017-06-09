#!/bin/bash
PATH=/Users/whmackay/WorkDocs/Projects/websites/AWS-CloudFormation-Wordpress-Multi-AZ/cloudformation-template/wordpress-multi-az-w-rds-snapshot-restore.json
TEMPLATENAME=wordpress-multi-az-w-rds-snapshot-restore.json

/usr/local/bin/aws s3 cp $PATH s3://mycustomcftemplates/
/usr/local/bin/aws cloudformation validate-template --template-url "https://s3.amazonaws.com/mycustomcftemplates/$TEMPLATENAME"

read -n1 -p "Do you want to create the stack? [y,n]" reply 
case $reply in  
  y|Y) 

	echo -e "\n\n"
	echo -n "Project Name:"
	read PROJECTNAME

	echo -n "Stack Name:"
	read STACKNAME

	echo -n "Code Commit Repository:"
	read CODEREPOSITORYNAME

	echo -n "RDS Snapshot to restore from (Leave blank if not restoring from snapshot):"
	read RDSSNAPSHOT

	echo -n "Database Name (Must match dbname of snapshot if restoring from snapshot):"
	read DBName

	echo -n "RDS USer Name (Must match credentials stored in RDS snapshot if restoring):"
	read DBUSERNAME

	echo -n "RDS Password (Figure out the pattern yet?):"
	read DBPASSWORD

	echo -n "EC2 Access Key Name:"
	read KeyName

	echo -n "Misc Permenant S3 Bucket for whatever:"
	read S3REPOSITORYNAME

	aws cloudformation create-stack --capabilities CAPABILITY_IAM --region us-east-1 --stack-name $STACKNAME --template-url https://s3.amazonaws.com/mycustomcftemplates/$TEMPLATENAME --parameters ParameterKey=ProjectName,ParameterValue=$PROJECTNAME ParameterKey=KeyName,ParameterValue=$KEYNAME ParameterKey=CodeCommitRepositoryName,ParameterValue=$CODEREPOSITORYNAME ParameterKey=DBName,ParameterValue=$DBNAME ParameterKey=DBUserName,ParameterValue=$DBUSERNAME ParameterKey=DBPassword,ParameterValue=$DBPASSWORD ParameterKey=RDSSnapshotName,ParameterValue=$RDSSNAPSHOT ParameterKey=S3Repository,ParameterValue=$S3REPOSITORYNAME

  ;; 

  n|N) echo -n "Exiting";; 
  *) echo -n "Exiting";; 
esac
