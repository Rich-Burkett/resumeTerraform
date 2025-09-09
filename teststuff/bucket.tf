resource "aws_s3_bucket" "www-bucket" {
    
    bucket = var.web-bucket

    tags = var.challenge-tags
  
}

resource "aws_s3_bucket_website_configuration" "www-bucket-config" {

    bucket = aws_s3_bucket.www-bucket.id

    index_document {
      suffix = "index.html"
    }

    error_document {
      key = "404.html"
    }
  
}

resource "aws_s3_account_public_access_block" "bucket_access_block" {
    
    block_public_acls = false
    block_public_policy = false
    

}

resource "aws_s3_bucket_policy" "www-bucket-pol" {
    bucket = aws_s3_bucket.www-bucket.id
    policy = jsonencode({

        Version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Principal = "*"
                Action = [
                    "s3:GetObject"
                ]
                Resource = [
                    "${aws_s3_bucket.www-bucket.arn}/*"
                ]

            }
        ]
    
    }

    )
}