# jenkinsci-zato-api-test
Jenkins Slave ZATO API testing Docker image

docker run -d -e JENKINS_URL=<url> -e JENKINS_AGENT_NAME=<jenkins-node-name> -e JENKINS_SECRET=<jenkins-node-secret> kineticskunk/jenkinsci-zato-api-testing:latest

Runs Zato API Test (https://github.com/zatosource/zato-apitest)
