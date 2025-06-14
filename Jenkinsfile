pipeline {
    agent {
        docker {
            dockerfile true
        }
    }

    environment {
        GHCR_USER = 'zandomed'                    // GitHub username
        IMAGE_NAME = 'tranzport-api'
        IMAGE_TAG = 'latest'
        GHCR_IMAGE = "ghcr.io/${GHCR_USER}/${IMAGE_NAME}:${IMAGE_TAG}"
    }

    stages {
        stage('Build Native Image') {
            steps {
                sh './gradlew clean nativeCompile --no-daemon'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t $GHCR_IMAGE .'
            }
        }

        stage('Push to GHCR') {
            steps {
                withCredentials([string(credentialsId: 'ghcr-token', variable: 'GHCR_TOKEN')]) {
                    sh '''
                        echo "$GHCR_TOKEN" | docker login ghcr.io -u $GHCR_USER --password-stdin
                        docker push $GHCR_IMAGE
                    '''
                }
            }
        }

        // stage('Trigger Railway Deploy') {
        //     steps {
        //         withCredentials([string(credentialsId: 'railway-api-token', variable: 'RAILWAY_TOKEN')]) {
        //             sh '''
        //                 curl -X POST https://backboard.railway.app/webhook/deploy/<tu-webhook-id> \
        //                      -H "Authorization: Bearer $RAILWAY_TOKEN"
        //             '''
        //         }
        //     }
        // }
    }
}
