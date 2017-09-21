FROM java:8
COPY target/mage-0.1.85-SNAPSHOT.jar /usr/src/mage-0.1.85-SNAPSHOT.jar
COPY config.yml /usr/src/config.yml
WORKDIR /usr/src
EXPOSE 8026
EXPOSE 8028
CMD ["java", "-jar", "mage-0.1.85-SNAPSHOT.jar", "server", "config.yml"]
