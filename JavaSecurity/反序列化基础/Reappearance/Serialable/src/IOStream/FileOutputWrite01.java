package src.IOStream;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

// write(byte[] b) 方法
public class FileOutputWrite01 {
    public static void main(String[] args) {
        writeFile();
    }

    public static void writeFile() {
        String filePath = "Serialable/src/IOStream/CreateForFile/new1.txt";
        FileOutputStream fileOutputStream = null;
        try { // 注意fileOutputStream的作用域，因为fileOutputStream需要在finally分支中被异常捕获
              // 所以这里的 try 先不闭合
            fileOutputStream = new FileOutputStream(filePath);
            String content = "gulugulu";
            try {
                //write(byte[] b)  将 b.length 个字节从指定 byte 数组写入此文件输出流中
                //String类型的字符串可以使用getBytes()方法将字符串转换为byte数组
                fileOutputStream.write(content.getBytes());
            } catch (IOException e) {
                e.printStackTrace();
            }
        }catch (FileNotFoundException e){
            e.printStackTrace();
        }
        finally {
            try {
                fileOutputStream.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }
    }
}
