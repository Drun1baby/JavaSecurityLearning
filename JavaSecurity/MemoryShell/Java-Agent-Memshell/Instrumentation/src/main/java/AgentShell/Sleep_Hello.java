package AgentShell;

import static java.lang.Thread.sleep;

public class Sleep_Hello {
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

