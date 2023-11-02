FROM azul/zulu-openjdk:20-jre-headless
WORKDIR /usr/src/app/java
COPY apiLoocaTeste1-1.0-SNAPSHOT-jar-with-dependencies.jar .
CMD ['java', 'apiLoocaTeste1-1.0-SNAPSHOT-jar-with-dependencies.jar']