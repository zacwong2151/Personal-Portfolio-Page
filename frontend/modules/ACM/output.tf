output "acm_cert_arn" {
    description = "The ARN of the validated ACM certificate"
    value = aws_acm_certificate.acm_cert.arn
}