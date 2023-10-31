package src.IOStream;


import java.io.FileInputStream;
import java.io.IOException;

// read(byte[] d) 方法，允许在方法中添加一个字节数组
public class FileInputRead02 {
    public static void main(String[] args) {
        readFile();
    }
    public static void readFile(){
        String filePath = "Serialable/src/IOStream/CreateForFile/new1.txt";
        FileInputStream fileInputStream = null;
        byte[] cache = new byte[8]; // 设置缓冲区，缓冲区大小为 8 字节
        int readLen = 0;
        try {
            fileInputStream = new FileInputStream(filePath);
            while((readLen = fileInputStream.read(cache)) != -1){
                System.out.println(new String(cache, 0, readLen));
            }
        } catch (IOException e){
                e.printStackTrace();
        } finally {
            try {
                fileInputStream.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }
    }
}
