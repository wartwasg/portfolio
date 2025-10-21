# Stage 1: Build the JAR
FROM maven:3.9.3-eclipse-temurin-21 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Run the app
FROM openjdk:21-jdk-slim
WORKDIR /app
COPY --from=build /app/target/portfolio-0.0.1-SNAPSHOT.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","app.jar"]
