🚀 Swathi ECS CI/CD Pipeline
Automated deployment of a Strapi app to AWS ECS using GitHub Actions and AWS CodeDeploy (Blue/Green deployment strategy).

🔍 What This Project Does
When you push code to GitHub, this pipeline automatically:

Builds a Docker image of your Strapi app
Pushes it to Amazon ECR (tagged with commit SHA)
Updates the ECS Task Definition with the new image
Triggers a Blue/Green deployment via AWS CodeDeploy
Monitors the deployment and auto-rolls back if it fails

No manual steps needed — just push and it deploys! ✅

🏗️ How It Works (Simple Flow)
You push code to GitHub
        ↓
GitHub Actions starts automatically
        ↓
Docker image is built from your Strapi app
        ↓
Image is pushed to Amazon ECR
(tagged with your commit SHA e.g. abc1234)
        ↓
ECS Task Definition is updated with new image
        ↓
AWS CodeDeploy does Blue/Green deployment
- New version (Green) starts up
- Health checks run
- Traffic switches from Blue → Green
- Old version (Blue) is removed after 5 mins
        ↓
✅ App is live  OR  ❌ Auto rollback happens

🛠️ Tools Used & Why
ToolPurposeWhy We Use ItGitHub ActionsRuns the pipelineFree, built into GitHub, easy to configureAmazon ECRStores Docker imagesAWS native, secure, fastAmazon ECS FargateRuns containersNo servers to manage, fully managedAWS CodeDeployBlue/Green deploymentZero downtime, auto rollback supportTerraformCreates AWS infrastructureRepeatable, version-controlled infraALBRoutes traffic to appDistributes load, enables Blue/Green

📁 Project Structure
swathi-ecs-cicd-pipeline/
├── .github/
│   └── workflows/
│       └── deploy.yml    → GitHub Actions pipeline (main file)
├── strapi-app/            → Your Strapi application code
├── terraform/             → All AWS infrastructure as code
│   ├── main.tf            → AWS provider setup
│   ├── variables.tf       → Configurable values
│   ├── vpc.tf             → Network & security groups
│   ├── ecr.tf             → Docker image storage
│   ├── iam.tf             → Permissions & roles
│   ├── alb.tf             → Load balancer & target groups
│   ├── ecs.tf             → ECS cluster, service & tasks
│   ├── codedeploy.tf      → Blue/Green deployment config
│   └── outputs.tf         → Shows created resource values
├── Dockerfile             → How to build the Docker image
├── appspec.yml            → Tells CodeDeploy which container to use
└── taskdef.json           → ECS container blueprint

🔐 GitHub Secrets Required
These are sensitive values stored securely in GitHub.
Go to: Repo → Settings → Secrets → Actions → New Secret
Secret NameValueWhy NeededAWS_REGIONus-east-1Where AWS resources areAWS_ACCESS_KEY_IDYour AWS KeyTo authenticate with AWSAWS_SECRET_ACCESS_KEYYour AWS SecretTo authenticate with AWSECR_REPOSITORYswathi-repoWhere to push Docker imageECS_CLUSTERswathi-clusterWhere containers runECS_SERVICEswathi-serviceWhich service to updateCODEDEPLOY_APPswathi-codedeploy-appCodeDeploy application nameCODEDEPLOY_GROUPswathi-deployment-groupDeployment group name

🚀 How to Run This Project
Step 1: Setup AWS Infrastructure
bashcd terraform
terraform init    # Download AWS plugins
terraform plan    # Preview what will be created
terraform apply   # Create all AWS resources
Step 2: Add GitHub Secrets
Add all 8 secrets listed above to your GitHub repo.
Step 3: Push Code to Deploy
bashgit add .
git commit -m "your message"
git push origin main
# Pipeline starts automatically!
Step 4: Monitor Deployment
bash# Check deployment status
aws deploy get-deployment \
  --deployment-id <ID> \
  --region us-east-1 \
  --query "deploymentInfo.status"
Step 5: Access Your App
http://swathi-alb-495540833.us-east-1.elb.amazonaws.com:1337

🔄 Pipeline Steps Explained
StepWhat HappensCheckoutDownloads your code to the runnerAWS LoginAuthenticates using GitHub SecretsECR LoginLogs into Docker registryDocker Build & PushBuilds image, tags with commit SHA, pushes to ECRTask Definition UpdateReplaces old image URI with new one dynamicallyCodeDeployStarts Blue/Green deployment on ECSMonitorChecks status every 30 secs, rolls back if failed

🔵🟢 Blue/Green Deployment Explained
BEFORE deployment:
Users → ALB → Blue (old version running) ✅

DURING deployment:
Users → ALB → Blue (still serving traffic)
              Green (new version starting up) 🟡

AFTER deployment:
Users → ALB → Green (new version now live) ✅
              Blue (terminated after 5 mins) 🗑️
Benefit: Zero downtime! Users never see an outage.

✅ Auto Rollback
If the new version fails health checks or crashes:
❌ Deployment Failed
        ↓
🔄 Auto Rollback triggered
        ↓
✅ Old version is restored automatically
        ↓
Users never notice anything went wrong!

🏗️ AWS Resources Created by Terraform
ResourceNameWhat It DoesECR Repositoryswathi-repoStores Docker imagesECS Clusterswathi-clusterGroups your containersECS Serviceswathi-serviceKeeps containers runningECS Task Definitionswathi-taskBlueprint for containerLoad Balancerswathi-albRoutes user trafficTarget Group Blueswathi-tg-blueOld version trafficTarget Group Greenswathi-tg-greenNew version trafficCodeDeploy Appswathi-codedeploy-appManages deploymentsDeployment Groupswathi-deployment-groupBlue/Green config

Author: Swathi Soora | Region: us-east-1 | App Port: 13371
