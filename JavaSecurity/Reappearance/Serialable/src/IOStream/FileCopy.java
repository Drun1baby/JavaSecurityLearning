package src.IOStream;


import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;

// 文件拷贝操作
public class FileCopy {
    public static void main(String[] args) {
            copyFile();
        }
    public static void  copyFile(){
        String srcFilename = "Serialable/src/IOStream/CreateForFile/new1.txt";
        String desFilename = "Serialable/src/IOStream/CreateForFile/new2.txt";
        FileInputStream fileInputStream = null;
        FileOutputStream fileOutputStream = null;
        try {
            fileInputStream = new FileInputStream(srcFilename);
            fileOutputStream = new FileOutputStream(desFilename);
            byte[] cache = new byte[1024];
            int readLen = 0;
            while((readLen = fileInputStream.read(cache)) != -1){
                fileOutputStream.write(cache, 0, readLen);
            }
    } catch (IOException e){
            e.printStackTrace();
        } finally {
            try {
                fileInputStream.close();
                fileOutputStream.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }
        }
}
