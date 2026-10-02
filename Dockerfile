# ==========================================
# ETAPA 1: Build
# ==========================================
FROM eclipse-temurin:25-jdk-alpine AS build

WORKDIR /app

RUN apk add --no-cache dos2unix

COPY . .

RUN dos2unix gradlew && chmod +x gradlew

RUN ./gradlew bootJar --no-daemon -x test -Dorg.gradle.jvmargs="-Xmx1g"

# ==========================================
# ETAPA 2: Execução
# ==========================================
FROM eclipse-temurin:25-jre-alpine

WORKDIR /app

RUN addgroup -S spring && adduser -S spring -G spring

USER spring:spring

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
