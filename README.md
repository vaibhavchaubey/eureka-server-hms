# Eureka Server HMS

[![Java](https://img.shields.io/badge/Java-21-orange)](https://openjdk.org/projects/jdk/21/)
[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.4-brightgreen)](https://spring.io/projects/spring-boot)
[![Spring Cloud](https://img.shields.io/badge/Spring%20Cloud-2025.0.0-blue)](https://spring.io/projects/spring-cloud)
[![Netflix Eureka](https://img.shields.io/badge/Netflix%20Eureka%20Server-latest-lightgrey)](https://cloud.spring.io/spring-cloud-netflix/)
[![Docker](https://img.shields.io/badge/Docker-Ready-blue)](https://www.docker.com/)

## 🚀 What the Project Does

`eureka-server-hms` is a Spring Cloud Netflix Eureka Server that serves as the **service registry and discovery mechanism** for the Hospital Management System microservices ecosystem. It enables automatic service registration, discovery, and load balancing for all HMS microservices (appointment, profile, billing, etc.). Microservices register themselves with Eureka on startup, and clients can discover service locations without hardcoded URLs. Designed for distributed systems architecture, it provides real-time service availability tracking and fault tolerance in a containerized infrastructure.

## 💡 Why the Project is Useful

- Provides a **centralized service registry** allowing microservices to register and discover each other dynamically.
- Eliminates hardcoded service URLs and enables **seamless service-to-service communication** in the HMS ecosystem.
- Offers a **visual dashboard** to monitor registered services, their health status, and instance information.
- Enables **load balancing and failover** capabilities through client-side discovery patterns.
- Supports scalable, cloud-native architecture for distributed hospital management workflows.
- Reduces operational complexity in deploying and managing multiple microservices.

## ✨ Key Features

- Designed as the **central service registry** for the Hospital Management System microservices.
- Built to automatically register microservices and provide real-time **service discovery** capabilities.
- Implemented with a **web-based dashboard** for visual monitoring of registered services and their instances.
- Configured for **high availability** with support for multiple Eureka instances (peer-to-peer replication).
- Optimized for **fast failover detection** and health status monitoring of registered services.
- Integrated with Spring Cloud ecosystem for seamless **OpenFeign and Ribbon** integration.
- Supports **REST API endpoints** for programmatic service lookup and management.

## 🛠️ Tech Stack

- **Backend:**
  - Java 21
  - Spring Boot 3.5.4
  - Spring Cloud 2025.0.0
  - Spring Cloud Netflix Eureka Server
  - Spring Web
- **DevOps / Tools:**
  - Maven
  - Docker (Dockerfile present)
  - Spring Boot Maven Plugin

## ⚙️ Getting Started (Installation & Setup)

```bash
git clone https://github.com/vaibhavchaubey/eureka-server-hms.git
cd eureka-server-hms
```

### 1. Configure Eureka Server (Optional)

Edit `src/main/resources/application.yml` for custom settings:

```yaml
server:
  port: 8761 # Default Eureka port
spring:
  application:
    name: eureka-server-hms
eureka:
  client:
    register-with-eureka: false # Server itself doesn't register
    fetch-registry: false # Server doesn't fetch registry
```

### 2. Run Locally

```bash
./mvnw clean package
./mvnw spring-boot:run
```

Eureka Server starts on port `8761` by default (browse: `http://localhost:8761`).

### 3. Access Eureka Dashboard

Once running, access the **dashboard** at:

```
http://localhost:8761/
```

The dashboard displays:

- **Registered Instances**: All microservices currently registered
- **Instance Status**: UP, DOWN, OUT_OF_SERVICE for each service
- **Service URLs**: Direct links to service endpoints
- **Health Information**: Last heartbeat, registration/deregistration history

## 🔌 Service Registration (for Microservices)

Microservices register with this Eureka Server by adding the dependency and configuration:

### 1. Add Eureka Client Dependency

In microservice `pom.xml`:

```xml
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

### 2. Configure Microservice

In microservice `application.yml`:

```yaml
spring:
  application:
    name: appointment-microservice-hms # Unique service name
eureka:
  client:
    service-url:
      defaultZone: http://localhost:8761/eureka/
```

### 3. Enable Eureka Client

Add annotation to microservice main class:

```java
@SpringBootApplication
@EnableEurekaClient
public class AppointmentMicroserviceApplication {
    public static void main(String[] args) {
        SpringApplication.run(AppointmentMicroserviceApplication.class, args);
    }
}
```

## 🌐 REST API Endpoints

| Endpoint                                | Method | Description                                    |
| --------------------------------------- | ------ | ---------------------------------------------- |
| `/`                                     | GET    | Dashboard UI                                   |
| `/eureka/apps`                          | GET    | List all registered applications (XML format)  |
| `/eureka/apps.json`                     | GET    | List all registered applications (JSON format) |
| `/eureka/apps/{app-name}`               | GET    | Get specific application instances             |
| `/eureka/apps/{app-name}/{instance-id}` | GET    | Get specific instance details                  |
| `/actuator/health`                      | GET    | Health check endpoint                          |

### Example: Query Registered Services

```bash
curl http://localhost:8761/eureka/apps.json | jq
```

## 🧪 Tests

```bash
./mvnw test
```

## 🚢 Docker (Optional)

### Build Docker Image

```bash
docker build -t eureka-server-hms:latest .
```

### Run Docker Container

```bash
docker run -p 8761:8761 \
  -e PORT=8761 \
  -e SPRING_APPLICATION_NAME=eureka-server-hms \
  eureka-server-hms:latest
```

### Docker Compose (for full HMS stack)

```yaml
version: '3.8'
services:
  eureka-server:
    image: eureka-server-hms:latest
    ports:
      - '8761:8761'
    environment:
      - SPRING_APPLICATION_NAME=eureka-server-hms
      - EUREKA_CLIENT_REGISTER_WITH_EUREKA=false
      - EUREKA_CLIENT_FETCH_REGISTRY=false
```

## 📦 Project Metadata

- **Name**: eureka-server-hms
- **Description**: Eureka Server for Hospital Management System
- **Artifact**: `com.hms.eureka-server:eureka-server-hms:0.0.1-SNAPSHOT`
- **Java Version**: 21
- **Spring Boot**: 3.5.4
- **Spring Cloud**: 2025.0.0

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/your-feature`)
3. Commit your changes (`git commit -m 'Add your feature'`)
4. Add tests if applicable and run `./mvnw test`
5. Push to the branch (`git push origin feature/your-feature`)
6. Open a Pull Request with a clear description and linked issue

## 📝 License

Add your open source / corporate license file at `/LICENSE` (e.g., Apache-2.0, MIT, etc.).

---

**Part of the Hospital Management System (HMS)** - A microservices-based healthcare platform.
