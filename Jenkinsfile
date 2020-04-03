pipeline {
    agent none 
    stages {
        stage('Versioning') {
            steps {
                echo 'Versioning'
            }
        }
        stage('Static Code Analysis') {
            steps {
                echo 'Static code Analysis'
            }
        }
        stage('Artifact Upload') {
            steps {
                echo 'If needed - Artifact Upload'
            }
        }
        stage('Deploy') {
            agent { docker 'hashicorp/terraform' } 
            stages{
                stage('Dev'){
                    steps {
                        sh "ls"
                        dir("Terraform/lambda/getProducts"){
                            sh "terraform init"
                        }
                    }
                }
                stage('QA'){
                    steps {
                        echo 'To QA'
                    }
                }
                stage('Stage'){
                    steps {
                        echo 'to Stage'
                    }
                }
                stage('Prod'){
                    steps {
                        echo 'to Prod'
                    }
                }
            }
        }
        stage('Automated Testin') {
            agent { docker 'openjdk:8-jre' } 
            steps {
                echo 'Testing...'
            }
        }
        stage('Tagging') {
            agent { docker 'openjdk:8-jre' } 
            steps {
                echo 'Tagging...'
            }
        }
    }
}