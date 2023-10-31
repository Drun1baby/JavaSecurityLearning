package SingleResponsebility;

/**
 * 方式一的run方法中，违反了单一职责原则，
 * 解决的方案是根据交通工具运行方法不同，分解成不同类即可
 */
public class SingleResponsebility1 {
    public static void main(String[] args) {
        Vehicle vehicle = new Vehicle();
        vehicle.run("汽车");
        vehicle.run("摩托");
        vehicle.run("飞机");
    }
}

class Vehicle {
    public void run(String vehicle) {
        System.out.println(vehicle+"在公路上跑");
    }
}
