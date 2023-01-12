pipeline{
    agent any
    stages{
        stage("sonar quality status"){
            agent{
                docker{
                    image 'maven'
                }
            }
            stage{
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
            steps{
                script{
               waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token' 
            }

            }
            
        }
    }
}