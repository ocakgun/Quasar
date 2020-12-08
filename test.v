module test(
  input         clock,
  input         reset,
  input  [2:0]  io_in,
  output [20:0] io_out
);
  assign io_out = {io_in,18'h20015}; // @[test.scala 9:10]
endmodule
