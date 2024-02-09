pipeline {
    agent any
    environment {
        AWS_DEFAULT_REGION = 'us-east-1'
        AWS_ACCOUNT_ID = '949108207608'
        ECR_REPOSITORY = 'jenkinsecs'
        IMAGE_TAG = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${ECR_REPOSITORY}:latest"
        ECS_CLUSTER_NAME = 'nodejs'
        ECS_SERVICE_NAME = 'jenkins-svc'
    }
    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build(IMAGE_TAG)
                }
            }
        }
        stage('Push to ECR') {
            steps {
                script {
                    sh 'aws ecr-public get-login-password --region us-east-1 | docker login --username AWS --password-stdin public.ecr.aws/f0c8t3z1'
                    docker.withRegistry('', 'ecr:us-east-1:949108207608') {
                        docker.image(IMAGE_TAG).push()
                    }
                }
            }
        }
        stage('Deploy to ECS') {
            steps {
                script {
                    sh """
                    aws ecs update-service --cluster ${ECS_CLUSTER_NAME} --service ${ECS_SERVICE_NAME} --force-new-deployment
                    """
                }
            }
        }
    }
}
