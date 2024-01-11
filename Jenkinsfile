pipeline {
    agent any

    tools {
        nodejs  'nodejs'
        docker 'docker'
        
        
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
