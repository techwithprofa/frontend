pipeline {
    agent any  // Run on any available agent

    environment {
        R = 'echwithproga/frontend'
        Rc = 'dockerhub'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }
      

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }


        stage('Bulid Docker Image') {
            steps {
                script {
                    dockerImage = docker.build R + ".v$BUILD_NUMBR"

                }
            }
        }

        stage('Uplode Image') {
            steps {
                script {
                    docker.withRegistry('' , Rc){
                        dockerImage.push("v$BUILD_NUMBR")
                        dockerImage.push("latest")

                    }

                }
            }
        }
        stage('Remove old Image') {
            steps {
                sh "docker rmi $r:v$BUILD_NUMBR"
             
            }
        }
    }
}
