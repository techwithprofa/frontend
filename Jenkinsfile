pipeline {
    agent any

    environment {
        R = 'techwithproga/frontend'
        Rc = 'dockerhub'
    }
    environmentMap {
       'PATH' = "/usr/local/bin/node:$PATH"
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                env.PATH = "/usr/local/bin/node:$PATH"
                sh 'npm run build'
            }
        }

        stage('Bulid Docker Image') {
            steps {
                script {
                    echo sudo service docker status
                    dockerImage = docker.build "${R}:v${BUILD_NUMBER}"
                }
            }
        }

        stage('Upload Image') {
            steps {
                script {
                    docker.withRegistry('' , Rc){
                        dockerImage.push("v${BUILD_NUMBER}")
                        dockerImage.push("latest")
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
