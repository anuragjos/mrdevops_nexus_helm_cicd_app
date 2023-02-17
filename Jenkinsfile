pipeline{
    agent any
    stages{
        stage("Sonar Quality check"){
            steps{
            script{
                withSonarQubeEnv(credentialsId: 'sonar-auth') {
                 sh 'mvn clean package sonar:sonar'
                  }
                }
           }
        }
        stage("Sonar Quality Gate Status"){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'sonar-auth'
                }
            }
        }
    }
}