package com.drunkbaby.controller;


import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.util.Base64;

@RestController
@RequestMapping("/cc")
public class CChains {

    private static Logger logger = LoggerFactory.getLogger(CChains.class);

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
}
