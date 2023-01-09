package com.drunkbaby.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.Arrays;
import java.util.Base64;

@RestController
public class CChains {

    private static Logger logger = LoggerFactory.getLogger(CChains.class);

    public CChains(){
    }

    /**
     * localhost:8081/cc1
     * POST: EXP=xxx
     * jdk 版本受限制的 CC1 链，要求 jdk 版本 <= jdk8u65，目前我是 jdk8u312 的版本
     * @return
     */

   @GetMapping("/cc1")
   @ResponseBody
   public String CC1(){
        return "CC1 Try Try";
   }

    @PostMapping("/cc1")
    @ResponseBody
    public String CC1(@RequestParam String EXP) throws IOException, ClassNotFoundException {
        if (EXP.equals("")) {
            return "Input the evil EXP";
        } else {
            byte[] exp = Base64.getDecoder().decode(EXP);
            ByteArrayInputStream bytes = new ByteArrayInputStream(exp);
            ObjectInputStream objectInputStream = new ObjectInputStream(bytes);
            objectInputStream.readObject();
            return "Input Success, u receive feedback?";
        }
    }

    /**
     * localhost:8081/cc6
     * POST: EXP=xxx
     * 不受 jdk 版本限制的 CC6 链子
     * @return
     */

    @GetMapping("/cc6")
    @ResponseBody
    public String CC6(){
        return "CC6 Try Try";
    }

    @PostMapping("/cc6")
    @ResponseBody
    public String CC6(@RequestParam String EXP) throws IOException, ClassNotFoundException {
            byte[] exp = Base64.getDecoder().decode(EXP);
            ByteArrayInputStream bytes = new ByteArrayInputStream(exp);
            ObjectInputStream objectInputStream = new ObjectInputStream(bytes);
            objectInputStream.readObject();
            return "Input Success, u receive feedback?";

    }

    /**
     * localhost:8081/cc3
     * POST: EXP=xxx
     * TemplatesImpl 动态加载字节码，CC3 链，我这里过滤了 Runtime.getRuntime().exec() 的命令执行方式
     * @return
     */

    @GetMapping("/cc3")
    @ResponseBody
    public String CC3(){
        return "TemplatesImpl yyds!";
    }

    @PostMapping("/cc3")
    @ResponseBody
    public String CC3(@RequestParam String EXP) throws IOException, ClassNotFoundException {

            byte[] exp = Base64.getDecoder().decode(EXP);
            if (Arrays.toString(exp).contains("Runtime.getRuntime().exec()")){
                return "My dear Hacker! No Runtime Please!";
            }
            else {
                ByteArrayInputStream bytes = new ByteArrayInputStream(exp);
                ObjectInputStream objectInputStream = new ObjectInputStream(bytes);
                objectInputStream.readObject();
                return "Input Success, u receive feedback?";
            }
    }

    /**
     * localhost:8081/cc5
     * POST: EXP=xxx
     * 平平无奇 CC5
     * @return
     */

    @GetMapping("/cc5")
    @ResponseBody
    public String CC5(){
        return "平平无奇 CC5";
    }

    @PostMapping("/cc5")
    @ResponseBody
    public String CC5(@RequestParam String EXP) throws IOException, ClassNotFoundException {
        if (EXP.equals("")) {
            return "Input the evil EXP";
        } else {
            byte[] exp = Base64.getDecoder().decode(EXP);
            ByteArrayInputStream bytes = new ByteArrayInputStream(exp);
            ObjectInputStream objectInputStream = new ObjectInputStream(bytes);
            objectInputStream.readObject();
            return "Input Success, u receive feedback?";
        }
    }


    /**
     * localhost:8081/cc24
     * POST: EXP=xxx
     * CC2 和 CC4 都可以打
     * @return
     */

    @GetMapping("/cc24")
    @ResponseBody
    public String CC24(){
        return "CC2 和 CC4 都可以打";
    }

    @PostMapping("/cc24")
    @ResponseBody
    public String CC24(@RequestParam String EXP) throws IOException, ClassNotFoundException {
        if (EXP.equals("")) {
            return "Input the evil EXP";
        } else {
            byte[] exp = Base64.getDecoder().decode(EXP);
            ByteArrayInputStream bytes = new ByteArrayInputStream(exp);
            ObjectInputStream objectInputStream = new ObjectInputStream(bytes);
            objectInputStream.readObject();
            return "Input Success, u receive feedback?";
        }
    }

    /**
     * localhost:8081/cc11
     * POST: EXP=xxx
     * 用来打 Shiro 的链子，CC11
     * @return
     */

    @GetMapping("/cc11")
    @ResponseBody
    public String CC11(){
        return "用来打 Shiro 的缝合怪 ———— CC11";
    }

    @PostMapping("/cc11")
    @ResponseBody
    public String CC11(@RequestParam String EXP) throws IOException, ClassNotFoundException {
            byte[] exp = Base64.getDecoder().decode(EXP);
            ByteArrayInputStream bytes = new ByteArrayInputStream(exp);
            ObjectInputStream objectInputStream = new ObjectInputStream(bytes);
            objectInputStream.readObject();
            return "Input Success, u receive feedback?";
    }
}

