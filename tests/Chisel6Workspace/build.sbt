// See README.md for license details.

ThisBuild / scalaVersion     := "2.13.9"
ThisBuild / version          := "0.1.0"
ThisBuild / organization     := "UCB"

val chiselVersion = "6.0.0-M3"

lazy val root = (project in file("."))
  .settings(
    name := "Test",
    libraryDependencies ++= Seq(
      "org.chipsalliance" %% "chisel" % chiselVersion,
      "edu.berkeley.cs" %% "chiseltest" % "5.0.2" % "test"
    ),
    scalacOptions ++= Seq(
      "-language:reflectiveCalls",
      "-deprecation",
      "-feature",
      "-Xcheckinit",
      "-Ymacro-annotations",
    ),
    addCompilerPlugin("org.chipsalliance" % "chisel-plugin" % chiselVersion cross CrossVersion.full),
  )

