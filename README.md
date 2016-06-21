# README

This Wercker step adds a permission to a Lambda function, which allows some principal/source arn to invoke some action on the Lambda function.
The main problem solved by this step is to handle the pesky "statement id" in a standardized way. Generally speaking, statement IDs suck balls.

The input to the step is as follows:

* account id (implied)
* function name
* action
* principal
* source arn

The effect of running the step is that the `principal` and `source arn` gets permission to invoke the `action` on the `named function`.

## Dependencies

* The `md5sum` command
* The `aws` command (Amazon Web Services CLI)

## Examples

Allow a CloudWatch rule to invoke a Lambda function:

```
- audienceproject/lambda-add-permission@1.0.1:
    function-name: my-funky-function
    action: lambda:InvokeFunction
    principal: events.amazonaws.com
    source-arn: arn:aws:events:us-east-1:1234456789:rule/my-funky-rule
```

Allow an API Gateway method to invoke a Lambda function:

```
- audienceproject/lambda-add-permission@1.0.3:
    function-name: my-funky-function
    action: lambda:InvokeFunction
    principal: apigateway.amazonaws.com
    source-arn: arn:aws:execute-api:us-east-1:1234456789:abzxyz123/*/GET/foo/bar
```
