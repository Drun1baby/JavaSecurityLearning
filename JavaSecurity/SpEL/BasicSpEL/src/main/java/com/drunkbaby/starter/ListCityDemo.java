package com.drunkbaby.starter;

import com.drunkbaby.pojo.City;
import com.drunkbaby.service.ListChoseCity;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ListCityDemo {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("city.xml");
        ListChoseCity listChoseCity = context.getBean("listChoseCity",ListChoseCity.class);
        for (City city:listChoseCity.getCity()){
            System.out.println(city.getName());
        }
    }
}
