# Etapa 1: Compilación del binario nativo con GraalVM
FROM ghcr.io/graalvm/native-image-community:21.0.2-ol9-20240116 AS builder

# RUN echo " --- Java version:"; java --version; echo "$JAVA_HOME" ; echo
# RUN echo " --- Graal version:"; native-image --version; echo "$GRAALVM_HOME" ; echo
# ENV JAVA_HOME=/opt/graalvm
# ENV PATH="$JAVA_HOME/bin:$PATH"
RUN echo " --- Java version:"
RUN java --version
RUN echo "$JAVA_HOME"
RUN echo " --- Graal version:"
RUN native-image --version
RUN echo "$GRAALVM_HOME"
# RUN gu install native-image

RUN microdnf install -y findutils
# Crea un directorio de trabajo
WORKDIR /app

# Copia el código fuente al contenedor
COPY . .

# Si usas Gradle:
RUN ./gradlew nativeCompile --no-fallback --no-daemon --stacktrace

FROM oraclelinux:9-slim
LABEL authors="zandome"
# USER root
RUN microdnf install -y zlib libstdc++ libgcc shadow-utils

RUN groupadd -r spring && useradd -r -g spring spring
USER spring:spring

WORKDIR /app
# COPY --from=builder /app/target/tranzport /app/app
COPY --from=builder /app/build/native/nativeCompile/tranzport ./tranzport

# Establece el directorio de trabajo
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["./tranzport"]