package SingleResponsebility;

/**
 * 这种修改方法没有对原来的类做大的修改，只是增加方法
 * 这里虽然没有在类这个级别上遵循单一职责原则，但是在方法级别上，仍然遵守这个原则
 */
public class SingleResonsibility3 {
    public static void main(String[] args) {
        Vehicle4 vehicle4 = new Vehicle4();
        vehicle4.run("汽车");
        vehicle4.run2("轮船");
        vehicle4.run3("飞机");
    }
}

class Vehicle4{
    public void run(String vehicle){
        System.out.println(vehicle+"在地上跑");
    }

    public void run2(String vehicle){
        System.out.println(vehicle+"在水上跑");
    }

    public void run3(String vehicle) {
        System.out.println(vehicle + "在天上跑");
    }
}
