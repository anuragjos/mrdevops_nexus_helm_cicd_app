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
                     withCredentials([string(credentialsId: 'nexus_auth', variable: 'nexus_auth')]) {
                       sh '''
                          docker build -t 3.110.117.4:8083/springapp:${VERSION} .
                          docker login -u admin -p $nexus_auth 3.110.117.4:8083
                          docker push 3.110.117.4:8083/springapp:${VERSION}
                          docker rmi 3.110.117.4:8083/springapp:${VERSION}

                       '''        
                    }
                }
            }
        }
    }
    post {
		always {
			mail bcc: '', body: "<br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: '', mimeType: 'text/html', replyTo: '', subject: "${currentBuild.result} CI: Project name -> ${env.JOB_NAME}", to: "aniljoshi.synsoft@gmail.com";  
		}
	}
}
    