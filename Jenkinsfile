pipeline{
    agent any
    stages{
        agnet{
            docker{
                image 'maven'
            }
        }
        steps("sonar quality status"){
            script{
                  withSonarQubeEnv(credentialsId: 'sonar-token') {
                    sh 'mvn clean package sonar:sonar'
                  } 

            }

        }
    }
}