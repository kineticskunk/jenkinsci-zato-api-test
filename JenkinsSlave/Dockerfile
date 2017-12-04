# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# NOTE: DO *NOT* EDIT THIS FILE.  IT IS GENERATED.
# PLEASE UPDATE Dockerfile.txt INSTEAD OF THIS FILE
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
FROM kinetic/jenkinsci:local
LABEL authors=skunk

USER root

ARG VERSION=3.9

RUN curl --create-dirs -sSLo /usr/share/jenkins/slave.jar https://repo.jenkins-ci.org/public/org/jenkins-ci/main/remoting/${VERSION}/remoting-${VERSION}.jar \
  && chmod 755 /usr/share/jenkins \
  && chmod 644 /usr/share/jenkins/slave.jar

ENV JENKINS_HOME /home/jenkins
RUN groupadd -g 10000 jenkins
RUN useradd -c "Jenkins user" -d $JENKINS_HOME -u 10000 -g 10000 -m jenkins \
	&& usermod -aG sudo jenkins \
	&& chown jenkins:jenkins -R /home/jenkins 

RUN mkdir /home/jenkins/.jenkins
VOLUME /home/jenkins/.jenkins
WORKDIR /home/jenkins
RUN chown jenkins:jenkins -R /home/jenkins 

ENV PATH $PATH:/opt/bin/jenkins-slave
RUN echo $PATH
COPY jenkins-slave /opt/bin/jenkins-slave

CMD ["/opt/bin/jenkins-slave"]