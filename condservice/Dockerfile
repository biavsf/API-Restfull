# ==========================================
# ETAPA 1: Build da aplicação
# ==========================================
FROM eclipse-temurin:17-jdk-alpine AS build

WORKDIR /app

# Instala o dos2unix para evitar erros de linha do Windows (CRLF vs LF)
RUN apk add --no-cache dos2unix

# Copia apenas os arquivos do Gradle primeiro para aproveitar o cache de camadas do Docker
COPY gradlew .
COPY gradle ./gradle
COPY build.gradle.kts settings.gradle.kts ./

# Corrige quebra de linha e permissão do script gradlew
RUN dos2unix gradlew && chmod +x gradlew

# Baixa as dependências do projeto (otimiza builds futuros)
RUN ./gradlew dependencies --no-daemon

# Copia todo o código fonte da aplicação
COPY src ./src

# Executa o build para gerar o arquivo JAR (ignorando testes)
RUN ./gradlew bootJar --no-daemon -x test -Dorg.gradle.jvmargs="-Xmx1g"

# ==========================================
# ETAPA 2: Imagem final leve para execução
# ==========================================
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Cria um usuário sem privilégios de root por segurança
RUN addgroup -S spring && adduser -S spring -G spring
USER spring:spring

# Copia o JAR gerado na etapa de build
COPY --from=build /app/build/libs/*.jar app.jar

# Expõe a porta padrão do Spring Boot
EXPOSE 8080

# Configurações de memória do JVM para container e comando de inicialização
ENTRYPOINT ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]