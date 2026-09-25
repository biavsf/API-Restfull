# Etapa 1: Build da aplicação usando Gradle com Java 21
FROM gradle:8.5-jdk21 AS build

WORKDIR /app

# Copia todos os arquivos da pasta atual para /app
COPY . .

# Compila o JAR do Spring Boot ignorando os testes
RUN gradle bootJar --no-daemon -x test

# Etapa 2: Imagem final leve para execução (JRE 21)
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copia o JAR gerado na etapa de build
COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]