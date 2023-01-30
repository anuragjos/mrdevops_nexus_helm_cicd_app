pipeline{
    agent any 
    stages('sonar quality check'){
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