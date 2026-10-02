FROM eclipse-temurin:25-jre

WORKDIR /app

RUN addgroup --system spring && \
    adduser --system spring --ingroup spring && \
    mkdir -p /app/data && \
    chown spring:spring /app/data

COPY --from=build /app/build/libs/*.jar app.jar

USER spring:spring

ENTRYPOINT ["java", "-jar", "app.jar"]
