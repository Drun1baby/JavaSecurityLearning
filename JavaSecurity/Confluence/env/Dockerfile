FROM openjdk:11-jdk-bullseye

COPY atlassian-confluence-8.5.3.zip /
COPY confluence.cfg.xml /var/data/confluence/confluence.cfg.xml

RUN unzip atlassian-confluence-8.5.3.zip && \ 
    mv atlassian-confluence-8.5.3 atlassian-confluence && \
    mkdir -p /var/data/confluence/ && \
    mkdir -p /var/data/clusters && \
    echo ' ' >> /atlassian-confluence/confluence/WEB-INF/classes/confluence-init.properties && \
    echo 'confluence.home=/var/data/confluence/' >> /atlassian-confluence/confluence/WEB-INF/classes/confluence-init.properties
