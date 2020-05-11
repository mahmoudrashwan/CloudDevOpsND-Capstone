

# CloudDevOpsND-Capstone
Capstone project for Cloud DevOps Engineer Nanodegree

## Summery
Applied what i learned in Nanodegree track to build full infrastructure with AWS Cloudformation [IaaC] to automate and containerized flask-app and deploy it to DockerHub using jenkins and docker, then Deployed the containerized app into AWS EKS using Blue/Green deployment strategy.

## Project Scope
* Working in AWS
* Using Jenkins to implement Continuous Integration and Continuous Deployment
* Building pipelines with Jenkins
* Working with CloudFormation to deploy clusters
* Building Kubernetes clusters with AWS EKS
* Building Docker containers in pipelines and Push images to DockerHub

## Installation
### Deploy Infrastructure
```bash
cd Cloudformation-Infrastructure/
./Create-stack.sh Capstone-Network Network-template.yml Network-parameters.json
./Create-stack.sh Capstone-JS Jenkins-box.yml Jenkins-box-parameters.json
./Create-stack.sh CapEKS-Infra eks-infra.yml eks-infra-parameters.json
```

### Configure Jenkins Server
Install Plugins:
* Pipeline: AWS Steps
* BlueOcean Aggregator 

Install Packages: 
* tidy
* hadolint
* pylint

### Linting App source code Locally
```bash
make lint
```

### RUN App Locally with Docker
```bash
docker build --tag=mahmoudrashwan001/capstone .
docker image ls
docker run -t -p 8000:80 mahmoudrashwan001/capstone
```

### Deploy Blue/Green Builds over K8 pods
Initialize Blue Deployment:
```bash
./Deployment-BlueGreen/kubernetes_blue_controller.sh
```
Activate Blue Deployment:

```bash
kubectl apply -f ./Deployment-BlueGreen/blue-green-service.json
```

Initialize Green Deployment:
```bash
./Deployment-BlueGreen/kubernetes_green_controller.sh
```

Activate Green Deployment over blue:

Change Selector in blue-green-service.json to: `"selector":{"app":"green"}`

then:
```bash
kubectl apply -f ./Deployment-BlueGreen/blue-green-service.json
```
Flask app will change based on new modification [within 2 min] without downtime.
 
## Notes:
pylint runs only on main python file [run.py], and tidy runs on [index.html].
because it just for demo of Capstone.

### Core-App Source code
The python flask application used as a core-app in this project is 'Flask-Dashboard' open-source and licensed based on MIT License, which is developed by 'AppSeed App Generator'.

## References:
* Cloud Devops Engineer NanoDegree Material | [Udacity](https://www.udacity.com/course/cloud-dev-ops-nanodegree--nd9991)
*  [AWS](https://docs.aws.amazon.com/cloudformation/index.html)
* [Jenkins](https://www.jenkins.io/doc/)
* [Kubernetes](https://kubernetes.io/docs/home/)
* [Udacity's Mentor](https://medium.com/@andresaaap/capstone-cloud-devops-nanodegree-4493ab439d48)

### Project Author
#### Mahmoud Rashwan
