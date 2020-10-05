//package dec
//import chisel3._
//import include._
//import snapshot.pt1
//import lib._
//
//class el2_dec_IO extends Bundle {
//  val clk                   = Input(Bool())
//  val free_clk              = Input(Bool())
//  val active_clk            = Input(Bool())
//
//  val lsu_fastint_stall_any = Input(Bool())           // needed by lsu for 2nd pass of dma with ecc correction, stall next cycle
//
//  val dec_extint_stall      = Output(Bool())
//
//  val dec_i0_decode_d       = Output(Bool())
//  val dec_pause_state_cg    = Output(Bool())          // to top for active state clock gating
//
//  val rst_l                 = Input(Bool())           // reset, active low
//  val rst_vec               = Input(UInt(32.W))       // [31:1] reset vector, from core pins
//
//  val nmi_int               = Input(Bool())           // NMI pin
//  val nmi_vec               = Input(UInt(32.W))       // [31:1] NMI vector, from pins
//
//  val i_cpu_halt_req        = Input(Bool())           // Asynchronous Halt request to CPU
//  val i_cpu_run_req         = Input(Bool())           // Asynchronous Restart request to CPU
//
//  val o_cpu_halt_status     = Output(Bool())          // Halt status of core (pmu/fw)
//  val o_cpu_halt_ack        = Output(Bool())          // Halt request ack
//  val o_cpu_run_ack         = Output(Bool())          // Run request ack
//  val o_debug_mode_status   = Output(Bool())          // Core to the PMU that core is in debug mode. When core is in debug mode, the PMU should refrain from sendng a halt or run request
//
//  val core_id               = Input(UInt(32.W))       // [31:4] CORE ID
//
//  // external MPC halt/run interface
//  val mpc_debug_halt_req    = Input(Bool())   // Async halt request
//  val mpc_debug_run_req     = Input(Bool())   // Async run request
//  val mpc_reset_run_req     = Input(Bool())   // Run/halt after reset
//  val mpc_debug_halt_ack    = Output(Bool())  // Halt ack
//  val mpc_debug_run_ack     = Output(Bool())  // Run ack
//  val debug_brkpt_status    = Output(Bool())  // debug breakpoint
//
//  val exu_pmu_i0_br_misp    = Input(Bool())   // slot 0 branch misp
//  val exu_pmu_i0_br_ataken  = Input(Bool())   // slot 0 branch actual taken
//  val exu_pmu_i0_pc4        = Input(Bool())   // slot 0 4 byte branch
//
//
//  val lsu_nonblock_load_valid_m     =   Input(Bool())                         // valid nonblock load at m
//  val lsu_nonblock_load_tag_m       =   Input(UInt(pt1.LSU_NUM_NBLOAD_WIDTH)) // -> corresponding tag
//  val lsu_nonblock_load_inv_r       =   Input(Bool())                         // invalidate request for nonblock load r
//  val lsu_nonblock_load_inv_tag_r   =   Input(UInt(pt1.LSU_NUM_NBLOAD_WIDTH)) // -> corresponding tag
//  val lsu_nonblock_load_data_valid  =   Input(Bool())                         // valid nonblock load data back
//  val lsu_nonblock_load_data_error  =   Input(Bool())                         // nonblock load bus error
//  val lsu_nonblock_load_data_tag    =   Input(UInt(pt1.LSU_NUM_NBLOAD_WIDTH)) // -> corresponding tag
//  val lsu_nonblock_load_data        =   Input(UInt(32.W))                     // nonblock load data
//
//  val lsu_pmu_bus_trxn              =  Input(Bool())      // D side bus transaction
//  val lsu_pmu_bus_misaligned        =  Input(Bool())      // D side bus misaligned
//  val lsu_pmu_bus_error             =  Input(Bool())      // D side bus error
//  val lsu_pmu_bus_busy              =  Input(Bool())      // D side bus busy
//  val lsu_pmu_misaligned_m          =  Input(Bool())      // D side load or store misaligned
//  val lsu_pmu_load_external_m       =  Input(Bool())      // D side bus load
//  val lsu_pmu_store_external_m      =  Input(Bool())      // D side bus store
//  val dma_pmu_dccm_read             =  Input(Bool())      // DMA DCCM read
//  val dma_pmu_dccm_write            =  Input(Bool())      // DMA DCCM write
//  val dma_pmu_any_read              =  Input(Bool())      // DMA read
//  val dma_pmu_any_write             =  Input(Bool())      // DMA write
//
//  val lsu_fir_addr    =   Input(UInt(32.W)) //[31:1] Fast int address
//  val lsu_fir_error   =   Input(UInt(2.W))  //[1:0]  Fast int lookup error
//
//  val ifu_pmu_instr_aligned   =  Input(Bool())         // aligned instructions
//  val ifu_pmu_fetch_stall     =  Input(Bool())         // fetch unit stalled
//  val ifu_pmu_ic_miss         =  Input(Bool())         // icache miss
//  val ifu_pmu_ic_hit          =  Input(Bool())         // icache hit
//  val ifu_pmu_bus_error       =  Input(Bool())         // Instruction side bus error
//  val ifu_pmu_bus_busy        =  Input(Bool())         // Instruction side bus busy
//  val ifu_pmu_bus_trxn        =  Input(Bool())         // Instruction side bus transaction
//
//  val ifu_ic_error_start            =  Input(Bool())     // IC single bit error
//  val ifu_iccm_rd_ecc_single_err    =  Input(Bool())     // ICCM single bit error
//
//  val lsu_trigger_match_m     = Input(UInt(4.W))
//  val dbg_cmd_valid           = Input(Bool())    // debugger abstract command valid
//  val dbg_cmd_write           = Input(Bool())    // command is a write
//  val dbg_cmd_type            = Input(UInt(2.W))    //  command type
//  val dbg_cmd_addr            = Input(UInt(32.W))    // command address
//  val dbg_cmd_wrdata          = Input(UInt(2.W))    // command write data, for fence/fence_i
//
//
//  val ifu_i0_icaf             = Input(Bool())         // icache access fault
//  val ifu_i0_icaf_type        = Input(UInt(2.W))
//
//  val ifu_i0_icaf_f1          = Input(Bool())    // i0 has access fault on second fetch group
//  val ifu_i0_dbecc            = Input(Bool())    // icache/iccm double-bit error
//
//  val lsu_idle_any            = Input(Bool())     // lsu idle for halting
//
//  val i0_brp                  = Input(new el2_br_tlu_pkt_t)         // branch packet
//  val ifu_i0_bp_index         = Input(UInt(pt1.BTB_ADDR_HI.W))      // BP index
//  val ifu_i0_bp_fghr          = Input(UInt(pt1.BHT_GHR_SIZE.W))     // BP FGHR
//  val ifu_i0_bp_btag          = Input(UInt(pt1.BTB_BTAG_SIZE.W))    // BP tag
//
//  val lsu_error_pkt_r               = Input(new el2_lsu_error_pkt_t) // LSU exception/error packet
//  val lsu_single_ecc_error_incr     = Input(Bool())// LSU inc SB error counter
//
//  val lsu_imprecise_error_load_any  = Input(Bool())  // LSU imprecise load bus error
//  val lsu_imprecise_error_store_any = Input(Bool())  // LSU imprecise store bus error
//  val lsu_imprecise_error_addr_any  = Input(UInt(32.W))                // LSU imprecise bus error address
//
//  val exu_div_result                = Input(UInt(32.W))    // final div result
//  val exu_div_wren                  = Input(UInt(32.W))    // Divide write enable to GPR
//                                    = Input(UInt(32.W))
//  val exu_csr_rs1_x                 = Input(UInt(32.W))     // rs1 for csr instruction
//                                    = Input(UInt(32.W))
//  val lsu_result_m                  = Input(UInt(32.W))     // load result
//  val lsu_result_corr_r             = Input(UInt(32.W))     // load result - corrected load data
//
//  val lsu_load_stall_any            = Input(Bool())            // This is for blocking loads
//  val lsu_store_stall_any           = Input(Bool())            // This is for blocking stores
//  val dma_dccm_stall_any            = Input(Bool())            // stall any load/store at decode, pmu event
//  val dma_iccm_stall_any            = Input(Bool())            // iccm stalled, pmu event
//                                    = Input(Bool())
//  val iccm_dma_sb_error             = Input(Bool())            // ICCM DMA single bit error
//
//  val exu_flush_final               = Input(Bool())             // slot0 flush
//
//  val exu_npc_r                     = Input(UInt(32.W))            // next PC
//
//  val exu_i0_result_x               = Input(UInt(32.W))     // alu result x
//
//
//  val ifu_i0_valid             = Input(Bool())         // fetch valids to instruction buffer
//  val ifu_i0_instr             = Input(UInt(32.W))     // fetch inst's to instruction buffer
//  val ifu_i0_pc                = Input(UInt(32.W))     // pc's for instruction buffer
//  val ifu_i0_pc4               = Input(Bool())         // indication of 4B or 2B for corresponding inst
//  val exu_i0_pc_x              = Input(UInt(32.W))     // pc's for e1 from the alu's
//
//  val mexintpend                = Input(Bool())        // External interrupt pending
//  val timer_int                 = Input(Bool())        // Timer interrupt pending (from pin)
//  val soft_int                  = Input(Bool())        // Software interrupt pending (from pin)
//
//  val pic_claimid               = Input(UInt(8.W))      // PIC claimid
//  val pic_pl                    = Input(UInt(4.W))      // PIC priv level
//  val mhwakeup                  = Input(Bool())      // High priority wakeup
//
//  val dec_tlu_meicurpl          = Output(UInt(4.W))     // to PIC, Current priv level
//  val dec_tlu_meipt             = Output(UInt(4.W))     // to PIC
//
//  val ifu_ic_debug_rd_data           = Input(UInt(70.W))          // diagnostic icache read data
//  val ifu_ic_debug_rd_data_valid     = Input(Bool())          // diagnostic icache read data valid
//  val dec_tlu_ic_diag_pkt            = Input(new el2_cache_debug_pkt_t)          // packet of DICAWICS, DICAD0/1, DICAGO info for icache diagnostics
//
//
//  // Debug start
//  val dbg_halt_req         = Input(Bool())        // DM requests a halt
//  val dbg_resume_req       = Input(Bool())        // DM requests a resume
//  val ifu_miss_state_idle  = Input(Bool())        // I-side miss buffer empty
//
//  val dec_tlu_dbg_halted        = Output(Bool())       // Core is halted and ready for debug command
//  val dec_tlu_debug_mode        = Output(Bool())       // Core is in debug mode
//  val dec_tlu_resume_ack        = Output(Bool())       // Resume acknowledge
//  val dec_tlu_flush_noredir_r   = Output(Bool())       // Tell fetch to idle on this flush
//  val dec_tlu_mpc_halted_only   = Output(Bool())       // Core is halted only due to MPC
//  val dec_tlu_flush_leak_one_r  = Output(Bool())       // single step
//  val dec_tlu_flush_err_r       = Output(Bool())       // iside perr/ecc rfpc
//  val dec_tlu_meihap            = Output(UInt(32.W))       // Fast ext int base
//
//  val dec_debug_wdata_rs1_d     = Output(Bool())      // insert debug write data into rs1 at decode
//
//  val dec_dbg_rddata            = Output(UInt(32.W))       // debug command read data
//
//  val dec_dbg_cmd_done          = Output(Bool())      // abstract command is done
//  val dec_dbg_cmd_fail          = Output(Bool())      // abstract command failed (illegal reg address)
//
//  val trigger_pkt_any           = Output(4,Vec(new el2_trigger_pkt_t))  // info needed by debug trigger blocks
//
//  val dec_tlu_force_halt        = Output(Bool())        // halt has been forced
//  // Debug end
//  // branch info from pipe0 for errors or counter updates
//  val exu_i0_br_hist_r           = Input(UInt(2.W))          // history
//  val exu_i0_br_error_r          = Input(Bool())          // error
//  val exu_i0_br_start_error_r    = Input(Bool())          // start error
//  val exu_i0_br_valid_r          = Input(Bool())          // valid
//  val exu_i0_br_mp_r             = Input(Bool())          // mispredict
//  val exu_i0_br_middle_r         = Input(Bool())          // middle of bank
//
//  val exu_i0_br_way_r            = Input(Bool())           // way hit or repl
//
//  val dec_i0_rs1_en_d            = Output(Bool()) // Qualify GPR RS1 data
//  val dec_i0_rs2_en_d            = Output(Bool()) // Qualify GPR RS2 data
//  val gpr_i0_rs1_d               = Output(UInt(32.W)) // gpr rs1 data
//  val gpr_i0_rs2_d               = Output(UInt(32.W)) // gpr rs2 data
//
//  val dec_i0_immed_d             = Output(UInt(32.W)) // immediate data
//  val dec_i0_br_immed_d          = Output(UInt(13.W)) // br immediate data
//
//  val i0_ap                      = Output(new el2_alu_pkt_t)// alu packet
//
//  val dec_i0_alu_decode_d       = Input(Bool())   // schedule on D-stage alu
//
//  val dec_i0_select_pc_d        = Input(Bool())   // select pc onto rs1 for jal's
//
//  val dec_i0_pc_d               = Output(UInt(32.W)) // pc's at decode
//  val dec_i0_rs1_bypass_en_d    = Output(UInt(2.W)) // rs1 bypass enable
//  val dec_i0_rs2_bypass_en_d    = Output(UInt(2.W)) // rs2 bypass enable
//
//  val dec_i0_rs1_bypass_data_d  = Output(UInt(32.W)) // rs1 bypass data
//  val dec_i0_rs2_bypass_data_d  = Output(UInt(32.W)) // rs2 bypass data
//
//  val lsu_p                     = Output(new el2_lsu_pkt_t) // lsu packet
//  val mul_p                     = Output(new el2_mul_pkt_t) // mul packet
//  val div_p                     = Output(new el2_div_pkt_t) // div packet
//  val dec_div_cancel            = Output(Bool()) // cancel divide operation
//
//  val dec_lsu_offset_d          = Output(UInt(12.W)) // 12b offset for load/store addresses
//
//  val dec_csr_ren_d             = Output(Bool()) // csr read enable
//
//
//  val dec_tlu_flush_lower_r     = Output(Bool())   // tlu flush due to late mp, exception, rfpc, or int
//  val dec_tlu_flush_path_r      = Output(UInt(32.W))   // tlu flush target
//  val dec_tlu_i0_kill_writeb_r  = Output(Bool())   // I0 is flushed, don't writeback any results to arch state
//  val dec_tlu_fence_i_r         = Output(Bool())   // flush is a fence_i rfnpc, flush icache
//
//  val pred_correct_npc_x  = Output(UInt(32.W))       // npc if prediction is correct at e2 stage
//
//  val dec_tlu_br0_r_pkt  = Output(new el2_br_tlu_pkt_t)    // slot 0 branch predictor update packet
//
//  val dec_tlu_perfcnt0   = Output(Bool())      // toggles when slot0 perf counter 0 has an event inc
//  val dec_tlu_perfcnt1   = Output(Bool())      // toggles when slot0 perf counter 1 has an event inc
//  val dec_tlu_perfcnt2   = Output(Bool())      // toggles when slot0 perf counter 2 has an event inc
//  val dec_tlu_perfcnt3   = Output(Bool())      // toggles when slot0 perf counter 3 has an event inc
//
//  val dec_i0_predict_p_d = Output(new el2_predict_pkt_t)      // prediction packet to alus
//  val i0_predict_fghr_d  = Output(UInt(pt1.BHT_GHR_SIZE.W))   // DEC predict fghr
//  val i0_predict_index_d = Output(UInt(pt1.BHT_ADDR_HI.W))   // DEC predict index
//  val i0_predict_btag_d  = Output(UInt(pt1.BTB_BTAG_SIZE.W))   // DEC predict branch tag
//
//  val dec_lsu_valid_raw_d = Output(Bool())
//
//  val dec_tlu_mrac_ff  = Output(UInt(32.W))          // CSR for memory region control
//
//  val dec_data_en      = Output(UInt(2.W))             // clock-gate control logic
//  val dec_ctl_en       = Output(UInt(2.W))
//
//  val ifu_i0_cinst     = Input(UInt(16.W))             // 16b compressed instruction
//
//  val rv_trace_pkt     = Output(new el2_trace_pkt_t)        // trace packet
//
//  // feature disable from mfdc
//  val dec_tlu_external_ldfwd_disable     = Output(Bool())       // disable external load forwarding
//  val dec_tlu_sideeffect_posted_disable  = Output(Bool())       // disable posted stores to side-effect address
//  val dec_tlu_core_ecc_disable           = Output(Bool())       // disable core ECC
//  val dec_tlu_bpred_disable              = Output(Bool())       // disable branch prediction
//  val dec_tlu_wb_coalescing_disable      = Output(Bool())       // disable writebuffer coalescing
//  val dec_tlu_dma_qos_prty               = Output(UInt(3.W))       // DMA QoS priority coming from MFDC [18:16]
//
//  // clock gating overrides from mcgc
//  val dec_tlu_misc_clk_override   = Output(Bool())       // override misc clock domain gating
//  val dec_tlu_ifu_clk_override    = Output(Bool())       // override fetch clock domain gating
//  val dec_tlu_lsu_clk_override    = Output(Bool())       // override load/store clock domain gating
//  val dec_tlu_bus_clk_override    = Output(Bool())       // override bus clock domain gating
//  val dec_tlu_pic_clk_override    = Output(Bool())       // override PIC clock domain gating
//  val dec_tlu_dccm_clk_override   = Output(Bool())       // override DCCM clock domain gating
//  val dec_tlu_icm_clk_override    = Output(Bool())       // override ICCM clock domain gating
//
//  val dec_tlu_i0_commit_cmt       = Output(Bool())          // committed i0 instruction
//  val scan_mode                   = Input(Bool())
//
//}
//
//class el2_dec extends Module with param{
//  val io = IO(new el2_dec_IO)
////  logic  dec_tlu_dec_clk_override; // to and from dec blocks
////  logic  clk_override;
////
////  logic               dec_ib0_valid_d;
////
////  logic               dec_pmu_instr_decoded;
////  logic               dec_pmu_decode_stall;
////  logic               dec_pmu_presync_stall;
////  logic               dec_pmu_postsync_stall;
////
////  logic dec_tlu_wr_pause_r;           // CSR write to pause reg is at R.
////
//    val dec_i0_rs1_d = Wire(UInt(5.W))
//    val dec_i0_rs2_d = Wire(UInt(5.W))
////
////  logic [31:0] dec_i0_instr_d;
////
////  logic  dec_tlu_pipelining_disable;
////
////
////  logic [4:0]  dec_i0_waddr_r;
////  logic        dec_i0_wen_r;
//    val dec_i0_wdata_r = Wire(UInt(32.W))
////  logic        dec_csr_wen_r;      // csr write enable at wb
////  logic [11:0] dec_csr_wraddr_r;      // write address for csryes
////  logic [31:0] dec_csr_wrdata_r;    // csr write data at wb
////
////  logic [11:0] dec_csr_rdaddr_d;      // read address for csr
////  logic [31:0] dec_csr_rddata_d;    // csr read data at wb
////  logic        dec_csr_legal_d;            // csr indicates legal operation
////
////  logic        dec_csr_wen_unq_d;       // valid csr with write - for csr legal
////  logic        dec_csr_any_unq_d;       // valid csr - for csr legal
////  logic        dec_csr_stall_int_ff;    // csr is mie/mstatus
////
////  el2_trap_pkt_t dec_tlu_packet_r;
////
////  logic        dec_i0_pc4_d;
////  logic        dec_tlu_presync_d;
////  logic        dec_tlu_postsync_d;
////  logic        dec_tlu_debug_stall;
////
////  logic [31:0] dec_illegal_inst;
////
////  logic                      dec_i0_icaf_d;
////
////  logic                      dec_i0_dbecc_d;
////  logic                      dec_i0_icaf_f1_d;
////  logic [3:0]                dec_i0_trigger_match_d;
////  logic                      dec_debug_fence_d;
////  logic                      dec_nonblock_load_wen;
////  logic [4:0]                dec_nonblock_load_waddr;
////  logic                      dec_tlu_flush_pause_r;
////  el2_br_pkt_t                   dec_i0_brp;
////  logic [pt.BTB_ADDR_HI:pt.BTB_ADDR_LO] dec_i0_bp_index;
////  logic [pt.BHT_GHR_SIZE-1:0] dec_i0_bp_fghr;
////  logic [pt.BTB_BTAG_SIZE-1:0] dec_i0_bp_btag;
////
////  logic [31:1]               dec_tlu_i0_pc_r;
////  logic                      dec_tlu_i0_kill_writeb_wb;
////  logic                      dec_tlu_flush_lower_wb;
////  logic                      dec_tlu_i0_valid_r;
////
////  logic                      dec_pause_state;
////
////  logic [1:0]                dec_i0_icaf_type_d; // i0 instruction access fault type
////
////  logic                      dec_tlu_flush_extint; // Fast ext int started
////
////  logic [31:0]               dec_i0_inst_wb1;
////  logic [31:1]               dec_i0_pc_wb1;
////  logic                      dec_tlu_i0_valid_wb1,  dec_tlu_int_valid_wb1;
////  logic [4:0]                dec_tlu_exc_cause_wb1;
////  logic [31:0]               dec_tlu_mtval_wb1;
////  logic                      dec_tlu_i0_exc_valid_wb1;
////
////  logic [4:0]                div_waddr_wb;
////
////  logic                      dec_div_active;              // non-block divide is active
//  val clk_override = Wire(Bool())
//  val dec_tlu_dec_clk_override = Wire(Bool())
//  clk_override:= dec_tlu_dec_clk_override
//  io.dec_dbg_rddata := dec_i0_wdata_r
//
//  val instbuff = Module(new el2_dec_ib_ctl)
//  instbuff.io <> io
//
//  val decode = Module(new el2_dec_decode_ctl)
//  decode.io <> io
//
//  val gpr = Module(new el2_dec_gpr_ctl)
//  gpr.io <> io
//  //inputs
//  gpr.io.raddr0 := dec_i0_rs1_d
//  gpr.io.raddr1 := dec_i0_rs2_d
//  gpr.io.wen0   := dec_i0_wen_r
//  gpr.io.waddr0   := dec_i0_waddr_r
//  gpr.io.wd0   := dec_i0_wdata_r
//  gpr.io.wen1   := dec_nonblock_load_wen
//  gpr.io.waddr1   := dec_nonblock_load_waddr
//  gpr.io.wd1   := lsu_nonblock_load_data
//  gpr.io.wen2   := exu_div_wren
//  gpr.io.waddr2   := div_waddr_wb
//  gpr.io.wd2   := exu_div_result
//  // outputs
//  gpr_i0_rs1_d := gpr.io.rd0
//  gpr_i0_rs2_d := gpr.io.rd1
//
//  val tlu = Module(new el2_dec_tlu_ctl)
//  tlu.io <>
//
//  val dec_trigger = Module(new el2_dec_trigger)
//  dec_trigger.io <> io
//
//}
