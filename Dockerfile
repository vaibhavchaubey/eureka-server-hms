# ----------- BUILD STAGE -----------
FROM maven:3.9.10-eclipse-temurin-21 AS build

WORKDIR /app

# Copy everything
COPY . .

# Build the jar
RUN mvn clean package -DskipTests


# ----------- RUNTIME STAGE -----------
FROM eclipse-temurin:21-jre-slim

WORKDIR /app

# Copy jar from build stage
COPY --from=build /app/target/eureka-server-hms-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 8761

ENTRYPOINT ["java", "-jar", "app.jar"]
