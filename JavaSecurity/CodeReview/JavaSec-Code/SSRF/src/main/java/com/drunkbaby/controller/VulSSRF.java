package com.drunkbaby.controller;


import com.drunkbaby.util.HttpUtils;
import com.drunkbaby.util.WebUtils;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;

@RestController
@RequestMapping("/ssrf")
public class VulSSRF {

    private static Logger logger = LoggerFactory.getLogger(VulSSRF.class);

    /**
     * http://127.0.0.1:8081/ssrf/urlConnection/vuln?url=file:///E:/1.txt (etc/passwd
     * @param url
     * @return
     * 毫无防护的 SSRF 攻击
     */

    @RequestMapping(value = "/urlConnection/vuln", method = {RequestMethod.POST, RequestMethod.GET})
    public String URLConnectionVuln(String url) {
        return HttpUtils.URLConnection(url);
    }


    @GetMapping("/openStream")
    public void openStream(@RequestParam String url, HttpServletResponse response) throws IOException {
        InputStream inputStream = null;
        OutputStream outputStream = null;

        try {
            String downLoadImgFileName = WebUtils.getNameWithoutExtension(url) + "." + WebUtils.getFileExtension(url);
            // download
            response.setHeader("content-disposition", "attachment;fileName=" + downLoadImgFileName);

            URL u = new URL(url);
            int length;
            byte[] bytes = new byte[1024];
            inputStream = u.openStream();
            while ((length = inputStream.read(bytes)) > 0) {
                outputStream.write(bytes, 0, length);
            }
        } catch (Exception e) {
            logger.error(e.toString());
        } finally {
            if (inputStream != null) {
                inputStream.close();
            }
            if (outputStream != null) {
                outputStream.close();
            }
        }
    }

    @GetMapping("/HttpSyncClients/vuln")
    public String HttpSyncClients(@RequestParam("url") String url) {
        return HttpUtils.HttpAsyncClients(url);
    }
}
