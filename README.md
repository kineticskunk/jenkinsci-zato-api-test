# jenkinsci-zato-api-test
Jenkins Slave ZATO API testing Docker image

## pull image
docker pull kineticskunk/jenkinsci-zato-api-testing:1.0.0
current verion = 1.0.0 (05-12-2017)

## build images
From commandline: VERSION='version' NAMESPACE='organisation_name' AUTHORS='whatever_you_call_yourself' make build

## run image
docker run -d -e JENKINS_URL='jenkins-url' -e JENKINS_AGENT_NAME='jenkins-node-name' -e JENKINS_SECRET='jenkins-node-secret' organisation_name/image_name:image_tag

## read up on zato api test
Runs Zato API Test
1. https://github.com/zatosource/zato-apitest
2. https://zato.io/blog/posts/apitest-start.html

## behaviour driven testing
ZATO uses python behave testing framework for test design and execution. Goto https://jenisys.github.io/behave.example
