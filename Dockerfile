# Etapa 1: Build da aplicação usando a imagem oficial do Gradle com Java 21
FROM gradle:8.5-jdk21 AS build

WORKDIR /app

# Copia todo o código-fonte do projeto para dentro do contêiner
COPY . .

# Compila o projeto gerando o JAR do Spring Boot sem rodar os testes
RUN gradle bootJar --no-daemon -x test

# Etapa 2: Imagem final leve apenas para execução (JRE 21)
FROM eclipse-temurin:21-jre

WORKDIR /app

# Copia o JAR gerado (ignorando arquivos -plain.jar)
COPY --from=build /app/build/libs/*[!plain].jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]