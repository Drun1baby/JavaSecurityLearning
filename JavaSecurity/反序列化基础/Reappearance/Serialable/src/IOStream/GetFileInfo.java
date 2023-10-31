package src.IOStream;

import java.io.File;

// 获取文件信息
public class GetFileInfo {
    public static void main(String[] args) {
        getFileContents();
    }

    public static void getFileContents(){
        File file = new File("Serialable/src/IOStream/CreateForFile/new1.txt");
        System.out.println("文件名称为：" + file.getName());
        System.out.println("文件的绝对路径为：" + file.getAbsolutePath());
        System.out.println("文件的父级目录为：" + file.getParent());
        System.out.println("文件的大小(字节)为：" + file.length());
        System.out.println("这是不是一个文件：" + file.isFile());
        System.out.println("这是不是一个目录：" + file.isDirectory());
    }
}
