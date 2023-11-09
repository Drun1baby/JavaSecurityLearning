package SimpleInstrumentation;

import static java.lang.Thread.sleep;

public class Hello_Sleep {
    public static void main(String[] args) throws InterruptedException {
        while(true) {
            hello();
            sleep(3000);
        }
    }
    public static void hello(){
        System.out.println("Hello World!");
    }
}
