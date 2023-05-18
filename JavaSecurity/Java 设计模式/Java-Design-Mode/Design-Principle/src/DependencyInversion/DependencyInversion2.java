package DependencyInversion;

/**
 * 如果我们获取的对象是微信、短信等等，则新增类，同时 Person 也要增加相应的接收方法
 * 解决思路：引入一个抽象的接口 IReceiver，表示接收者，这样 Person 类与接口 IReceiver 发生依赖
 * 因为 Email、WeChat 等等属于接收的范围，它们各自实现 IReceiver 接口就可以，这样我们就符合依赖倒转原则
 */
public class DependencyInversion2 {
    public static void main(String[] args) {
        Person2 Person2 = new Person2();
        Person2.receive(new Email2());
        Person2.receive(new WeChat());
    }
}

interface IReceiver {
    public String getInfo();
}

class Email2 implements IReceiver {
    @Override
    public String getInfo() {
        return "电子邮件：Hello World!";
    }
}

class WeChat implements IReceiver {
    @Override
    public String getInfo() {
        return "微信消息：Hello weixin";
    }
}


class Person2 {
    public void receive(IReceiver i) {
        System.out.println(i.getInfo());
    }
}
