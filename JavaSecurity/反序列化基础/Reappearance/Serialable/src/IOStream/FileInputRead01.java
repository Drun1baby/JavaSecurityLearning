package src.IOStream;

import java.io.FileInputStream;
import java.io.IOException;

// 使用 FileInputStream.read 读取文件
public class FileInputRead01 {
    public static void main(String[] args) {
        readFile();
    }
    public static void readFile(){
        String filePath = "Serialable/src/IOStream/CreateForFile/new1.txt";
        FileInputStream fileInputStream = null;
        int readData = 0;
        try{
            fileInputStream = new FileInputStream(filePath);
            while((readData = fileInputStream.read())!=-1){
                System.out.print((char)readData);
            }
        } catch (IOException e){
            e.printStackTrace();
        } finally {
            try{
                fileInputStream.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }
    }
}
