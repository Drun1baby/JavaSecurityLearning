package OpenClose;

public class Ocp2 {
    public static void main(String[] args) {
        GraphicEditor2 graphicEditor2 = new GraphicEditor2();
        graphicEditor2.drawShape2(new Rectangle2());
        graphicEditor2.drawShape2(new Circle2());
    }
}

//这是一个用于绘图的类
class GraphicEditor2 {
    //接收Shape2时对象，然后根据type，来绘制不同的图形
    public void drawShape2(Shape2 s) {
        s.draw();
    }
}

//Shape2类，基类
abstract class Shape2 {
    public abstract void draw();//抽象方法
}

class Rectangle2 extends Shape2 {
    @Override
    public void draw() {
        System.out.println("绘制矩形");
    }
}

class Circle2 extends Shape2 {
    @Override
    public void draw() {
        System.out.println("绘制圆形");
    }
}
