package com.drunkbaby.starter;

import com.drunkbaby.pojo.HelloWorld;
import javafx.application.Application;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

// 第一个 Demo

public class MainTestDemo {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("Demo.xml");
        HelloWorld helloWorld = context.getBean("helloWorld", HelloWorld.class);
        helloWorld.getMessage();
    }
}
