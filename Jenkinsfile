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

        stage('Bulid Docker Image') {
            steps {
               
                dockerImage = docker.build image: "${R}:v${BUILD_NUMBER}", context: '.', env: ['MY_ENV_VAR="my_value"']  // Build image with env var (optional)
            

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
