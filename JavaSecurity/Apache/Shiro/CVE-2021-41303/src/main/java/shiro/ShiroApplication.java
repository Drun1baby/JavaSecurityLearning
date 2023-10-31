package shiro;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import shiro.service.UserService;

@SpringBootApplication
public class ShiroApplication {

    @Autowired
    UserService userService;

    public static void main(String[] args) {
        SpringApplication.run(ShiroApplication.class, args);
    }

}
