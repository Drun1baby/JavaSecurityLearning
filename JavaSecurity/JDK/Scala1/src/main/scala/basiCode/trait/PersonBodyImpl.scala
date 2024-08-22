import basiCode.`trait`.PersonBody

object PersonBodyImpl {

  class PersonBodyImpl(name : String) extends PersonBody{
    override val height: Int = 185
  }
  def main(args: Array[String]): Unit = {
    var person = new PersonBodyImpl("Cloud")
    println(person.height)
    //185
  }
}