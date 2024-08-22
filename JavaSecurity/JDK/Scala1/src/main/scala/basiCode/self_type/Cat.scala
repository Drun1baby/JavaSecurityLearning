package basiCode.self_type


object Cat {

  class Cat {
    val name: String = "Tom"
    val color: String = "Gray"

    def meow(): Unit = println("Meow!")

  }
    trait Talkative {
      def talk(): Unit
    }

    trait Singer {
      self: Talkative => // 声明自身类型，表示Singer依赖于Talkative
      def sing(): Unit = {
        talk() // 可以直接使用Talkative的成员
        println("La la la...")
      }
    }

    trait Dancer {
      self: Singer => // 声明自身类型，表示Dancer依赖于Singer
      def dance(): Unit = {
        sing() // 可以直接使用Singer的成员
        println("Shake shake shake...")
      }
    }

    def main(args: Array[String]): Unit = {
      val tom = new Cat with Talkative with Singer with Dancer {
        override def talk(): Unit =  {
          println("test")
        }
      } // 创建一个会说话、唱歌、跳舞的猫
      tom.talk() // 输出：Meow!
      tom.sing() // 输出：Meow! La la la...
      tom.dance() // 输出：Meow! La la la... Shake shake shake...
    }

}
