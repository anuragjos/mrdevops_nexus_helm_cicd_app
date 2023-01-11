pipeline{
    agent any
    stages{
        stage('sonar qulaity status'){
            agent{
                docker{
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
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar-token'
            }
        }
    }
}    