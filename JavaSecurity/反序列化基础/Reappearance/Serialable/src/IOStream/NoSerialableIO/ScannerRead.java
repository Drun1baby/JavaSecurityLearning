package src.IOStream.NoSerialableIO;

import java.io.File;
import java.io.IOException;
import java.util.Scanner;

// 用 Scanner 进行文件读取
public class ScannerRead {
    public static void main(String[] args) {
        try(Scanner scanner = new Scanner(new File("Serialable/src/IOStream/CreateForFile/sample.csv"))) {
            while (scanner.hasNext()) {
                System.out.println(scanner.nextLine());
            }
        }
        catch (IOException e){
            e.printStackTrace();
        }
    }
}
