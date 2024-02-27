package com.drunkbaby.javagent;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.lang.instrument.Instrumentation;
import java.lang.instrument.UnmodifiableClassException;

public class PreMain {
    public static void premain(String agentArgs, Instrumentation inst) throws IOException, UnmodifiableClassException {
        // 先测试一次使用ProcessBuilder获取当前路径
        System.out.println("\n");
        ProcessBuilder processBuilder = new ProcessBuilder();
        processBuilder.command("cmd", "/c", "chdir");
        Process process = processBuilder.start();
        BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(process.getInputStream(), "gbk"));
        System.out.println(bufferedReader.readLine());

        // 添加ClassFileTransformer类
        ProcessBuilderHook processBuilderHook = new ProcessBuilderHook(inst);
        inst.addTransformer(processBuilderHook, true);

        // 获取所有jvm中加载过的类
        Class[] allLoadedClasses = inst.getAllLoadedClasses();
        for (Class aClass : allLoadedClasses) {
            if (inst.isModifiableClass(aClass) && !aClass.getName().startsWith("java.lang.invoke.LambdaForm")){
                // 调用instrumentation中所有的ClassFileTransformer#transform方法，实现类字节码修改
                inst.retransformClasses(new Class[]{aClass});
            }
        }
        System.out.println("++++++++++++++++++hook finished++++++++++++++++++\n");
    }
}
