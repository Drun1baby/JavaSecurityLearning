package src.IOStream;

import java.io.File;

//删除目录
public class DirectoryDelete {
    public static void main(String[] args) {
        deleteDirectory();
    }
    public static void deleteDirectory(){
        File file = new File("Serialable/src/IOStream/CreateForDelete");
        System.out.println(file.delete()? "Delete Successfully":"Delete failed");
    }
}
