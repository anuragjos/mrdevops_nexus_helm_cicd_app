pipeline{
    agent any
    environment{

        VERSION = "${env.BUILD_ID}"

    }
    stages{
        stage("sonar quality check"){
            agent {
                docker {
                    image 'maven'
                }
            }
            steps{

                script{
                       withSonarQubeEnv(credentialsId: 'jenkins-auth') {
                       sh 'mvn clean package sonar:sonar'
                   }
                }
            }
        }
        stage("Quality Gates Status"){
            steps{
                script{
                    waitForQualityGate abortPipeline: false, credentialsId: 'jenkins-auth'
                }
            }
        }
        stage("docker build & push image push to Nexus Repo"){
            steps{

                script{
                      withCredentials([string(credentialsId: 'nexus-auth', variable: 'nexus-passwd')]) {
                        sh '''
                          docker build -t 3.110.117.4:8083/springapp:${VERSION} .
                          docker login -u admin -p $nexus-passwd 3.110.117.4:8083
                          docker push 3.110.117.4:8083/springapp: ${VERSION}
                          docker rmi 3.110.117.4:8083/springapp: ${VERSION}

                       '''    

}
    
                       


}
            }
        }
    }
}
    