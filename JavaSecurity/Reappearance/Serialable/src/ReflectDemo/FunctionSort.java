package src.ReflectDemo;

// 各种代码块执行顺序
public class FunctionSort {
    public static void main(String[] args) throws Exception{
        Test test = new Test();
    }
static class Test{
    {
        System.out.println("1");
    }
    static {
        System.out.println("2");
    }
    Test(){
        System.out.println("3");
    }
}
}
