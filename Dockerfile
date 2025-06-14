FROM alpine:3.22.0
LABEL authors="zandome"
RUN apk update && apk add --no-cache libstdc++ findutils
COPY build/native/nativeCompile/tranzport /app
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["/app"]