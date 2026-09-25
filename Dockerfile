# Etapa 1: Build com Java 21
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

# Copia os arquivos do Gradle (usando * para cobrir .gradle e .gradle.kts)
COPY gradlew .
COPY gradle gradle
COPY build.gradle* settings.gradle* ./

# Permissão e download de dependências
RUN chmod +x gradlew
RUN ./gradlew dependencies --no-daemon || true

# Copia todo o código-fonte
COPY . .

# Compila a aplicação
RUN ./gradlew bootJar --no-daemon

# Etapa 2: Imagem final leve (JRE 21)
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/build/libs/*[!plain].jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]