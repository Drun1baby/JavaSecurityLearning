package src.IOStream;


import java.io.File;

// 创建单级目录
public class CreateSingleDirectory {
    public static void main(String[] args) {
        createSingleDir();
    }
    public static void createSingleDir(){
        File file = new File("Serialable/src/IOStream/CreateForSingleDirectory");
        System.out.println(file.mkdir() ? "Create Successfully":"Create failed");
    }
}
