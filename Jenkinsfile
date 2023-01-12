pipeline{

    agent any
    environment = "${env.BUILD_ID}"

    stages{
        
        stage('sonar quality status'){

            agent{

                docker {

                    image 'maven'
                }
            }
            steps{

                script{
                    
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh 'mvn clean package sonar:sonar'

                    }

                }
            }
        }
        stage('quality Gate status'){
            steps{
                script{
                   waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
                }
            }
        }
        // stage('docker image build & docker image push nexus repo'){
            steps{
                script{
                    withCredentials([string(credentialsId: 'nexus-pass', variable: 'nexus_creds')]) {
                     sh '''
                        docker  build -t 13.233.88.71:8083/springapp:${VERSION} .
                        docker login -u nexus -p nexus_creds 13.233.88.71:8083
                        docker push 13.233.88.71:8083/springapp:${VERSION}
                        docker rmi 13.233.88.71:8083/springapp:${VERSION}

                     '''
                    }
                     

                }
            }
        }
    }
}
