# KinesisのメッセージをLambdaを使ってPubNubに投げる例

1. `functions/kinesis-lambda-pubnub`で`npm install`を実行
2. `apex infra apply --target aws_iam_role_policy_attachment.lambda_kinesis_execution_role_attach`
3. 2のOutputに出力されるロールのARNでproject.jsonのroleを更新
4. `env.json`にPubNubの`publish_key`と`subscribe_key`を記入
5. `apex deploy --env-file ./env.json  kinesis-lambda-pubnub`
6. `apex infra apply`
