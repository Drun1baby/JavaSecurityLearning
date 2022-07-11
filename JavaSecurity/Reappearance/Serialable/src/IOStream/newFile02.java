package src.IOStream;

import java.io.File;
import java.io.IOException;

// 根据父目录File对象，在子路径创建一个文件
public class newFile02 {
    public static void main(String[] args) {
        createFile();
    }
    public static void createFile(){
        File parentFile = new File("Serialable/src/IOStream/CreateForFile");
        File file = new File(parentFile, "new2.txt");
        try{
            file.createNewFile();
            System.out.println("Create Successfully");
        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
