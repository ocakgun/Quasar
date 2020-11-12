module ahb_to_axi4(
  input         clock,
  input         reset,
  input         io_scan_mode,
  input         io_bus_clk_en,
  input         io_clk_override,
  input         io_axi_awready,
  input         io_axi_wready,
  input         io_axi_bvalid,
  input  [1:0]  io_axi_bresp,
  input         io_axi_bid,
  input         io_axi_arready,
  input         io_axi_rvalid,
  input         io_axi_rid,
  input  [63:0] io_axi_rdata,
  input  [1:0]  io_axi_rresp,
  input  [31:0] io_ahb_haddr,
  input  [2:0]  io_ahb_hburst,
  input         io_ahb_hmastlock,
  input  [3:0]  io_ahb_hprot,
  input  [2:0]  io_ahb_hsize,
  input  [1:0]  io_ahb_htrans,
  input         io_ahb_hwrite,
  input  [63:0] io_ahb_hwdata,
  input         io_ahb_hsel,
  input         io_ahb_hreadyin,
  output        io_axi_awvalid,
  output        io_axi_awid,
  output [31:0] io_axi_awaddr,
  output [2:0]  io_axi_awsize,
  output [2:0]  io_axi_awprot,
  output [7:0]  io_axi_awlen,
  output [1:0]  io_axi_awburst,
  output        io_axi_wvalid,
  output [63:0] io_axi_wdata,
  output [7:0]  io_axi_wstrb,
  output        io_axi_wlast,
  output        io_axi_bready,
  output        io_axi_arvalid,
  output        io_axi_arid,
  output [31:0] io_axi_araddr,
  output [2:0]  io_axi_arsize,
  output [2:0]  io_axi_arprot,
  output [7:0]  io_axi_arlen,
  output [1:0]  io_axi_arburst,
  output        io_axi_rready,
  output [63:0] io_ahb_hrdata,
  output        io_ahb_hreadyout,
  output        io_ahb_hresp
);
  assign io_axi_awvalid = 1'h0; // @[ahb_to_axi4.scala 58:18]
  assign io_axi_awid = 1'h0; // @[ahb_to_axi4.scala 59:15]
  assign io_axi_awaddr = 32'h0; // @[ahb_to_axi4.scala 60:17]
  assign io_axi_awsize = 3'h0; // @[ahb_to_axi4.scala 61:17]
  assign io_axi_awprot = 3'h0; // @[ahb_to_axi4.scala 62:17]
  assign io_axi_awlen = 8'h0; // @[ahb_to_axi4.scala 63:16]
  assign io_axi_awburst = 2'h0; // @[ahb_to_axi4.scala 64:18]
  assign io_axi_wvalid = 1'h0; // @[ahb_to_axi4.scala 65:17]
  assign io_axi_wdata = 64'h0; // @[ahb_to_axi4.scala 66:16]
  assign io_axi_wstrb = 8'h0; // @[ahb_to_axi4.scala 67:16]
  assign io_axi_wlast = 1'h0; // @[ahb_to_axi4.scala 68:16]
  assign io_axi_bready = 1'h0; // @[ahb_to_axi4.scala 69:17]
  assign io_axi_arvalid = 1'h0; // @[ahb_to_axi4.scala 70:18]
  assign io_axi_arid = 1'h0; // @[ahb_to_axi4.scala 71:15]
  assign io_axi_araddr = 32'h0; // @[ahb_to_axi4.scala 72:17]
  assign io_axi_arsize = 3'h0; // @[ahb_to_axi4.scala 73:17]
  assign io_axi_arprot = 3'h0; // @[ahb_to_axi4.scala 74:17]
  assign io_axi_arlen = 8'h0; // @[ahb_to_axi4.scala 75:16]
  assign io_axi_arburst = 2'h0; // @[ahb_to_axi4.scala 76:18]
  assign io_axi_rready = 1'h0; // @[ahb_to_axi4.scala 77:17]
  assign io_ahb_hrdata = 64'h0; // @[ahb_to_axi4.scala 78:17]
  assign io_ahb_hreadyout = 1'h0; // @[ahb_to_axi4.scala 79:20]
  assign io_ahb_hresp = 1'h0; // @[ahb_to_axi4.scala 80:16]
endmodule
