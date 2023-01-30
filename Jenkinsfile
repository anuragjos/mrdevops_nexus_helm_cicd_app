pipeline{
    agent any 
    stage('sonar quality check'){
        agent {
            docker {
                image 'maven'
            }
        }
        steps {
            script{
                withSonarQubeEnv(credentialsId: 'jenkins-auth') {
                 sh 'mvn clean package sonar:sonar'
}
               
            }
        }
    }
}