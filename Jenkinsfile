pipeline{
    agent any
    stages{
        stage("sonar quality status"){
            agent{
                docker{
                    image 'maven'
                }
            }
            steps{
                steps{
                    script{
                    withSonarQubeEnv(credentialsId: 'sonar-token') {
                        sh 'mvn clean package sonar:sonar'
                    }
                   }

                }
                
            }
        }
        stage("quality Gate status"){
            script{
               waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token' 
            }
        }
    }
}