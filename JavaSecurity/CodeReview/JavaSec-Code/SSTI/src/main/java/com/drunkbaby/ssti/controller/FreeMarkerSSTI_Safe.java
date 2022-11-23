package com.drunkbaby.ssti.controller;

import freemarker.cache.StringTemplateLoader;
import freemarker.core.TemplateClassResolver;
import freemarker.template.Configuration;
import freemarker.template.Template;

import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.StringWriter;
import java.util.HashMap;

public class FreeMarkerSSTI_Safe {
    public static void main(String[] args) throws Exception {

        //设置模板
        HashMap<String, String> map = new HashMap<String, String>();
        // String poc ="<#assign aaa=\"freemarker.template.utility.Execute\"?new()> ${ aaa(\"Calc\") }";
        String poc ="";
        System.out.println(poc);
        StringTemplateLoader stringLoader = new StringTemplateLoader();
        Configuration cfg = new Configuration();
        stringLoader.putTemplate("name",poc);
        cfg.setTemplateLoader(stringLoader);
        // cfg.setNewBuiltinClassResolver(TemplateClassResolver.SAFER_RESOLVER);
        //处理解析模板
        Template Template_name = cfg.getTemplate("name");
        StringWriter stringWriter = new StringWriter();

        Template_name.process(Template_name,stringWriter);


    }
}

