pipeline{
    agent any
    environment{
        VERSION = "${env.BUILD_ID}"
    }
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
        stage("Docker Build & Push to Nexus Repo"){
            steps{
                script{
                    withCredentials([string(credentialsId: 'nexus_auth', variable: 'nexus_pass')]) {
                        sh '''
                        docker build -t 3.111.38.99:8083/springapp:${VERSION} .
                        docker login -u admin -p $nexus_pass 3.111.38.99:8083
                        docker push 3.111.38.99:8083/springapp:${VERSION}


                        '''
    
}
                }
            }
        }

    }
}