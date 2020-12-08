;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit test : 
  module test : 
    input clock : Clock
    input reset : UInt<1>
    output io : {flip in : UInt<3>, out : UInt}
    
    node _T = cat(io.in, UInt<18>("h020015")) @[Cat.scala 29:58]
    io.out <= _T @[test.scala 9:10]
    
