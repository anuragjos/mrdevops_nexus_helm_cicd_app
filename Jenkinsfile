pipeline{
    agent any

    environment{

        VERSION = "${env.BUILD_ID}"
    }
    stages{
        stage('sonar quality status'){
            agent{
                docker{
                    image 'maven'
                }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar') {
                    sh 'mvn clean package sonar:sonar'
                 }

                }
            }
        

        }
        stage('quality gates status'){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar'
                }
            }
        }
        stage('docker build & docker push to Nexus repo '){
            steps{
                script{
                    withCredentials([string(credentialsId: 'nexus-password', variable: 'nexus-creds')]) {
                        sh '''
                        docker build -t 13.232.72.9:8083/springapp:${VERSION} .
                        docker login -u admin -p nexus 13.232.72.9:8083
                        docker push 13.232.72.9:8083/springapp:${VERSION}
                        docker rmi 13.232.72.9:8083/springapp:${VERSION}
                          '''
                    }
                }
            }
        }
    }
}