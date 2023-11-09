package com.drunkbaby;

import java.lang.instrument.Instrumentation;

import static java.lang.Thread.sleep;

public class Java_Agent_agentmain {
    public static void agentmain(String args, Instrumentation inst) throws InterruptedException {
        while (true){
            System.out.println("调用了agentmain-Agent!");
            sleep(3000);
        }
    }
}