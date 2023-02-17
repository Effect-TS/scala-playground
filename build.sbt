organization := "com.effect"
name := "playground"
description := "A Scala playground used by the Effect maintainers"
version := "0.1.0"
scalaVersion := "2.13.8"

val zioVersion = "2.0.0"

lazy val core =
  project
    .in(file("modules/core"))
    .settings(
      name := "playground",
      libraryDependencies ++= Seq(
        "dev.zio" %% "zio" % zioVersion,
        "dev.zio" %% "zio-streams" % zioVersion,
        "dev.zio" %% "zio-test" % zioVersion % Test,
        "dev.zio" %% "zio-test-sbt" % zioVersion % Test,
        ),
      testFrameworks := List(new TestFramework("zio.test.sbt.ZTestFramework"))
    )