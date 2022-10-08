package com.drunkbaby.controller;

import com.drunkbaby.security.SSRFException;
import com.drunkbaby.security.SecurityUtil;
import com.drunkbaby.util.HttpUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.io.IOException;

@RestController
@RequestMapping("/ssrf")
public class SecSSRF {

    private static Logger logger = LoggerFactory.getLogger(SecSSRF.class);

    @GetMapping("/urlConnection/sec")
    public String URLConnectionSec(String url) {
        if (!SecurityUtil.isHttp(url)) {
            return "[-] SSRF check failed";
        }

        try {
            SecurityUtil.startSSRFHook();
            return HttpUtils.URLConnection(url);
        } catch (SSRFException | IOException exception) {
            return exception.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }
    }

    @GetMapping("/HttpURLConnection/sec")
    public String httpURLConnection(@RequestParam String url) {
        try {
            SecurityUtil.startSSRFHook();
            return HttpUtils.HttpURLConnection(url);
        } catch (SSRFException | IOException e) {
            return e.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }
    }

    @GetMapping("/request/sec")
    public String request(@RequestParam String url) {
        try {
            SecurityUtil.startSSRFHook();
            return HttpUtils.request(url);
        } catch (SSRFException | IOException e) {
            return e.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }
    }

    @GetMapping("/ImageIO/sec")
    public String ImageIO(@RequestParam String url) {
        try {
            SecurityUtil.startSSRFHook();
            HttpUtils.imageIO(url);
        } catch (SSRFException | IOException e) {
            return e.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }

        return "ImageIO ssrf test";
    }

    @GetMapping("/okhttp/sec")
    public String okhttp(@RequestParam String url) {

        try {
            SecurityUtil.startSSRFHook();
            return HttpUtils.okhttp(url);
        } catch (SSRFException | IOException e) {
            return e.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }

    }

    @GetMapping("/httpclient/sec")
    public String HttpClient(@RequestParam String url) {

        try {
            SecurityUtil.startSSRFHook();
            return HttpUtils.httpClient(url);
        } catch (SSRFException | IOException e) {
            return e.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }

    }

    @GetMapping("/commonsHttpClient/sec")
    public String commonsHttpClient(@RequestParam String url) {

        try {
            SecurityUtil.startSSRFHook();
            return HttpUtils.commonHttpClient(url);
        } catch (SSRFException | IOException e) {
            return e.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }

    }

    @GetMapping("/Jsoup/sec")
    public String Jsoup(@RequestParam String url) {

        try {
            SecurityUtil.startSSRFHook();
            return HttpUtils.Jsoup(url);
        } catch (SSRFException | IOException e) {
            return e.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }

    }

    @GetMapping("/IOUtils/sec")
    public String IOUtils(String url) {
        try {
            SecurityUtil.startSSRFHook();
            HttpUtils.IOUtils(url);
        } catch (SSRFException | IOException e) {
            return e.getMessage();
        } finally {
            SecurityUtil.stopSSRFHook();
        }

        return "IOUtils ssrf test";
    }

}
