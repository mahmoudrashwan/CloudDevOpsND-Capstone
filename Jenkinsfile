pipeline {
    environment {
        registry = "mahmoudrashwan001/capstone"
        registryCredential = 'dockerhubcred'
        dockerImage = ''
    }
    agent any
    stages {
        stage ('Updating dependencies') {
            steps {
                sh 'echo "Updating python dependencies"'
                sh 'make install'
            }
        }
        stage ('Linting') {
            steps {
                sh 'echo "Lint html files | python files | Dockerfile"'
                sh 'make lint'
            }
        }
        stage ('Build Docker Image') {
            steps {
                sh 'echo "Building Docker Image.."'
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage ('Push Image to Dockerhub') {
            steps {
                sh 'echo "Pushing Docker Image to DockerHub.."'
                script {
                    docker.withRegistry( '', registryCredential ) {
                        dockerImage.push()
                }
            }
        }
        stage ('Security Scan') {
            steps {
                echo "${dockerImage}"
                aquaMicroscanner imageName: "${dockerImage}", notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
            }
        }
    }
}
