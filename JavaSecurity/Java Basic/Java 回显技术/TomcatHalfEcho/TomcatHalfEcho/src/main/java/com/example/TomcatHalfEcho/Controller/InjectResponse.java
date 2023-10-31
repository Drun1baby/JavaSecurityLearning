package com.example.TomcatHalfEcho.Controller;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletResponse;

@Controller
@RequestMapping("/vulResponse")
public class InjectResponse {

    @RequestMapping(("/test"))
    @ResponseBody
    public String vulResponse(String input, HttpServletResponse response) throws Exception {
        System.out.println(response);
        return input;
    }
}
