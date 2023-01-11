pipeline{
    agent any
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
                    sh 'mav clean package sonar:sonar'
}

                }
            }
        }
    }
}