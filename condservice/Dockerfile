# ==========================================
# ETAPA 1: Build da aplicação
# ==========================================
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Instala o utilitário para converter quebras de linha do Windows (CRLF -> LF)
RUN apk add --no-cache dos2unix

# Copia TODOS os arquivos do projeto de uma vez
COPY . .

# Garante a formatação e as permissões de execução do script do Gradle
RUN dos2unix gradlew && chmod +x gradlew

# Executa o build da aplicação ignorando os testes
RUN ./gradlew bootJar --no-daemon -x test -Dorg.gradle.jvmargs="-Xmx1g"

# ==========================================
# ETAPA 2: Imagem final leve para execução
# ==========================================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Cria usuário sem privilégios de root por segurança
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copia o arquivo .jar gerado na etapa anterior
COPY --from=build /app/build/libs/*.jar app.jar

# Porta padrão exposta pelo Spring Boot
EXPOSE 8080

# Comando para iniciar a aplicação
ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]