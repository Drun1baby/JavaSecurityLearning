package src.IOStream;

import java.io.File;

// 文件删除
public class FileDelete {
    public static void main(String[] args) {
        deleteFile();
    }
    public static void deleteFile(){
        File file = new File("Serialable/src/IOStream/CreateForFile/new1.txt");
        System.out.println(file.delete() ? "Delete Successfully":"Delete failed");
    }
}
