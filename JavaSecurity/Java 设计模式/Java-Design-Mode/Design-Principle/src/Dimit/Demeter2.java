package Dimit;

import java.util.ArrayList;
import java.util.List;

public class Demeter2 {
    public static void main(String[] args) {
        SchoolManager2 schoolManager2 = new SchoolManager2();
        schoolManager2.printAllEmployee2(new CollegeManager2());
    }
}

//学校总部员工
class Employee2 {
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}

//学院员工
class CollegeEmployee2 {
    private String id;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }
}

//管理学院员工的类
class CollegeManager2 {
    //返回学院的所有员工
    public List<CollegeEmployee2> getAllEmployee2() {
        List<CollegeEmployee2> list = new ArrayList<CollegeEmployee2>();
        for (int i = 0; i < 10; i++) {//增加了10个员工
            CollegeEmployee2 emp = new CollegeEmployee2();
            emp.setId("学院员工id=" + i);
            list.add(emp);
        }
        return list;
    }

    //获取学院员工
    public void printEmployee2() {
        List<CollegeEmployee2> list1 = this.getAllEmployee2();
        System.out.println("------------学院员工------------");
        for (CollegeEmployee2 e : list1) {
            System.out.println(e.getId());
        }
    }
}

/**
 * 管理学校员工的类
 * 分析：SchoolManager2类的直接朋友有哪些？
 * 直接朋友有“Employee2”、“CollegeManager2”
 * 非直接朋友有“CollegeEmployee2”
 * 这就违背了迪米特法则
 */
class SchoolManager2 {
    //返回学校总部的员工
    public List<Employee2> getAllEmployee2() {
        List<Employee2> list = new ArrayList<Employee2>();

        for (int i = 0; i < 5; i++) { //增加了5个员工
            Employee2 emp = new Employee2();
            emp.setId("学校总部员工id= " + i);
            list.add(emp);
        }
        return list;
    }

    //完成输出学校总部和学院员工信息的方法
    void printAllEmployee2(CollegeManager2 sub) {
        //获取学院员工
        sub.printEmployee2();
        //获取学校总部员工
        List<Employee2> list2 = this.getAllEmployee2();
        System.out.println("------------学校总部员工------------");
        for (Employee2 e : list2) {
            System.out.println(e.getId());
        }
    }
}
