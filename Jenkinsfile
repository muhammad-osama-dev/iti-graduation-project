pipeline{
    agent any
    stages{
        stage('Git checkout') {
            steps {
                script {
                    withCredentials([usernamePassword(credentialsId: 'mo-git', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
                        sh "git clone https://$GIT_USERNAME:$GIT_PASSWORD@github.com/muhammad-osama-dev/iti-graduation-project"
                    }
                }
            }
        }
        stage('Initialize'){
            steps{
                sh 'terraform init'
            }
        }
        stage('Plan'){
            steps{
                sh 'terraform plan'
            }
        }
        stage('Apply'){
            steps{
                sh 'terraform apply -auto-approve'
            }
        }
        stage('Destroy'){
            steps{
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}