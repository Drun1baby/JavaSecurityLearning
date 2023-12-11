package com.drunkbaby.ssti.VulTest;

import org.apache.velocity.Template;
import org.apache.velocity.VelocityContext;
import org.apache.velocity.app.VelocityEngine;

import java.io.StringWriter;
import java.util.Properties;

public class test {
    public static void main(String[] args) throws Exception {
        Properties p = new Properties();
        VelocityEngine velocity = new VelocityEngine();
        velocity.init(p);

        Template template = velocity.getTemplate("test.vm");
        VelocityContext context = new VelocityContext();
        StringWriter writer = new StringWriter();
        template.merge(context, writer);
        writer.flush();
        System.out.println(writer.toString());
    }
}
