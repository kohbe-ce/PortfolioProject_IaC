resource "aws_cloudwatch_log_group" "log-group" {
 name = "log-group"
 depends_on = [
 aws_s3_bucket.cicdpipeline-s3-bucket-0119
 ]
}