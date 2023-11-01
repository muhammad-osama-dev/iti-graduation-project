pipeline {
    agent any
    parameters {
        choice(name: 'ACTION', choices: ['Apply', 'Destroy'], description: 'Select an action')
    }
    stages {
        stage('Initialize') {
            steps {
                sh 'terraform init -input=false'
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
