package src.IOStream;

import java.io.File;
import java.io.IOException;

// 根据父目录路径，在子路径下生成文件
public class newFile03 {
    public static void main(String[] args) {
        createFile();
    }
    public static void createFile(){
        String parentPath = "Serialable/src/IOStream/CreateForFile";
        String fileName = "new3.txt";
        File file = new File(parentPath, fileName);
        try{
            file.createNewFile();
            System.out.println("Create Successfully");
        } catch (IOException e){
            e.printStackTrace();
        }
    }
}
