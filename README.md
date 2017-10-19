# jenkinsci-zato-api-test
Jenkins Slave ZATO API testing Docker image

# run image
docker run -d -e JENKINS_URL=jenkins-url -e JENKINS_AGENT_NAME=jenkins-node-name -e JENKINS_SECRET=jenkins-node-secret kineticskunk/jenkinsci-zato-api-testing:latest

# read up on zato api test
Runs Zato API Test (https://github.com/zatosource/zato-apitest)
