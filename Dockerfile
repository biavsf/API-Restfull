FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

COPY condservice/ .

RUN chmod +x gradlew

RUN ./gradlew clean bootJar --no-daemon -x test


FROM eclipse-temurin:21-jre

WORKDIR /app

RUN addgroup --system spring && \
    adduser --system spring --ingroup spring

COPY --from=build /app/build/libs/*.jar app.jar

RUN chown spring:spring app.jar

USER spring

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
