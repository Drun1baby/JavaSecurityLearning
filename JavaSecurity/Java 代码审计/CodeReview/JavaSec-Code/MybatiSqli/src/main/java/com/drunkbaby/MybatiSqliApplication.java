package com.drunkbaby;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
@MapperScan("com.drunkbaby.mapper")
public class MybatiSqliApplication {

    public static void main(String[] args) {
        SpringApplication.run(MybatiSqliApplication.class, args);
    }

}
