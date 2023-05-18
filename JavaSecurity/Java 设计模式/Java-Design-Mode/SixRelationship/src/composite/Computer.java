package composite;

public class Computer {
    private Mouse mouse = new Mouse(); //鼠标不可以和Computer分离

    private Moniter moniter = new Moniter();//显示器不可以	和Computer分离

    public void setMouse(Mouse mouse) {

        this.mouse = mouse;
    }

    public void setMoniter(

            Moniter moniter) {

        this.moniter = moniter;
    }
}
