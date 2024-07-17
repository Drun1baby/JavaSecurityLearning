// 定义一个Person类，作为伴生类
class Person(val name: String, val age: Int) {
  private val secret = "I love Scala"


  def sayHello(): Unit = {
    println(s"Hello, I am $name, $age years old.")
  }
}

// 定义一个Person对象，作为伴生对象
object Person {

  var count = 0

  def increase(): Unit = {
    count += 1
    println(s"Person count: $count")
  }

  def showSec():Unit={
    println(apply("test",1).secret)
  }

  // 定义一个apply方法，用于创建Person类的实例
  def apply(name: String, age: Int): Person = {
    increase()
    new Person(name, age) // 返回新的Person对象
  }

  // 定义一个unapply方法，用于提取Person类的属性
  def unapply(person: Person): Option[(String, Int)] = {
    if (person == null) None // 如果person为空，返回None
    else Some(person.name, person.age) // 否则返回Some元组
  }
}
object Main {

  def main(args: Array[String]): Unit = {
    // 使用伴生对象的apply方法创建Person类的实例，省略了new关键字
    val p1 = Person("Alice", 20)//Person count: 1
    val p2 = Person("Bob", 25)//Person count: 2

    // 使用伴生对象的字段和方法
    println(Person.count) // 输出2
    Person.increase() // Person count: 3
    Person.showSec()//输出Person count: 4
    //I love Scala(伴生对象可以访问伴生类的私有成员)

    // 使用伴生类的字段和方法
    /*
    println(p1.secret)// 无法访问私有成员
     */
    p1.sayHello() // 输出Hello, I am Alice, 20 years old.

    // 使用模式匹配和提取器，利用伴生对象的unapply方法
    val p3=null
    p1 match {
      case Person(name, age) => println(s"$name is $age years old.") // 输出Alice is 20 years old.
      case _ => println("Unknown person.")
    }
    p3 match {
      case Person(name, age) => println(s"$name is $age years old.") // 输出Unknown person.
      case _ => println("Unknown person.")
    }
  }
}
