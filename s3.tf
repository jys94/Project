resource "aws_s3_bucket" "bucket" {
  bucket = "lish-prj-terraform-backend"
  force_destroy = true
}
resource "aws_s3_bucket_public_access_block" "pub_acc_blk" {
  bucket = aws_s3_bucket.bucket.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}
resource "aws_s3_object" "objects" {
  for_each = toset(local.backends)
  bucket = aws_s3_bucket.bucket.id
  key    = "dev/${each.value}/"
}
output "bucket_id" {
  value = aws_s3_bucket.bucket.id
}