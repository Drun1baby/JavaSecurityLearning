package SingleResponsebility;

/**
 * 方案二遵循单一职责原则
 * 但是这样做的改动很大，即将类分解，同时修改客户端
 * 改进：直接修改Vehicle类，改动的代码会比较少
 */
public class SingleResponsibility2 {
    public static void main(String[] args) {
        Vehicle1 vehicle1 = new Vehicle1();
        vehicle1.run("汽车");
        Vehicle2 vehicle2 = new Vehicle2();
        vehicle2.run("轮船");
        Vehicle3 vehicle3 = new Vehicle3();
        vehicle3.run("飞机");
    }
}


class Vehicle1{
    public void run(String vehicle){
        System.out.println(vehicle+"在地上跑");
    }
}

class Vehicle2{
    public void run(String vehicle){
        System.out.println(vehicle+"在水上跑");
    }
}

class Vehicle3{
    public void run(String vehicle){
        System.out.println(vehicle+"在天上跑");
    }
}
