package src.IOStream.NoSerialableIO;

import java.io.PrintWriter;

// 用 PrintWriter 写入文件
public class PrintWriteFile {
    public static void main(String[] args) {
        try (PrintWriter printWriter = new PrintWriter("Serialable/src/IOStream/CreateForFile/new1.txt")){
            printWriter.println("hello");
            printWriter.printf("%2f", 6.27);
        } catch (Exception e){
            e.printStackTrace();
        }

    }
}
