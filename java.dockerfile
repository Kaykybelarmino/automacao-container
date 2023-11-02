FROM openjdk:19
WORKDIR /usr/src/app/java
COPY app.jar .
CMD ["java", "-jar", "app.jar"]
