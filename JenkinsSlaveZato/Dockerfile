# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
# NOTE: DO *NOT* EDIT THIS FILE.  IT IS GENERATED.
# PLEASE UPDATE Dockerfile.txt INSTEAD OF THIS FILE
# !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
FROM kinetic/jenkins-slave-zato-api-testing:local
LABEL authors=skunk

USER root

# No interactive frontend during docker build
ENV DEBIAN_FRONTEND=noninteractive \
    DEBCONF_NONINTERACTIVE_SEEN=true

#========================
# Miscellaneous packages
# Includes minimal runtime used for executing non GUI Python programs
#========================
RUN apt-get install -y libpq-dev libxml2-dev libxslt1-dev python-dev libyaml-dev
RUN apt-get install pip
RUN mkdir -p /opt/zato-apitest/
RUN git clone https://github.com/yodaqua/zato-apitest.git /opt/zato-apitest/
RUN pip install 'six==1.6.1'
RUN pip install 'nose==1.3.3'
RUN chown root:root -R /opt/zato-apitest/ && cd /opt/zato-apitest/ && pip install -r requirements.txt
RUN pip install zato-apitest
RUN pip install -U requests