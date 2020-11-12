;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit ahb_to_axi4 : 
  module ahb_to_axi4 : 
    input clock : Clock
    input reset : AsyncReset
    output io : {flip scan_mode : UInt<1>, flip bus_clk_en : UInt<1>, flip clk_override : UInt<1>, flip axi_awready : UInt<1>, flip axi_wready : UInt<1>, flip axi_bvalid : UInt<1>, flip axi_bresp : UInt<2>, flip axi_bid : UInt<1>, flip axi_arready : UInt<1>, flip axi_rvalid : UInt<1>, flip axi_rid : UInt<1>, flip axi_rdata : UInt<64>, flip axi_rresp : UInt<2>, flip ahb_haddr : UInt<32>, flip ahb_hburst : UInt<3>, flip ahb_hmastlock : UInt<1>, flip ahb_hprot : UInt<4>, flip ahb_hsize : UInt<3>, flip ahb_htrans : UInt<2>, flip ahb_hwrite : UInt<1>, flip ahb_hwdata : UInt<64>, flip ahb_hsel : UInt<1>, flip ahb_hreadyin : UInt<1>, axi_awvalid : UInt<1>, axi_awid : UInt<1>, axi_awaddr : UInt<32>, axi_awsize : UInt<3>, axi_awprot : UInt<3>, axi_awlen : UInt<8>, axi_awburst : UInt<2>, axi_wvalid : UInt<1>, axi_wdata : UInt<64>, axi_wstrb : UInt<8>, axi_wlast : UInt<1>, axi_bready : UInt<1>, axi_arvalid : UInt<1>, axi_arid : UInt<1>, axi_araddr : UInt<32>, axi_arsize : UInt<3>, axi_arprot : UInt<3>, axi_arlen : UInt<8>, axi_arburst : UInt<2>, axi_rready : UInt<1>, ahb_hrdata : UInt<64>, ahb_hreadyout : UInt<1>, ahb_hresp : UInt<1>}
    
    io.axi_awvalid <= UInt<1>("h00") @[ahb_to_axi4.scala 58:18]
    io.axi_awid <= UInt<1>("h00") @[ahb_to_axi4.scala 59:15]
    io.axi_awaddr <= UInt<1>("h00") @[ahb_to_axi4.scala 60:17]
    io.axi_awsize <= UInt<1>("h00") @[ahb_to_axi4.scala 61:17]
    io.axi_awprot <= UInt<1>("h00") @[ahb_to_axi4.scala 62:17]
    io.axi_awlen <= UInt<1>("h00") @[ahb_to_axi4.scala 63:16]
    io.axi_awburst <= UInt<1>("h00") @[ahb_to_axi4.scala 64:18]
    io.axi_wvalid <= UInt<1>("h00") @[ahb_to_axi4.scala 65:17]
    io.axi_wdata <= UInt<1>("h00") @[ahb_to_axi4.scala 66:16]
    io.axi_wstrb <= UInt<1>("h00") @[ahb_to_axi4.scala 67:16]
    io.axi_wlast <= UInt<1>("h00") @[ahb_to_axi4.scala 68:16]
    io.axi_bready <= UInt<1>("h00") @[ahb_to_axi4.scala 69:17]
    io.axi_arvalid <= UInt<1>("h00") @[ahb_to_axi4.scala 70:18]
    io.axi_arid <= UInt<1>("h00") @[ahb_to_axi4.scala 71:15]
    io.axi_araddr <= UInt<1>("h00") @[ahb_to_axi4.scala 72:17]
    io.axi_arsize <= UInt<1>("h00") @[ahb_to_axi4.scala 73:17]
    io.axi_arprot <= UInt<1>("h00") @[ahb_to_axi4.scala 74:17]
    io.axi_arlen <= UInt<1>("h00") @[ahb_to_axi4.scala 75:16]
    io.axi_arburst <= UInt<1>("h00") @[ahb_to_axi4.scala 76:18]
    io.axi_rready <= UInt<1>("h00") @[ahb_to_axi4.scala 77:17]
    io.ahb_hrdata <= UInt<1>("h00") @[ahb_to_axi4.scala 78:17]
    io.ahb_hreadyout <= UInt<1>("h00") @[ahb_to_axi4.scala 79:20]
    io.ahb_hresp <= UInt<1>("h00") @[ahb_to_axi4.scala 80:16]
    
