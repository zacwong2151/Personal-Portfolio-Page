# Steps to recreate project
> Note that the following steps are general guidelines if using the AWS console. Everything from step 2 onwards has to be done using Terraform

## 1. Create AWS account
1. Under account settings, enable the setting for 'Activate IAM Access'
2. Enable MFA for the root user (later on, need enable MFA for all IAM users as well)
3. Configure a budget (additionally, under 'Billing Preferences', enable the settings there)
4. Create an IAM user with administrator privileges (use this IAM user for your all work)
5. Create an access key pair so that you can run a terraform script from your CLI
6. Create a named profile on the CLI using the command `aws configure --profile <insert-your-profile-name-here>`
    - To test if configured properly, try `aws configure list --profile <insert-your-profile-name-here>`


## 2. Set up S3 bucket and upload web files
1. Create a bucket which allows public access
2. Go to properties tab and enable static website hosting
3. Enable all principals to view objects in the bucket using the bucket policy

## 3. Make your S3 bucket accessible via your custom domain
1. Buy and register a domain name using Route 53 (`.click` domain is cheap)
2. Create a Route 53 'A' record to route traffic from your domain to the S3 bucket

## 4. Deploy and validate public certificate using ACM
1. Create public certificate from ACM with validation method as 'DNS validation'
2. Create a CNAME record in Route 53. This is how ACM verifies that you control this domain

## 5. Set up CloudFront distribution with associated SSL cert
1. Deploy a CloudFront distribution and associate the SSL cert to enable HTTPS access
2. Create a Route 53 'A' record with Alias to the distribution (the record in step 3 is no longer needed)
3. Modify the bucket policy to only allow access from this specific distribution

## 5.1 Consideration when choosing S3 origin or custom origin
| | S3 origin | Custom origin |
| -------- | -------- | ------- |
| Public access settings | Private bucket | Public bucket |
| How to enforce request only via CloudFront | Force all traffic through CloudFront via OAC | Bucket only accepts requests with custom secret headers which are sent from CloudFront |
| Bucket policy | Only accept requests from the CloudFront distribution ARN | Accepts requests from all principals |
| Invalid object request | May need to write a CloudFront function to route requests for non-existent objects to `error.html` | Comes with native support with routing to default objects |

## 6. Deploy a DynamoDB table

## 7. Deploy a Lambda function to update visitor count in the DynamoDB table
1. Test your code on your local machine, before testing it on Lambda

## 8. Expose your Lambda via an endpoint in an API Gateway
1. Create a HTTP API
2. Integrate this API with your Lambda function
3. Configure a route for your HTTP API which is a PUT method with a specific path name

## 8.1 Consideration when choosing API Gateway or Lambda Function URL
| | API Gateway | Function URL |
| -------- | -------- | ------- |
| Simplicity |  | It's a single, direct endpoint for your Lambda function. Setup is minimal |
| Cost-Effective |  | For very basic and direct invocations, it is cheaper because you do not pay for API Gateway's processing overhead |
| Custom domains | Easily map custom domains to your API Gateway endpoints |  |
| Throttling | Control API usage, set rate limits |  |
| Request/Response Transformations | Transform payloads between client, API Gateway, and Lambda | |
| Authentication & Authorisation | Integrates with Lambda authorisers/Cognito User Pools for authentication and authorisation of API requests | |
| WAF | Seamlessly integrate with AWS WAF for protection against common web exploits | |
| Caching | Enable caching at the API Gateway level to reduce load on Lambda and improve response times | |
| Versioning | Manage multiple versions of your API (e.g., /v1, /v2). | |
| Integration with AWS services | Integrate with various AWS services (Lambda, EC2, S3, Kinesis) and any HTTP endpoint | |
| Logging | Provides detailed CloudWatch metrics and access logging for all API requests | |

## 8.2 Consideration when choosing HTTP API or REST API
|  | HTTP | REST |
| -------- | -------- | ------- |
| Cost | Up to 70% cheaper per request than REST APIs |  |
| Performance | Lower latency and higher throughput |  |
| WAF | No direct integration with WAF | Can directly integrate with WAF |
| Cache | No built-in caching | Built-in caching at the API Gateway level to reduce load on backend and improve latency |
| Auth options | Supports JWT auth (for OAuth), IAM auth, basic Lambda auth | Supports a broader range of auth mechanisms, including IAM auth, Cognito User Pools auth, custom Lambda auth, API keys |
| Private APIs | No direct support for private API endpoints (you'd need a private ALB) | Can create private endpoints accessible only from within your VPC using VPC Endpoints |