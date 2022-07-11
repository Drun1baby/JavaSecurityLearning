package src.IOStream;

import java.io.FileReader;
import java.io.IOException;

// 读取文件的字符流
public class FileReaderPrint {
    public static void main(String[] args) {
        readFile();
    }
    public static void readFile(){
        String filePath = "Serialable/src/IOStream/CreateForFile/new1.txt";
        FileReader fileReader = null;
        try {
            fileReader = new FileReader(filePath);
            int readLen = 0;
            char[] cache = new char[8];
            while ((readLen = fileReader.read(cache))!=-1){
                System.out.println(new String(cache, 0, readLen));
            }
        } catch (IOException e){
            e.printStackTrace();
        } finally {
            try {
                fileReader.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }
    }
}
