FROM ubuntu:24.04

# Install OpenJDK 11, wget, and tar
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget tar && \
    rm -rf /var/lib/apt/lists/*

# Set environment variable for JAVA_HOME
ENV JAVA_HOME=/usr/lib/jvm/java-11-openjdk-amd64
ENV PATH="$JAVA_HOME/bin:${PATH}"

# Download and extract Tomcat
RUN wget https://archive.apache.org/dist/tomcat/tomcat-9/v9.0.108/bin/apache-tomcat-9.0.108.tar.gz -P /tmp && \
    tar -xvzf /tmp/apache-tomcat-9.0.108.tar.gz -C /opt && \
    mv /opt/apache-tomcat-9.0.108 /opt/tomcat && \
    rm /tmp/apache-tomcat-9.0.108.tar.gz

# Set working directory
WORKDIR /opt/tomcat

# Copy WAR file into Tomcat webapps
COPY Amazon.war /opt/tomcat/webapps/

# Expose port 8080
EXPOSE 8080

# Start Tomcat
CMD ["/opt/tomcat/bin/catalina.sh", "run"]

