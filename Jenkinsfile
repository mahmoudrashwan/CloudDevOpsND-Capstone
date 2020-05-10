pipeline {
    environment {
        registry = "mahmoudrashwan001/capstone"
        dockerhubCredentials = 'dockerhubcred'
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
                    docker.build(registry+":$BUILD_NUMBER")
                }
            }
        }
        stage ('Security Scan') {
            steps {
                aquaMicroscanner imageName: 'mahmoudrashwan001/capstone:$BUILD_NUMBER', notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
            }
        }
    }
}
