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
  # Add more stages as desired here...
}

# Notification via Slack - this assumes that Slack (Chatbot) has already been configured; and this includes
# the SNS topic that publishes to the Slack Channel
resource "aws_codestarnotifications_notification_rule" "approval" {
  detail_type    = "FULL"
  event_type_ids = ["codepipeline-pipeline-manual-approval-needed"] #notify when approval is pending

  name     = "codepipeline-approval"
  resource = aws_codepipeline.codepipeline.arn #codepipeline ARN

  target {
    address = <ARN of SNS Topic>
  }
}

resource "aws_codestarnotifications_notification_rule" "approved" {
  detail_type    = "FULL"
  event_type_ids = ["codepipeline-pipeline-manual-approval-succeeded"] #notify when approved

  name     = "codepipeline-approved"
  resource = aws_codepipeline.codepipeline.arn  #codepipeline ARN

  target {
    address = <ARN of SNS Topic>
  }
}
