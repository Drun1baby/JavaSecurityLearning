package javassist;

import java.lang.reflect.Modifier;

public class Javassist_Test {
    public static void Create_Person() throws Exception {

        //获取 CtClass 对象的容器 ClassPool
        ClassPool classPool = ClassPool.getDefault();

        //创建一个新类 Javassist.Learning.Person
        CtClass ctClass = classPool.makeClass("javassist.Person");

        //创建一个类属性 name
        CtField ctField1 = new CtField(classPool.get("java.lang.String"), "name", ctClass);
        //设置属性访问符
        ctField1.setModifiers(Modifier.PRIVATE);
        //将 name 属性添加进 Person 中，并设置初始值为 Drunkbaby
        ctClass.addField(ctField1, CtField.Initializer.constant("Drunkbaby"));

        //向 Person 类中添加 setter 和 getter
        ctClass.addMethod(CtNewMethod.setter("setName", ctField1));
        ctClass.addMethod(CtNewMethod.getter("getName", ctField1));

        //创建一个无参构造
        CtConstructor ctConstructor = new CtConstructor(new CtClass[]{}, ctClass);
        //设置方法体
        ctConstructor.setBody("{name = \"Drunkbaby\";}");
        //向Person类中添加无参构造
        ctClass.addConstructor(ctConstructor);

        //创建一个类方法printName
        CtMethod ctMethod = new CtMethod(CtClass.voidType,"printName", new CtClass[]{}, ctClass);
        //设置方法访问符
        ctMethod.setModifiers(Modifier.PRIVATE);
        //设置方法体
        ctMethod.setBody("{System.out.println(name);}");
        //将该方法添加进Person中
        ctClass.addMethod(ctMethod);

        //将生成的字节码写入文件
        ctClass.writeFile("E:\\Coding\\Java\\Java-Agent-Memshell\\Instrumentation\\src\\main\\java");
    }

    public static void main(String[] args) throws Exception {
        Create_Person();
    }

}
