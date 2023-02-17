package com.effect.playground

import zio.test._
import zio._

object MainSpec extends ZIOSpecDefault {

  def spec = 
    suite("MainSpec")(
      test("it works!") {
        val result = 10
        assertTrue(result == 10)
      }
    )
    
}