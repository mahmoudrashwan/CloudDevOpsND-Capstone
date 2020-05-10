pipeline {
    environment {
        registry = "mahmoudrashwan001/capstone"
        registryCredential = 'dockerhubcred'
        dockerImage = ''
        tag = "$BUILD_NUMBER"
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

        stage ('Security Scan') {
            steps {
                sh 'echo "${tag}"'
                sh 'echo'+"mahmoudrashwan001/capstone:${tag}"
                sh 'echo'+tag
                aquaMicroscanner imageName: "mahmoudrashwan001/capstone:"+tag, notCompliesCmd: 'exit 1', onDisallowed: 'fail', outputFormat: 'html'
            }
        }
    }
}
