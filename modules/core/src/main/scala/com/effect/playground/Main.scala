//> using dep dev.zio::zio:2.0.15
//> using dep dev.zio::zio-streams:2.0.15

package com.effect.playground

import zio._
import zio.stream._

object Main extends ZIOAppDefault {

  val program1 = ZIO
    .scoped {
      ZStream
        .fail("fail")
        .broadcastDynamic(1)
        .flatMap((stream) => stream.runDrain.zipPar(stream.runDrain))
    }
    .catchAllCause(ZIO.logErrorCause(_))

  val program2 = ZIO
    .scoped {
      ZStream
        .fail("fail")
        .broadcastDynamic(1)
        .flatMap((stream) => stream.runDrain.zip(stream.runDrain))
    }
    .catchAllCause(ZIO.logErrorCause(_))

  val run = program1

}