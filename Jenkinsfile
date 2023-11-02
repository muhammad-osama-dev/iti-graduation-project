pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Select an action')
    }
    stages {
        stage('Initialize') {
            steps {
                sh 'terraform init'
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
                build job: "childJob", wait: true
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
