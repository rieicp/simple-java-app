FROM adoptopenjdk/maven-openjdk12 AS simple_app_maven_build

RUN mkdir -p /usr/app
WORKDIR /usr/app

COPY src src/
COPY pom.xml .

RUN mvn clean install;
RUN mv $(find target -name "*simpleSpringAppInK8s*.jar") target/all.jar


FROM openjdk:12-alpine AS simple_app

RUN apk add --no-cache libstdc++

RUN mkdir -p /usr/app/target
WORKDIR /usr/app

COPY --from=simple_app_maven_build /usr/app/target/all.jar /usr/app/target/all.jar

CMD ["sh", "-c", "java -jar target/all.jar"]
