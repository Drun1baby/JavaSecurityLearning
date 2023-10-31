package src.IOStream;

import java.io.FileWriter;
import java.io.IOException;

// 使用 FileWriter 方法写入数据
public class FileWriteUse {
    public static void main(String[] args) {
        writeFile();
    }
    public static void writeFile(){
        String filePath = "Serialable/src/IOStream/CreateForFile/new1.txt";
        FileWriter fileWriter = null;
        try {
            fileWriter = new FileWriter(filePath);
            char[] a = {0, 'a', ' '};
            fileWriter.write("abc ");
            fileWriter.write(a);
            String b = "Drun1baby";
            fileWriter.write(b.toCharArray());
        } catch (IOException e){
            e.printStackTrace();
        } finally {
            try{
                //必须使用close()或者flush()方法，否则无法写入数据
                fileWriter.close();
            } catch (IOException e){
                e.printStackTrace();
            }
        }
    }
}
