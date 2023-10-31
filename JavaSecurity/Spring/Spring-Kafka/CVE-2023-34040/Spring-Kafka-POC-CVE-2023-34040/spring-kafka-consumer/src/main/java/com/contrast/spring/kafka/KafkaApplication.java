package com.contrast.spring.kafka;

import java.util.concurrent.CountDownLatch;
import java.util.concurrent.TimeUnit;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.kafka.annotation.KafkaListener;

@SpringBootApplication
public class KafkaApplication {




    public static void main(String[] args) throws Exception {


        ConfigurableApplicationContext context = SpringApplication.run(KafkaApplication.class, args);

        MessageListener listener = context.getBean(MessageListener.class);






        /*
         * Sending message to 'greeting' topic. This will send
         * and received a java object with the help of
         * greetingKafkaListenerContainerFactory.
         */
        listener.greetingLatch.await(10, TimeUnit.MINUTES);

        context.close();
    }

    @Bean
    public MessageListener messageListener() {
        return new MessageListener();
    }


    public static class MessageListener {


        private CountDownLatch greetingLatch = new CountDownLatch(1);



        @KafkaListener(topics = "${greeting.topic.name}", containerFactory = "greetingKafkaListenerContainerFactory")
        public void greetingListener(Greeting greeting) {
            System.out.println("Received greeting message: " + greeting);
            this.greetingLatch.countDown();
        }

    }

}
