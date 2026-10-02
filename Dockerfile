FROM eclipse-temurin:25-jdk AS build

WORKDIR /app
COPY condservice/ .
RUN chmod +x gradlew
RUN ./gradlew clean bootJar --no-daemon -x test


FROM eclipse-temurin:25-jre

WORKDIR /app

RUN addgroup --system spring && \
    adduser --system spring --ingroup spring

RUN mkdir -p /app/data && \
    chown -R spring:spring /app

COPY --from=build /app/build/libs/*.jar app.jar

USER spring:spring

ENTRYPOINT ["java", "-jar", "app.jar"]
