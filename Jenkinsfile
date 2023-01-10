pipeline{
    agent any
    stages{
        stage('sonar quality check'){
            agent{
                docker{
                    image 'maven'
                }
            }
            steps{
                script{
                    withSonarQubeEnv(credentialsId: 'sonar-auth') {
                        sh 'mvn clean package sonar:sonar'

                 }
                }
                
            }
        }
    }
}