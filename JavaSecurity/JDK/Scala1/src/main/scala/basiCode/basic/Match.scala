package basiCode;object Match {
        def show(result:String):Unit={
                println(result)
                }
        def main(args: Array[String]): Unit = {
                val x=11
                val y=x match {
                        case 1 => "one"
                                case 2 => "two"
                                case other => s"other: $other" // other是一个变量名，它会接收除了1和2以外的任何值
                                case _ => s"other: _"
                        }
                show(y)
                //other: 11

                }
        }
