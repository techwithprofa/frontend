pipeline {
    agent any  // Run on any available agent

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/your-org/your-repo.git'  // Replace with your repository URL
            }
        }

        stage('Build') {
            steps {
                sh 'npm install'
                sh 'npm run build'
            }
        }

        stage('Test') {
            steps {
                sh 'npm test'
            }
        }

        stage('Archive Artifacts') {
            post {
                success {
                    archiveArtifacts artifacts: '.next/**'
                }
            }
        }
    }
}
