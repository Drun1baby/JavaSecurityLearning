package com.drunkbaby.starter;

import com.drunkbaby.pojo.TextEditor;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

// T(Type) 表达式

public class RefSpellAndEditor {
    public static void main(String[] args) {
        ApplicationContext context = new ClassPathXmlApplicationContext("editor.xml");

        TextEditor te = (TextEditor) context.getBean("textEditor");
        te.spellCheck();
    }
}