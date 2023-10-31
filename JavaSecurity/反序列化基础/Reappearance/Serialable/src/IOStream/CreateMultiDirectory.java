package src.IOStream;


import java.io.File;

// 创建多级目录
public class CreateMultiDirectory {
    public static void main(String[] args) {
        createMultiDir();
    }

    public static void createMultiDir(){
        File file = new File("Serialable/src/IOStream/CreateMultiDirectory/test");
        System.out.println(file.mkdirs() ? "Create Successfully":"Create failed");
    }
}
