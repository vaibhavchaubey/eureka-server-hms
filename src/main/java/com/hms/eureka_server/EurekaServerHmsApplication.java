package com.hms.eureka_server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@EnableEurekaServer
public class EurekaServerHmsApplication {

	public static void main(String[] args) {
		SpringApplication.run(EurekaServerHmsApplication.class, args);
	}

}
