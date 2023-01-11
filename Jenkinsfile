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
    
}
                }

            }
        }
    }
}    