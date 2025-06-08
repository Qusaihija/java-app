pipeline {
    agent any
    
    environment {
        TOMCAT_CONTAINER = 'tomcat-server'
        APP_NAME = 'java-webapp'
    }
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/yourusername/java-app.git'
            }
        }
        
        stage('Build') {
            steps {
                sh 'mvn clean package'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("${APP_NAME}:${BUILD_NUMBER}")
                }
            }
        }
        
        stage('Deploy to Tomcat') {
            steps {
                script {
                    // Stop and remove existing container if running
                    sh "docker stop ${TOMCAT_CONTAINER} || true"
                    sh "docker rm ${TOMCAT_CONTAINER} || true"
                    
                    // Run new Tomcat container with the deployed app
                    docker.image('tomcat:9.0').run(
                        "--name ${TOMCAT_CONTAINER} " +
                        "-p 8080:8080 " +
                        "-v ${WORKSPACE}/target/${APP_NAME}.war:/usr/local/tomcat/webapps/${APP_NAME}.war " +
                        "--rm"
                    )
                }
            }
        }
    }
    
    post {
        always {
            echo 'Cleaning up...'
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}