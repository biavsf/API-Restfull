plugins {
	id 'org.springframework.boot' version '3.2.4'
	id 'io.spring.dependency-management' version '1.1.4'

	id 'org.jetbrains.kotlin.jvm' version '1.9.23'
	id 'org.jetbrains.kotlin.plugin.spring' version '1.9.23'
	id 'org.jetbrains.kotlin.plugin.jpa' version '1.9.23'
}

group = "com.example"
version = "0.0.1-SNAPSHOT"

java {
	toolchain {
		languageVersion = JavaLanguageVersion.of(25)
	}
}

repositories {
	mavenCentral()
}

dependencies {
	implementation 'org.springframework.boot:spring-boot-starter-web'
	implementation 'org.springframework.boot:spring-boot-starter-data-jpa'

	implementation 'org.jetbrains.kotlin:kotlin-reflect'
	implementation 'com.fasterxml.jackson.module:jackson-module-kotlin'

	runtimeOnly 'com.h2database:h2'

	testImplementation 'org.springframework.boot:spring-boot-starter-test'
	testImplementation 'org.jetbrains.kotlin:kotlin-test-junit5'
}

kotlin {
	compilerOptions {
		freeCompilerArgs.addAll(
			"-Xjsr305=strict",
			"-Xannotation-default-target=param-property"
		)
	}
}

allOpen {
	annotation("jakarta.persistence.Entity")
	annotation("jakarta.persistence.MappedSuperclass")
	annotation("jakarta.persistence.Embeddable")
}

tasks.withType(Test).configureEach {
	useJUnitPlatform()
}
