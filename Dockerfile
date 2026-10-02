# ==========================================
# ETAPA 1: Build
# ==========================================
FROM eclipse-temurin:25-jdk AS build

WORKDIR /app

COPY condservice/ .

RUN chmod +x gradlew

RUN ./gradlew clean bootJar --no-daemon -x test


# ==========================================
# ETAPA 2: Execução
# ==========================================
FROM eclipse-temurin:25-jre

WORKDIR /app

RUN addgroup --system spring && adduser --system spring --ingroup spring

USER spring:spring

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
