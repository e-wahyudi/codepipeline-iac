resource "aws_codepipeline" "codepipeline" {
  name     = var.pipelinename
  role_arn = "<codepipeline_svcrole_ARN>"

  artifact_store {
    location = var.artifact_store_location
    type     = "S3"

  }

  stage {
    name = "Source" # !Mandatory Stage: Source!

    action {
      name             = "Source"
      category         = "Source"
      owner            = "AWS"
      provider         = "CodeStarSourceConnection"
      version          = "1"
      output_artifacts = [var.artifact]

      configuration = {
        ConnectionArn        = "<ARN to codestar>"
        FullRepositoryId     = var.repository_id
        BranchName           = var.branch_name
        OutputArtifactFormat = "CODEBUILD_CLONE_REF"  #Full Clone
        DetectChanges        = false #Change detection options | Start the pipeline on source code change
      }
    }
  }

  stage {
    name = var.stage1name # Stage #1

    action {
      name            = var.stage1_action_name
      category        = var.stage1category
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = [var.artifact]
      version         = "1"

      configuration = {
        #provider: Project Name
        ProjectName = var.project1
      }
    }
  }

  stage {
    name = var.stage2name #Stage2

    action {
      name            = var.stage2_action_name
      category        = var.stage2category
      owner           = "AWS"
      provider        = "CodeBuild"
      input_artifacts = [var.artifact]
      version         = "1"

      configuration = {
        #provider: Project Name
        ProjectName = var.project2
      }
    }
  }
}