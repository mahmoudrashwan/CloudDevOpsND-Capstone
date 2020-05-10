pipeline {
    environment {
        registry = "mahmoudrashwan001/capstone"
        registryCredential = 'dockerhubcred'
        dockerImage = ''
        tag = "1.$BUILD_NUMBER"
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
                    dockerImage = docker.build registry + ":${tag}"
                }
            }
        }

        stage ('Security Scan') {
            steps {
                aquaMicroscanner imageName: "mahmoudrashwan001/capstone:${tag}", notCompliesCmd: 'exit 4', onDisallowed: 'fail', outputFormat: 'html'
            }
        }
    }
}
