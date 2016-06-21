#!/bin/bash
#
# -----------
# Input
# -----------
# function name
# principal
# source arn
# action
#
# -----------
# Pseudo code
# -----------
#
# statement-id = "unique amalgamation of function-name + principal + arn + action"
# exists = get-policy + grep
# if statement-id exists:
#    remove permission with statement-id
# add permission with statement-id

STATEMENT_ID="SID-$WERCKER_LAMBDA_ADD_PERMISSION_FUNCTION_NAME+$WERCKER_LAMBDA_ADD_PERMISSION_ACTION+$WERCKER_LAMBDA_ADD_PERMISSION_PRINCIPAL+$WERCKER_LAMBDA_ADD_PERMISSION_SOURCE_ARN"
set +e
# Returns 0 if statement ID already exists
aws lambda get-policy --function-name $WERCKER_LAMBDA_ADD_PERMISSION_FUNCTION_NAME | grep $STATEMENT_ID
if [ $? == 0 ]; then
    # Remove permission with statement ID
    aws lambda remove-permission --function-name $WERCKER_LAMBDA_ADD_PERMISSION_FUNCTION_NAME --statement-id $STATEMENT_ID
fi
set -e
# Add permission
aws lambda add-permission \
--function-name $WERCKER_LAMBDA_ADD_PERMISSION_FUNCTION_NAME \
--statement-id $STATEMENT_ID \
--action $WERCKER_LAMBDA_ADD_PERMISSION_ACTION \
--principal $WERCKER_LAMBDA_ADD_PERMISSION_PRINCIPAL \
--source-arn $WERCKER_LAMBDA_ADD_PERMISSION_SOURCE_ARN

# One could argue that we don't need to delete the existing permission if the statement-id matches.
# This approach was chosen because it ensures that the statement-id matches the intended permission.
