pipeline {
    agent any

    tools {
        nodejs 'nodejs'
        dockerTool 'docker'
    }

    environment {
        R = 'techwithproga/frontend'
        Rc = 'dockerhub'
        PATH = "${tool 'nodejs'}/bin:${env.PATH}"
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm install'
            }
        }

        stage('Build') {
            steps {
                sh 'npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build "${R}:v${BUILD_NUMBER}"
                }
            }
        }

        stage('Upload Image') {
            steps {
                script {
            // Use Docker Hub credential for authentication
            withCredentials([usernamePassword(credentialsId: 'Rc', passwordVariable: 'DOCKERHUB_PASSWORD', usernameVariable: 'DOCKERHUB_USERNAME')]) {
                // Log in to Docker Hub and push images
                sh 'docker login -u $DOCKERHUB_USERNAME -p $DOCKERHUB_PASSWORD https://index.docker.io/v1/'
                docker.withRegistry('https://index.docker.io/v1/', 'dockerhub') {
                    dockerImage.push("v${BUILD_NUMBER}")
                    dockerImage.push("latest")
                }
            }
                }
            }
        }

        stage('Remove old Image') {
            steps {
                sh "docker rmi ${R}:v${BUILD_NUMBER}"
            }
        }
    }
}
