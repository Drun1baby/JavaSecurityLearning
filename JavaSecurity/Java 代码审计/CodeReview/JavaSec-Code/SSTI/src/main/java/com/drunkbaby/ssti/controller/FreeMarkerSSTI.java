package com.drunkbaby.ssti.controller;

import freemarker.core.TemplateClassResolver;
import freemarker.template.Configuration;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class FreeMarkerSSTI {

    @GetMapping("/freeMarker")
    public String index() {
        return "index";
    }

    @GetMapping("/hello")
    public String hello(Model model, @RequestParam(value="name", required=false, defaultValue="Drunkbaby") String name) {
        model.addAttribute("name", name);
        return "hello";
    }
}
