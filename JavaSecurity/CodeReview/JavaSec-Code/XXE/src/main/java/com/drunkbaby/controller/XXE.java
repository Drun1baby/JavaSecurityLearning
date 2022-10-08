package com.drunkbaby.controller;

import org.dom4j.DocumentHelper;
import org.dom4j.io.SAXReader;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;

import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.helpers.XMLReaderFactory;
import org.xml.sax.XMLReader;

import java.io.*;

import org.xml.sax.InputSource;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.SAXParserFactory;
import javax.xml.parsers.SAXParser;

import org.xml.sax.helpers.DefaultHandler;
import org.apache.commons.digester3.Digester;
import org.jdom2.input.SAXBuilder;
import com.drunkbaby.utils.WebUtils;

/**
 * Java xxe vuln and security code.
 *
 * @author JoyChou @2017-12-22
 */

@RestController
@RequestMapping("/xxe")
public class XXE {

    private static Logger logger = LoggerFactory.getLogger(XXE.class);
    private static String EXCEPT = "xxe except";

    @PostMapping("/xmlReader/vuln")
    public String xmlReaderVuln(HttpServletRequest request) {
        try {
            String body = WebUtils.getRequestBody(request);
            logger.info(body);
            XMLReader xmlReader = XMLReaderFactory.createXMLReader();
            xmlReader.parse(new InputSource(new StringReader(body)));  // parse xml
            return "xmlReader xxe vuln code";
        } catch (Exception e) {
            logger.error(e.toString());
            return EXCEPT;
        }
    }

    @RequestMapping(value = "/SAXBuilder/vuln", method = RequestMethod.POST)
    public String SAXBuilderVuln(HttpServletRequest request) {
        try {
            String body = WebUtils.getRequestBody(request);
            logger.info(body);

            SAXBuilder builder = new SAXBuilder();
            // org.jdom2.Document document
            builder.build(new InputSource(new StringReader(body)));  // cause xxe
            return "SAXBuilder xxe vuln code";
        } catch (Exception e) {
            logger.error(e.toString());
            return EXCEPT;
        }
    }

    @RequestMapping(value = "/SAXReader/vuln", method = RequestMethod.POST)
    public String SAXReaderVuln(HttpServletRequest request) {
        try {
            String body = WebUtils.getRequestBody(request);
            logger.info(body);

            SAXReader reader = new SAXReader();
            // org.dom4j.Document document
            reader.read(new InputSource(new StringReader(body))); // cause xxe

        } catch (Exception e) {
            logger.error(e.toString());
            return EXCEPT;
        }

        return "SAXReader xxe vuln code";
    }

    @RequestMapping(value = "/SAXParser/vuln", method = RequestMethod.POST)
    public String SAXParserVuln(HttpServletRequest request) {
        try {
            String body = WebUtils.getRequestBody(request);
            logger.info(body);

            SAXParserFactory spf = SAXParserFactory.newInstance();
            SAXParser parser = spf.newSAXParser();
            parser.parse(new InputSource(new StringReader(body)), new DefaultHandler());  // parse xml

            return "SAXParser xxe vuln code";
        } catch (Exception e) {
            logger.error(e.toString());
            return EXCEPT;
        }
    }

    @RequestMapping(value = "/Digester/vuln", method = RequestMethod.POST)
    public String DigesterVuln(HttpServletRequest request) {
        try {
            String body = WebUtils.getRequestBody(request);
            logger.info(body);

            Digester digester = new Digester();
            digester.parse(new StringReader(body));  // parse xml
        } catch (Exception e) {
            logger.error(e.toString());
            return EXCEPT;
        }
        return "Digester xxe vuln code";
    }

    // 有回显
    @RequestMapping(value = "/DocumentBuilder/vuln", method = RequestMethod.POST)
    public String DocumentBuilderVuln01(HttpServletRequest request) {
        try {
            String body = WebUtils.getRequestBody(request);
            logger.info(body);
            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            DocumentBuilder db = dbf.newDocumentBuilder();
            StringReader sr = new StringReader(body);
            InputSource is = new InputSource(sr);
            Document document = db.parse(is);  // parse xml

            // 遍历xml节点name和value
            StringBuilder buf = new StringBuilder();
            NodeList rootNodeList = document.getChildNodes();
            for (int i = 0; i < rootNodeList.getLength(); i++) {
                Node rootNode = rootNodeList.item(i);
                NodeList child = rootNode.getChildNodes();
                for (int j = 0; j < child.getLength(); j++) {
                    Node node = child.item(j);
                    buf.append(String.format("%s: %s\n", node.getNodeName(), node.getTextContent()));
                }
            }
            sr.close();
            return buf.toString();
        } catch (Exception e) {
            logger.error(e.toString());
            return EXCEPT;
        }
    }


    @RequestMapping(value = "/DocumentBuilder/xinclude/vuln", method = RequestMethod.POST)
    public String DocumentBuilderXincludeVuln(HttpServletRequest request) {
        try {
            String body = WebUtils.getRequestBody(request);
            logger.info(body);

            DocumentBuilderFactory dbf = DocumentBuilderFactory.newInstance();
            dbf.setXIncludeAware(true);   // 支持XInclude
            dbf.setNamespaceAware(true);  // 支持XInclude
            DocumentBuilder db = dbf.newDocumentBuilder();
            StringReader sr = new StringReader(body);
            InputSource is = new InputSource(sr);
            Document document = db.parse(is);  // parse xml

            NodeList rootNodeList = document.getChildNodes();
            response(rootNodeList);

            sr.close();
            return "DocumentBuilder xinclude xxe vuln code";
        } catch (Exception e) {
            logger.error(e.toString());
            return EXCEPT;
        }
    }


    /**
     * 修复该漏洞只需升级dom4j到2.1.1及以上，该版本及以上禁用了ENTITY；
     * 不带ENTITY的PoC不能利用，所以禁用ENTITY即可完成修复。
     */

    @PostMapping("/DocumentHelper/vuln")
    public String DocumentHelper(HttpServletRequest req) {
        try {
            String body = WebUtils.getRequestBody(req);
            DocumentHelper.parseText(body); // parse xml
        } catch (Exception e) {
            logger.error(e.toString());
            return EXCEPT;
        }

        return "DocumentHelper xxe vuln code";
    }


    private static void response(NodeList rootNodeList){
        for (int i = 0; i < rootNodeList.getLength(); i++) {
            Node rootNode = rootNodeList.item(i);
            NodeList xxe = rootNode.getChildNodes();
            for (int j = 0; j < xxe.getLength(); j++) {
                Node xxeNode = xxe.item(j);
                // 测试不能blind xxe，所以强行加了一个回显
                logger.info("xxeNode: " + xxeNode.getNodeValue());
            }

        }
    }

    public static void main(String[] args)  {
    }

}