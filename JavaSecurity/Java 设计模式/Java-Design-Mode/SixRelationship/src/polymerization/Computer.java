package polymerization;

public class Computer {
    private Mouse mouse; //鼠标可以和Computer分离
    private Moniter moniter;//显示器可以和Computer分离

    public void setMouse(Mouse mouse) {
        this.mouse = mouse;
    }

    public void setMoniter(Moniter moniter) {
        this.moniter = moniter;
    }
}
