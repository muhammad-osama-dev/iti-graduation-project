pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Select an action')
    }
    stages {
        stage('Initialize') {
            steps {
                script {
                    def gcpCredentials = credentials('terraformkey')
                    withCredentials([file(credentialsId: 'terraformkey', variable: 'TERRAFORM_KEY')]) {
                        sh "sudo cp \$TERRAFORM_KEY ./SA_key.json"
                        sh 'ls'
                    }  
                    sh 'terraform init'
                }
            }
        }
        stage('Plan') {
            steps {
                sh 'terraform plan'
            }
        }
        stage('Apply') {
            when {
                expression {
                    return params.ACTION == 'Apply'
                }
            }
            steps {
                sh 'terraform apply -auto-approve'
            }
        }
        stage('trigger deployment pipeline') {
            when {
                expression {
                    return params.ACTION == 'Apply'
                }
            }
            steps {
                build job: "iti-final-project-app-pipeline", wait: true
            }
        }
        stage('Destroy') {
            when {
                expression {
                    return params.ACTION == 'Destroy'
                }
            }
            steps {
                sh 'terraform destroy -auto-approve'
            }
        }
    }
}
