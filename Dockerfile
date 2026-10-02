FROM eclipse-temurin:25-jdk AS build

WORKDIR /app

COPY condservice/ .

RUN chmod +x gradlew

RUN ./gradlew clean bootJar --no-daemon -x test


FROM eclipse-temurin:25-jre

WORKDIR /app

RUN addgroup --system spring && \
    adduser --system spring --ingroup spring

COPY --from=build /app/build/libs/*.jar app.jar

RUN chown spring:spring app.jar

USER spring:spring

EXPOSE 8080

ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
