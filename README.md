🚀 Swathi ECS CI/CD Pipeline
Automated deployment of a Strapi app to AWS ECS using GitHub Actions and AWS CodeDeploy (Blue/Green).

🏗️ What This Does
Git Push → GitHub Actions → Docker Build → Push to ECR → ECS Deploy → Live App

🛠️ Tools Used
ToolPurposeGitHub ActionsAutomates the pipelineAmazon ECRStores Docker imagesAmazon ECS FargateRuns the containerAWS CodeDeployBlue/Green deploymentTerraformCreates AWS infrastructureALBRoutes traffic to app

📁 Project Structure
swathi-ecs-cicd-pipeline/
├── .github/workflows/deploy.yml  # CI/CD pipeline
├── strapi-app/                   # Strapi application
├── terraform/                    # AWS infrastructure
├── Dockerfile                    # Docker build file
├── appspec.yml                   # CodeDeploy config
└── taskdef.json                  # ECS Task Definition

🔐 GitHub Secrets Required
SecretValueAWS_REGIONus-east-1AWS_ACCESS_KEY_IDYour AWS Access KeyAWS_SECRET_ACCESS_KEYYour AWS Secret KeyECR_REPOSITORYswathi-repoECS_CLUSTERswathi-clusterECS_SERVICEswathi-serviceCODEDEPLOY_APPswathi-codedeploy-appCODEDEPLOY_GROUPswathi-deployment-group

🚀 How to Deploy
bash# 1. Setup infrastructure
cd terraform && terraform apply

# 2. Push code to trigger pipeline
git add . && git commit -m "deploy" && git push origin main

# 3. Access app
http://swathi-alb-495540833.us-east-1.elb.amazonaws.com:1337

🔄 Pipeline Steps
1. Checkout code
2. Login to AWS & ECR
3. Build & push Docker image (tagged with commit SHA)
4. Update ECS Task Definition with new image
5. Trigger CodeDeploy Blue/Green deployment
6. Monitor & auto rollback if failed

✅ Auto Rollback
If deployment fails → automatically rolls back to previous version.

Author: Swathi Soora | Region: us-east-1
