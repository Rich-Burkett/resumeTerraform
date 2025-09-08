resource "aws_s3_bucket" "www-bucket" {
    
    bucket = var.web-bucket

    tags = var.challenge-tags
  
}

resource "aws_s3_bucket_website_configuration" "www-bucket" {

    bucket = aws_s3_bucket.www-bucket.id

    index_document {
      suffix = index.html
    }

    error_document {
      key = "404.html"
    }
  
}

resource "aws_s3_account_public_access_block" "bucket_access_block" {
    
    block_public_acls = false
    block_public_policy = false

}

resource "aws_s3_bucket_policy" "name" {
    bucket = aws_s3_bucket.www-bucket.id
    policy = jsondecode({

        version = "2012-10-17"
        Statement = [
            {
                Effect = "Allow"
                Pricipal = "*"
                Action = [
                    "s3.GetObject"
                ]
                resource = [
                    "${aws_s3_bucket.www-bucket.arn}/*"
                ]

            }
        ]
    
    }

    )
}