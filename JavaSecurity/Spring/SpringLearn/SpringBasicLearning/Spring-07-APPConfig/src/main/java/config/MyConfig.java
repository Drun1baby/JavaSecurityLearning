package config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Import;
import org.springframework.stereotype.Component;
import pojo.User;

@Configuration
@ComponentScan("pojo")
public class MyConfig {

    @Bean
    public User getUser(){
        return new User();
    }
}
