# Etapa 1: Build com Java 21
FROM eclipse-temurin:21-jdk AS build

WORKDIR /app

# Copia apenas os arquivos de configuração que existem
COPY gradlew* ./
COPY build.gradle* settings.gradle* ./

# Se você não tiver o gradlew, o comando abaixo garante permissão apenas se o arquivo existir
RUN if [ -f gradlew ]; then chmod +x gradlew; fi

# Copia todo o código para compilar
COPY . .

# Compila a aplicação
RUN if [ -f gradlew ]; then ./gradlew bootJar --no-daemon; else gradle bootJar --no-daemon; fi

# Etapa 2: Imagem final leve (JRE 21)
FROM eclipse-temurin:21-jre

WORKDIR /app

COPY --from=build /app/build/libs/*[!plain].jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]