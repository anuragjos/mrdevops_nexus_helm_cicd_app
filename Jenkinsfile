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
                    sh 'mvn clean package sonar:sonar'
}

                }
            }
        }
        stage('quality gate status'){
            script{
                waitForQualityGate abortPipeline: false, credentialsId: 'sonar'
            }
        }
    }
}