FROM alpine:3.22.0
LABEL authors="zandome"
RUN apk add --no-cache libstdc++
COPY build/native/nativeCompile/tranzport /app
ENV PORT=8080
EXPOSE 8080
ENTRYPOINT ["/app"]