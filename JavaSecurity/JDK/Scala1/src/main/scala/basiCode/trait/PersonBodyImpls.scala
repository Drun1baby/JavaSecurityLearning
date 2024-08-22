import basiCode.`trait`.{PersonBody, PersonHobby}

object PersonBodyImpls {

  class PersonBodyImpls(name : String) extends PersonBody with PersonHobby {

    override def showHobby(): Unit = {
      println(hobbyGame)
    }

    override val height: Int = 185

    override var hobbyGame: String = "Drunkbaby sleep"

  }

  def main(args: Array[String]): Unit = {
    var person = new PersonBodyImpls("Cloud")
    person.showHobby()

  }


}

