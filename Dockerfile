# Etapa 1: Build com a imagem oficial do Gradle e Java 21
FROM gradle:8.5-jdk21 AS build

WORKDIR /app

# Copia todo o código-fonte
COPY . .

# Compila o JAR do Spring Boot limitando o uso de memória no Render
RUN gradle bootJar --no-daemon -x test -Dorg.gradle.jvmargs="-Xmx384m -XX:MaxMetaspaceSize=192m"

# Etapa 2: Imagem final leve (JRE 21)
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/build/libs/*[!plain].jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]