provider "aws" {
  region = "us-east-1"
}

# uncomment this block to keep statefile in S3 bucket
/* terraform {
  backend "s3" {
    bucket         = "S3 Bucket Name"
    key            = "sub-directories/.../terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "dynamo DB Table name"
  }
} */

module "codepipeline" {
  source                  = "./module/codepipeline"
  pipelinename            = ""
  artifact_store_location = "<S3_Bucket_name>"
  repository_id           = "<host_name>/<Project_name>"
  branch_name             = "<branch_name>"
  artifact                = "<artifact_name>"

  # Stage/Project 1
  stage2name         = ""
  stage2_action_name = ""
  stage2category     = "Build"
  project2           = "<codebuild_projectname>"

  # Stage/Project 2
  stage1name         = ""
  stage1_action_name = ""
  stage1category     = "Build"
  project1           = "<codebuild_projectname>"
  
  # add more stages to match what's in module/codepipeline/main.tf as necessary
}
