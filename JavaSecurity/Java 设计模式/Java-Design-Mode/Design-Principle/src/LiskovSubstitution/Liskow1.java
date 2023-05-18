//package LiskovSubstitution;
//
//public class Liskow1 {
//    public static void main(String[] args) {
//        A a = new A();
//        System.out.println("11-3=" + a.func1(11, 3));
//        B b = new B();
//        System.out.println("11-3=" + b.func1(11, 3));//这里本意是求出11-3
//        System.out.println("11+3+9=" + b.func2(11, 3));
//    }
//}
//
//class A {
//    // 重写了A类的方法，可能是无意识的
//    public int func1(int num1, int num2) {
//        return num1 - num2;
//    }
//}
//
//class B extends A {
//    public int func1(int a, int b) {
//        return a + b;
//    }
//
//    public int func2(int a, int b) {
//        return func1(a, b) + 9;
//    }
//}
