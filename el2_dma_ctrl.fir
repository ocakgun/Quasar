;buildInfoPackage: chisel3, version: 3.3.1, scalaVersion: 2.12.11, sbtVersion: 1.3.10
circuit el2_dma_ctrl : 
  extmodule gated_latch : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_1 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_1 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_1 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_2 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_2 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_2 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_3 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_3 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_3 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_4 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_4 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_4 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_5 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_5 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_5 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_6 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_6 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_6 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_7 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_7 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_7 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_8 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_8 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_8 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_9 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_9 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_9 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_10 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_10 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_10 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_11 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_11 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_11 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_12 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_12 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_12 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_13 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_13 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_13 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_14 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_14 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_14 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  extmodule gated_latch_15 : 
    output Q : Clock
    input CK : Clock
    input EN : UInt<1>
    input SE : UInt<1>
    
    defname = gated_latch
    
    
  module rvclkhdr_15 : 
    input clock : Clock
    input reset : Reset
    output io : {l1clk : Clock, flip clk : Clock, flip en : UInt<1>, flip scan_mode : UInt<1>}
    
    inst clkhdr of gated_latch_15 @[el2_lib.scala 474:26]
    clkhdr.SE is invalid
    clkhdr.EN is invalid
    clkhdr.CK is invalid
    clkhdr.Q is invalid
    io.l1clk <= clkhdr.Q @[el2_lib.scala 475:14]
    clkhdr.CK <= io.clk @[el2_lib.scala 476:18]
    clkhdr.EN <= io.en @[el2_lib.scala 477:18]
    clkhdr.SE <= io.scan_mode @[el2_lib.scala 478:18]
    
  module el2_dma_ctrl : 
    input clock : Clock
    input reset : AsyncReset
    output io : {flip free_clk : Clock, flip dma_bus_clk_en : UInt<1>, flip clk_override : UInt<1>, flip scan_mode : UInt<1>, flip dbg_cmd_addr : UInt<32>, flip dbg_cmd_wrdata : UInt<32>, flip dbg_cmd_valid : UInt<1>, flip dbg_cmd_write : UInt<1>, flip dbg_cmd_type : UInt<2>, flip dbg_cmd_size : UInt<2>, flip dbg_dma_bubble : UInt<1>, dma_dbg_ready : UInt<1>, dma_dbg_cmd_done : UInt<1>, dma_dbg_cmd_fail : UInt<1>, dma_dbg_rddata : UInt<32>, dma_dccm_req : UInt<1>, dma_iccm_req : UInt<1>, dma_mem_tag : UInt<3>, dma_mem_addr : UInt<32>, dma_mem_sz : UInt<3>, dma_mem_write : UInt<1>, dma_mem_wdata : UInt<64>, flip dccm_dma_rvalid : UInt<1>, flip dccm_dma_ecc_error : UInt<1>, flip dccm_dma_rtag : UInt<3>, flip dccm_dma_rdata : UInt<64>, flip iccm_dma_rvalid : UInt<1>, flip iccm_dma_ecc_error : UInt<1>, flip iccm_dma_rtag : UInt<3>, flip iccm_dma_rdata : UInt<64>, dma_dccm_stall_any : UInt<1>, dma_iccm_stall_any : UInt<1>, flip dccm_ready : UInt<1>, flip iccm_ready : UInt<1>, flip dec_tlu_dma_qos_prty : UInt<3>, dma_pmu_dccm_read : UInt<1>, dma_pmu_dccm_write : UInt<1>, dma_pmu_any_read : UInt<1>, dma_pmu_any_write : UInt<1>, flip dma_axi_awvalid : UInt<1>, dma_axi_awready : UInt<1>, flip dma_axi_awid : UInt<1>, flip dma_axi_awaddr : UInt<32>, flip dma_axi_awsize : UInt<3>, flip dma_axi_wvalid : UInt<1>, dma_axi_wready : UInt<1>, flip dma_axi_wdata : UInt<64>, flip dma_axi_wstrb : UInt<8>, dma_axi_bvalid : UInt<1>, flip dma_axi_bready : UInt<1>, dma_axi_bresp : UInt<2>, dma_axi_bid : UInt<1>, flip dma_axi_arvalid : UInt<1>, dma_axi_arready : UInt<1>, flip dma_axi_arid : UInt<1>, flip dma_axi_araddr : UInt<32>, flip dma_axi_arsize : UInt<3>, dma_axi_rvalid : UInt<1>, flip dma_axi_rready : UInt<1>, dma_axi_rid : UInt<1>, dma_axi_rdata : UInt<64>, dma_axi_rresp : UInt<2>, dma_axi_rlast : UInt<1>}
    
    wire fifo_error : UInt<2>[5] @[el2_dma_ctrl.scala 94:24]
    wire fifo_error_bus : UInt<5>
    fifo_error_bus <= UInt<1>("h00")
    wire fifo_done : UInt<5>
    fifo_done <= UInt<1>("h00")
    wire fifo_addr : UInt<32>[5] @[el2_dma_ctrl.scala 100:23]
    wire fifo_sz : UInt<3>[5] @[el2_dma_ctrl.scala 102:21]
    wire fifo_byteen : UInt<8>[5] @[el2_dma_ctrl.scala 104:25]
    wire fifo_data : UInt<64>[5] @[el2_dma_ctrl.scala 106:23]
    wire fifo_tag : UInt<1>[5] @[el2_dma_ctrl.scala 108:22]
    wire fifo_mid : UInt<1>[5] @[el2_dma_ctrl.scala 110:22]
    wire fifo_prty : UInt<2>[5] @[el2_dma_ctrl.scala 112:23]
    wire fifo_error_en : UInt<5>
    fifo_error_en <= UInt<1>("h00")
    wire fifo_error_in : UInt<2>[5] @[el2_dma_ctrl.scala 116:27]
    wire fifo_data_in : UInt<64>[5] @[el2_dma_ctrl.scala 118:26]
    wire RspPtr : UInt<3>
    RspPtr <= UInt<1>("h00")
    wire WrPtr : UInt<3>
    WrPtr <= UInt<1>("h00")
    wire RdPtr : UInt<3>
    RdPtr <= UInt<1>("h00")
    wire NxtRspPtr : UInt<3>
    NxtRspPtr <= UInt<1>("h00")
    wire NxtWrPtr : UInt<3>
    NxtWrPtr <= UInt<1>("h00")
    wire NxtRdPtr : UInt<3>
    NxtRdPtr <= UInt<1>("h00")
    wire dma_dbg_cmd_error : UInt<1>
    dma_dbg_cmd_error <= UInt<1>("h00")
    wire dma_dbg_cmd_done_q : UInt<1>
    dma_dbg_cmd_done_q <= UInt<1>("h00")
    wire fifo_empty : UInt<1>
    fifo_empty <= UInt<1>("h00")
    wire dma_address_error : UInt<1>
    dma_address_error <= UInt<1>("h00")
    wire dma_alignment_error : UInt<1>
    dma_alignment_error <= UInt<1>("h00")
    wire num_fifo_vld : UInt<4>
    num_fifo_vld <= UInt<1>("h00")
    wire dma_mem_req : UInt<1>
    dma_mem_req <= UInt<1>("h00")
    wire dma_mem_addr_int : UInt<32>
    dma_mem_addr_int <= UInt<1>("h00")
    wire dma_mem_sz_int : UInt<3>
    dma_mem_sz_int <= UInt<1>("h00")
    wire dma_mem_byteen : UInt<8>
    dma_mem_byteen <= UInt<1>("h00")
    wire dma_nack_count : UInt<3>
    dma_nack_count <= UInt<1>("h00")
    wire dma_nack_count_csr : UInt<3>
    dma_nack_count_csr <= UInt<1>("h00")
    wire bus_rsp_valid : UInt<1>
    bus_rsp_valid <= UInt<1>("h00")
    wire bus_rsp_sent : UInt<1>
    bus_rsp_sent <= UInt<1>("h00")
    wire bus_cmd_valid : UInt<1>
    bus_cmd_valid <= UInt<1>("h00")
    wire bus_cmd_sent : UInt<1>
    bus_cmd_sent <= UInt<1>("h00")
    wire bus_cmd_write : UInt<1>
    bus_cmd_write <= UInt<1>("h00")
    wire bus_cmd_posted_write : UInt<1>
    bus_cmd_posted_write <= UInt<1>("h00")
    wire bus_cmd_byteen : UInt<8>
    bus_cmd_byteen <= UInt<1>("h00")
    wire bus_cmd_sz : UInt<3>
    bus_cmd_sz <= UInt<1>("h00")
    wire bus_cmd_addr : UInt<32>
    bus_cmd_addr <= UInt<1>("h00")
    wire bus_cmd_wdata : UInt<64>
    bus_cmd_wdata <= UInt<1>("h00")
    wire bus_cmd_tag : UInt<1>
    bus_cmd_tag <= UInt<1>("h00")
    wire bus_cmd_mid : UInt<1>
    bus_cmd_mid <= UInt<1>("h00")
    wire bus_cmd_prty : UInt<2>
    bus_cmd_prty <= UInt<1>("h00")
    wire bus_posted_write_done : UInt<1>
    bus_posted_write_done <= UInt<1>("h00")
    wire fifo_full : UInt<1>
    fifo_full <= UInt<1>("h00")
    wire dbg_dma_bubble_bus : UInt<1>
    dbg_dma_bubble_bus <= UInt<1>("h00")
    wire axi_mstr_priority : UInt<1>
    axi_mstr_priority <= UInt<1>("h00")
    wire axi_mstr_sel : UInt<1>
    axi_mstr_sel <= UInt<1>("h00")
    wire axi_rsp_sent : UInt<1>
    axi_rsp_sent <= UInt<1>("h00")
    wire fifo_cmd_en : UInt<5>
    fifo_cmd_en <= UInt<1>("h00")
    wire fifo_data_en : UInt<5>
    fifo_data_en <= UInt<1>("h00")
    wire fifo_pend_en : UInt<5>
    fifo_pend_en <= UInt<1>("h00")
    wire fifo_error_bus_en : UInt<5>
    fifo_error_bus_en <= UInt<1>("h00")
    wire fifo_done_en : UInt<5>
    fifo_done_en <= UInt<1>("h00")
    wire fifo_done_bus_en : UInt<5>
    fifo_done_bus_en <= UInt<1>("h00")
    wire fifo_reset : UInt<5>
    fifo_reset <= UInt<1>("h00")
    wire fifo_valid : UInt<5>
    fifo_valid <= UInt<1>("h00")
    wire fifo_rpend : UInt<5>
    fifo_rpend <= UInt<1>("h00")
    wire fifo_done_bus : UInt<5>
    fifo_done_bus <= UInt<1>("h00")
    wire fifo_write : UInt<5>
    fifo_write <= UInt<1>("h00")
    wire fifo_posted_write : UInt<5>
    fifo_posted_write <= UInt<1>("h00")
    wire fifo_dbg : UInt<5>
    fifo_dbg <= UInt<1>("h00")
    wire wrbuf_vld : UInt<1>
    wrbuf_vld <= UInt<1>("h00")
    wire fifo_posted_write_in : UInt<1>
    fifo_posted_write_in <= UInt<1>("h00")
    wire wrbuf_data_vld : UInt<1>
    wrbuf_data_vld <= UInt<1>("h00")
    wire rdbuf_vld : UInt<1>
    rdbuf_vld <= UInt<1>("h00")
    wire axi_mstr_prty_en : UInt<1>
    axi_mstr_prty_en <= UInt<1>("h00")
    wire dma_free_clk : Clock @[el2_dma_ctrl.scala 230:26]
    wire dma_bus_clk : Clock @[el2_dma_ctrl.scala 232:25]
    wire dma_buffer_c1_clk : Clock @[el2_dma_ctrl.scala 234:31]
    wire fifo_byteen_in : UInt<8>
    fifo_byteen_in <= UInt<1>("h00")
    node _T = bits(dma_mem_addr_int, 31, 0) @[el2_dma_ctrl.scala 243:95]
    node _T_1 = bits(_T, 31, 28) @[el2_lib.scala 496:27]
    node dma_mem_addr_in_dccm_region_nc = eq(_T_1, UInt<4>("h0f")) @[el2_lib.scala 496:49]
    wire dma_mem_addr_in_dccm : UInt<1> @[el2_lib.scala 497:26]
    node _T_2 = bits(_T, 31, 16) @[el2_lib.scala 501:24]
    node _T_3 = eq(_T_2, UInt<16>("h0f004")) @[el2_lib.scala 501:39]
    dma_mem_addr_in_dccm <= _T_3 @[el2_lib.scala 501:16]
    node _T_4 = bits(dma_mem_addr_int, 31, 0) @[el2_dma_ctrl.scala 247:93]
    node _T_5 = bits(_T_4, 31, 28) @[el2_lib.scala 496:27]
    node dma_mem_addr_in_pic_region_nc = eq(_T_5, UInt<4>("h0f")) @[el2_lib.scala 496:49]
    wire dma_mem_addr_in_pic : UInt<1> @[el2_lib.scala 497:26]
    node _T_6 = bits(_T_4, 31, 15) @[el2_lib.scala 501:24]
    node _T_7 = eq(_T_6, UInt<17>("h01e018")) @[el2_lib.scala 501:39]
    dma_mem_addr_in_pic <= _T_7 @[el2_lib.scala 501:16]
    node _T_8 = bits(dma_mem_addr_int, 31, 0) @[el2_dma_ctrl.scala 251:111]
    node _T_9 = bits(_T_8, 31, 28) @[el2_lib.scala 496:27]
    node dma_mem_addr_in_iccm_region_nc = eq(_T_9, UInt<4>("h0e")) @[el2_lib.scala 496:49]
    wire dma_mem_addr_in_iccm : UInt<1> @[el2_lib.scala 497:26]
    node _T_10 = bits(_T_8, 31, 16) @[el2_lib.scala 501:24]
    node _T_11 = eq(_T_10, UInt<16>("h0ee00")) @[el2_lib.scala 501:39]
    dma_mem_addr_in_iccm <= _T_11 @[el2_lib.scala 501:16]
    node _T_12 = bits(io.dbg_cmd_valid, 0, 0) @[el2_dma_ctrl.scala 255:51]
    node _T_13 = bits(io.dbg_cmd_addr, 31, 0) @[el2_dma_ctrl.scala 255:74]
    node _T_14 = bits(bus_cmd_addr, 31, 0) @[el2_dma_ctrl.scala 255:94]
    node fifo_addr_in = mux(_T_12, _T_13, _T_14) @[el2_dma_ctrl.scala 255:33]
    node _T_15 = bits(io.dbg_cmd_valid, 0, 0) @[el2_dma_ctrl.scala 257:52]
    node _T_16 = bits(io.dbg_cmd_addr, 2, 2) @[el2_dma_ctrl.scala 257:93]
    node _T_17 = mul(UInt<3>("h04"), _T_16) @[el2_dma_ctrl.scala 257:76]
    node _T_18 = dshl(UInt<4>("h0f"), _T_17) @[el2_dma_ctrl.scala 257:68]
    node _T_19 = bits(bus_cmd_byteen, 7, 0) @[el2_dma_ctrl.scala 257:113]
    node _T_20 = mux(_T_15, _T_18, _T_19) @[el2_dma_ctrl.scala 257:34]
    fifo_byteen_in <= _T_20 @[el2_dma_ctrl.scala 257:28]
    node _T_21 = bits(io.dbg_cmd_valid, 0, 0) @[el2_dma_ctrl.scala 259:51]
    node _T_22 = bits(io.dbg_cmd_size, 1, 0) @[el2_dma_ctrl.scala 259:83]
    node _T_23 = cat(UInt<1>("h00"), _T_22) @[Cat.scala 29:58]
    node _T_24 = bits(bus_cmd_sz, 2, 0) @[el2_dma_ctrl.scala 259:101]
    node fifo_sz_in = mux(_T_21, _T_23, _T_24) @[el2_dma_ctrl.scala 259:33]
    node _T_25 = bits(io.dbg_cmd_valid, 0, 0) @[el2_dma_ctrl.scala 261:51]
    node fifo_write_in = mux(_T_25, io.dbg_cmd_write, bus_cmd_write) @[el2_dma_ctrl.scala 261:33]
    node _T_26 = not(io.dbg_cmd_valid) @[el2_dma_ctrl.scala 263:27]
    node _T_27 = and(_T_26, bus_cmd_posted_write) @[el2_dma_ctrl.scala 263:45]
    fifo_posted_write_in <= _T_27 @[el2_dma_ctrl.scala 263:24]
    node _T_28 = bits(bus_cmd_sent, 0, 0) @[el2_dma_ctrl.scala 268:73]
    node _T_29 = and(_T_28, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 268:80]
    node _T_30 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 268:138]
    node _T_31 = bits(_T_30, 0, 0) @[el2_dma_ctrl.scala 268:142]
    node _T_32 = and(io.dbg_cmd_valid, _T_31) @[el2_dma_ctrl.scala 268:121]
    node _T_33 = or(_T_29, _T_32) @[el2_dma_ctrl.scala 268:101]
    node _T_34 = eq(UInt<1>("h00"), WrPtr) @[el2_dma_ctrl.scala 268:158]
    node _T_35 = and(_T_33, _T_34) @[el2_dma_ctrl.scala 268:151]
    node _T_36 = bits(bus_cmd_sent, 0, 0) @[el2_dma_ctrl.scala 268:73]
    node _T_37 = and(_T_36, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 268:80]
    node _T_38 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 268:138]
    node _T_39 = bits(_T_38, 0, 0) @[el2_dma_ctrl.scala 268:142]
    node _T_40 = and(io.dbg_cmd_valid, _T_39) @[el2_dma_ctrl.scala 268:121]
    node _T_41 = or(_T_37, _T_40) @[el2_dma_ctrl.scala 268:101]
    node _T_42 = eq(UInt<1>("h01"), WrPtr) @[el2_dma_ctrl.scala 268:158]
    node _T_43 = and(_T_41, _T_42) @[el2_dma_ctrl.scala 268:151]
    node _T_44 = bits(bus_cmd_sent, 0, 0) @[el2_dma_ctrl.scala 268:73]
    node _T_45 = and(_T_44, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 268:80]
    node _T_46 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 268:138]
    node _T_47 = bits(_T_46, 0, 0) @[el2_dma_ctrl.scala 268:142]
    node _T_48 = and(io.dbg_cmd_valid, _T_47) @[el2_dma_ctrl.scala 268:121]
    node _T_49 = or(_T_45, _T_48) @[el2_dma_ctrl.scala 268:101]
    node _T_50 = eq(UInt<2>("h02"), WrPtr) @[el2_dma_ctrl.scala 268:158]
    node _T_51 = and(_T_49, _T_50) @[el2_dma_ctrl.scala 268:151]
    node _T_52 = bits(bus_cmd_sent, 0, 0) @[el2_dma_ctrl.scala 268:73]
    node _T_53 = and(_T_52, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 268:80]
    node _T_54 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 268:138]
    node _T_55 = bits(_T_54, 0, 0) @[el2_dma_ctrl.scala 268:142]
    node _T_56 = and(io.dbg_cmd_valid, _T_55) @[el2_dma_ctrl.scala 268:121]
    node _T_57 = or(_T_53, _T_56) @[el2_dma_ctrl.scala 268:101]
    node _T_58 = eq(UInt<2>("h03"), WrPtr) @[el2_dma_ctrl.scala 268:158]
    node _T_59 = and(_T_57, _T_58) @[el2_dma_ctrl.scala 268:151]
    node _T_60 = bits(bus_cmd_sent, 0, 0) @[el2_dma_ctrl.scala 268:73]
    node _T_61 = and(_T_60, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 268:80]
    node _T_62 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 268:138]
    node _T_63 = bits(_T_62, 0, 0) @[el2_dma_ctrl.scala 268:142]
    node _T_64 = and(io.dbg_cmd_valid, _T_63) @[el2_dma_ctrl.scala 268:121]
    node _T_65 = or(_T_61, _T_64) @[el2_dma_ctrl.scala 268:101]
    node _T_66 = eq(UInt<3>("h04"), WrPtr) @[el2_dma_ctrl.scala 268:158]
    node _T_67 = and(_T_65, _T_66) @[el2_dma_ctrl.scala 268:151]
    node _T_68 = cat(_T_67, _T_59) @[Cat.scala 29:58]
    node _T_69 = cat(_T_68, _T_51) @[Cat.scala 29:58]
    node _T_70 = cat(_T_69, _T_43) @[Cat.scala 29:58]
    node _T_71 = cat(_T_70, _T_35) @[Cat.scala 29:58]
    fifo_cmd_en <= _T_71 @[el2_dma_ctrl.scala 268:21]
    node _T_72 = and(bus_cmd_sent, fifo_write_in) @[el2_dma_ctrl.scala 270:73]
    node _T_73 = and(_T_72, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 270:89]
    node _T_74 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 270:147]
    node _T_75 = and(io.dbg_cmd_valid, _T_74) @[el2_dma_ctrl.scala 270:130]
    node _T_76 = and(_T_75, io.dbg_cmd_write) @[el2_dma_ctrl.scala 270:151]
    node _T_77 = or(_T_73, _T_76) @[el2_dma_ctrl.scala 270:110]
    node _T_78 = eq(UInt<1>("h00"), WrPtr) @[el2_dma_ctrl.scala 270:179]
    node _T_79 = and(_T_77, _T_78) @[el2_dma_ctrl.scala 270:172]
    node _T_80 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 270:213]
    node _T_81 = eq(UInt<1>("h00"), RdPtr) @[el2_dma_ctrl.scala 270:243]
    node _T_82 = and(_T_80, _T_81) @[el2_dma_ctrl.scala 270:236]
    node _T_83 = or(_T_79, _T_82) @[el2_dma_ctrl.scala 270:191]
    node _T_84 = eq(UInt<1>("h00"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 270:284]
    node _T_85 = and(io.dccm_dma_rvalid, _T_84) @[el2_dma_ctrl.scala 270:277]
    node _T_86 = or(_T_83, _T_85) @[el2_dma_ctrl.scala 270:255]
    node _T_87 = eq(UInt<1>("h00"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 270:336]
    node _T_88 = and(io.iccm_dma_rvalid, _T_87) @[el2_dma_ctrl.scala 270:329]
    node _T_89 = or(_T_86, _T_88) @[el2_dma_ctrl.scala 270:307]
    node _T_90 = and(bus_cmd_sent, fifo_write_in) @[el2_dma_ctrl.scala 270:73]
    node _T_91 = and(_T_90, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 270:89]
    node _T_92 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 270:147]
    node _T_93 = and(io.dbg_cmd_valid, _T_92) @[el2_dma_ctrl.scala 270:130]
    node _T_94 = and(_T_93, io.dbg_cmd_write) @[el2_dma_ctrl.scala 270:151]
    node _T_95 = or(_T_91, _T_94) @[el2_dma_ctrl.scala 270:110]
    node _T_96 = eq(UInt<1>("h01"), WrPtr) @[el2_dma_ctrl.scala 270:179]
    node _T_97 = and(_T_95, _T_96) @[el2_dma_ctrl.scala 270:172]
    node _T_98 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 270:213]
    node _T_99 = eq(UInt<1>("h01"), RdPtr) @[el2_dma_ctrl.scala 270:243]
    node _T_100 = and(_T_98, _T_99) @[el2_dma_ctrl.scala 270:236]
    node _T_101 = or(_T_97, _T_100) @[el2_dma_ctrl.scala 270:191]
    node _T_102 = eq(UInt<1>("h01"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 270:284]
    node _T_103 = and(io.dccm_dma_rvalid, _T_102) @[el2_dma_ctrl.scala 270:277]
    node _T_104 = or(_T_101, _T_103) @[el2_dma_ctrl.scala 270:255]
    node _T_105 = eq(UInt<1>("h01"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 270:336]
    node _T_106 = and(io.iccm_dma_rvalid, _T_105) @[el2_dma_ctrl.scala 270:329]
    node _T_107 = or(_T_104, _T_106) @[el2_dma_ctrl.scala 270:307]
    node _T_108 = and(bus_cmd_sent, fifo_write_in) @[el2_dma_ctrl.scala 270:73]
    node _T_109 = and(_T_108, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 270:89]
    node _T_110 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 270:147]
    node _T_111 = and(io.dbg_cmd_valid, _T_110) @[el2_dma_ctrl.scala 270:130]
    node _T_112 = and(_T_111, io.dbg_cmd_write) @[el2_dma_ctrl.scala 270:151]
    node _T_113 = or(_T_109, _T_112) @[el2_dma_ctrl.scala 270:110]
    node _T_114 = eq(UInt<2>("h02"), WrPtr) @[el2_dma_ctrl.scala 270:179]
    node _T_115 = and(_T_113, _T_114) @[el2_dma_ctrl.scala 270:172]
    node _T_116 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 270:213]
    node _T_117 = eq(UInt<2>("h02"), RdPtr) @[el2_dma_ctrl.scala 270:243]
    node _T_118 = and(_T_116, _T_117) @[el2_dma_ctrl.scala 270:236]
    node _T_119 = or(_T_115, _T_118) @[el2_dma_ctrl.scala 270:191]
    node _T_120 = eq(UInt<2>("h02"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 270:284]
    node _T_121 = and(io.dccm_dma_rvalid, _T_120) @[el2_dma_ctrl.scala 270:277]
    node _T_122 = or(_T_119, _T_121) @[el2_dma_ctrl.scala 270:255]
    node _T_123 = eq(UInt<2>("h02"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 270:336]
    node _T_124 = and(io.iccm_dma_rvalid, _T_123) @[el2_dma_ctrl.scala 270:329]
    node _T_125 = or(_T_122, _T_124) @[el2_dma_ctrl.scala 270:307]
    node _T_126 = and(bus_cmd_sent, fifo_write_in) @[el2_dma_ctrl.scala 270:73]
    node _T_127 = and(_T_126, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 270:89]
    node _T_128 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 270:147]
    node _T_129 = and(io.dbg_cmd_valid, _T_128) @[el2_dma_ctrl.scala 270:130]
    node _T_130 = and(_T_129, io.dbg_cmd_write) @[el2_dma_ctrl.scala 270:151]
    node _T_131 = or(_T_127, _T_130) @[el2_dma_ctrl.scala 270:110]
    node _T_132 = eq(UInt<2>("h03"), WrPtr) @[el2_dma_ctrl.scala 270:179]
    node _T_133 = and(_T_131, _T_132) @[el2_dma_ctrl.scala 270:172]
    node _T_134 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 270:213]
    node _T_135 = eq(UInt<2>("h03"), RdPtr) @[el2_dma_ctrl.scala 270:243]
    node _T_136 = and(_T_134, _T_135) @[el2_dma_ctrl.scala 270:236]
    node _T_137 = or(_T_133, _T_136) @[el2_dma_ctrl.scala 270:191]
    node _T_138 = eq(UInt<2>("h03"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 270:284]
    node _T_139 = and(io.dccm_dma_rvalid, _T_138) @[el2_dma_ctrl.scala 270:277]
    node _T_140 = or(_T_137, _T_139) @[el2_dma_ctrl.scala 270:255]
    node _T_141 = eq(UInt<2>("h03"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 270:336]
    node _T_142 = and(io.iccm_dma_rvalid, _T_141) @[el2_dma_ctrl.scala 270:329]
    node _T_143 = or(_T_140, _T_142) @[el2_dma_ctrl.scala 270:307]
    node _T_144 = and(bus_cmd_sent, fifo_write_in) @[el2_dma_ctrl.scala 270:73]
    node _T_145 = and(_T_144, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 270:89]
    node _T_146 = bits(io.dbg_cmd_type, 1, 1) @[el2_dma_ctrl.scala 270:147]
    node _T_147 = and(io.dbg_cmd_valid, _T_146) @[el2_dma_ctrl.scala 270:130]
    node _T_148 = and(_T_147, io.dbg_cmd_write) @[el2_dma_ctrl.scala 270:151]
    node _T_149 = or(_T_145, _T_148) @[el2_dma_ctrl.scala 270:110]
    node _T_150 = eq(UInt<3>("h04"), WrPtr) @[el2_dma_ctrl.scala 270:179]
    node _T_151 = and(_T_149, _T_150) @[el2_dma_ctrl.scala 270:172]
    node _T_152 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 270:213]
    node _T_153 = eq(UInt<3>("h04"), RdPtr) @[el2_dma_ctrl.scala 270:243]
    node _T_154 = and(_T_152, _T_153) @[el2_dma_ctrl.scala 270:236]
    node _T_155 = or(_T_151, _T_154) @[el2_dma_ctrl.scala 270:191]
    node _T_156 = eq(UInt<3>("h04"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 270:284]
    node _T_157 = and(io.dccm_dma_rvalid, _T_156) @[el2_dma_ctrl.scala 270:277]
    node _T_158 = or(_T_155, _T_157) @[el2_dma_ctrl.scala 270:255]
    node _T_159 = eq(UInt<3>("h04"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 270:336]
    node _T_160 = and(io.iccm_dma_rvalid, _T_159) @[el2_dma_ctrl.scala 270:329]
    node _T_161 = or(_T_158, _T_160) @[el2_dma_ctrl.scala 270:307]
    node _T_162 = cat(_T_161, _T_143) @[Cat.scala 29:58]
    node _T_163 = cat(_T_162, _T_125) @[Cat.scala 29:58]
    node _T_164 = cat(_T_163, _T_107) @[Cat.scala 29:58]
    node _T_165 = cat(_T_164, _T_89) @[Cat.scala 29:58]
    fifo_data_en <= _T_165 @[el2_dma_ctrl.scala 270:21]
    node _T_166 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 272:75]
    node _T_167 = not(io.dma_mem_write) @[el2_dma_ctrl.scala 272:96]
    node _T_168 = and(_T_166, _T_167) @[el2_dma_ctrl.scala 272:94]
    node _T_169 = eq(UInt<1>("h00"), RdPtr) @[el2_dma_ctrl.scala 272:121]
    node _T_170 = and(_T_168, _T_169) @[el2_dma_ctrl.scala 272:114]
    node _T_171 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 272:75]
    node _T_172 = not(io.dma_mem_write) @[el2_dma_ctrl.scala 272:96]
    node _T_173 = and(_T_171, _T_172) @[el2_dma_ctrl.scala 272:94]
    node _T_174 = eq(UInt<1>("h01"), RdPtr) @[el2_dma_ctrl.scala 272:121]
    node _T_175 = and(_T_173, _T_174) @[el2_dma_ctrl.scala 272:114]
    node _T_176 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 272:75]
    node _T_177 = not(io.dma_mem_write) @[el2_dma_ctrl.scala 272:96]
    node _T_178 = and(_T_176, _T_177) @[el2_dma_ctrl.scala 272:94]
    node _T_179 = eq(UInt<2>("h02"), RdPtr) @[el2_dma_ctrl.scala 272:121]
    node _T_180 = and(_T_178, _T_179) @[el2_dma_ctrl.scala 272:114]
    node _T_181 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 272:75]
    node _T_182 = not(io.dma_mem_write) @[el2_dma_ctrl.scala 272:96]
    node _T_183 = and(_T_181, _T_182) @[el2_dma_ctrl.scala 272:94]
    node _T_184 = eq(UInt<2>("h03"), RdPtr) @[el2_dma_ctrl.scala 272:121]
    node _T_185 = and(_T_183, _T_184) @[el2_dma_ctrl.scala 272:114]
    node _T_186 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 272:75]
    node _T_187 = not(io.dma_mem_write) @[el2_dma_ctrl.scala 272:96]
    node _T_188 = and(_T_186, _T_187) @[el2_dma_ctrl.scala 272:94]
    node _T_189 = eq(UInt<3>("h04"), RdPtr) @[el2_dma_ctrl.scala 272:121]
    node _T_190 = and(_T_188, _T_189) @[el2_dma_ctrl.scala 272:114]
    node _T_191 = cat(_T_190, _T_185) @[Cat.scala 29:58]
    node _T_192 = cat(_T_191, _T_180) @[Cat.scala 29:58]
    node _T_193 = cat(_T_192, _T_175) @[Cat.scala 29:58]
    node _T_194 = cat(_T_193, _T_170) @[Cat.scala 29:58]
    fifo_pend_en <= _T_194 @[el2_dma_ctrl.scala 272:21]
    node _T_195 = bits(dma_address_error, 0, 0) @[el2_dma_ctrl.scala 274:78]
    node _T_196 = bits(dma_alignment_error, 0, 0) @[el2_dma_ctrl.scala 274:107]
    node _T_197 = or(_T_195, _T_196) @[el2_dma_ctrl.scala 274:85]
    node _T_198 = or(_T_197, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 274:114]
    node _T_199 = eq(UInt<1>("h00"), RdPtr) @[el2_dma_ctrl.scala 274:142]
    node _T_200 = and(_T_198, _T_199) @[el2_dma_ctrl.scala 274:135]
    node _T_201 = and(io.dccm_dma_rvalid, io.dccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:177]
    node _T_202 = eq(UInt<1>("h00"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 274:209]
    node _T_203 = and(_T_201, _T_202) @[el2_dma_ctrl.scala 274:202]
    node _T_204 = or(_T_200, _T_203) @[el2_dma_ctrl.scala 274:154]
    node _T_205 = and(io.iccm_dma_rvalid, io.iccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:255]
    node _T_206 = eq(UInt<1>("h00"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 274:287]
    node _T_207 = and(_T_205, _T_206) @[el2_dma_ctrl.scala 274:280]
    node _T_208 = or(_T_204, _T_207) @[el2_dma_ctrl.scala 274:232]
    node _T_209 = bits(dma_address_error, 0, 0) @[el2_dma_ctrl.scala 274:78]
    node _T_210 = bits(dma_alignment_error, 0, 0) @[el2_dma_ctrl.scala 274:107]
    node _T_211 = or(_T_209, _T_210) @[el2_dma_ctrl.scala 274:85]
    node _T_212 = or(_T_211, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 274:114]
    node _T_213 = eq(UInt<1>("h01"), RdPtr) @[el2_dma_ctrl.scala 274:142]
    node _T_214 = and(_T_212, _T_213) @[el2_dma_ctrl.scala 274:135]
    node _T_215 = and(io.dccm_dma_rvalid, io.dccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:177]
    node _T_216 = eq(UInt<1>("h01"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 274:209]
    node _T_217 = and(_T_215, _T_216) @[el2_dma_ctrl.scala 274:202]
    node _T_218 = or(_T_214, _T_217) @[el2_dma_ctrl.scala 274:154]
    node _T_219 = and(io.iccm_dma_rvalid, io.iccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:255]
    node _T_220 = eq(UInt<1>("h01"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 274:287]
    node _T_221 = and(_T_219, _T_220) @[el2_dma_ctrl.scala 274:280]
    node _T_222 = or(_T_218, _T_221) @[el2_dma_ctrl.scala 274:232]
    node _T_223 = bits(dma_address_error, 0, 0) @[el2_dma_ctrl.scala 274:78]
    node _T_224 = bits(dma_alignment_error, 0, 0) @[el2_dma_ctrl.scala 274:107]
    node _T_225 = or(_T_223, _T_224) @[el2_dma_ctrl.scala 274:85]
    node _T_226 = or(_T_225, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 274:114]
    node _T_227 = eq(UInt<2>("h02"), RdPtr) @[el2_dma_ctrl.scala 274:142]
    node _T_228 = and(_T_226, _T_227) @[el2_dma_ctrl.scala 274:135]
    node _T_229 = and(io.dccm_dma_rvalid, io.dccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:177]
    node _T_230 = eq(UInt<2>("h02"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 274:209]
    node _T_231 = and(_T_229, _T_230) @[el2_dma_ctrl.scala 274:202]
    node _T_232 = or(_T_228, _T_231) @[el2_dma_ctrl.scala 274:154]
    node _T_233 = and(io.iccm_dma_rvalid, io.iccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:255]
    node _T_234 = eq(UInt<2>("h02"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 274:287]
    node _T_235 = and(_T_233, _T_234) @[el2_dma_ctrl.scala 274:280]
    node _T_236 = or(_T_232, _T_235) @[el2_dma_ctrl.scala 274:232]
    node _T_237 = bits(dma_address_error, 0, 0) @[el2_dma_ctrl.scala 274:78]
    node _T_238 = bits(dma_alignment_error, 0, 0) @[el2_dma_ctrl.scala 274:107]
    node _T_239 = or(_T_237, _T_238) @[el2_dma_ctrl.scala 274:85]
    node _T_240 = or(_T_239, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 274:114]
    node _T_241 = eq(UInt<2>("h03"), RdPtr) @[el2_dma_ctrl.scala 274:142]
    node _T_242 = and(_T_240, _T_241) @[el2_dma_ctrl.scala 274:135]
    node _T_243 = and(io.dccm_dma_rvalid, io.dccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:177]
    node _T_244 = eq(UInt<2>("h03"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 274:209]
    node _T_245 = and(_T_243, _T_244) @[el2_dma_ctrl.scala 274:202]
    node _T_246 = or(_T_242, _T_245) @[el2_dma_ctrl.scala 274:154]
    node _T_247 = and(io.iccm_dma_rvalid, io.iccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:255]
    node _T_248 = eq(UInt<2>("h03"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 274:287]
    node _T_249 = and(_T_247, _T_248) @[el2_dma_ctrl.scala 274:280]
    node _T_250 = or(_T_246, _T_249) @[el2_dma_ctrl.scala 274:232]
    node _T_251 = bits(dma_address_error, 0, 0) @[el2_dma_ctrl.scala 274:78]
    node _T_252 = bits(dma_alignment_error, 0, 0) @[el2_dma_ctrl.scala 274:107]
    node _T_253 = or(_T_251, _T_252) @[el2_dma_ctrl.scala 274:85]
    node _T_254 = or(_T_253, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 274:114]
    node _T_255 = eq(UInt<3>("h04"), RdPtr) @[el2_dma_ctrl.scala 274:142]
    node _T_256 = and(_T_254, _T_255) @[el2_dma_ctrl.scala 274:135]
    node _T_257 = and(io.dccm_dma_rvalid, io.dccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:177]
    node _T_258 = eq(UInt<3>("h04"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 274:209]
    node _T_259 = and(_T_257, _T_258) @[el2_dma_ctrl.scala 274:202]
    node _T_260 = or(_T_256, _T_259) @[el2_dma_ctrl.scala 274:154]
    node _T_261 = and(io.iccm_dma_rvalid, io.iccm_dma_ecc_error) @[el2_dma_ctrl.scala 274:255]
    node _T_262 = eq(UInt<3>("h04"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 274:287]
    node _T_263 = and(_T_261, _T_262) @[el2_dma_ctrl.scala 274:280]
    node _T_264 = or(_T_260, _T_263) @[el2_dma_ctrl.scala 274:232]
    node _T_265 = cat(_T_264, _T_250) @[Cat.scala 29:58]
    node _T_266 = cat(_T_265, _T_236) @[Cat.scala 29:58]
    node _T_267 = cat(_T_266, _T_222) @[Cat.scala 29:58]
    node _T_268 = cat(_T_267, _T_208) @[Cat.scala 29:58]
    fifo_error_en <= _T_268 @[el2_dma_ctrl.scala 274:21]
    node _T_269 = bits(fifo_error_in[0], 1, 0) @[el2_dma_ctrl.scala 276:77]
    node _T_270 = orr(_T_269) @[el2_dma_ctrl.scala 276:83]
    node _T_271 = bits(fifo_error_en, 0, 0) @[el2_dma_ctrl.scala 276:103]
    node _T_272 = and(_T_270, _T_271) @[el2_dma_ctrl.scala 276:88]
    node _T_273 = orr(fifo_error[0]) @[el2_dma_ctrl.scala 276:125]
    node _T_274 = or(_T_272, _T_273) @[el2_dma_ctrl.scala 276:108]
    node _T_275 = and(_T_274, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 276:131]
    node _T_276 = bits(fifo_error_in[1], 1, 0) @[el2_dma_ctrl.scala 276:77]
    node _T_277 = orr(_T_276) @[el2_dma_ctrl.scala 276:83]
    node _T_278 = bits(fifo_error_en, 1, 1) @[el2_dma_ctrl.scala 276:103]
    node _T_279 = and(_T_277, _T_278) @[el2_dma_ctrl.scala 276:88]
    node _T_280 = orr(fifo_error[1]) @[el2_dma_ctrl.scala 276:125]
    node _T_281 = or(_T_279, _T_280) @[el2_dma_ctrl.scala 276:108]
    node _T_282 = and(_T_281, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 276:131]
    node _T_283 = bits(fifo_error_in[2], 1, 0) @[el2_dma_ctrl.scala 276:77]
    node _T_284 = orr(_T_283) @[el2_dma_ctrl.scala 276:83]
    node _T_285 = bits(fifo_error_en, 2, 2) @[el2_dma_ctrl.scala 276:103]
    node _T_286 = and(_T_284, _T_285) @[el2_dma_ctrl.scala 276:88]
    node _T_287 = orr(fifo_error[2]) @[el2_dma_ctrl.scala 276:125]
    node _T_288 = or(_T_286, _T_287) @[el2_dma_ctrl.scala 276:108]
    node _T_289 = and(_T_288, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 276:131]
    node _T_290 = bits(fifo_error_in[3], 1, 0) @[el2_dma_ctrl.scala 276:77]
    node _T_291 = orr(_T_290) @[el2_dma_ctrl.scala 276:83]
    node _T_292 = bits(fifo_error_en, 3, 3) @[el2_dma_ctrl.scala 276:103]
    node _T_293 = and(_T_291, _T_292) @[el2_dma_ctrl.scala 276:88]
    node _T_294 = orr(fifo_error[3]) @[el2_dma_ctrl.scala 276:125]
    node _T_295 = or(_T_293, _T_294) @[el2_dma_ctrl.scala 276:108]
    node _T_296 = and(_T_295, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 276:131]
    node _T_297 = bits(fifo_error_in[4], 1, 0) @[el2_dma_ctrl.scala 276:77]
    node _T_298 = orr(_T_297) @[el2_dma_ctrl.scala 276:83]
    node _T_299 = bits(fifo_error_en, 4, 4) @[el2_dma_ctrl.scala 276:103]
    node _T_300 = and(_T_298, _T_299) @[el2_dma_ctrl.scala 276:88]
    node _T_301 = orr(fifo_error[4]) @[el2_dma_ctrl.scala 276:125]
    node _T_302 = or(_T_300, _T_301) @[el2_dma_ctrl.scala 276:108]
    node _T_303 = and(_T_302, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 276:131]
    node _T_304 = cat(_T_303, _T_296) @[Cat.scala 29:58]
    node _T_305 = cat(_T_304, _T_289) @[Cat.scala 29:58]
    node _T_306 = cat(_T_305, _T_282) @[Cat.scala 29:58]
    node _T_307 = cat(_T_306, _T_275) @[Cat.scala 29:58]
    fifo_error_bus_en <= _T_307 @[el2_dma_ctrl.scala 276:21]
    node _T_308 = orr(fifo_error[0]) @[el2_dma_ctrl.scala 278:74]
    node _T_309 = bits(fifo_error_en, 0, 0) @[el2_dma_ctrl.scala 278:93]
    node _T_310 = or(_T_308, _T_309) @[el2_dma_ctrl.scala 278:78]
    node _T_311 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 278:117]
    node _T_312 = and(_T_311, io.dma_mem_write) @[el2_dma_ctrl.scala 278:136]
    node _T_313 = or(_T_310, _T_312) @[el2_dma_ctrl.scala 278:97]
    node _T_314 = eq(UInt<1>("h00"), RdPtr) @[el2_dma_ctrl.scala 278:164]
    node _T_315 = and(_T_313, _T_314) @[el2_dma_ctrl.scala 278:157]
    node _T_316 = eq(UInt<1>("h00"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 278:205]
    node _T_317 = and(io.dccm_dma_rvalid, _T_316) @[el2_dma_ctrl.scala 278:198]
    node _T_318 = or(_T_315, _T_317) @[el2_dma_ctrl.scala 278:176]
    node _T_319 = eq(UInt<1>("h00"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 278:257]
    node _T_320 = and(io.iccm_dma_rvalid, _T_319) @[el2_dma_ctrl.scala 278:250]
    node _T_321 = or(_T_318, _T_320) @[el2_dma_ctrl.scala 278:228]
    node _T_322 = orr(fifo_error[1]) @[el2_dma_ctrl.scala 278:74]
    node _T_323 = bits(fifo_error_en, 1, 1) @[el2_dma_ctrl.scala 278:93]
    node _T_324 = or(_T_322, _T_323) @[el2_dma_ctrl.scala 278:78]
    node _T_325 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 278:117]
    node _T_326 = and(_T_325, io.dma_mem_write) @[el2_dma_ctrl.scala 278:136]
    node _T_327 = or(_T_324, _T_326) @[el2_dma_ctrl.scala 278:97]
    node _T_328 = eq(UInt<1>("h01"), RdPtr) @[el2_dma_ctrl.scala 278:164]
    node _T_329 = and(_T_327, _T_328) @[el2_dma_ctrl.scala 278:157]
    node _T_330 = eq(UInt<1>("h01"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 278:205]
    node _T_331 = and(io.dccm_dma_rvalid, _T_330) @[el2_dma_ctrl.scala 278:198]
    node _T_332 = or(_T_329, _T_331) @[el2_dma_ctrl.scala 278:176]
    node _T_333 = eq(UInt<1>("h01"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 278:257]
    node _T_334 = and(io.iccm_dma_rvalid, _T_333) @[el2_dma_ctrl.scala 278:250]
    node _T_335 = or(_T_332, _T_334) @[el2_dma_ctrl.scala 278:228]
    node _T_336 = orr(fifo_error[2]) @[el2_dma_ctrl.scala 278:74]
    node _T_337 = bits(fifo_error_en, 2, 2) @[el2_dma_ctrl.scala 278:93]
    node _T_338 = or(_T_336, _T_337) @[el2_dma_ctrl.scala 278:78]
    node _T_339 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 278:117]
    node _T_340 = and(_T_339, io.dma_mem_write) @[el2_dma_ctrl.scala 278:136]
    node _T_341 = or(_T_338, _T_340) @[el2_dma_ctrl.scala 278:97]
    node _T_342 = eq(UInt<2>("h02"), RdPtr) @[el2_dma_ctrl.scala 278:164]
    node _T_343 = and(_T_341, _T_342) @[el2_dma_ctrl.scala 278:157]
    node _T_344 = eq(UInt<2>("h02"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 278:205]
    node _T_345 = and(io.dccm_dma_rvalid, _T_344) @[el2_dma_ctrl.scala 278:198]
    node _T_346 = or(_T_343, _T_345) @[el2_dma_ctrl.scala 278:176]
    node _T_347 = eq(UInt<2>("h02"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 278:257]
    node _T_348 = and(io.iccm_dma_rvalid, _T_347) @[el2_dma_ctrl.scala 278:250]
    node _T_349 = or(_T_346, _T_348) @[el2_dma_ctrl.scala 278:228]
    node _T_350 = orr(fifo_error[3]) @[el2_dma_ctrl.scala 278:74]
    node _T_351 = bits(fifo_error_en, 3, 3) @[el2_dma_ctrl.scala 278:93]
    node _T_352 = or(_T_350, _T_351) @[el2_dma_ctrl.scala 278:78]
    node _T_353 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 278:117]
    node _T_354 = and(_T_353, io.dma_mem_write) @[el2_dma_ctrl.scala 278:136]
    node _T_355 = or(_T_352, _T_354) @[el2_dma_ctrl.scala 278:97]
    node _T_356 = eq(UInt<2>("h03"), RdPtr) @[el2_dma_ctrl.scala 278:164]
    node _T_357 = and(_T_355, _T_356) @[el2_dma_ctrl.scala 278:157]
    node _T_358 = eq(UInt<2>("h03"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 278:205]
    node _T_359 = and(io.dccm_dma_rvalid, _T_358) @[el2_dma_ctrl.scala 278:198]
    node _T_360 = or(_T_357, _T_359) @[el2_dma_ctrl.scala 278:176]
    node _T_361 = eq(UInt<2>("h03"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 278:257]
    node _T_362 = and(io.iccm_dma_rvalid, _T_361) @[el2_dma_ctrl.scala 278:250]
    node _T_363 = or(_T_360, _T_362) @[el2_dma_ctrl.scala 278:228]
    node _T_364 = orr(fifo_error[4]) @[el2_dma_ctrl.scala 278:74]
    node _T_365 = bits(fifo_error_en, 4, 4) @[el2_dma_ctrl.scala 278:93]
    node _T_366 = or(_T_364, _T_365) @[el2_dma_ctrl.scala 278:78]
    node _T_367 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 278:117]
    node _T_368 = and(_T_367, io.dma_mem_write) @[el2_dma_ctrl.scala 278:136]
    node _T_369 = or(_T_366, _T_368) @[el2_dma_ctrl.scala 278:97]
    node _T_370 = eq(UInt<3>("h04"), RdPtr) @[el2_dma_ctrl.scala 278:164]
    node _T_371 = and(_T_369, _T_370) @[el2_dma_ctrl.scala 278:157]
    node _T_372 = eq(UInt<3>("h04"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 278:205]
    node _T_373 = and(io.dccm_dma_rvalid, _T_372) @[el2_dma_ctrl.scala 278:198]
    node _T_374 = or(_T_371, _T_373) @[el2_dma_ctrl.scala 278:176]
    node _T_375 = eq(UInt<3>("h04"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 278:257]
    node _T_376 = and(io.iccm_dma_rvalid, _T_375) @[el2_dma_ctrl.scala 278:250]
    node _T_377 = or(_T_374, _T_376) @[el2_dma_ctrl.scala 278:228]
    node _T_378 = cat(_T_377, _T_363) @[Cat.scala 29:58]
    node _T_379 = cat(_T_378, _T_349) @[Cat.scala 29:58]
    node _T_380 = cat(_T_379, _T_335) @[Cat.scala 29:58]
    node _T_381 = cat(_T_380, _T_321) @[Cat.scala 29:58]
    fifo_done_en <= _T_381 @[el2_dma_ctrl.scala 278:21]
    node _T_382 = bits(fifo_done_en, 0, 0) @[el2_dma_ctrl.scala 280:71]
    node _T_383 = bits(fifo_done, 0, 0) @[el2_dma_ctrl.scala 280:86]
    node _T_384 = or(_T_382, _T_383) @[el2_dma_ctrl.scala 280:75]
    node _T_385 = and(_T_384, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 280:91]
    node _T_386 = bits(fifo_done_en, 1, 1) @[el2_dma_ctrl.scala 280:71]
    node _T_387 = bits(fifo_done, 1, 1) @[el2_dma_ctrl.scala 280:86]
    node _T_388 = or(_T_386, _T_387) @[el2_dma_ctrl.scala 280:75]
    node _T_389 = and(_T_388, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 280:91]
    node _T_390 = bits(fifo_done_en, 2, 2) @[el2_dma_ctrl.scala 280:71]
    node _T_391 = bits(fifo_done, 2, 2) @[el2_dma_ctrl.scala 280:86]
    node _T_392 = or(_T_390, _T_391) @[el2_dma_ctrl.scala 280:75]
    node _T_393 = and(_T_392, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 280:91]
    node _T_394 = bits(fifo_done_en, 3, 3) @[el2_dma_ctrl.scala 280:71]
    node _T_395 = bits(fifo_done, 3, 3) @[el2_dma_ctrl.scala 280:86]
    node _T_396 = or(_T_394, _T_395) @[el2_dma_ctrl.scala 280:75]
    node _T_397 = and(_T_396, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 280:91]
    node _T_398 = bits(fifo_done_en, 4, 4) @[el2_dma_ctrl.scala 280:71]
    node _T_399 = bits(fifo_done, 4, 4) @[el2_dma_ctrl.scala 280:86]
    node _T_400 = or(_T_398, _T_399) @[el2_dma_ctrl.scala 280:75]
    node _T_401 = and(_T_400, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 280:91]
    node _T_402 = cat(_T_401, _T_397) @[Cat.scala 29:58]
    node _T_403 = cat(_T_402, _T_393) @[Cat.scala 29:58]
    node _T_404 = cat(_T_403, _T_389) @[Cat.scala 29:58]
    node _T_405 = cat(_T_404, _T_385) @[Cat.scala 29:58]
    fifo_done_bus_en <= _T_405 @[el2_dma_ctrl.scala 280:21]
    node _T_406 = or(bus_rsp_sent, bus_posted_write_done) @[el2_dma_ctrl.scala 282:74]
    node _T_407 = and(_T_406, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 282:99]
    node _T_408 = or(_T_407, io.dma_dbg_cmd_done) @[el2_dma_ctrl.scala 282:120]
    node _T_409 = eq(UInt<1>("h00"), RspPtr) @[el2_dma_ctrl.scala 282:150]
    node _T_410 = and(_T_408, _T_409) @[el2_dma_ctrl.scala 282:143]
    node _T_411 = or(bus_rsp_sent, bus_posted_write_done) @[el2_dma_ctrl.scala 282:74]
    node _T_412 = and(_T_411, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 282:99]
    node _T_413 = or(_T_412, io.dma_dbg_cmd_done) @[el2_dma_ctrl.scala 282:120]
    node _T_414 = eq(UInt<1>("h01"), RspPtr) @[el2_dma_ctrl.scala 282:150]
    node _T_415 = and(_T_413, _T_414) @[el2_dma_ctrl.scala 282:143]
    node _T_416 = or(bus_rsp_sent, bus_posted_write_done) @[el2_dma_ctrl.scala 282:74]
    node _T_417 = and(_T_416, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 282:99]
    node _T_418 = or(_T_417, io.dma_dbg_cmd_done) @[el2_dma_ctrl.scala 282:120]
    node _T_419 = eq(UInt<2>("h02"), RspPtr) @[el2_dma_ctrl.scala 282:150]
    node _T_420 = and(_T_418, _T_419) @[el2_dma_ctrl.scala 282:143]
    node _T_421 = or(bus_rsp_sent, bus_posted_write_done) @[el2_dma_ctrl.scala 282:74]
    node _T_422 = and(_T_421, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 282:99]
    node _T_423 = or(_T_422, io.dma_dbg_cmd_done) @[el2_dma_ctrl.scala 282:120]
    node _T_424 = eq(UInt<2>("h03"), RspPtr) @[el2_dma_ctrl.scala 282:150]
    node _T_425 = and(_T_423, _T_424) @[el2_dma_ctrl.scala 282:143]
    node _T_426 = or(bus_rsp_sent, bus_posted_write_done) @[el2_dma_ctrl.scala 282:74]
    node _T_427 = and(_T_426, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 282:99]
    node _T_428 = or(_T_427, io.dma_dbg_cmd_done) @[el2_dma_ctrl.scala 282:120]
    node _T_429 = eq(UInt<3>("h04"), RspPtr) @[el2_dma_ctrl.scala 282:150]
    node _T_430 = and(_T_428, _T_429) @[el2_dma_ctrl.scala 282:143]
    node _T_431 = cat(_T_430, _T_425) @[Cat.scala 29:58]
    node _T_432 = cat(_T_431, _T_420) @[Cat.scala 29:58]
    node _T_433 = cat(_T_432, _T_415) @[Cat.scala 29:58]
    node _T_434 = cat(_T_433, _T_410) @[Cat.scala 29:58]
    fifo_reset <= _T_434 @[el2_dma_ctrl.scala 282:21]
    node _T_435 = eq(UInt<1>("h00"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 284:87]
    node _T_436 = and(io.dccm_dma_rvalid, _T_435) @[el2_dma_ctrl.scala 284:80]
    node _T_437 = cat(UInt<1>("h00"), io.dccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_438 = eq(UInt<1>("h00"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 284:173]
    node _T_439 = and(io.iccm_dma_rvalid, _T_438) @[el2_dma_ctrl.scala 284:166]
    node _T_440 = cat(UInt<1>("h00"), io.iccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_441 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 284:255]
    node _T_442 = or(_T_441, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 284:277]
    node _T_443 = cat(_T_442, dma_alignment_error) @[Cat.scala 29:58]
    node _T_444 = mux(_T_439, _T_440, _T_443) @[el2_dma_ctrl.scala 284:146]
    node _T_445 = mux(_T_436, _T_437, _T_444) @[el2_dma_ctrl.scala 284:60]
    fifo_error_in[0] <= _T_445 @[el2_dma_ctrl.scala 284:53]
    node _T_446 = eq(UInt<1>("h01"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 284:87]
    node _T_447 = and(io.dccm_dma_rvalid, _T_446) @[el2_dma_ctrl.scala 284:80]
    node _T_448 = cat(UInt<1>("h00"), io.dccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_449 = eq(UInt<1>("h01"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 284:173]
    node _T_450 = and(io.iccm_dma_rvalid, _T_449) @[el2_dma_ctrl.scala 284:166]
    node _T_451 = cat(UInt<1>("h00"), io.iccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_452 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 284:255]
    node _T_453 = or(_T_452, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 284:277]
    node _T_454 = cat(_T_453, dma_alignment_error) @[Cat.scala 29:58]
    node _T_455 = mux(_T_450, _T_451, _T_454) @[el2_dma_ctrl.scala 284:146]
    node _T_456 = mux(_T_447, _T_448, _T_455) @[el2_dma_ctrl.scala 284:60]
    fifo_error_in[1] <= _T_456 @[el2_dma_ctrl.scala 284:53]
    node _T_457 = eq(UInt<2>("h02"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 284:87]
    node _T_458 = and(io.dccm_dma_rvalid, _T_457) @[el2_dma_ctrl.scala 284:80]
    node _T_459 = cat(UInt<1>("h00"), io.dccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_460 = eq(UInt<2>("h02"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 284:173]
    node _T_461 = and(io.iccm_dma_rvalid, _T_460) @[el2_dma_ctrl.scala 284:166]
    node _T_462 = cat(UInt<1>("h00"), io.iccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_463 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 284:255]
    node _T_464 = or(_T_463, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 284:277]
    node _T_465 = cat(_T_464, dma_alignment_error) @[Cat.scala 29:58]
    node _T_466 = mux(_T_461, _T_462, _T_465) @[el2_dma_ctrl.scala 284:146]
    node _T_467 = mux(_T_458, _T_459, _T_466) @[el2_dma_ctrl.scala 284:60]
    fifo_error_in[2] <= _T_467 @[el2_dma_ctrl.scala 284:53]
    node _T_468 = eq(UInt<2>("h03"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 284:87]
    node _T_469 = and(io.dccm_dma_rvalid, _T_468) @[el2_dma_ctrl.scala 284:80]
    node _T_470 = cat(UInt<1>("h00"), io.dccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_471 = eq(UInt<2>("h03"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 284:173]
    node _T_472 = and(io.iccm_dma_rvalid, _T_471) @[el2_dma_ctrl.scala 284:166]
    node _T_473 = cat(UInt<1>("h00"), io.iccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_474 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 284:255]
    node _T_475 = or(_T_474, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 284:277]
    node _T_476 = cat(_T_475, dma_alignment_error) @[Cat.scala 29:58]
    node _T_477 = mux(_T_472, _T_473, _T_476) @[el2_dma_ctrl.scala 284:146]
    node _T_478 = mux(_T_469, _T_470, _T_477) @[el2_dma_ctrl.scala 284:60]
    fifo_error_in[3] <= _T_478 @[el2_dma_ctrl.scala 284:53]
    node _T_479 = eq(UInt<3>("h04"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 284:87]
    node _T_480 = and(io.dccm_dma_rvalid, _T_479) @[el2_dma_ctrl.scala 284:80]
    node _T_481 = cat(UInt<1>("h00"), io.dccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_482 = eq(UInt<3>("h04"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 284:173]
    node _T_483 = and(io.iccm_dma_rvalid, _T_482) @[el2_dma_ctrl.scala 284:166]
    node _T_484 = cat(UInt<1>("h00"), io.iccm_dma_ecc_error) @[Cat.scala 29:58]
    node _T_485 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 284:255]
    node _T_486 = or(_T_485, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 284:277]
    node _T_487 = cat(_T_486, dma_alignment_error) @[Cat.scala 29:58]
    node _T_488 = mux(_T_483, _T_484, _T_487) @[el2_dma_ctrl.scala 284:146]
    node _T_489 = mux(_T_480, _T_481, _T_488) @[el2_dma_ctrl.scala 284:60]
    fifo_error_in[4] <= _T_489 @[el2_dma_ctrl.scala 284:53]
    node _T_490 = bits(fifo_error_en, 0, 0) @[el2_dma_ctrl.scala 286:73]
    node _T_491 = orr(fifo_error_in[0]) @[el2_dma_ctrl.scala 286:97]
    node _T_492 = and(_T_490, _T_491) @[el2_dma_ctrl.scala 286:77]
    node _T_493 = mux(UInt<1>("h00"), UInt<32>("h0ffffffff"), UInt<32>("h00")) @[Bitwise.scala 72:12]
    node _T_494 = cat(_T_493, fifo_addr[0]) @[Cat.scala 29:58]
    node _T_495 = eq(UInt<1>("h00"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 286:167]
    node _T_496 = and(io.dccm_dma_rvalid, _T_495) @[el2_dma_ctrl.scala 286:160]
    node _T_497 = eq(UInt<1>("h00"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 286:239]
    node _T_498 = and(io.iccm_dma_rvalid, _T_497) @[el2_dma_ctrl.scala 286:232]
    node _T_499 = cat(io.dbg_cmd_wrdata, io.dbg_cmd_wrdata) @[Cat.scala 29:58]
    node _T_500 = bits(bus_cmd_wdata, 63, 0) @[el2_dma_ctrl.scala 286:344]
    node _T_501 = mux(io.dbg_cmd_valid, _T_499, _T_500) @[el2_dma_ctrl.scala 286:284]
    node _T_502 = mux(_T_498, io.iccm_dma_rdata, _T_501) @[el2_dma_ctrl.scala 286:212]
    node _T_503 = mux(_T_496, io.dccm_dma_rdata, _T_502) @[el2_dma_ctrl.scala 286:140]
    node _T_504 = mux(_T_492, _T_494, _T_503) @[el2_dma_ctrl.scala 286:59]
    fifo_data_in[0] <= _T_504 @[el2_dma_ctrl.scala 286:52]
    node _T_505 = bits(fifo_error_en, 1, 1) @[el2_dma_ctrl.scala 286:73]
    node _T_506 = orr(fifo_error_in[1]) @[el2_dma_ctrl.scala 286:97]
    node _T_507 = and(_T_505, _T_506) @[el2_dma_ctrl.scala 286:77]
    node _T_508 = mux(UInt<1>("h00"), UInt<32>("h0ffffffff"), UInt<32>("h00")) @[Bitwise.scala 72:12]
    node _T_509 = cat(_T_508, fifo_addr[1]) @[Cat.scala 29:58]
    node _T_510 = eq(UInt<1>("h01"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 286:167]
    node _T_511 = and(io.dccm_dma_rvalid, _T_510) @[el2_dma_ctrl.scala 286:160]
    node _T_512 = eq(UInt<1>("h01"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 286:239]
    node _T_513 = and(io.iccm_dma_rvalid, _T_512) @[el2_dma_ctrl.scala 286:232]
    node _T_514 = cat(io.dbg_cmd_wrdata, io.dbg_cmd_wrdata) @[Cat.scala 29:58]
    node _T_515 = bits(bus_cmd_wdata, 63, 0) @[el2_dma_ctrl.scala 286:344]
    node _T_516 = mux(io.dbg_cmd_valid, _T_514, _T_515) @[el2_dma_ctrl.scala 286:284]
    node _T_517 = mux(_T_513, io.iccm_dma_rdata, _T_516) @[el2_dma_ctrl.scala 286:212]
    node _T_518 = mux(_T_511, io.dccm_dma_rdata, _T_517) @[el2_dma_ctrl.scala 286:140]
    node _T_519 = mux(_T_507, _T_509, _T_518) @[el2_dma_ctrl.scala 286:59]
    fifo_data_in[1] <= _T_519 @[el2_dma_ctrl.scala 286:52]
    node _T_520 = bits(fifo_error_en, 2, 2) @[el2_dma_ctrl.scala 286:73]
    node _T_521 = orr(fifo_error_in[2]) @[el2_dma_ctrl.scala 286:97]
    node _T_522 = and(_T_520, _T_521) @[el2_dma_ctrl.scala 286:77]
    node _T_523 = mux(UInt<1>("h00"), UInt<32>("h0ffffffff"), UInt<32>("h00")) @[Bitwise.scala 72:12]
    node _T_524 = cat(_T_523, fifo_addr[2]) @[Cat.scala 29:58]
    node _T_525 = eq(UInt<2>("h02"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 286:167]
    node _T_526 = and(io.dccm_dma_rvalid, _T_525) @[el2_dma_ctrl.scala 286:160]
    node _T_527 = eq(UInt<2>("h02"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 286:239]
    node _T_528 = and(io.iccm_dma_rvalid, _T_527) @[el2_dma_ctrl.scala 286:232]
    node _T_529 = cat(io.dbg_cmd_wrdata, io.dbg_cmd_wrdata) @[Cat.scala 29:58]
    node _T_530 = bits(bus_cmd_wdata, 63, 0) @[el2_dma_ctrl.scala 286:344]
    node _T_531 = mux(io.dbg_cmd_valid, _T_529, _T_530) @[el2_dma_ctrl.scala 286:284]
    node _T_532 = mux(_T_528, io.iccm_dma_rdata, _T_531) @[el2_dma_ctrl.scala 286:212]
    node _T_533 = mux(_T_526, io.dccm_dma_rdata, _T_532) @[el2_dma_ctrl.scala 286:140]
    node _T_534 = mux(_T_522, _T_524, _T_533) @[el2_dma_ctrl.scala 286:59]
    fifo_data_in[2] <= _T_534 @[el2_dma_ctrl.scala 286:52]
    node _T_535 = bits(fifo_error_en, 3, 3) @[el2_dma_ctrl.scala 286:73]
    node _T_536 = orr(fifo_error_in[3]) @[el2_dma_ctrl.scala 286:97]
    node _T_537 = and(_T_535, _T_536) @[el2_dma_ctrl.scala 286:77]
    node _T_538 = mux(UInt<1>("h00"), UInt<32>("h0ffffffff"), UInt<32>("h00")) @[Bitwise.scala 72:12]
    node _T_539 = cat(_T_538, fifo_addr[3]) @[Cat.scala 29:58]
    node _T_540 = eq(UInt<2>("h03"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 286:167]
    node _T_541 = and(io.dccm_dma_rvalid, _T_540) @[el2_dma_ctrl.scala 286:160]
    node _T_542 = eq(UInt<2>("h03"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 286:239]
    node _T_543 = and(io.iccm_dma_rvalid, _T_542) @[el2_dma_ctrl.scala 286:232]
    node _T_544 = cat(io.dbg_cmd_wrdata, io.dbg_cmd_wrdata) @[Cat.scala 29:58]
    node _T_545 = bits(bus_cmd_wdata, 63, 0) @[el2_dma_ctrl.scala 286:344]
    node _T_546 = mux(io.dbg_cmd_valid, _T_544, _T_545) @[el2_dma_ctrl.scala 286:284]
    node _T_547 = mux(_T_543, io.iccm_dma_rdata, _T_546) @[el2_dma_ctrl.scala 286:212]
    node _T_548 = mux(_T_541, io.dccm_dma_rdata, _T_547) @[el2_dma_ctrl.scala 286:140]
    node _T_549 = mux(_T_537, _T_539, _T_548) @[el2_dma_ctrl.scala 286:59]
    fifo_data_in[3] <= _T_549 @[el2_dma_ctrl.scala 286:52]
    node _T_550 = bits(fifo_error_en, 4, 4) @[el2_dma_ctrl.scala 286:73]
    node _T_551 = orr(fifo_error_in[4]) @[el2_dma_ctrl.scala 286:97]
    node _T_552 = and(_T_550, _T_551) @[el2_dma_ctrl.scala 286:77]
    node _T_553 = mux(UInt<1>("h00"), UInt<32>("h0ffffffff"), UInt<32>("h00")) @[Bitwise.scala 72:12]
    node _T_554 = cat(_T_553, fifo_addr[4]) @[Cat.scala 29:58]
    node _T_555 = eq(UInt<3>("h04"), io.dccm_dma_rtag) @[el2_dma_ctrl.scala 286:167]
    node _T_556 = and(io.dccm_dma_rvalid, _T_555) @[el2_dma_ctrl.scala 286:160]
    node _T_557 = eq(UInt<3>("h04"), io.iccm_dma_rtag) @[el2_dma_ctrl.scala 286:239]
    node _T_558 = and(io.iccm_dma_rvalid, _T_557) @[el2_dma_ctrl.scala 286:232]
    node _T_559 = cat(io.dbg_cmd_wrdata, io.dbg_cmd_wrdata) @[Cat.scala 29:58]
    node _T_560 = bits(bus_cmd_wdata, 63, 0) @[el2_dma_ctrl.scala 286:344]
    node _T_561 = mux(io.dbg_cmd_valid, _T_559, _T_560) @[el2_dma_ctrl.scala 286:284]
    node _T_562 = mux(_T_558, io.iccm_dma_rdata, _T_561) @[el2_dma_ctrl.scala 286:212]
    node _T_563 = mux(_T_556, io.dccm_dma_rdata, _T_562) @[el2_dma_ctrl.scala 286:140]
    node _T_564 = mux(_T_552, _T_554, _T_563) @[el2_dma_ctrl.scala 286:59]
    fifo_data_in[4] <= _T_564 @[el2_dma_ctrl.scala 286:52]
    node _T_565 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 288:98]
    node _T_566 = bits(fifo_valid, 0, 0) @[el2_dma_ctrl.scala 288:118]
    node _T_567 = mux(_T_565, UInt<1>("h01"), _T_566) @[el2_dma_ctrl.scala 288:86]
    node _T_568 = bits(fifo_reset, 0, 0) @[el2_dma_ctrl.scala 288:136]
    node _T_569 = not(_T_568) @[el2_dma_ctrl.scala 288:125]
    node _T_570 = and(_T_567, _T_569) @[el2_dma_ctrl.scala 288:123]
    reg _T_571 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 288:82]
    _T_571 <= _T_570 @[el2_dma_ctrl.scala 288:82]
    node _T_572 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 288:98]
    node _T_573 = bits(fifo_valid, 1, 1) @[el2_dma_ctrl.scala 288:118]
    node _T_574 = mux(_T_572, UInt<1>("h01"), _T_573) @[el2_dma_ctrl.scala 288:86]
    node _T_575 = bits(fifo_reset, 1, 1) @[el2_dma_ctrl.scala 288:136]
    node _T_576 = not(_T_575) @[el2_dma_ctrl.scala 288:125]
    node _T_577 = and(_T_574, _T_576) @[el2_dma_ctrl.scala 288:123]
    reg _T_578 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 288:82]
    _T_578 <= _T_577 @[el2_dma_ctrl.scala 288:82]
    node _T_579 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 288:98]
    node _T_580 = bits(fifo_valid, 2, 2) @[el2_dma_ctrl.scala 288:118]
    node _T_581 = mux(_T_579, UInt<1>("h01"), _T_580) @[el2_dma_ctrl.scala 288:86]
    node _T_582 = bits(fifo_reset, 2, 2) @[el2_dma_ctrl.scala 288:136]
    node _T_583 = not(_T_582) @[el2_dma_ctrl.scala 288:125]
    node _T_584 = and(_T_581, _T_583) @[el2_dma_ctrl.scala 288:123]
    reg _T_585 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 288:82]
    _T_585 <= _T_584 @[el2_dma_ctrl.scala 288:82]
    node _T_586 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 288:98]
    node _T_587 = bits(fifo_valid, 3, 3) @[el2_dma_ctrl.scala 288:118]
    node _T_588 = mux(_T_586, UInt<1>("h01"), _T_587) @[el2_dma_ctrl.scala 288:86]
    node _T_589 = bits(fifo_reset, 3, 3) @[el2_dma_ctrl.scala 288:136]
    node _T_590 = not(_T_589) @[el2_dma_ctrl.scala 288:125]
    node _T_591 = and(_T_588, _T_590) @[el2_dma_ctrl.scala 288:123]
    reg _T_592 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 288:82]
    _T_592 <= _T_591 @[el2_dma_ctrl.scala 288:82]
    node _T_593 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 288:98]
    node _T_594 = bits(fifo_valid, 4, 4) @[el2_dma_ctrl.scala 288:118]
    node _T_595 = mux(_T_593, UInt<1>("h01"), _T_594) @[el2_dma_ctrl.scala 288:86]
    node _T_596 = bits(fifo_reset, 4, 4) @[el2_dma_ctrl.scala 288:136]
    node _T_597 = not(_T_596) @[el2_dma_ctrl.scala 288:125]
    node _T_598 = and(_T_595, _T_597) @[el2_dma_ctrl.scala 288:123]
    reg _T_599 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 288:82]
    _T_599 <= _T_598 @[el2_dma_ctrl.scala 288:82]
    node _T_600 = cat(_T_599, _T_592) @[Cat.scala 29:58]
    node _T_601 = cat(_T_600, _T_585) @[Cat.scala 29:58]
    node _T_602 = cat(_T_601, _T_578) @[Cat.scala 29:58]
    node _T_603 = cat(_T_602, _T_571) @[Cat.scala 29:58]
    fifo_valid <= _T_603 @[el2_dma_ctrl.scala 288:14]
    node _T_604 = bits(fifo_error_en, 0, 0) @[el2_dma_ctrl.scala 290:103]
    node _T_605 = bits(_T_604, 0, 0) @[el2_dma_ctrl.scala 290:113]
    node _T_606 = mux(_T_605, fifo_error_in[0], fifo_error[0]) @[el2_dma_ctrl.scala 290:89]
    node _T_607 = bits(fifo_reset, 0, 0) @[el2_dma_ctrl.scala 290:196]
    node _T_608 = not(_T_607) @[el2_dma_ctrl.scala 290:185]
    node _T_609 = bits(_T_608, 0, 0) @[Bitwise.scala 72:15]
    node _T_610 = mux(_T_609, UInt<2>("h03"), UInt<2>("h00")) @[Bitwise.scala 72:12]
    node _T_611 = and(_T_606, _T_610) @[el2_dma_ctrl.scala 290:150]
    reg _T_612 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 290:85]
    _T_612 <= _T_611 @[el2_dma_ctrl.scala 290:85]
    fifo_error[0] <= _T_612 @[el2_dma_ctrl.scala 290:50]
    node _T_613 = bits(fifo_error_en, 1, 1) @[el2_dma_ctrl.scala 290:103]
    node _T_614 = bits(_T_613, 0, 0) @[el2_dma_ctrl.scala 290:113]
    node _T_615 = mux(_T_614, fifo_error_in[1], fifo_error[1]) @[el2_dma_ctrl.scala 290:89]
    node _T_616 = bits(fifo_reset, 1, 1) @[el2_dma_ctrl.scala 290:196]
    node _T_617 = not(_T_616) @[el2_dma_ctrl.scala 290:185]
    node _T_618 = bits(_T_617, 0, 0) @[Bitwise.scala 72:15]
    node _T_619 = mux(_T_618, UInt<2>("h03"), UInt<2>("h00")) @[Bitwise.scala 72:12]
    node _T_620 = and(_T_615, _T_619) @[el2_dma_ctrl.scala 290:150]
    reg _T_621 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 290:85]
    _T_621 <= _T_620 @[el2_dma_ctrl.scala 290:85]
    fifo_error[1] <= _T_621 @[el2_dma_ctrl.scala 290:50]
    node _T_622 = bits(fifo_error_en, 2, 2) @[el2_dma_ctrl.scala 290:103]
    node _T_623 = bits(_T_622, 0, 0) @[el2_dma_ctrl.scala 290:113]
    node _T_624 = mux(_T_623, fifo_error_in[2], fifo_error[2]) @[el2_dma_ctrl.scala 290:89]
    node _T_625 = bits(fifo_reset, 2, 2) @[el2_dma_ctrl.scala 290:196]
    node _T_626 = not(_T_625) @[el2_dma_ctrl.scala 290:185]
    node _T_627 = bits(_T_626, 0, 0) @[Bitwise.scala 72:15]
    node _T_628 = mux(_T_627, UInt<2>("h03"), UInt<2>("h00")) @[Bitwise.scala 72:12]
    node _T_629 = and(_T_624, _T_628) @[el2_dma_ctrl.scala 290:150]
    reg _T_630 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 290:85]
    _T_630 <= _T_629 @[el2_dma_ctrl.scala 290:85]
    fifo_error[2] <= _T_630 @[el2_dma_ctrl.scala 290:50]
    node _T_631 = bits(fifo_error_en, 3, 3) @[el2_dma_ctrl.scala 290:103]
    node _T_632 = bits(_T_631, 0, 0) @[el2_dma_ctrl.scala 290:113]
    node _T_633 = mux(_T_632, fifo_error_in[3], fifo_error[3]) @[el2_dma_ctrl.scala 290:89]
    node _T_634 = bits(fifo_reset, 3, 3) @[el2_dma_ctrl.scala 290:196]
    node _T_635 = not(_T_634) @[el2_dma_ctrl.scala 290:185]
    node _T_636 = bits(_T_635, 0, 0) @[Bitwise.scala 72:15]
    node _T_637 = mux(_T_636, UInt<2>("h03"), UInt<2>("h00")) @[Bitwise.scala 72:12]
    node _T_638 = and(_T_633, _T_637) @[el2_dma_ctrl.scala 290:150]
    reg _T_639 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 290:85]
    _T_639 <= _T_638 @[el2_dma_ctrl.scala 290:85]
    fifo_error[3] <= _T_639 @[el2_dma_ctrl.scala 290:50]
    node _T_640 = bits(fifo_error_en, 4, 4) @[el2_dma_ctrl.scala 290:103]
    node _T_641 = bits(_T_640, 0, 0) @[el2_dma_ctrl.scala 290:113]
    node _T_642 = mux(_T_641, fifo_error_in[4], fifo_error[4]) @[el2_dma_ctrl.scala 290:89]
    node _T_643 = bits(fifo_reset, 4, 4) @[el2_dma_ctrl.scala 290:196]
    node _T_644 = not(_T_643) @[el2_dma_ctrl.scala 290:185]
    node _T_645 = bits(_T_644, 0, 0) @[Bitwise.scala 72:15]
    node _T_646 = mux(_T_645, UInt<2>("h03"), UInt<2>("h00")) @[Bitwise.scala 72:12]
    node _T_647 = and(_T_642, _T_646) @[el2_dma_ctrl.scala 290:150]
    reg _T_648 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 290:85]
    _T_648 <= _T_647 @[el2_dma_ctrl.scala 290:85]
    fifo_error[4] <= _T_648 @[el2_dma_ctrl.scala 290:50]
    node _T_649 = bits(fifo_error_bus_en, 0, 0) @[el2_dma_ctrl.scala 292:111]
    node _T_650 = bits(fifo_error_bus, 0, 0) @[el2_dma_ctrl.scala 292:135]
    node _T_651 = mux(_T_649, UInt<1>("h01"), _T_650) @[el2_dma_ctrl.scala 292:93]
    node _T_652 = bits(fifo_reset, 0, 0) @[el2_dma_ctrl.scala 292:153]
    node _T_653 = not(_T_652) @[el2_dma_ctrl.scala 292:142]
    node _T_654 = and(_T_651, _T_653) @[el2_dma_ctrl.scala 292:140]
    reg _T_655 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 292:89]
    _T_655 <= _T_654 @[el2_dma_ctrl.scala 292:89]
    node _T_656 = bits(fifo_error_bus_en, 1, 1) @[el2_dma_ctrl.scala 292:111]
    node _T_657 = bits(fifo_error_bus, 1, 1) @[el2_dma_ctrl.scala 292:135]
    node _T_658 = mux(_T_656, UInt<1>("h01"), _T_657) @[el2_dma_ctrl.scala 292:93]
    node _T_659 = bits(fifo_reset, 1, 1) @[el2_dma_ctrl.scala 292:153]
    node _T_660 = not(_T_659) @[el2_dma_ctrl.scala 292:142]
    node _T_661 = and(_T_658, _T_660) @[el2_dma_ctrl.scala 292:140]
    reg _T_662 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 292:89]
    _T_662 <= _T_661 @[el2_dma_ctrl.scala 292:89]
    node _T_663 = bits(fifo_error_bus_en, 2, 2) @[el2_dma_ctrl.scala 292:111]
    node _T_664 = bits(fifo_error_bus, 2, 2) @[el2_dma_ctrl.scala 292:135]
    node _T_665 = mux(_T_663, UInt<1>("h01"), _T_664) @[el2_dma_ctrl.scala 292:93]
    node _T_666 = bits(fifo_reset, 2, 2) @[el2_dma_ctrl.scala 292:153]
    node _T_667 = not(_T_666) @[el2_dma_ctrl.scala 292:142]
    node _T_668 = and(_T_665, _T_667) @[el2_dma_ctrl.scala 292:140]
    reg _T_669 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 292:89]
    _T_669 <= _T_668 @[el2_dma_ctrl.scala 292:89]
    node _T_670 = bits(fifo_error_bus_en, 3, 3) @[el2_dma_ctrl.scala 292:111]
    node _T_671 = bits(fifo_error_bus, 3, 3) @[el2_dma_ctrl.scala 292:135]
    node _T_672 = mux(_T_670, UInt<1>("h01"), _T_671) @[el2_dma_ctrl.scala 292:93]
    node _T_673 = bits(fifo_reset, 3, 3) @[el2_dma_ctrl.scala 292:153]
    node _T_674 = not(_T_673) @[el2_dma_ctrl.scala 292:142]
    node _T_675 = and(_T_672, _T_674) @[el2_dma_ctrl.scala 292:140]
    reg _T_676 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 292:89]
    _T_676 <= _T_675 @[el2_dma_ctrl.scala 292:89]
    node _T_677 = bits(fifo_error_bus_en, 4, 4) @[el2_dma_ctrl.scala 292:111]
    node _T_678 = bits(fifo_error_bus, 4, 4) @[el2_dma_ctrl.scala 292:135]
    node _T_679 = mux(_T_677, UInt<1>("h01"), _T_678) @[el2_dma_ctrl.scala 292:93]
    node _T_680 = bits(fifo_reset, 4, 4) @[el2_dma_ctrl.scala 292:153]
    node _T_681 = not(_T_680) @[el2_dma_ctrl.scala 292:142]
    node _T_682 = and(_T_679, _T_681) @[el2_dma_ctrl.scala 292:140]
    reg _T_683 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 292:89]
    _T_683 <= _T_682 @[el2_dma_ctrl.scala 292:89]
    node _T_684 = cat(_T_683, _T_676) @[Cat.scala 29:58]
    node _T_685 = cat(_T_684, _T_669) @[Cat.scala 29:58]
    node _T_686 = cat(_T_685, _T_662) @[Cat.scala 29:58]
    node _T_687 = cat(_T_686, _T_655) @[Cat.scala 29:58]
    fifo_error_bus <= _T_687 @[el2_dma_ctrl.scala 292:21]
    node _T_688 = bits(fifo_pend_en, 0, 0) @[el2_dma_ctrl.scala 294:106]
    node _T_689 = bits(fifo_rpend, 0, 0) @[el2_dma_ctrl.scala 294:126]
    node _T_690 = mux(_T_688, UInt<1>("h01"), _T_689) @[el2_dma_ctrl.scala 294:93]
    node _T_691 = bits(fifo_reset, 0, 0) @[el2_dma_ctrl.scala 294:144]
    node _T_692 = not(_T_691) @[el2_dma_ctrl.scala 294:133]
    node _T_693 = and(_T_690, _T_692) @[el2_dma_ctrl.scala 294:131]
    reg _T_694 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 294:89]
    _T_694 <= _T_693 @[el2_dma_ctrl.scala 294:89]
    node _T_695 = bits(fifo_pend_en, 1, 1) @[el2_dma_ctrl.scala 294:106]
    node _T_696 = bits(fifo_rpend, 1, 1) @[el2_dma_ctrl.scala 294:126]
    node _T_697 = mux(_T_695, UInt<1>("h01"), _T_696) @[el2_dma_ctrl.scala 294:93]
    node _T_698 = bits(fifo_reset, 1, 1) @[el2_dma_ctrl.scala 294:144]
    node _T_699 = not(_T_698) @[el2_dma_ctrl.scala 294:133]
    node _T_700 = and(_T_697, _T_699) @[el2_dma_ctrl.scala 294:131]
    reg _T_701 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 294:89]
    _T_701 <= _T_700 @[el2_dma_ctrl.scala 294:89]
    node _T_702 = bits(fifo_pend_en, 2, 2) @[el2_dma_ctrl.scala 294:106]
    node _T_703 = bits(fifo_rpend, 2, 2) @[el2_dma_ctrl.scala 294:126]
    node _T_704 = mux(_T_702, UInt<1>("h01"), _T_703) @[el2_dma_ctrl.scala 294:93]
    node _T_705 = bits(fifo_reset, 2, 2) @[el2_dma_ctrl.scala 294:144]
    node _T_706 = not(_T_705) @[el2_dma_ctrl.scala 294:133]
    node _T_707 = and(_T_704, _T_706) @[el2_dma_ctrl.scala 294:131]
    reg _T_708 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 294:89]
    _T_708 <= _T_707 @[el2_dma_ctrl.scala 294:89]
    node _T_709 = bits(fifo_pend_en, 3, 3) @[el2_dma_ctrl.scala 294:106]
    node _T_710 = bits(fifo_rpend, 3, 3) @[el2_dma_ctrl.scala 294:126]
    node _T_711 = mux(_T_709, UInt<1>("h01"), _T_710) @[el2_dma_ctrl.scala 294:93]
    node _T_712 = bits(fifo_reset, 3, 3) @[el2_dma_ctrl.scala 294:144]
    node _T_713 = not(_T_712) @[el2_dma_ctrl.scala 294:133]
    node _T_714 = and(_T_711, _T_713) @[el2_dma_ctrl.scala 294:131]
    reg _T_715 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 294:89]
    _T_715 <= _T_714 @[el2_dma_ctrl.scala 294:89]
    node _T_716 = bits(fifo_pend_en, 4, 4) @[el2_dma_ctrl.scala 294:106]
    node _T_717 = bits(fifo_rpend, 4, 4) @[el2_dma_ctrl.scala 294:126]
    node _T_718 = mux(_T_716, UInt<1>("h01"), _T_717) @[el2_dma_ctrl.scala 294:93]
    node _T_719 = bits(fifo_reset, 4, 4) @[el2_dma_ctrl.scala 294:144]
    node _T_720 = not(_T_719) @[el2_dma_ctrl.scala 294:133]
    node _T_721 = and(_T_718, _T_720) @[el2_dma_ctrl.scala 294:131]
    reg _T_722 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 294:89]
    _T_722 <= _T_721 @[el2_dma_ctrl.scala 294:89]
    node _T_723 = cat(_T_722, _T_715) @[Cat.scala 29:58]
    node _T_724 = cat(_T_723, _T_708) @[Cat.scala 29:58]
    node _T_725 = cat(_T_724, _T_701) @[Cat.scala 29:58]
    node _T_726 = cat(_T_725, _T_694) @[Cat.scala 29:58]
    fifo_rpend <= _T_726 @[el2_dma_ctrl.scala 294:21]
    node _T_727 = bits(fifo_done_en, 0, 0) @[el2_dma_ctrl.scala 296:106]
    node _T_728 = bits(fifo_done, 0, 0) @[el2_dma_ctrl.scala 296:125]
    node _T_729 = mux(_T_727, UInt<1>("h01"), _T_728) @[el2_dma_ctrl.scala 296:93]
    node _T_730 = bits(fifo_reset, 0, 0) @[el2_dma_ctrl.scala 296:143]
    node _T_731 = not(_T_730) @[el2_dma_ctrl.scala 296:132]
    node _T_732 = and(_T_729, _T_731) @[el2_dma_ctrl.scala 296:130]
    reg _T_733 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 296:89]
    _T_733 <= _T_732 @[el2_dma_ctrl.scala 296:89]
    node _T_734 = bits(fifo_done_en, 1, 1) @[el2_dma_ctrl.scala 296:106]
    node _T_735 = bits(fifo_done, 1, 1) @[el2_dma_ctrl.scala 296:125]
    node _T_736 = mux(_T_734, UInt<1>("h01"), _T_735) @[el2_dma_ctrl.scala 296:93]
    node _T_737 = bits(fifo_reset, 1, 1) @[el2_dma_ctrl.scala 296:143]
    node _T_738 = not(_T_737) @[el2_dma_ctrl.scala 296:132]
    node _T_739 = and(_T_736, _T_738) @[el2_dma_ctrl.scala 296:130]
    reg _T_740 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 296:89]
    _T_740 <= _T_739 @[el2_dma_ctrl.scala 296:89]
    node _T_741 = bits(fifo_done_en, 2, 2) @[el2_dma_ctrl.scala 296:106]
    node _T_742 = bits(fifo_done, 2, 2) @[el2_dma_ctrl.scala 296:125]
    node _T_743 = mux(_T_741, UInt<1>("h01"), _T_742) @[el2_dma_ctrl.scala 296:93]
    node _T_744 = bits(fifo_reset, 2, 2) @[el2_dma_ctrl.scala 296:143]
    node _T_745 = not(_T_744) @[el2_dma_ctrl.scala 296:132]
    node _T_746 = and(_T_743, _T_745) @[el2_dma_ctrl.scala 296:130]
    reg _T_747 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 296:89]
    _T_747 <= _T_746 @[el2_dma_ctrl.scala 296:89]
    node _T_748 = bits(fifo_done_en, 3, 3) @[el2_dma_ctrl.scala 296:106]
    node _T_749 = bits(fifo_done, 3, 3) @[el2_dma_ctrl.scala 296:125]
    node _T_750 = mux(_T_748, UInt<1>("h01"), _T_749) @[el2_dma_ctrl.scala 296:93]
    node _T_751 = bits(fifo_reset, 3, 3) @[el2_dma_ctrl.scala 296:143]
    node _T_752 = not(_T_751) @[el2_dma_ctrl.scala 296:132]
    node _T_753 = and(_T_750, _T_752) @[el2_dma_ctrl.scala 296:130]
    reg _T_754 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 296:89]
    _T_754 <= _T_753 @[el2_dma_ctrl.scala 296:89]
    node _T_755 = bits(fifo_done_en, 4, 4) @[el2_dma_ctrl.scala 296:106]
    node _T_756 = bits(fifo_done, 4, 4) @[el2_dma_ctrl.scala 296:125]
    node _T_757 = mux(_T_755, UInt<1>("h01"), _T_756) @[el2_dma_ctrl.scala 296:93]
    node _T_758 = bits(fifo_reset, 4, 4) @[el2_dma_ctrl.scala 296:143]
    node _T_759 = not(_T_758) @[el2_dma_ctrl.scala 296:132]
    node _T_760 = and(_T_757, _T_759) @[el2_dma_ctrl.scala 296:130]
    reg _T_761 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 296:89]
    _T_761 <= _T_760 @[el2_dma_ctrl.scala 296:89]
    node _T_762 = cat(_T_761, _T_754) @[Cat.scala 29:58]
    node _T_763 = cat(_T_762, _T_747) @[Cat.scala 29:58]
    node _T_764 = cat(_T_763, _T_740) @[Cat.scala 29:58]
    node _T_765 = cat(_T_764, _T_733) @[Cat.scala 29:58]
    fifo_done <= _T_765 @[el2_dma_ctrl.scala 296:21]
    node _T_766 = bits(fifo_done_bus_en, 0, 0) @[el2_dma_ctrl.scala 298:110]
    node _T_767 = bits(fifo_done_bus, 0, 0) @[el2_dma_ctrl.scala 298:133]
    node _T_768 = mux(_T_766, UInt<1>("h01"), _T_767) @[el2_dma_ctrl.scala 298:93]
    node _T_769 = bits(fifo_reset, 0, 0) @[el2_dma_ctrl.scala 298:151]
    node _T_770 = not(_T_769) @[el2_dma_ctrl.scala 298:140]
    node _T_771 = and(_T_768, _T_770) @[el2_dma_ctrl.scala 298:138]
    reg _T_772 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 298:89]
    _T_772 <= _T_771 @[el2_dma_ctrl.scala 298:89]
    node _T_773 = bits(fifo_done_bus_en, 1, 1) @[el2_dma_ctrl.scala 298:110]
    node _T_774 = bits(fifo_done_bus, 1, 1) @[el2_dma_ctrl.scala 298:133]
    node _T_775 = mux(_T_773, UInt<1>("h01"), _T_774) @[el2_dma_ctrl.scala 298:93]
    node _T_776 = bits(fifo_reset, 1, 1) @[el2_dma_ctrl.scala 298:151]
    node _T_777 = not(_T_776) @[el2_dma_ctrl.scala 298:140]
    node _T_778 = and(_T_775, _T_777) @[el2_dma_ctrl.scala 298:138]
    reg _T_779 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 298:89]
    _T_779 <= _T_778 @[el2_dma_ctrl.scala 298:89]
    node _T_780 = bits(fifo_done_bus_en, 2, 2) @[el2_dma_ctrl.scala 298:110]
    node _T_781 = bits(fifo_done_bus, 2, 2) @[el2_dma_ctrl.scala 298:133]
    node _T_782 = mux(_T_780, UInt<1>("h01"), _T_781) @[el2_dma_ctrl.scala 298:93]
    node _T_783 = bits(fifo_reset, 2, 2) @[el2_dma_ctrl.scala 298:151]
    node _T_784 = not(_T_783) @[el2_dma_ctrl.scala 298:140]
    node _T_785 = and(_T_782, _T_784) @[el2_dma_ctrl.scala 298:138]
    reg _T_786 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 298:89]
    _T_786 <= _T_785 @[el2_dma_ctrl.scala 298:89]
    node _T_787 = bits(fifo_done_bus_en, 3, 3) @[el2_dma_ctrl.scala 298:110]
    node _T_788 = bits(fifo_done_bus, 3, 3) @[el2_dma_ctrl.scala 298:133]
    node _T_789 = mux(_T_787, UInt<1>("h01"), _T_788) @[el2_dma_ctrl.scala 298:93]
    node _T_790 = bits(fifo_reset, 3, 3) @[el2_dma_ctrl.scala 298:151]
    node _T_791 = not(_T_790) @[el2_dma_ctrl.scala 298:140]
    node _T_792 = and(_T_789, _T_791) @[el2_dma_ctrl.scala 298:138]
    reg _T_793 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 298:89]
    _T_793 <= _T_792 @[el2_dma_ctrl.scala 298:89]
    node _T_794 = bits(fifo_done_bus_en, 4, 4) @[el2_dma_ctrl.scala 298:110]
    node _T_795 = bits(fifo_done_bus, 4, 4) @[el2_dma_ctrl.scala 298:133]
    node _T_796 = mux(_T_794, UInt<1>("h01"), _T_795) @[el2_dma_ctrl.scala 298:93]
    node _T_797 = bits(fifo_reset, 4, 4) @[el2_dma_ctrl.scala 298:151]
    node _T_798 = not(_T_797) @[el2_dma_ctrl.scala 298:140]
    node _T_799 = and(_T_796, _T_798) @[el2_dma_ctrl.scala 298:138]
    reg _T_800 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 298:89]
    _T_800 <= _T_799 @[el2_dma_ctrl.scala 298:89]
    node _T_801 = cat(_T_800, _T_793) @[Cat.scala 29:58]
    node _T_802 = cat(_T_801, _T_786) @[Cat.scala 29:58]
    node _T_803 = cat(_T_802, _T_779) @[Cat.scala 29:58]
    node _T_804 = cat(_T_803, _T_772) @[Cat.scala 29:58]
    fifo_done_bus <= _T_804 @[el2_dma_ctrl.scala 298:21]
    node _T_805 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 300:84]
    inst rvclkhdr of rvclkhdr @[el2_lib.scala 508:23]
    rvclkhdr.clock <= clock
    rvclkhdr.reset <= reset
    rvclkhdr.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr.io.en <= _T_805 @[el2_lib.scala 511:17]
    rvclkhdr.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_806 : UInt, rvclkhdr.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_806 <= fifo_addr_in @[el2_lib.scala 514:16]
    fifo_addr[0] <= _T_806 @[el2_dma_ctrl.scala 300:49]
    node _T_807 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 300:84]
    inst rvclkhdr_1 of rvclkhdr_1 @[el2_lib.scala 508:23]
    rvclkhdr_1.clock <= clock
    rvclkhdr_1.reset <= reset
    rvclkhdr_1.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_1.io.en <= _T_807 @[el2_lib.scala 511:17]
    rvclkhdr_1.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_808 : UInt, rvclkhdr_1.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_808 <= fifo_addr_in @[el2_lib.scala 514:16]
    fifo_addr[1] <= _T_808 @[el2_dma_ctrl.scala 300:49]
    node _T_809 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 300:84]
    inst rvclkhdr_2 of rvclkhdr_2 @[el2_lib.scala 508:23]
    rvclkhdr_2.clock <= clock
    rvclkhdr_2.reset <= reset
    rvclkhdr_2.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_2.io.en <= _T_809 @[el2_lib.scala 511:17]
    rvclkhdr_2.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_810 : UInt, rvclkhdr_2.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_810 <= fifo_addr_in @[el2_lib.scala 514:16]
    fifo_addr[2] <= _T_810 @[el2_dma_ctrl.scala 300:49]
    node _T_811 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 300:84]
    inst rvclkhdr_3 of rvclkhdr_3 @[el2_lib.scala 508:23]
    rvclkhdr_3.clock <= clock
    rvclkhdr_3.reset <= reset
    rvclkhdr_3.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_3.io.en <= _T_811 @[el2_lib.scala 511:17]
    rvclkhdr_3.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_812 : UInt, rvclkhdr_3.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_812 <= fifo_addr_in @[el2_lib.scala 514:16]
    fifo_addr[3] <= _T_812 @[el2_dma_ctrl.scala 300:49]
    node _T_813 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 300:84]
    inst rvclkhdr_4 of rvclkhdr_4 @[el2_lib.scala 508:23]
    rvclkhdr_4.clock <= clock
    rvclkhdr_4.reset <= reset
    rvclkhdr_4.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_4.io.en <= _T_813 @[el2_lib.scala 511:17]
    rvclkhdr_4.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_814 : UInt, rvclkhdr_4.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_814 <= fifo_addr_in @[el2_lib.scala 514:16]
    fifo_addr[4] <= _T_814 @[el2_dma_ctrl.scala 300:49]
    node _T_815 = bits(fifo_sz_in, 2, 0) @[el2_dma_ctrl.scala 302:100]
    node _T_816 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 302:123]
    reg _T_817 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_816 : @[Reg.scala 28:19]
      _T_817 <= _T_815 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_sz[0] <= _T_817 @[el2_dma_ctrl.scala 302:47]
    node _T_818 = bits(fifo_sz_in, 2, 0) @[el2_dma_ctrl.scala 302:100]
    node _T_819 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 302:123]
    reg _T_820 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_819 : @[Reg.scala 28:19]
      _T_820 <= _T_818 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_sz[1] <= _T_820 @[el2_dma_ctrl.scala 302:47]
    node _T_821 = bits(fifo_sz_in, 2, 0) @[el2_dma_ctrl.scala 302:100]
    node _T_822 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 302:123]
    reg _T_823 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_822 : @[Reg.scala 28:19]
      _T_823 <= _T_821 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_sz[2] <= _T_823 @[el2_dma_ctrl.scala 302:47]
    node _T_824 = bits(fifo_sz_in, 2, 0) @[el2_dma_ctrl.scala 302:100]
    node _T_825 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 302:123]
    reg _T_826 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_825 : @[Reg.scala 28:19]
      _T_826 <= _T_824 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_sz[3] <= _T_826 @[el2_dma_ctrl.scala 302:47]
    node _T_827 = bits(fifo_sz_in, 2, 0) @[el2_dma_ctrl.scala 302:100]
    node _T_828 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 302:123]
    reg _T_829 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_828 : @[Reg.scala 28:19]
      _T_829 <= _T_827 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_sz[4] <= _T_829 @[el2_dma_ctrl.scala 302:47]
    node _T_830 = bits(fifo_byteen_in, 7, 0) @[el2_dma_ctrl.scala 304:108]
    node _T_831 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 304:131]
    node _T_832 = bits(_T_831, 0, 0) @[el2_dma_ctrl.scala 304:141]
    reg _T_833 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_832 : @[Reg.scala 28:19]
      _T_833 <= _T_830 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_byteen[0] <= _T_833 @[el2_dma_ctrl.scala 304:51]
    node _T_834 = bits(fifo_byteen_in, 7, 0) @[el2_dma_ctrl.scala 304:108]
    node _T_835 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 304:131]
    node _T_836 = bits(_T_835, 0, 0) @[el2_dma_ctrl.scala 304:141]
    reg _T_837 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_836 : @[Reg.scala 28:19]
      _T_837 <= _T_834 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_byteen[1] <= _T_837 @[el2_dma_ctrl.scala 304:51]
    node _T_838 = bits(fifo_byteen_in, 7, 0) @[el2_dma_ctrl.scala 304:108]
    node _T_839 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 304:131]
    node _T_840 = bits(_T_839, 0, 0) @[el2_dma_ctrl.scala 304:141]
    reg _T_841 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_840 : @[Reg.scala 28:19]
      _T_841 <= _T_838 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_byteen[2] <= _T_841 @[el2_dma_ctrl.scala 304:51]
    node _T_842 = bits(fifo_byteen_in, 7, 0) @[el2_dma_ctrl.scala 304:108]
    node _T_843 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 304:131]
    node _T_844 = bits(_T_843, 0, 0) @[el2_dma_ctrl.scala 304:141]
    reg _T_845 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_844 : @[Reg.scala 28:19]
      _T_845 <= _T_842 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_byteen[3] <= _T_845 @[el2_dma_ctrl.scala 304:51]
    node _T_846 = bits(fifo_byteen_in, 7, 0) @[el2_dma_ctrl.scala 304:108]
    node _T_847 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 304:131]
    node _T_848 = bits(_T_847, 0, 0) @[el2_dma_ctrl.scala 304:141]
    reg _T_849 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_848 : @[Reg.scala 28:19]
      _T_849 <= _T_846 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_byteen[4] <= _T_849 @[el2_dma_ctrl.scala 304:51]
    node _T_850 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 306:129]
    reg _T_851 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_850 : @[Reg.scala 28:19]
      _T_851 <= fifo_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_852 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 306:129]
    reg _T_853 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_852 : @[Reg.scala 28:19]
      _T_853 <= fifo_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_854 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 306:129]
    reg _T_855 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_854 : @[Reg.scala 28:19]
      _T_855 <= fifo_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_856 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 306:129]
    reg _T_857 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_856 : @[Reg.scala 28:19]
      _T_857 <= fifo_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_858 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 306:129]
    reg _T_859 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_858 : @[Reg.scala 28:19]
      _T_859 <= fifo_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_860 = cat(_T_859, _T_857) @[Cat.scala 29:58]
    node _T_861 = cat(_T_860, _T_855) @[Cat.scala 29:58]
    node _T_862 = cat(_T_861, _T_853) @[Cat.scala 29:58]
    node _T_863 = cat(_T_862, _T_851) @[Cat.scala 29:58]
    fifo_write <= _T_863 @[el2_dma_ctrl.scala 306:21]
    node _T_864 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 308:136]
    reg _T_865 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_864 : @[Reg.scala 28:19]
      _T_865 <= fifo_posted_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_866 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 308:136]
    reg _T_867 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_866 : @[Reg.scala 28:19]
      _T_867 <= fifo_posted_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_868 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 308:136]
    reg _T_869 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_868 : @[Reg.scala 28:19]
      _T_869 <= fifo_posted_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_870 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 308:136]
    reg _T_871 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_870 : @[Reg.scala 28:19]
      _T_871 <= fifo_posted_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_872 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 308:136]
    reg _T_873 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_872 : @[Reg.scala 28:19]
      _T_873 <= fifo_posted_write_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_874 = cat(_T_873, _T_871) @[Cat.scala 29:58]
    node _T_875 = cat(_T_874, _T_869) @[Cat.scala 29:58]
    node _T_876 = cat(_T_875, _T_867) @[Cat.scala 29:58]
    node _T_877 = cat(_T_876, _T_865) @[Cat.scala 29:58]
    fifo_posted_write <= _T_877 @[el2_dma_ctrl.scala 308:21]
    node _T_878 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 310:126]
    reg _T_879 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_878 : @[Reg.scala 28:19]
      _T_879 <= io.dbg_cmd_valid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_880 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 310:126]
    reg _T_881 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_880 : @[Reg.scala 28:19]
      _T_881 <= io.dbg_cmd_valid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_882 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 310:126]
    reg _T_883 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_882 : @[Reg.scala 28:19]
      _T_883 <= io.dbg_cmd_valid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_884 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 310:126]
    reg _T_885 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_884 : @[Reg.scala 28:19]
      _T_885 <= io.dbg_cmd_valid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_886 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 310:126]
    reg _T_887 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_886 : @[Reg.scala 28:19]
      _T_887 <= io.dbg_cmd_valid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_888 = cat(_T_887, _T_885) @[Cat.scala 29:58]
    node _T_889 = cat(_T_888, _T_883) @[Cat.scala 29:58]
    node _T_890 = cat(_T_889, _T_881) @[Cat.scala 29:58]
    node _T_891 = cat(_T_890, _T_879) @[Cat.scala 29:58]
    fifo_dbg <= _T_891 @[el2_dma_ctrl.scala 310:21]
    node _T_892 = bits(fifo_data_en, 0, 0) @[el2_dma_ctrl.scala 312:88]
    inst rvclkhdr_5 of rvclkhdr_5 @[el2_lib.scala 508:23]
    rvclkhdr_5.clock <= clock
    rvclkhdr_5.reset <= reset
    rvclkhdr_5.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_5.io.en <= _T_892 @[el2_lib.scala 511:17]
    rvclkhdr_5.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_893 : UInt, rvclkhdr_5.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_893 <= fifo_data_in[0] @[el2_lib.scala 514:16]
    fifo_data[0] <= _T_893 @[el2_dma_ctrl.scala 312:49]
    node _T_894 = bits(fifo_data_en, 1, 1) @[el2_dma_ctrl.scala 312:88]
    inst rvclkhdr_6 of rvclkhdr_6 @[el2_lib.scala 508:23]
    rvclkhdr_6.clock <= clock
    rvclkhdr_6.reset <= reset
    rvclkhdr_6.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_6.io.en <= _T_894 @[el2_lib.scala 511:17]
    rvclkhdr_6.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_895 : UInt, rvclkhdr_6.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_895 <= fifo_data_in[1] @[el2_lib.scala 514:16]
    fifo_data[1] <= _T_895 @[el2_dma_ctrl.scala 312:49]
    node _T_896 = bits(fifo_data_en, 2, 2) @[el2_dma_ctrl.scala 312:88]
    inst rvclkhdr_7 of rvclkhdr_7 @[el2_lib.scala 508:23]
    rvclkhdr_7.clock <= clock
    rvclkhdr_7.reset <= reset
    rvclkhdr_7.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_7.io.en <= _T_896 @[el2_lib.scala 511:17]
    rvclkhdr_7.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_897 : UInt, rvclkhdr_7.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_897 <= fifo_data_in[2] @[el2_lib.scala 514:16]
    fifo_data[2] <= _T_897 @[el2_dma_ctrl.scala 312:49]
    node _T_898 = bits(fifo_data_en, 3, 3) @[el2_dma_ctrl.scala 312:88]
    inst rvclkhdr_8 of rvclkhdr_8 @[el2_lib.scala 508:23]
    rvclkhdr_8.clock <= clock
    rvclkhdr_8.reset <= reset
    rvclkhdr_8.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_8.io.en <= _T_898 @[el2_lib.scala 511:17]
    rvclkhdr_8.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_899 : UInt, rvclkhdr_8.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_899 <= fifo_data_in[3] @[el2_lib.scala 514:16]
    fifo_data[3] <= _T_899 @[el2_dma_ctrl.scala 312:49]
    node _T_900 = bits(fifo_data_en, 4, 4) @[el2_dma_ctrl.scala 312:88]
    inst rvclkhdr_9 of rvclkhdr_9 @[el2_lib.scala 508:23]
    rvclkhdr_9.clock <= clock
    rvclkhdr_9.reset <= reset
    rvclkhdr_9.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_9.io.en <= _T_900 @[el2_lib.scala 511:17]
    rvclkhdr_9.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg _T_901 : UInt, rvclkhdr_9.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    _T_901 <= fifo_data_in[4] @[el2_lib.scala 514:16]
    fifo_data[4] <= _T_901 @[el2_dma_ctrl.scala 312:49]
    node _T_902 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 314:120]
    reg _T_903 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_902 : @[Reg.scala 28:19]
      _T_903 <= bus_cmd_tag @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_tag[0] <= _T_903 @[el2_dma_ctrl.scala 314:48]
    node _T_904 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 314:120]
    reg _T_905 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_904 : @[Reg.scala 28:19]
      _T_905 <= bus_cmd_tag @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_tag[1] <= _T_905 @[el2_dma_ctrl.scala 314:48]
    node _T_906 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 314:120]
    reg _T_907 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_906 : @[Reg.scala 28:19]
      _T_907 <= bus_cmd_tag @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_tag[2] <= _T_907 @[el2_dma_ctrl.scala 314:48]
    node _T_908 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 314:120]
    reg _T_909 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_908 : @[Reg.scala 28:19]
      _T_909 <= bus_cmd_tag @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_tag[3] <= _T_909 @[el2_dma_ctrl.scala 314:48]
    node _T_910 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 314:120]
    reg _T_911 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_910 : @[Reg.scala 28:19]
      _T_911 <= bus_cmd_tag @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_tag[4] <= _T_911 @[el2_dma_ctrl.scala 314:48]
    node _T_912 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 316:120]
    reg _T_913 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_912 : @[Reg.scala 28:19]
      _T_913 <= bus_cmd_mid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_mid[0] <= _T_913 @[el2_dma_ctrl.scala 316:48]
    node _T_914 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 316:120]
    reg _T_915 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_914 : @[Reg.scala 28:19]
      _T_915 <= bus_cmd_mid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_mid[1] <= _T_915 @[el2_dma_ctrl.scala 316:48]
    node _T_916 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 316:120]
    reg _T_917 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_916 : @[Reg.scala 28:19]
      _T_917 <= bus_cmd_mid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_mid[2] <= _T_917 @[el2_dma_ctrl.scala 316:48]
    node _T_918 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 316:120]
    reg _T_919 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_918 : @[Reg.scala 28:19]
      _T_919 <= bus_cmd_mid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_mid[3] <= _T_919 @[el2_dma_ctrl.scala 316:48]
    node _T_920 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 316:120]
    reg _T_921 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_920 : @[Reg.scala 28:19]
      _T_921 <= bus_cmd_mid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_mid[4] <= _T_921 @[el2_dma_ctrl.scala 316:48]
    node _T_922 = bits(fifo_cmd_en, 0, 0) @[el2_dma_ctrl.scala 318:122]
    reg _T_923 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_922 : @[Reg.scala 28:19]
      _T_923 <= bus_cmd_prty @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_prty[0] <= _T_923 @[el2_dma_ctrl.scala 318:49]
    node _T_924 = bits(fifo_cmd_en, 1, 1) @[el2_dma_ctrl.scala 318:122]
    reg _T_925 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_924 : @[Reg.scala 28:19]
      _T_925 <= bus_cmd_prty @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_prty[1] <= _T_925 @[el2_dma_ctrl.scala 318:49]
    node _T_926 = bits(fifo_cmd_en, 2, 2) @[el2_dma_ctrl.scala 318:122]
    reg _T_927 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_926 : @[Reg.scala 28:19]
      _T_927 <= bus_cmd_prty @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_prty[2] <= _T_927 @[el2_dma_ctrl.scala 318:49]
    node _T_928 = bits(fifo_cmd_en, 3, 3) @[el2_dma_ctrl.scala 318:122]
    reg _T_929 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_928 : @[Reg.scala 28:19]
      _T_929 <= bus_cmd_prty @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_prty[3] <= _T_929 @[el2_dma_ctrl.scala 318:49]
    node _T_930 = bits(fifo_cmd_en, 4, 4) @[el2_dma_ctrl.scala 318:122]
    reg _T_931 : UInt, dma_buffer_c1_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_930 : @[Reg.scala 28:19]
      _T_931 <= bus_cmd_prty @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    fifo_prty[4] <= _T_931 @[el2_dma_ctrl.scala 318:49]
    node _T_932 = eq(WrPtr, UInt<3>("h04")) @[el2_dma_ctrl.scala 322:30]
    node _T_933 = bits(_T_932, 0, 0) @[el2_dma_ctrl.scala 322:57]
    node _T_934 = add(WrPtr, UInt<1>("h01")) @[el2_dma_ctrl.scala 322:76]
    node _T_935 = tail(_T_934, 1) @[el2_dma_ctrl.scala 322:76]
    node _T_936 = mux(_T_933, UInt<1>("h00"), _T_935) @[el2_dma_ctrl.scala 322:22]
    NxtWrPtr <= _T_936 @[el2_dma_ctrl.scala 322:16]
    node _T_937 = eq(RdPtr, UInt<3>("h04")) @[el2_dma_ctrl.scala 324:30]
    node _T_938 = bits(_T_937, 0, 0) @[el2_dma_ctrl.scala 324:57]
    node _T_939 = add(RdPtr, UInt<1>("h01")) @[el2_dma_ctrl.scala 324:76]
    node _T_940 = tail(_T_939, 1) @[el2_dma_ctrl.scala 324:76]
    node _T_941 = mux(_T_938, UInt<1>("h00"), _T_940) @[el2_dma_ctrl.scala 324:22]
    NxtRdPtr <= _T_941 @[el2_dma_ctrl.scala 324:16]
    node _T_942 = eq(RspPtr, UInt<3>("h04")) @[el2_dma_ctrl.scala 326:31]
    node _T_943 = bits(_T_942, 0, 0) @[el2_dma_ctrl.scala 326:58]
    node _T_944 = add(RspPtr, UInt<1>("h01")) @[el2_dma_ctrl.scala 326:78]
    node _T_945 = tail(_T_944, 1) @[el2_dma_ctrl.scala 326:78]
    node _T_946 = mux(_T_943, UInt<1>("h00"), _T_945) @[el2_dma_ctrl.scala 326:22]
    NxtRspPtr <= _T_946 @[el2_dma_ctrl.scala 326:16]
    node WrPtrEn = orr(fifo_cmd_en) @[el2_dma_ctrl.scala 328:30]
    node _T_947 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 330:35]
    node _T_948 = bits(dma_address_error, 0, 0) @[el2_dma_ctrl.scala 330:74]
    node _T_949 = bits(dma_alignment_error, 0, 0) @[el2_dma_ctrl.scala 330:103]
    node _T_950 = or(_T_948, _T_949) @[el2_dma_ctrl.scala 330:81]
    node _T_951 = or(_T_950, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 330:110]
    node RdPtrEn = or(_T_947, _T_951) @[el2_dma_ctrl.scala 330:53]
    node _T_952 = or(bus_rsp_sent, bus_posted_write_done) @[el2_dma_ctrl.scala 332:55]
    node _T_953 = and(_T_952, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 332:80]
    node RspPtrEn = or(io.dma_dbg_cmd_done, _T_953) @[el2_dma_ctrl.scala 332:39]
    reg _T_954 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when WrPtrEn : @[Reg.scala 28:19]
      _T_954 <= NxtWrPtr @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    WrPtr <= _T_954 @[el2_dma_ctrl.scala 334:16]
    node _T_955 = bits(RdPtrEn, 0, 0) @[el2_dma_ctrl.scala 339:38]
    reg _T_956 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_955 : @[Reg.scala 28:19]
      _T_956 <= NxtRdPtr @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    RdPtr <= _T_956 @[el2_dma_ctrl.scala 338:16]
    node _T_957 = bits(RspPtrEn, 0, 0) @[el2_dma_ctrl.scala 343:40]
    reg _T_958 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_957 : @[Reg.scala 28:19]
      _T_958 <= NxtRspPtr @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    RspPtr <= _T_958 @[el2_dma_ctrl.scala 342:16]
    wire num_fifo_vld_tmp : UInt<4>
    num_fifo_vld_tmp <= UInt<1>("h00")
    wire num_fifo_vld_tmp2 : UInt<4>
    num_fifo_vld_tmp2 <= UInt<1>("h00")
    node _T_959 = mux(UInt<1>("h00"), UInt<3>("h07"), UInt<3>("h00")) @[Bitwise.scala 72:12]
    node _T_960 = cat(_T_959, bus_cmd_sent) @[Cat.scala 29:58]
    node _T_961 = mux(UInt<1>("h00"), UInt<3>("h07"), UInt<3>("h00")) @[Bitwise.scala 72:12]
    node _T_962 = cat(_T_961, bus_rsp_sent) @[Cat.scala 29:58]
    node _T_963 = sub(_T_960, _T_962) @[el2_dma_ctrl.scala 353:62]
    node _T_964 = tail(_T_963, 1) @[el2_dma_ctrl.scala 353:62]
    num_fifo_vld_tmp <= _T_964 @[el2_dma_ctrl.scala 353:25]
    node _T_965 = mux(UInt<1>("h00"), UInt<3>("h07"), UInt<3>("h00")) @[Bitwise.scala 72:12]
    node _T_966 = bits(fifo_valid, 0, 0) @[el2_dma_ctrl.scala 355:88]
    node _T_967 = cat(_T_965, _T_966) @[Cat.scala 29:58]
    node _T_968 = mux(UInt<1>("h00"), UInt<3>("h07"), UInt<3>("h00")) @[Bitwise.scala 72:12]
    node _T_969 = bits(fifo_valid, 1, 1) @[el2_dma_ctrl.scala 355:88]
    node _T_970 = cat(_T_968, _T_969) @[Cat.scala 29:58]
    node _T_971 = mux(UInt<1>("h00"), UInt<3>("h07"), UInt<3>("h00")) @[Bitwise.scala 72:12]
    node _T_972 = bits(fifo_valid, 2, 2) @[el2_dma_ctrl.scala 355:88]
    node _T_973 = cat(_T_971, _T_972) @[Cat.scala 29:58]
    node _T_974 = mux(UInt<1>("h00"), UInt<3>("h07"), UInt<3>("h00")) @[Bitwise.scala 72:12]
    node _T_975 = bits(fifo_valid, 3, 3) @[el2_dma_ctrl.scala 355:88]
    node _T_976 = cat(_T_974, _T_975) @[Cat.scala 29:58]
    node _T_977 = mux(UInt<1>("h00"), UInt<3>("h07"), UInt<3>("h00")) @[Bitwise.scala 72:12]
    node _T_978 = bits(fifo_valid, 4, 4) @[el2_dma_ctrl.scala 355:88]
    node _T_979 = cat(_T_977, _T_978) @[Cat.scala 29:58]
    node _T_980 = add(_T_967, _T_970) @[el2_dma_ctrl.scala 355:102]
    node _T_981 = tail(_T_980, 1) @[el2_dma_ctrl.scala 355:102]
    node _T_982 = add(_T_981, _T_973) @[el2_dma_ctrl.scala 355:102]
    node _T_983 = tail(_T_982, 1) @[el2_dma_ctrl.scala 355:102]
    node _T_984 = add(_T_983, _T_976) @[el2_dma_ctrl.scala 355:102]
    node _T_985 = tail(_T_984, 1) @[el2_dma_ctrl.scala 355:102]
    node _T_986 = add(_T_985, _T_979) @[el2_dma_ctrl.scala 355:102]
    node _T_987 = tail(_T_986, 1) @[el2_dma_ctrl.scala 355:102]
    num_fifo_vld_tmp2 <= _T_987 @[el2_dma_ctrl.scala 355:25]
    node _T_988 = add(num_fifo_vld_tmp, num_fifo_vld_tmp2) @[el2_dma_ctrl.scala 357:45]
    node _T_989 = tail(_T_988, 1) @[el2_dma_ctrl.scala 357:45]
    num_fifo_vld <= _T_989 @[el2_dma_ctrl.scala 357:25]
    node fifo_full_spec = geq(num_fifo_vld, UInt<3>("h05")) @[el2_dma_ctrl.scala 359:41]
    node _T_990 = or(fifo_full, dbg_dma_bubble_bus) @[el2_dma_ctrl.scala 361:39]
    node dma_fifo_ready = not(_T_990) @[el2_dma_ctrl.scala 361:27]
    node _T_991 = dshr(fifo_valid, RdPtr) @[el2_dma_ctrl.scala 365:38]
    node _T_992 = bits(_T_991, 0, 0) @[el2_dma_ctrl.scala 365:38]
    node _T_993 = dshr(fifo_done, RdPtr) @[el2_dma_ctrl.scala 365:58]
    node _T_994 = bits(_T_993, 0, 0) @[el2_dma_ctrl.scala 365:58]
    node _T_995 = not(_T_994) @[el2_dma_ctrl.scala 365:48]
    node _T_996 = and(_T_992, _T_995) @[el2_dma_ctrl.scala 365:46]
    node _T_997 = dshr(fifo_dbg, RdPtr) @[el2_dma_ctrl.scala 365:77]
    node _T_998 = bits(_T_997, 0, 0) @[el2_dma_ctrl.scala 365:77]
    node _T_999 = not(_T_998) @[el2_dma_ctrl.scala 365:68]
    node _T_1000 = and(_T_996, _T_999) @[el2_dma_ctrl.scala 365:66]
    node _T_1001 = or(dma_mem_addr_in_dccm, dma_mem_addr_in_iccm) @[el2_dma_ctrl.scala 365:111]
    node _T_1002 = not(_T_1001) @[el2_dma_ctrl.scala 365:88]
    node _T_1003 = and(_T_1000, _T_1002) @[el2_dma_ctrl.scala 365:85]
    dma_address_error <= _T_1003 @[el2_dma_ctrl.scala 365:25]
    node _T_1004 = dshr(fifo_valid, RdPtr) @[el2_dma_ctrl.scala 366:38]
    node _T_1005 = bits(_T_1004, 0, 0) @[el2_dma_ctrl.scala 366:38]
    node _T_1006 = dshr(fifo_done, RdPtr) @[el2_dma_ctrl.scala 366:58]
    node _T_1007 = bits(_T_1006, 0, 0) @[el2_dma_ctrl.scala 366:58]
    node _T_1008 = not(_T_1007) @[el2_dma_ctrl.scala 366:48]
    node _T_1009 = and(_T_1005, _T_1008) @[el2_dma_ctrl.scala 366:46]
    node _T_1010 = not(dma_address_error) @[el2_dma_ctrl.scala 366:68]
    node _T_1011 = and(_T_1009, _T_1010) @[el2_dma_ctrl.scala 366:66]
    node _T_1012 = bits(dma_mem_sz_int, 2, 0) @[el2_dma_ctrl.scala 367:22]
    node _T_1013 = eq(_T_1012, UInt<1>("h01")) @[el2_dma_ctrl.scala 367:28]
    node _T_1014 = bits(dma_mem_addr_int, 0, 0) @[el2_dma_ctrl.scala 367:55]
    node _T_1015 = and(_T_1013, _T_1014) @[el2_dma_ctrl.scala 367:37]
    node _T_1016 = bits(dma_mem_sz_int, 2, 0) @[el2_dma_ctrl.scala 368:23]
    node _T_1017 = eq(_T_1016, UInt<2>("h02")) @[el2_dma_ctrl.scala 368:29]
    node _T_1018 = bits(dma_mem_addr_int, 1, 0) @[el2_dma_ctrl.scala 368:57]
    node _T_1019 = orr(_T_1018) @[el2_dma_ctrl.scala 368:64]
    node _T_1020 = and(_T_1017, _T_1019) @[el2_dma_ctrl.scala 368:38]
    node _T_1021 = or(_T_1015, _T_1020) @[el2_dma_ctrl.scala 367:60]
    node _T_1022 = bits(dma_mem_sz_int, 2, 0) @[el2_dma_ctrl.scala 369:23]
    node _T_1023 = eq(_T_1022, UInt<2>("h03")) @[el2_dma_ctrl.scala 369:29]
    node _T_1024 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 369:57]
    node _T_1025 = orr(_T_1024) @[el2_dma_ctrl.scala 369:64]
    node _T_1026 = and(_T_1023, _T_1025) @[el2_dma_ctrl.scala 369:38]
    node _T_1027 = or(_T_1021, _T_1026) @[el2_dma_ctrl.scala 368:70]
    node _T_1028 = bits(dma_mem_sz_int, 1, 0) @[el2_dma_ctrl.scala 370:48]
    node _T_1029 = eq(_T_1028, UInt<2>("h02")) @[el2_dma_ctrl.scala 370:55]
    node _T_1030 = bits(dma_mem_sz_int, 1, 0) @[el2_dma_ctrl.scala 370:81]
    node _T_1031 = eq(_T_1030, UInt<2>("h03")) @[el2_dma_ctrl.scala 370:88]
    node _T_1032 = or(_T_1029, _T_1031) @[el2_dma_ctrl.scala 370:64]
    node _T_1033 = not(_T_1032) @[el2_dma_ctrl.scala 370:31]
    node _T_1034 = and(dma_mem_addr_in_iccm, _T_1033) @[el2_dma_ctrl.scala 370:29]
    node _T_1035 = or(_T_1027, _T_1034) @[el2_dma_ctrl.scala 369:70]
    node _T_1036 = and(dma_mem_addr_in_dccm, io.dma_mem_write) @[el2_dma_ctrl.scala 371:29]
    node _T_1037 = bits(dma_mem_sz_int, 1, 0) @[el2_dma_ctrl.scala 371:67]
    node _T_1038 = eq(_T_1037, UInt<2>("h02")) @[el2_dma_ctrl.scala 371:74]
    node _T_1039 = bits(dma_mem_sz_int, 1, 0) @[el2_dma_ctrl.scala 371:100]
    node _T_1040 = eq(_T_1039, UInt<2>("h03")) @[el2_dma_ctrl.scala 371:107]
    node _T_1041 = or(_T_1038, _T_1040) @[el2_dma_ctrl.scala 371:83]
    node _T_1042 = not(_T_1041) @[el2_dma_ctrl.scala 371:50]
    node _T_1043 = and(_T_1036, _T_1042) @[el2_dma_ctrl.scala 371:48]
    node _T_1044 = or(_T_1035, _T_1043) @[el2_dma_ctrl.scala 370:108]
    node _T_1045 = bits(dma_mem_sz_int, 2, 0) @[el2_dma_ctrl.scala 372:42]
    node _T_1046 = eq(_T_1045, UInt<2>("h02")) @[el2_dma_ctrl.scala 372:49]
    node _T_1047 = and(io.dma_mem_write, _T_1046) @[el2_dma_ctrl.scala 372:25]
    node _T_1048 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 372:88]
    node _T_1049 = eq(_T_1048, UInt<1>("h00")) @[el2_dma_ctrl.scala 372:94]
    node _T_1050 = bits(dma_mem_byteen, 3, 0) @[el2_dma_ctrl.scala 372:121]
    node _T_1051 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 373:26]
    node _T_1052 = eq(_T_1051, UInt<1>("h01")) @[el2_dma_ctrl.scala 373:32]
    node _T_1053 = bits(dma_mem_byteen, 4, 1) @[el2_dma_ctrl.scala 373:59]
    node _T_1054 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 374:26]
    node _T_1055 = eq(_T_1054, UInt<2>("h02")) @[el2_dma_ctrl.scala 374:32]
    node _T_1056 = bits(dma_mem_byteen, 5, 2) @[el2_dma_ctrl.scala 374:59]
    node _T_1057 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 375:26]
    node _T_1058 = eq(_T_1057, UInt<2>("h03")) @[el2_dma_ctrl.scala 375:32]
    node _T_1059 = bits(dma_mem_byteen, 6, 3) @[el2_dma_ctrl.scala 375:59]
    node _T_1060 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 376:26]
    node _T_1061 = eq(_T_1060, UInt<3>("h04")) @[el2_dma_ctrl.scala 376:32]
    node _T_1062 = bits(dma_mem_byteen, 7, 4) @[el2_dma_ctrl.scala 376:59]
    node _T_1063 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 377:26]
    node _T_1064 = eq(_T_1063, UInt<3>("h05")) @[el2_dma_ctrl.scala 377:32]
    node _T_1065 = bits(dma_mem_byteen, 7, 5) @[el2_dma_ctrl.scala 377:59]
    node _T_1066 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 378:26]
    node _T_1067 = eq(_T_1066, UInt<3>("h06")) @[el2_dma_ctrl.scala 378:32]
    node _T_1068 = bits(dma_mem_byteen, 7, 6) @[el2_dma_ctrl.scala 378:59]
    node _T_1069 = bits(dma_mem_addr_int, 2, 0) @[el2_dma_ctrl.scala 379:26]
    node _T_1070 = eq(_T_1069, UInt<3>("h07")) @[el2_dma_ctrl.scala 379:32]
    node _T_1071 = bits(dma_mem_byteen, 7, 7) @[el2_dma_ctrl.scala 379:59]
    node _T_1072 = mux(_T_1049, _T_1050, UInt<1>("h00")) @[Mux.scala 27:72]
    node _T_1073 = mux(_T_1052, _T_1053, UInt<1>("h00")) @[Mux.scala 27:72]
    node _T_1074 = mux(_T_1055, _T_1056, UInt<1>("h00")) @[Mux.scala 27:72]
    node _T_1075 = mux(_T_1058, _T_1059, UInt<1>("h00")) @[Mux.scala 27:72]
    node _T_1076 = mux(_T_1061, _T_1062, UInt<1>("h00")) @[Mux.scala 27:72]
    node _T_1077 = mux(_T_1064, _T_1065, UInt<1>("h00")) @[Mux.scala 27:72]
    node _T_1078 = mux(_T_1067, _T_1068, UInt<1>("h00")) @[Mux.scala 27:72]
    node _T_1079 = mux(_T_1070, _T_1071, UInt<1>("h00")) @[Mux.scala 27:72]
    node _T_1080 = or(_T_1072, _T_1073) @[Mux.scala 27:72]
    node _T_1081 = or(_T_1080, _T_1074) @[Mux.scala 27:72]
    node _T_1082 = or(_T_1081, _T_1075) @[Mux.scala 27:72]
    node _T_1083 = or(_T_1082, _T_1076) @[Mux.scala 27:72]
    node _T_1084 = or(_T_1083, _T_1077) @[Mux.scala 27:72]
    node _T_1085 = or(_T_1084, _T_1078) @[Mux.scala 27:72]
    node _T_1086 = or(_T_1085, _T_1079) @[Mux.scala 27:72]
    wire _T_1087 : UInt<4> @[Mux.scala 27:72]
    _T_1087 <= _T_1086 @[Mux.scala 27:72]
    node _T_1088 = neq(_T_1087, UInt<4>("h0f")) @[el2_dma_ctrl.scala 379:66]
    node _T_1089 = and(_T_1047, _T_1088) @[el2_dma_ctrl.scala 372:58]
    node _T_1090 = or(_T_1044, _T_1089) @[el2_dma_ctrl.scala 371:125]
    node _T_1091 = bits(dma_mem_sz_int, 2, 0) @[el2_dma_ctrl.scala 380:42]
    node _T_1092 = eq(_T_1091, UInt<2>("h03")) @[el2_dma_ctrl.scala 380:49]
    node _T_1093 = and(io.dma_mem_write, _T_1092) @[el2_dma_ctrl.scala 380:25]
    node _T_1094 = bits(dma_mem_byteen, 7, 0) @[el2_dma_ctrl.scala 380:77]
    node _T_1095 = eq(_T_1094, UInt<4>("h0f")) @[el2_dma_ctrl.scala 380:83]
    node _T_1096 = bits(dma_mem_byteen, 7, 0) @[el2_dma_ctrl.scala 380:113]
    node _T_1097 = eq(_T_1096, UInt<8>("h0f0")) @[el2_dma_ctrl.scala 380:119]
    node _T_1098 = or(_T_1095, _T_1097) @[el2_dma_ctrl.scala 380:96]
    node _T_1099 = bits(dma_mem_byteen, 7, 0) @[el2_dma_ctrl.scala 380:149]
    node _T_1100 = eq(_T_1099, UInt<8>("h0ff")) @[el2_dma_ctrl.scala 380:155]
    node _T_1101 = or(_T_1098, _T_1100) @[el2_dma_ctrl.scala 380:132]
    node _T_1102 = not(_T_1101) @[el2_dma_ctrl.scala 380:60]
    node _T_1103 = and(_T_1093, _T_1102) @[el2_dma_ctrl.scala 380:58]
    node _T_1104 = or(_T_1090, _T_1103) @[el2_dma_ctrl.scala 379:79]
    node _T_1105 = and(_T_1011, _T_1104) @[el2_dma_ctrl.scala 366:87]
    dma_alignment_error <= _T_1105 @[el2_dma_ctrl.scala 366:25]
    node _T_1106 = and(fifo_empty, dbg_dma_bubble_bus) @[el2_dma_ctrl.scala 384:39]
    io.dma_dbg_ready <= _T_1106 @[el2_dma_ctrl.scala 384:25]
    node _T_1107 = dshr(fifo_valid, RspPtr) @[el2_dma_ctrl.scala 385:39]
    node _T_1108 = bits(_T_1107, 0, 0) @[el2_dma_ctrl.scala 385:39]
    node _T_1109 = dshr(fifo_dbg, RspPtr) @[el2_dma_ctrl.scala 385:58]
    node _T_1110 = bits(_T_1109, 0, 0) @[el2_dma_ctrl.scala 385:58]
    node _T_1111 = and(_T_1108, _T_1110) @[el2_dma_ctrl.scala 385:48]
    node _T_1112 = dshr(fifo_done, RspPtr) @[el2_dma_ctrl.scala 385:78]
    node _T_1113 = bits(_T_1112, 0, 0) @[el2_dma_ctrl.scala 385:78]
    node _T_1114 = and(_T_1111, _T_1113) @[el2_dma_ctrl.scala 385:67]
    io.dma_dbg_cmd_done <= _T_1114 @[el2_dma_ctrl.scala 385:25]
    node _T_1115 = bits(fifo_addr[RspPtr], 2, 2) @[el2_dma_ctrl.scala 386:49]
    node _T_1116 = bits(fifo_data[RspPtr], 63, 32) @[el2_dma_ctrl.scala 386:71]
    node _T_1117 = bits(fifo_data[RspPtr], 31, 0) @[el2_dma_ctrl.scala 386:98]
    node _T_1118 = mux(_T_1115, _T_1116, _T_1117) @[el2_dma_ctrl.scala 386:31]
    io.dma_dbg_rddata <= _T_1118 @[el2_dma_ctrl.scala 386:25]
    node _T_1119 = orr(fifo_error[RspPtr]) @[el2_dma_ctrl.scala 387:47]
    io.dma_dbg_cmd_fail <= _T_1119 @[el2_dma_ctrl.scala 387:25]
    node _T_1120 = dshr(fifo_valid, RdPtr) @[el2_dma_ctrl.scala 389:38]
    node _T_1121 = bits(_T_1120, 0, 0) @[el2_dma_ctrl.scala 389:38]
    node _T_1122 = dshr(fifo_done, RdPtr) @[el2_dma_ctrl.scala 389:58]
    node _T_1123 = bits(_T_1122, 0, 0) @[el2_dma_ctrl.scala 389:58]
    node _T_1124 = not(_T_1123) @[el2_dma_ctrl.scala 389:48]
    node _T_1125 = and(_T_1121, _T_1124) @[el2_dma_ctrl.scala 389:46]
    node _T_1126 = dshr(fifo_dbg, RdPtr) @[el2_dma_ctrl.scala 389:76]
    node _T_1127 = bits(_T_1126, 0, 0) @[el2_dma_ctrl.scala 389:76]
    node _T_1128 = and(_T_1125, _T_1127) @[el2_dma_ctrl.scala 389:66]
    node _T_1129 = or(dma_mem_addr_in_dccm, dma_mem_addr_in_iccm) @[el2_dma_ctrl.scala 389:111]
    node _T_1130 = or(_T_1129, dma_mem_addr_in_pic) @[el2_dma_ctrl.scala 389:134]
    node _T_1131 = not(_T_1130) @[el2_dma_ctrl.scala 389:88]
    node _T_1132 = bits(_T_1131, 0, 0) @[el2_dma_ctrl.scala 389:164]
    node _T_1133 = bits(dma_mem_sz_int, 1, 0) @[el2_dma_ctrl.scala 389:184]
    node _T_1134 = neq(_T_1133, UInt<2>("h02")) @[el2_dma_ctrl.scala 389:191]
    node _T_1135 = or(_T_1132, _T_1134) @[el2_dma_ctrl.scala 389:167]
    node _T_1136 = and(_T_1128, _T_1135) @[el2_dma_ctrl.scala 389:84]
    dma_dbg_cmd_error <= _T_1136 @[el2_dma_ctrl.scala 389:25]
    node _T_1137 = or(dma_mem_addr_in_dccm, dma_mem_addr_in_pic) @[el2_dma_ctrl.scala 393:64]
    node _T_1138 = and(dma_mem_req, _T_1137) @[el2_dma_ctrl.scala 393:40]
    node _T_1139 = geq(dma_nack_count, dma_nack_count_csr) @[el2_dma_ctrl.scala 393:105]
    node _T_1140 = and(_T_1138, _T_1139) @[el2_dma_ctrl.scala 393:87]
    io.dma_dccm_stall_any <= _T_1140 @[el2_dma_ctrl.scala 393:25]
    node _T_1141 = and(dma_mem_req, dma_mem_addr_in_iccm) @[el2_dma_ctrl.scala 394:40]
    node _T_1142 = geq(dma_nack_count, dma_nack_count_csr) @[el2_dma_ctrl.scala 394:81]
    node _T_1143 = and(_T_1141, _T_1142) @[el2_dma_ctrl.scala 394:63]
    io.dma_iccm_stall_any <= _T_1143 @[el2_dma_ctrl.scala 394:25]
    node _T_1144 = orr(fifo_valid) @[el2_dma_ctrl.scala 398:30]
    node _T_1145 = not(_T_1144) @[el2_dma_ctrl.scala 398:17]
    fifo_empty <= _T_1145 @[el2_dma_ctrl.scala 398:14]
    dma_nack_count_csr <= io.dec_tlu_dma_qos_prty @[el2_dma_ctrl.scala 402:22]
    node _T_1146 = geq(dma_nack_count, dma_nack_count_csr) @[el2_dma_ctrl.scala 403:45]
    node _T_1147 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 403:95]
    node _T_1148 = not(_T_1147) @[el2_dma_ctrl.scala 403:77]
    node _T_1149 = bits(_T_1148, 0, 0) @[Bitwise.scala 72:15]
    node _T_1150 = mux(_T_1149, UInt<3>("h07"), UInt<3>("h00")) @[Bitwise.scala 72:12]
    node _T_1151 = bits(dma_nack_count, 2, 0) @[el2_dma_ctrl.scala 403:131]
    node _T_1152 = and(_T_1150, _T_1151) @[el2_dma_ctrl.scala 403:115]
    node _T_1153 = bits(dma_mem_req, 0, 0) @[el2_dma_ctrl.scala 403:156]
    node _T_1154 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 403:183]
    node _T_1155 = not(_T_1154) @[el2_dma_ctrl.scala 403:165]
    node _T_1156 = and(_T_1153, _T_1155) @[el2_dma_ctrl.scala 403:163]
    node _T_1157 = bits(dma_nack_count, 2, 0) @[el2_dma_ctrl.scala 403:218]
    node _T_1158 = add(_T_1157, UInt<1>("h01")) @[el2_dma_ctrl.scala 403:224]
    node _T_1159 = tail(_T_1158, 1) @[el2_dma_ctrl.scala 403:224]
    node _T_1160 = mux(_T_1156, _T_1159, UInt<1>("h00")) @[el2_dma_ctrl.scala 403:142]
    node dma_nack_count_d = mux(_T_1146, _T_1152, _T_1160) @[el2_dma_ctrl.scala 403:29]
    node _T_1161 = bits(dma_nack_count_d, 2, 0) @[el2_dma_ctrl.scala 406:31]
    node _T_1162 = bits(dma_mem_req, 0, 0) @[el2_dma_ctrl.scala 406:55]
    reg _T_1163 : UInt, dma_free_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_1162 : @[Reg.scala 28:19]
      _T_1163 <= _T_1161 @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    dma_nack_count <= _T_1163 @[el2_dma_ctrl.scala 405:22]
    node _T_1164 = dshr(fifo_valid, RdPtr) @[el2_dma_ctrl.scala 411:33]
    node _T_1165 = bits(_T_1164, 0, 0) @[el2_dma_ctrl.scala 411:33]
    node _T_1166 = dshr(fifo_rpend, RdPtr) @[el2_dma_ctrl.scala 411:54]
    node _T_1167 = bits(_T_1166, 0, 0) @[el2_dma_ctrl.scala 411:54]
    node _T_1168 = not(_T_1167) @[el2_dma_ctrl.scala 411:43]
    node _T_1169 = and(_T_1165, _T_1168) @[el2_dma_ctrl.scala 411:41]
    node _T_1170 = dshr(fifo_done, RdPtr) @[el2_dma_ctrl.scala 411:74]
    node _T_1171 = bits(_T_1170, 0, 0) @[el2_dma_ctrl.scala 411:74]
    node _T_1172 = not(_T_1171) @[el2_dma_ctrl.scala 411:64]
    node _T_1173 = and(_T_1169, _T_1172) @[el2_dma_ctrl.scala 411:62]
    node _T_1174 = or(dma_address_error, dma_alignment_error) @[el2_dma_ctrl.scala 411:104]
    node _T_1175 = or(_T_1174, dma_dbg_cmd_error) @[el2_dma_ctrl.scala 411:126]
    node _T_1176 = not(_T_1175) @[el2_dma_ctrl.scala 411:84]
    node _T_1177 = and(_T_1173, _T_1176) @[el2_dma_ctrl.scala 411:82]
    dma_mem_req <= _T_1177 @[el2_dma_ctrl.scala 411:20]
    node _T_1178 = or(dma_mem_addr_in_dccm, dma_mem_addr_in_pic) @[el2_dma_ctrl.scala 412:59]
    node _T_1179 = and(dma_mem_req, _T_1178) @[el2_dma_ctrl.scala 412:35]
    node _T_1180 = and(_T_1179, io.dccm_ready) @[el2_dma_ctrl.scala 412:82]
    io.dma_dccm_req <= _T_1180 @[el2_dma_ctrl.scala 412:20]
    node _T_1181 = and(dma_mem_req, dma_mem_addr_in_iccm) @[el2_dma_ctrl.scala 413:35]
    node _T_1182 = and(_T_1181, io.iccm_ready) @[el2_dma_ctrl.scala 413:58]
    io.dma_iccm_req <= _T_1182 @[el2_dma_ctrl.scala 413:20]
    io.dma_mem_tag <= RdPtr @[el2_dma_ctrl.scala 414:20]
    dma_mem_addr_int <= fifo_addr[RdPtr] @[el2_dma_ctrl.scala 415:20]
    dma_mem_sz_int <= fifo_sz[RdPtr] @[el2_dma_ctrl.scala 416:20]
    node _T_1183 = bits(dma_mem_byteen, 7, 0) @[el2_dma_ctrl.scala 417:61]
    node _T_1184 = eq(_T_1183, UInt<8>("h0f0")) @[el2_dma_ctrl.scala 417:67]
    node _T_1185 = and(io.dma_mem_write, _T_1184) @[el2_dma_ctrl.scala 417:44]
    node _T_1186 = bits(dma_mem_addr_int, 31, 3) @[el2_dma_ctrl.scala 417:101]
    node _T_1187 = bits(dma_mem_addr_int, 1, 0) @[el2_dma_ctrl.scala 417:131]
    node _T_1188 = cat(_T_1186, UInt<1>("h01")) @[Cat.scala 29:58]
    node _T_1189 = cat(_T_1188, _T_1187) @[Cat.scala 29:58]
    node _T_1190 = bits(dma_mem_addr_int, 31, 0) @[el2_dma_ctrl.scala 417:156]
    node _T_1191 = mux(_T_1185, _T_1189, _T_1190) @[el2_dma_ctrl.scala 417:26]
    io.dma_mem_addr <= _T_1191 @[el2_dma_ctrl.scala 417:20]
    node _T_1192 = bits(dma_mem_byteen, 7, 0) @[el2_dma_ctrl.scala 418:62]
    node _T_1193 = eq(_T_1192, UInt<4>("h0f")) @[el2_dma_ctrl.scala 418:68]
    node _T_1194 = bits(dma_mem_byteen, 7, 0) @[el2_dma_ctrl.scala 418:98]
    node _T_1195 = eq(_T_1194, UInt<8>("h0f0")) @[el2_dma_ctrl.scala 418:104]
    node _T_1196 = or(_T_1193, _T_1195) @[el2_dma_ctrl.scala 418:81]
    node _T_1197 = and(io.dma_mem_write, _T_1196) @[el2_dma_ctrl.scala 418:44]
    node _T_1198 = bits(dma_mem_sz_int, 2, 0) @[el2_dma_ctrl.scala 418:138]
    node _T_1199 = mux(_T_1197, UInt<2>("h02"), _T_1198) @[el2_dma_ctrl.scala 418:26]
    io.dma_mem_sz <= _T_1199 @[el2_dma_ctrl.scala 418:20]
    dma_mem_byteen <= fifo_byteen[RdPtr] @[el2_dma_ctrl.scala 419:20]
    node _T_1200 = dshr(fifo_write, RdPtr) @[el2_dma_ctrl.scala 420:33]
    node _T_1201 = bits(_T_1200, 0, 0) @[el2_dma_ctrl.scala 420:33]
    io.dma_mem_write <= _T_1201 @[el2_dma_ctrl.scala 420:20]
    io.dma_mem_wdata <= fifo_data[RdPtr] @[el2_dma_ctrl.scala 421:20]
    node _T_1202 = not(io.dma_mem_write) @[el2_dma_ctrl.scala 425:47]
    node _T_1203 = and(io.dma_dccm_req, _T_1202) @[el2_dma_ctrl.scala 425:45]
    io.dma_pmu_dccm_read <= _T_1203 @[el2_dma_ctrl.scala 425:26]
    node _T_1204 = and(io.dma_dccm_req, io.dma_mem_write) @[el2_dma_ctrl.scala 426:45]
    io.dma_pmu_dccm_write <= _T_1204 @[el2_dma_ctrl.scala 426:26]
    node _T_1205 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 427:46]
    node _T_1206 = not(io.dma_mem_write) @[el2_dma_ctrl.scala 427:67]
    node _T_1207 = and(_T_1205, _T_1206) @[el2_dma_ctrl.scala 427:65]
    io.dma_pmu_any_read <= _T_1207 @[el2_dma_ctrl.scala 427:26]
    node _T_1208 = or(io.dma_dccm_req, io.dma_iccm_req) @[el2_dma_ctrl.scala 428:46]
    node _T_1209 = and(_T_1208, io.dma_mem_write) @[el2_dma_ctrl.scala 428:65]
    io.dma_pmu_any_write <= _T_1209 @[el2_dma_ctrl.scala 428:26]
    reg _T_1210 : UInt<1>, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 433:12]
    _T_1210 <= fifo_full_spec @[el2_dma_ctrl.scala 433:12]
    fifo_full <= _T_1210 @[el2_dma_ctrl.scala 432:22]
    reg _T_1211 : UInt<1>, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 437:12]
    _T_1211 <= io.dbg_dma_bubble @[el2_dma_ctrl.scala 437:12]
    dbg_dma_bubble_bus <= _T_1211 @[el2_dma_ctrl.scala 436:22]
    reg _T_1212 : UInt<1>, io.free_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 441:12]
    _T_1212 <= io.dma_dbg_cmd_done @[el2_dma_ctrl.scala 441:12]
    dma_dbg_cmd_done_q <= _T_1212 @[el2_dma_ctrl.scala 440:22]
    node _T_1213 = and(bus_cmd_valid, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 446:44]
    node _T_1214 = or(_T_1213, io.dbg_cmd_valid) @[el2_dma_ctrl.scala 446:65]
    node dma_buffer_c1_clken = or(_T_1214, io.clk_override) @[el2_dma_ctrl.scala 446:84]
    node _T_1215 = or(bus_cmd_valid, bus_rsp_valid) @[el2_dma_ctrl.scala 447:44]
    node _T_1216 = or(_T_1215, io.dbg_cmd_valid) @[el2_dma_ctrl.scala 447:60]
    node _T_1217 = or(_T_1216, io.dma_dbg_cmd_done) @[el2_dma_ctrl.scala 447:79]
    node _T_1218 = or(_T_1217, dma_dbg_cmd_done_q) @[el2_dma_ctrl.scala 447:101]
    node _T_1219 = orr(fifo_valid) @[el2_dma_ctrl.scala 447:136]
    node _T_1220 = or(_T_1218, _T_1219) @[el2_dma_ctrl.scala 447:122]
    node dma_free_clken = or(_T_1220, io.clk_override) @[el2_dma_ctrl.scala 447:141]
    inst dma_buffer_c1cgc of rvclkhdr_10 @[el2_dma_ctrl.scala 449:32]
    dma_buffer_c1cgc.clock <= clock
    dma_buffer_c1cgc.reset <= reset
    dma_buffer_c1cgc.io.en <= dma_buffer_c1_clken @[el2_dma_ctrl.scala 450:33]
    dma_buffer_c1cgc.io.scan_mode <= io.scan_mode @[el2_dma_ctrl.scala 451:33]
    dma_buffer_c1cgc.io.clk <= clock @[el2_dma_ctrl.scala 452:33]
    dma_buffer_c1_clk <= dma_buffer_c1cgc.io.l1clk @[el2_dma_ctrl.scala 453:33]
    inst dma_free_cgc of rvclkhdr_11 @[el2_dma_ctrl.scala 455:28]
    dma_free_cgc.clock <= clock
    dma_free_cgc.reset <= reset
    dma_free_cgc.io.en <= dma_free_clken @[el2_dma_ctrl.scala 456:29]
    dma_free_cgc.io.scan_mode <= io.scan_mode @[el2_dma_ctrl.scala 457:29]
    dma_free_cgc.io.clk <= clock @[el2_dma_ctrl.scala 458:29]
    dma_free_clk <= dma_free_cgc.io.l1clk @[el2_dma_ctrl.scala 459:29]
    inst dma_bus_cgc of rvclkhdr_12 @[el2_dma_ctrl.scala 461:27]
    dma_bus_cgc.clock <= clock
    dma_bus_cgc.reset <= reset
    dma_bus_cgc.io.en <= io.dma_bus_clk_en @[el2_dma_ctrl.scala 462:28]
    dma_bus_cgc.io.scan_mode <= io.scan_mode @[el2_dma_ctrl.scala 463:28]
    dma_bus_cgc.io.clk <= clock @[el2_dma_ctrl.scala 464:28]
    dma_bus_clk <= dma_bus_cgc.io.l1clk @[el2_dma_ctrl.scala 465:28]
    node wrbuf_en = and(io.dma_axi_awvalid, io.dma_axi_awready) @[el2_dma_ctrl.scala 469:46]
    node wrbuf_data_en = and(io.dma_axi_wvalid, io.dma_axi_wready) @[el2_dma_ctrl.scala 470:45]
    node wrbuf_cmd_sent = and(bus_cmd_sent, bus_cmd_write) @[el2_dma_ctrl.scala 471:40]
    node _T_1221 = bits(wrbuf_cmd_sent, 0, 0) @[el2_dma_ctrl.scala 472:42]
    node _T_1222 = not(wrbuf_en) @[el2_dma_ctrl.scala 472:51]
    node wrbuf_rst = and(_T_1221, _T_1222) @[el2_dma_ctrl.scala 472:49]
    node _T_1223 = bits(wrbuf_cmd_sent, 0, 0) @[el2_dma_ctrl.scala 473:42]
    node _T_1224 = not(wrbuf_data_en) @[el2_dma_ctrl.scala 473:51]
    node wrbuf_data_rst = and(_T_1223, _T_1224) @[el2_dma_ctrl.scala 473:49]
    node _T_1225 = mux(wrbuf_en, UInt<1>("h01"), wrbuf_vld) @[el2_dma_ctrl.scala 475:63]
    node _T_1226 = not(wrbuf_rst) @[el2_dma_ctrl.scala 475:92]
    node _T_1227 = and(_T_1225, _T_1226) @[el2_dma_ctrl.scala 475:90]
    reg _T_1228 : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 475:59]
    _T_1228 <= _T_1227 @[el2_dma_ctrl.scala 475:59]
    wrbuf_vld <= _T_1228 @[el2_dma_ctrl.scala 475:25]
    node _T_1229 = mux(wrbuf_data_en, UInt<1>("h01"), wrbuf_data_vld) @[el2_dma_ctrl.scala 477:63]
    node _T_1230 = not(wrbuf_data_rst) @[el2_dma_ctrl.scala 477:102]
    node _T_1231 = and(_T_1229, _T_1230) @[el2_dma_ctrl.scala 477:100]
    reg _T_1232 : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 477:59]
    _T_1232 <= _T_1231 @[el2_dma_ctrl.scala 477:59]
    wrbuf_data_vld <= _T_1232 @[el2_dma_ctrl.scala 477:25]
    reg wrbuf_tag : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when wrbuf_en : @[Reg.scala 28:19]
      wrbuf_tag <= io.dma_axi_awid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    reg wrbuf_sz : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when wrbuf_en : @[Reg.scala 28:19]
      wrbuf_sz <= io.dma_axi_awsize @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_1233 = and(wrbuf_en, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 487:62]
    inst rvclkhdr_10 of rvclkhdr_13 @[el2_lib.scala 508:23]
    rvclkhdr_10.clock <= clock
    rvclkhdr_10.reset <= reset
    rvclkhdr_10.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_10.io.en <= _T_1233 @[el2_lib.scala 511:17]
    rvclkhdr_10.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg wrbuf_addr : UInt, rvclkhdr_10.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    wrbuf_addr <= io.dma_axi_awaddr @[el2_lib.scala 514:16]
    node _T_1234 = and(wrbuf_data_en, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 489:66]
    inst rvclkhdr_11 of rvclkhdr_14 @[el2_lib.scala 508:23]
    rvclkhdr_11.clock <= clock
    rvclkhdr_11.reset <= reset
    rvclkhdr_11.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_11.io.en <= _T_1234 @[el2_lib.scala 511:17]
    rvclkhdr_11.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg wrbuf_data : UInt, rvclkhdr_11.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    wrbuf_data <= io.dma_axi_wdata @[el2_lib.scala 514:16]
    reg wrbuf_byteen : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when wrbuf_data_en : @[Reg.scala 28:19]
      wrbuf_byteen <= io.dma_axi_wstrb @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node rdbuf_en = and(io.dma_axi_arvalid, io.dma_axi_arready) @[el2_dma_ctrl.scala 497:58]
    node _T_1235 = not(bus_cmd_write) @[el2_dma_ctrl.scala 498:44]
    node rdbuf_cmd_sent = and(bus_cmd_sent, _T_1235) @[el2_dma_ctrl.scala 498:42]
    node _T_1236 = bits(rdbuf_cmd_sent, 0, 0) @[el2_dma_ctrl.scala 499:54]
    node _T_1237 = not(rdbuf_en) @[el2_dma_ctrl.scala 499:63]
    node rdbuf_rst = and(_T_1236, _T_1237) @[el2_dma_ctrl.scala 499:61]
    node _T_1238 = mux(rdbuf_en, UInt<1>("h01"), rdbuf_vld) @[el2_dma_ctrl.scala 501:51]
    node _T_1239 = not(rdbuf_rst) @[el2_dma_ctrl.scala 501:80]
    node _T_1240 = and(_T_1238, _T_1239) @[el2_dma_ctrl.scala 501:78]
    reg _T_1241 : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[el2_dma_ctrl.scala 501:47]
    _T_1241 <= _T_1240 @[el2_dma_ctrl.scala 501:47]
    rdbuf_vld <= _T_1241 @[el2_dma_ctrl.scala 501:13]
    reg rdbuf_tag : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when rdbuf_en : @[Reg.scala 28:19]
      rdbuf_tag <= io.dma_axi_arid @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    reg rdbuf_sz : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when rdbuf_en : @[Reg.scala 28:19]
      rdbuf_sz <= io.dma_axi_arsize @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    node _T_1242 = and(rdbuf_en, io.dma_bus_clk_en) @[el2_dma_ctrl.scala 511:55]
    inst rvclkhdr_12 of rvclkhdr_15 @[el2_lib.scala 508:23]
    rvclkhdr_12.clock <= clock
    rvclkhdr_12.reset <= reset
    rvclkhdr_12.io.clk <= clock @[el2_lib.scala 510:18]
    rvclkhdr_12.io.en <= _T_1242 @[el2_lib.scala 511:17]
    rvclkhdr_12.io.scan_mode <= io.scan_mode @[el2_lib.scala 512:24]
    reg rdbuf_addr : UInt, rvclkhdr_12.io.l1clk with : (reset => (reset, UInt<1>("h00"))) @[el2_lib.scala 514:16]
    rdbuf_addr <= io.dma_axi_araddr @[el2_lib.scala 514:16]
    node _T_1243 = not(wrbuf_cmd_sent) @[el2_dma_ctrl.scala 513:44]
    node _T_1244 = and(wrbuf_vld, _T_1243) @[el2_dma_ctrl.scala 513:42]
    node _T_1245 = not(_T_1244) @[el2_dma_ctrl.scala 513:30]
    io.dma_axi_awready <= _T_1245 @[el2_dma_ctrl.scala 513:27]
    node _T_1246 = not(wrbuf_cmd_sent) @[el2_dma_ctrl.scala 514:49]
    node _T_1247 = and(wrbuf_data_vld, _T_1246) @[el2_dma_ctrl.scala 514:47]
    node _T_1248 = not(_T_1247) @[el2_dma_ctrl.scala 514:30]
    io.dma_axi_wready <= _T_1248 @[el2_dma_ctrl.scala 514:27]
    node _T_1249 = not(rdbuf_cmd_sent) @[el2_dma_ctrl.scala 515:44]
    node _T_1250 = and(rdbuf_vld, _T_1249) @[el2_dma_ctrl.scala 515:42]
    node _T_1251 = not(_T_1250) @[el2_dma_ctrl.scala 515:30]
    io.dma_axi_arready <= _T_1251 @[el2_dma_ctrl.scala 515:27]
    node _T_1252 = and(wrbuf_vld, wrbuf_data_vld) @[el2_dma_ctrl.scala 519:51]
    node _T_1253 = or(_T_1252, rdbuf_vld) @[el2_dma_ctrl.scala 519:69]
    bus_cmd_valid <= _T_1253 @[el2_dma_ctrl.scala 519:37]
    node _T_1254 = and(bus_cmd_valid, dma_fifo_ready) @[el2_dma_ctrl.scala 520:54]
    bus_cmd_sent <= _T_1254 @[el2_dma_ctrl.scala 520:37]
    bus_cmd_write <= axi_mstr_sel @[el2_dma_ctrl.scala 521:37]
    bus_cmd_posted_write <= UInt<1>("h00") @[el2_dma_ctrl.scala 522:25]
    node _T_1255 = bits(axi_mstr_sel, 0, 0) @[el2_dma_ctrl.scala 523:57]
    node _T_1256 = mux(_T_1255, wrbuf_addr, rdbuf_addr) @[el2_dma_ctrl.scala 523:43]
    bus_cmd_addr <= _T_1256 @[el2_dma_ctrl.scala 523:37]
    node _T_1257 = bits(axi_mstr_sel, 0, 0) @[el2_dma_ctrl.scala 524:59]
    node _T_1258 = mux(_T_1257, wrbuf_sz, rdbuf_sz) @[el2_dma_ctrl.scala 524:45]
    bus_cmd_sz <= _T_1258 @[el2_dma_ctrl.scala 524:39]
    bus_cmd_wdata <= wrbuf_data @[el2_dma_ctrl.scala 525:37]
    bus_cmd_byteen <= wrbuf_byteen @[el2_dma_ctrl.scala 526:37]
    node _T_1259 = bits(axi_mstr_sel, 0, 0) @[el2_dma_ctrl.scala 527:57]
    node _T_1260 = mux(_T_1259, wrbuf_tag, rdbuf_tag) @[el2_dma_ctrl.scala 527:43]
    bus_cmd_tag <= _T_1260 @[el2_dma_ctrl.scala 527:37]
    bus_cmd_mid <= UInt<1>("h00") @[el2_dma_ctrl.scala 528:37]
    bus_cmd_prty <= UInt<1>("h00") @[el2_dma_ctrl.scala 529:37]
    node _T_1261 = and(wrbuf_vld, wrbuf_data_vld) @[el2_dma_ctrl.scala 533:43]
    node _T_1262 = and(_T_1261, rdbuf_vld) @[el2_dma_ctrl.scala 533:60]
    node _T_1263 = eq(_T_1262, UInt<1>("h01")) @[el2_dma_ctrl.scala 533:73]
    node _T_1264 = and(wrbuf_vld, wrbuf_data_vld) @[el2_dma_ctrl.scala 533:111]
    node _T_1265 = mux(_T_1263, axi_mstr_priority, _T_1264) @[el2_dma_ctrl.scala 533:31]
    axi_mstr_sel <= _T_1265 @[el2_dma_ctrl.scala 533:25]
    node axi_mstr_prty_in = not(axi_mstr_priority) @[el2_dma_ctrl.scala 534:27]
    axi_mstr_prty_en <= bus_cmd_sent @[el2_dma_ctrl.scala 535:25]
    node _T_1266 = bits(axi_mstr_prty_en, 0, 0) @[el2_dma_ctrl.scala 538:55]
    reg _T_1267 : UInt, dma_bus_clk with : (reset => (reset, UInt<1>("h00"))) @[Reg.scala 27:20]
    when _T_1266 : @[Reg.scala 28:19]
      _T_1267 <= axi_mstr_prty_in @[Reg.scala 28:23]
      skip @[Reg.scala 28:19]
    axi_mstr_priority <= _T_1267 @[el2_dma_ctrl.scala 537:27]
    node _T_1268 = dshr(fifo_valid, RspPtr) @[el2_dma_ctrl.scala 541:39]
    node _T_1269 = bits(_T_1268, 0, 0) @[el2_dma_ctrl.scala 541:39]
    node _T_1270 = dshr(fifo_dbg, RspPtr) @[el2_dma_ctrl.scala 541:59]
    node _T_1271 = bits(_T_1270, 0, 0) @[el2_dma_ctrl.scala 541:59]
    node _T_1272 = not(_T_1271) @[el2_dma_ctrl.scala 541:50]
    node _T_1273 = and(_T_1269, _T_1272) @[el2_dma_ctrl.scala 541:48]
    node _T_1274 = dshr(fifo_done_bus, RspPtr) @[el2_dma_ctrl.scala 541:83]
    node _T_1275 = bits(_T_1274, 0, 0) @[el2_dma_ctrl.scala 541:83]
    node axi_rsp_valid = and(_T_1273, _T_1275) @[el2_dma_ctrl.scala 541:68]
    node _T_1276 = dshr(fifo_write, RspPtr) @[el2_dma_ctrl.scala 543:39]
    node axi_rsp_write = bits(_T_1276, 0, 0) @[el2_dma_ctrl.scala 543:39]
    node _T_1277 = bits(fifo_error[RspPtr], 0, 0) @[el2_dma_ctrl.scala 544:51]
    node _T_1278 = bits(fifo_error[RspPtr], 1, 1) @[el2_dma_ctrl.scala 544:83]
    node _T_1279 = mux(_T_1278, UInt<2>("h03"), UInt<1>("h00")) @[el2_dma_ctrl.scala 544:64]
    node axi_rsp_error = mux(_T_1277, UInt<2>("h02"), _T_1279) @[el2_dma_ctrl.scala 544:32]
    node _T_1280 = and(axi_rsp_valid, axi_rsp_write) @[el2_dma_ctrl.scala 550:44]
    io.dma_axi_bvalid <= _T_1280 @[el2_dma_ctrl.scala 550:27]
    node _T_1281 = bits(axi_rsp_error, 1, 0) @[el2_dma_ctrl.scala 551:49]
    io.dma_axi_bresp <= _T_1281 @[el2_dma_ctrl.scala 551:33]
    io.dma_axi_bid <= fifo_tag[RspPtr] @[el2_dma_ctrl.scala 552:33]
    node _T_1282 = not(axi_rsp_write) @[el2_dma_ctrl.scala 554:46]
    node _T_1283 = and(axi_rsp_valid, _T_1282) @[el2_dma_ctrl.scala 554:44]
    io.dma_axi_rvalid <= _T_1283 @[el2_dma_ctrl.scala 554:27]
    io.dma_axi_rresp <= axi_rsp_error @[el2_dma_ctrl.scala 555:33]
    node _T_1284 = bits(fifo_data[RspPtr], 63, 0) @[el2_dma_ctrl.scala 556:51]
    io.dma_axi_rdata <= _T_1284 @[el2_dma_ctrl.scala 556:35]
    io.dma_axi_rlast <= UInt<1>("h01") @[el2_dma_ctrl.scala 557:33]
    io.dma_axi_rid <= fifo_tag[RspPtr] @[el2_dma_ctrl.scala 558:37]
    bus_posted_write_done <= UInt<1>("h00") @[el2_dma_ctrl.scala 560:25]
    node _T_1285 = or(io.dma_axi_bvalid, io.dma_axi_rvalid) @[el2_dma_ctrl.scala 561:59]
    bus_rsp_valid <= _T_1285 @[el2_dma_ctrl.scala 561:37]
    node _T_1286 = and(io.dma_axi_bvalid, io.dma_axi_bready) @[el2_dma_ctrl.scala 562:60]
    node _T_1287 = and(io.dma_axi_rvalid, io.dma_axi_rready) @[el2_dma_ctrl.scala 562:102]
    node _T_1288 = or(_T_1286, _T_1287) @[el2_dma_ctrl.scala 562:81]
    bus_rsp_sent <= _T_1288 @[el2_dma_ctrl.scala 562:37]
    
