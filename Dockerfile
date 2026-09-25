# Etapa 1: Build da aplicação usando Gradle com Java 21
FROM gradle:8.5-jdk21 AS build

WORKDIR /app

# Copia todo o conteúdo da pasta condservice
COPY . .

# Compila o JAR do Spring Boot desativando os testes
RUN gradle bootJar --no-daemon -x test -Dorg.gradle.jvmargs="-Xmx384m -XX:MaxMetaspaceSize=192m"

# Etapa 2: Imagem final leve para execução (JRE 21)
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copia o JAR compilado para a imagem de execução
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]