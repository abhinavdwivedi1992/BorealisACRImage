# Pull base image 
From tomcat

# Maintainer 
MAINTAINER "sachinsharm_a@hcl.com" 
RUN apt-get update && apt-get install -y vim
EXPOSE 8080
#CMD ["/usr/local/tomcat/bin/startup.sh", "run"]
CMD ["/usr/local/tomcat/bin/catalina.sh", "run"]
