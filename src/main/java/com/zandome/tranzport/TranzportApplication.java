package com.zandome.tranzport;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;
import reactor.core.publisher.Flux;

import java.io.IOException;
import java.time.Duration;
import java.util.List;

@SpringBootApplication
@RestController
public class TranzportApplication {

    public static void main(String[] args) throws IOException {
        SpringApplication.run(TranzportApplication.class, args);
    }

    @GetMapping("/hello")
    public String hello() {
        return "Hello, World!";
    }

    @GetMapping("/products")
    public Flux<String> getAllProducts() {
        return Flux.fromIterable(List.of("Product A", "Product B", "Product C"))
                .delayElements(Duration.ofSeconds(1)); // Simulate stream
    }
}
