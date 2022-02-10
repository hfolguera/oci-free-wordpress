pipeline {

  /*
    This is an example Jenkinsfile with a CI/CD pipeline for Terraform configuration.
    The steps in this pipeline include:
    - terraform init
    - terraform validate
    - terraform fmt
    - terraform plan
    - terraform apply

    In order to this pipeline work properly your Jenkins environment must satisfy the following requirements:
    - Have an Agent labeled with terraform and terraform binaries installed
    - Pipeline Utility Steps plugin installed
    - SSH Agent plugin installed
    - OCI Credentials created
  */

  agent {
    label 'terraform'
  }

  /*
    The following variables should be created as Credentials in Jenkins. This credentials are used to connecto to Oracle Cloud Infrastructure.
  */
  environment {
    tenancy_ocid          = credentials('tenancy_ocid')
    user_ocid             = credentials('user_ocid')
    fingerprint           = credentials('fingerprint')
    private_key           = credentials('private_key')
    AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
    AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')

    PATH = "/var/jenkins_home/terraform_temp:${env.PATH}" // Add terraform and terragrunt to PATH
  }

  stages {
    stage('Init') {
      steps {
        ansiColor('xterm') {
          sh 'terraform init'
        }
      }
    }

    stage('Validate') {
      steps {
        ansiColor('xterm') {
          sh 'terraform validate'
        }
      }
    }

    stage('Format') {
      steps {
        ansiColor('xterm') {
          sh 'terraform fmt -recursive -check -diff'
        }
      }
    }

    stage('Plan'){
      steps {
        ansiColor('xterm') {
          withCredentials([
            file(credentialsId: 'private_key', variable: 'TF_VAR_private_key_path'),
          ]) {
            sh 'terraform plan -input=false'
          }
        }
      }
    }

    stage('Approve'){
      steps {
        input ("Please, review the plan output. Apply configuration?")
      }
    }

    stage('Apply'){
      steps {
        ansiColor('xterm') {
          withCredentials([
            file(credentialsId: 'private_key', variable: 'TF_VAR_private_key_path'),
          ]) {
            sh 'terraform apply -input=false'
          }
        }
      }
    }
  }
}
