FROM tomcat

COPY target/hello-world-war-1.0.0.war /var/lib/tomcat9/webapps/
COPY target/hello-world-war-1.0.0/ /var/lib/tomcat9/webapps/

EXPOSE 8080

