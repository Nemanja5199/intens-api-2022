FROM maven:3.8.4-openjdk-8 AS builder

WORKDIR /app

COPY pom.xml .

RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn package -DskipTests

FROM openjdk:8-jre-alpine

WORKDIR /app

COPY --from=builder /app/target/*.jar ./app.jar

ENV PORT=8080

EXPOSE $PORT

CMD ["java","-jar","app.jar"]