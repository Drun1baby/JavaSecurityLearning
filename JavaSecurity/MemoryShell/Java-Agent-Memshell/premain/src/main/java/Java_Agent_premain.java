import java.lang.instrument.Instrumentation;

public class Java_Agent_premain {
    public static void premain(String args, Instrumentation inst) {
        for (int i=0 ; i<10 ; i++){
            System.out.println("调用了premain-Agent！");
        }
    }
}