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
        stage("Identifying Misconfigs using datree in Helm charts"){
            steps{
                script{
                    dir('kubernetes/myapp') {
                        withEnv(['DATREE_TOKEN=5262aca5-69a3-4dc3-acbe-2d286385ed67']) {
                        sh 'helm datree test .'
                        }
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