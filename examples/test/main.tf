module "test" {
  source = "../.."
  name   = "test"
  lifecycle_policy_rules = [
    {
      rulePriority : 1,
      description : "Expire untagged images older than 1 days",
      selection : {
        tagStatus : "untagged",
        countType : "sinceImagePushed",
        countUnit : "days",
        countNumber : 1
      },
      action : {
        type : "expire"
      }
    },
    {
      rulePriority : 2,
      description : "Expire images tagged commit- older than 30 days",
      selection : {
        tagStatus : "tagged",
        tagPrefixList : ["commit-"],
        countType : "sinceImagePushed",
        countNumber : 30,
        countUnit : "days",
      },
      action : {
        type : "expire"
      }
    }
  ]
}