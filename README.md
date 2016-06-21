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

* Amazon Web Services CLI

## Examples

Allow the CloudWatch rule `my-funky-rule` to invoke the Lambda function `my-funky-function`

```
steps:
    - audienceproject/lambda-add-permission@1.0.1:
        function-name: my-funky-function
        action: lambda:InvokeFunction
        principal: events.amazonaws.com
        source-arn: arn:aws:events:1234456789:rule/my-funky-rule
```
