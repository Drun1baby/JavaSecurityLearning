package ysoserial.payloads.util;

import java.io.*;

public class CmdUtils {

    public static String readStringFromInputStream(InputStream inputStream) throws Exception{
        StringBuilder stringBuilder = new StringBuilder("");
        byte[] bytes = new byte[1024];
        int n = 0;
        while ((n=inputStream.read(bytes)) != -1){
            stringBuilder.append(new String(bytes,0,n));
        }
        return stringBuilder.toString();
    }

    public static byte[] getBytes(String path) throws Exception{
        InputStream inputStream = new FileInputStream(path);
        ByteArrayOutputStream byteArrayOutputStream = new ByteArrayOutputStream();
        int n = 0;
        while ((n=inputStream.read())!=-1){
            byteArrayOutputStream.write(n);
        }
        byte[] bytes = byteArrayOutputStream.toByteArray();
        return bytes;
    }


    public static byte[] readClassByte(String filename) throws IOException{
        File f = new File(filename);
        if (!f.exists()) {
            throw new FileNotFoundException(filename);
        }
        ByteArrayOutputStream bos = new ByteArrayOutputStream((int) f.length());
        BufferedInputStream in = null;
        try {
            in = new BufferedInputStream(new FileInputStream(f));
            int buf_size = 1024;
            byte[] buffer = new byte[buf_size];
            int len = 0;
            while (-1 != (len = in.read(buffer, 0, buf_size))) {
                bos.write(buffer, 0, len);
            }
            return bos.toByteArray();
        } catch (IOException e) {
            e.printStackTrace();
            throw e;
        } finally {
            try {
                in.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            bos.close();
        }
    }

    public static String getCodeFile(String codefile) {
        try{
            File file = new File(codefile);
            if (file.exists()){
                FileReader reader = new FileReader(file);
                BufferedReader bufferedReader = new BufferedReader(reader);
                StringBuilder sb = new StringBuilder("");
                String line = "";
                while ((line=bufferedReader.readLine()) != null){
                    sb.append(line);
                    sb.append("\r\n");
                }
                return sb.toString();
            } else {
                System.err.println(String.format("[-] %s is not exists!",codefile));
                System.exit(0);
                return null;
            }
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }
}
