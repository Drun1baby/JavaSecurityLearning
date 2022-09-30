package com.drunkbaby.starter;

import com.drunkbaby.service.ChoseCity;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class CityDemo {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("city.xml");
        ChoseCity c = (ChoseCity)context.getBean("choseCity");
        System.out.println(c.getCity().getName());
    }
}
