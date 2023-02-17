pipeline{
    agent any
    stages{
        stage("Sonar Quality check")
        steps{
            script{
                withSonarQubeEnv(credentialsId: 'sonar-auth') {
                 sh 'mvn clean package sonar:sonar'
           }
                
        }
    }
}
}