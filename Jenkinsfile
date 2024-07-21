pipeline {
    agent any
    environment {
        PACKER_FILE = "main.pkr.hcl"
    }
    parameters {
        choice(name: 'SUB_FOLDER', choices: ['AMI-Jenkins', 'AMI-EKS-node', 'AMI-EC2'], description: 'Select the sub-folder where packer file is')
    }
    stages {
        stage('clean Workspace'){
            steps{
                cleanWs()
            }
        }
        stage ('Checkout code') {
            steps {
                git branch: 'main', url: 'https://github.com/Barney7777/petclinic-packer-ami.git'
            }
        }
        stage ('packer init') {
            steps {
                dir("Packer-AMI/${params.SUB_FOLDER}") {
                    script {
                        echo "Initializing Packer"
                        sh "packer init $PACKER_FILE"
                    }
                }
            }
        }
        stage ('packer fmt') {
            steps {
                dir("Packer-AMI/${params.SUB_FOLDER}") {
                    script {
                        echo "formatting Packer"
                        sh "packer fmt $PACKER_FILE"
                    }
                }
            }
        }

        stage ('packer validate') {
            steps {
                dir("Packer-AMI/${params.SUB_FOLDER}") {
                    script {
                        echo "validating Packer"
                        sh "packer validate $PACKER_FILE"
                    }
                }
            }
        }

        stage ('packer build ami') {
            steps {
                dir("Packer-AMI/${params.SUB_FOLDER}") {
                    script {
                        echo "Building Packer"
                        sh "packer build $PACKER_FILE"
                    }
                }
            }
        }
    }
}