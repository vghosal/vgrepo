provider "aws" {
  # Configuration options
  region = "us-east-1"
  access_key = "AKIAYAAWXR7UNQSQP2DR"
  secret_key = "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"

}

resource "aws_iam_user" "iamuer" {

  for_each = toset(["user1","user2","user3"])
  name=each.key
}