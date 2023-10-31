package src.IOStream;

import java.io.File;
import java.io.IOException;

// 根据路径创建一个 File 对象
public class newFile01 {
    public static void main(String[] args) {
        createFile();
    }
    public static void createFile(){
        File file = new File("Serialable/src/IOStream/CreateForFile/new1.txt");
        try{
            file.createNewFile();
            System.out.println("Create Successfully");
        } catch (IOException e){
            e.printStackTrace();
        }
    }

}
