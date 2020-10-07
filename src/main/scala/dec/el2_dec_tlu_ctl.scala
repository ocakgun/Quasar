package dec
import chisel3._
import chisel3.util._
import lib._
import include._

class el2_dec_tlu_ctl extends Module with el2_lib {
  val io = IO(new Bundle{
    //val clk         = Input(Clock())
    val active_clk  = Input(Clock())
    val free_clk    = Input(Clock())
    //val rst_l       = Input(Bool())
    val scan_mode   = Input(Bool())

    val        rst_vec         = Input(UInt(32.W))    // reset vector, from core pins
    val        nmi_int         = Input(UInt(1.W))    // nmi pin
    val        nmi_vec         = Input(UInt(32.W))    // nmi vector
    val  i_cpu_halt_req        = Input(UInt(1.W))        // Asynchronous Halt request to CPU
    val  i_cpu_run_req         = Input(UInt(1.W))        // Asynchronous Restart request to CPU

    val lsu_fastint_stall_any  = Input(UInt(1.W))   // needed by lsu for 2nd pass of dma with ecc correction, stall next cycle


    // perf counter inputs
    val       ifu_pmu_instr_aligned   = Input(UInt(1.W))// aligned instructions
    val       ifu_pmu_fetch_stall     = Input(UInt(1.W))// fetch unit stalled
    val       ifu_pmu_ic_miss         = Input(UInt(1.W))// icache miss
    val       ifu_pmu_ic_hit          = Input(UInt(1.W))// icache hit
    val       ifu_pmu_bus_error       = Input(UInt(1.W))// Instruction side bus error
    val       ifu_pmu_bus_busy        = Input(UInt(1.W))// Instruction side bus busy
    val       ifu_pmu_bus_trxn        = Input(UInt(1.W))// Instruction side bus transaction
    val       dec_pmu_instr_decoded   = Input(UInt(1.W))// decoded instructions
    val       dec_pmu_decode_stall    = Input(UInt(1.W))// decode stall
    val       dec_pmu_presync_stall   = Input(UInt(1.W))// decode stall due to presync'd inst
    val       dec_pmu_postsync_stall  = Input(UInt(1.W))// decode stall due to postsync'd inst
    val       lsu_store_stall_any     = Input(UInt(1.W))// SB or WB is full, stall decode
    val       dma_dccm_stall_any      = Input(UInt(1.W))// DMA stall of lsu
    val       dma_iccm_stall_any      = Input(UInt(1.W))// DMA stall of ifu
    val       exu_pmu_i0_br_misp      = Input(UInt(1.W))// pipe 0 branch misp
    val       exu_pmu_i0_br_ataken    = Input(UInt(1.W))// pipe 0 branch actual taken
    val       exu_pmu_i0_pc4          = Input(UInt(1.W))// pipe 0 4 byte branch
    val       lsu_pmu_bus_trxn        = Input(UInt(1.W))// D side bus transaction
    val       lsu_pmu_bus_misaligned  = Input(UInt(1.W)) // D side bus misaligned
    val       lsu_pmu_bus_error       = Input(UInt(1.W)) // D side bus error
    val       lsu_pmu_bus_busy        = Input(UInt(1.W)) // D side bus busy
    val       lsu_pmu_load_external_m = Input(UInt(1.W))  // D side bus load
    val       lsu_pmu_store_external_m= Input(UInt(1.W))  // D side bus store
    val       dma_pmu_dccm_read       = Input(UInt(1.W))   // DMA DCCM read
    val       dma_pmu_dccm_write      = Input(UInt(1.W))   // DMA DCCM write
    val       dma_pmu_any_read        = Input(UInt(1.W))   // DMA read
    val       dma_pmu_any_write       = Input(UInt(1.W))   // DMA write

    val     lsu_fir_addr           = Input(UInt(32.W)) // Fast int address
    val     lsu_fir_error           = Input(UInt(2.W)) // Fast int lookup error

    val     iccm_dma_sb_error  = Input(UInt(1.W))      // I side dma single bit error

    val     lsu_error_pkt_r  = Input(new el2_lsu_error_pkt_t)// lsu precise exception/error packet
    val     lsu_single_ecc_error_incr = Input(UInt(1.W)) // LSU inc SB error counter

    val         dec_pause_state = Input(UInt(1.W)) // Pause counter not zero
    val         lsu_imprecise_error_store_any = Input(UInt(1.W))      // store bus error
    val         lsu_imprecise_error_load_any = Input(UInt(1.W))      // store bus error
    val         lsu_imprecise_error_addr_any = Input(UInt(32.W)) // store bus error address

    val        dec_csr_wen_unq_d = Input(UInt(1.W))       // valid csr with write - for csr legal
    val        dec_csr_any_unq_d = Input(UInt(1.W))       // valid csr - for csr legal
    val        dec_csr_rdaddr_d = Input(UInt(12.W))      // read address for csr

    val        dec_csr_wen_r = Input(UInt(1.W))      // csr write enable at wb
    val        dec_csr_wraddr_r = Input(UInt(12.W))      // write address for csr
    val        dec_csr_wrdata_r = Input(UInt(32.W))   // csr write data at wb

    val        dec_csr_stall_int_ff = Input(UInt(1.W)) // csr is mie/mstatus

    val       dec_tlu_i0_valid_r = Input(UInt(1.W)) // pipe 0 op at e4 is valid

    val       exu_npc_r = Input(UInt(32.W)) // for NPC tracking

    val       dec_tlu_i0_pc_r = Input(UInt(32.W)) // for PC/NPC tracking

    val  dec_tlu_packet_r = Input(new el2_trap_pkt_t) // exceptions known at decode

    val        dec_illegal_inst = Input(UInt(32.W)) // For mtval
    val        dec_i0_decode_d = Input(UInt(1.W))  // decode valid, used for clean icache diagnostics

    // branch info from pipe0 for errors or counter updates
    val         exu_i0_br_hist_r  = Input(UInt(2.W)) // history
    val        exu_i0_br_error_r = Input(UInt(1.W)) // error
    val        exu_i0_br_start_error_r = Input(UInt(1.W)) // start error
    val        exu_i0_br_valid_r = Input(UInt(1.W)) // valid
    val        exu_i0_br_mp_r = Input(UInt(1.W)) // mispredict
    val        exu_i0_br_middle_r = Input(UInt(1.W)) // middle of bank

    // branch info from pipe1 for errors or counter updates

    val             exu_i0_br_way_r = Input(UInt(1.W))// way hit or repl

    // Debug start
    val dec_dbg_cmd_done      = Output(UInt(1.W)) // abstract command done
    val dec_dbg_cmd_fail      = Output(UInt(1.W)) // abstract command failed
    val dec_tlu_dbg_halted    = Output(UInt(1.W)) // Core is halted and ready for debug command
    val dec_tlu_debug_mode    = Output(UInt(1.W)) // Core is in debug mode
    val dec_tlu_resume_ack    = Output(UInt(1.W)) // Resume acknowledge
    val dec_tlu_debug_stall    = Output(UInt(1.W)) // stall decode while waiting on core to empty

    val dec_tlu_flush_noredir_r     = Output(UInt(1.W)) // Tell fetch to idle on this flush
    val dec_tlu_mpc_halted_only     = Output(UInt(1.W)) // Core is halted only due to MPC
    val dec_tlu_flush_leak_one_r    = Output(UInt(1.W)) // single step
    val dec_tlu_flush_err_r         = Output(UInt(1.W)) // iside perr/ecc rfpc. This is the D stage of the error

    val dec_tlu_flush_extint        = Output(UInt(1.W)) // fast ext int started
    val dec_tlu_meihap              = Output(UInt(32.W)) // meihap for fast int

    val dbg_halt_req = Input(UInt(1.W)) // DM requests a halt
    val dbg_resume_req = Input(UInt(1.W)) // DM requests a resume
    val ifu_miss_state_idle = Input(UInt(1.W)) // I-side miss buffer empty
    val lsu_idle_any = Input(UInt(1.W)) // lsu is idle
    val dec_div_active = Input(UInt(1.W)) // oop div is active
    val trigger_pkt_any             = Output(Vec(4,new el2_trigger_pkt_t))// trigger info for trigger blocks

    val  ifu_ic_error_start = Input(UInt(1.W))     // IC single bit error
    val  ifu_iccm_rd_ecc_single_err = Input(UInt(1.W)) // ICCM single bit error


    val ifu_ic_debug_rd_data = Input(UInt(71.W)) // diagnostic icache read data
    val ifu_ic_debug_rd_data_valid = Input(UInt(1.W)) // diagnostic icache read data valid
    val dec_tlu_ic_diag_pkt         = Output(new el2_cache_debug_pkt_t) // packet of DICAWICS, DICAD0/1, DICAGO info for icache diagnostics
    // Debug end

    val pic_claimid  = Input(UInt(8.W)) // pic claimid for csr
    val pic_pl = Input(UInt(4.W)) // pic priv level for csr
    val       mhwakeup = Input(UInt(1.W)) // high priority external int, wakeup if halted

    val mexintpend= Input(UInt(1.W)) // external interrupt pending
    val timer_int= Input(UInt(1.W)) // timer interrupt pending
    val soft_int= Input(UInt(1.W)) // software interrupt pending

    val o_cpu_halt_status     = Output(UInt(1.W)) // PMU interface, halted
    val o_cpu_halt_ack        = Output(UInt(1.W)) // halt req ack
    val o_cpu_run_ack         = Output(UInt(1.W)) // run req ack
    val o_debug_mode_status   = Output(UInt(1.W)) // Core to the PMU that core is in debug mode. When core is in debug mode, the PMU should refrain from sendng a halt or run request

    val core_id = Input(UInt(32.W)) // Core ID

    // external MPC halt/run interface
    val mpc_debug_halt_req  = Input(UInt(1.W))  // Async halt request
    val mpc_debug_run_req = Input(UInt(1.W)) // Async run request
    val mpc_reset_run_req = Input(UInt(1.W)) // Run/halt after reset
    val mpc_debug_halt_ack          = Output(UInt(1.W)) // Halt ack
    val mpc_debug_run_ack           = Output(UInt(1.W)) // Run ack
    val debug_brkpt_status          = Output(UInt(1.W)) // debug breakpoint
    val dec_tlu_meicurpl            = Output(UInt(4.W)) // to PIC
    val  dec_tlu_meipt              = Output(UInt(4.W)) // to PIC
    val  dec_csr_rddata_d           = Output(UInt(32.W))      // csr read data at wb
    val dec_csr_legal_d             = Output(UInt(1.W))              // csr indicates legal operation
    val dec_tlu_br0_r_pkt           = Output(new el2_br_tlu_pkt_t) // branch pkt to bp
    val dec_tlu_i0_kill_writeb_wb   = Output(UInt(1.W))    // I0 is flushed, don't writeback any results to arch state
    val dec_tlu_flush_lower_wb      = Output(UInt(1.W))       // commit has a flush (exception, int, mispredict at e4)
    val dec_tlu_i0_commit_cmt       = Output(UInt(1.W))        // committed an instruction
    val dec_tlu_i0_kill_writeb_r    = Output(UInt(1.W))    // I0 is flushed, don't writeback any results to arch state
    val dec_tlu_flush_lower_r       = Output(UInt(1.W))       // commit has a flush (exception, int)
    val dec_tlu_flush_path_r        = Output(UInt(32.W)) // flush pc
    val dec_tlu_fence_i_r           = Output(UInt(1.W))           // flush is a fence_i rfnpc, flush icache
    val dec_tlu_wr_pause_r          = Output(UInt(1.W))           // CSR write to pause reg is at R.
    val dec_tlu_flush_pause_r       = Output(UInt(1.W))        // Flush is due to pause
    val dec_tlu_presync_d           = Output(UInt(1.W))            // CSR read needs to be presync'd
    val dec_tlu_postsync_d          = Output(UInt(1.W))           // CSR needs to be presync'd
    val dec_tlu_mrac_ff             = Output(UInt(32.W))        // CSR for memory region control
    val dec_tlu_force_halt          = Output(UInt(1.W)) // halt has been forced
    val dec_tlu_perfcnt0            = Output(UInt(1.W)) // toggles when pipe0 perf counter 0 has an event inc
    val dec_tlu_perfcnt1            = Output(UInt(1.W)) // toggles when pipe0 perf counter 1 has an event inc
    val dec_tlu_perfcnt2            = Output(UInt(1.W)) // toggles when pipe0 perf counter 2 has an event inc
    val dec_tlu_perfcnt3            = Output(UInt(1.W)) // toggles when pipe0 perf counter 3 has an event inc
    val dec_tlu_i0_exc_valid_wb1    = Output(UInt(1.W)) // pipe 0 exception valid
    val dec_tlu_i0_valid_wb1        = Output(UInt(1.W))  // pipe 0 valid
    val dec_tlu_int_valid_wb1       = Output(UInt(1.W)) // pipe 2 int valid
    val dec_tlu_exc_cause_wb1       = Output(UInt(5.W)) // exception or int cause
    val dec_tlu_mtval_wb1           = Output(UInt(32.W)) // MTVAL value

    // feature disable from mfdc
    val  dec_tlu_external_ldfwd_disable     = Output(UInt(1.W)) // disable external load forwarding
    val  dec_tlu_sideeffect_posted_disable  = Output(UInt(1.W))  // disable posted stores to side-effect address
    val  dec_tlu_core_ecc_disable           = Output(UInt(1.W)) // disable core ECC
    val  dec_tlu_bpred_disable              = Output(UInt(1.W))           // disable branch prediction
    val  dec_tlu_wb_coalescing_disable      = Output(UInt(1.W))   // disable writebuffer coalescing
    val  dec_tlu_pipelining_disable         = Output(UInt(1.W))      // disable pipelining
    val   dec_tlu_dma_qos_prty              = Output(UInt(3.W))    // DMA QoS priority coming from MFDC [18:16]

    // clock gating overrides from mcgc
    val  dec_tlu_misc_clk_override  = Output(UInt(1.W)) // override misc clock domain gating
    val  dec_tlu_dec_clk_override   = Output(UInt(1.W)) // override decode clock domain gating
    val  dec_tlu_ifu_clk_override   = Output(UInt(1.W)) // override fetch clock domain gating
    val  dec_tlu_lsu_clk_override   = Output(UInt(1.W)) // override load/store clock domain gating
    val  dec_tlu_bus_clk_override   = Output(UInt(1.W)) // override bus clock domain gating
    val  dec_tlu_pic_clk_override   = Output(UInt(1.W)) // override PIC clock domain gating
    val  dec_tlu_dccm_clk_override  = Output(UInt(1.W)) // override DCCM clock domain gating
    val  dec_tlu_icm_clk_override   = Output(UInt(1.W)) // override ICCM clock domain gating


  })
  io.trigger_pkt_any(0).select  :=  0.U
  io.trigger_pkt_any(0).match_  :=  0.U
  io.trigger_pkt_any(0).store    := 0.U
  io.trigger_pkt_any(0).load     := 0.U
  io.trigger_pkt_any(0).execute  := 0.U
  io.trigger_pkt_any(0).m        := 0.U
  io.trigger_pkt_any(0).tdata2   := 0.U

  io.trigger_pkt_any(1).select  :=  0.U
  io.trigger_pkt_any(1).match_  :=  0.U
  io.trigger_pkt_any(1).store    := 0.U
  io.trigger_pkt_any(1).load     := 0.U
  io.trigger_pkt_any(1).execute  := 0.U
  io.trigger_pkt_any(1).m        := 0.U
  io.trigger_pkt_any(1).tdata2   := 0.U

  io.trigger_pkt_any(2).select  :=  0.U
  io.trigger_pkt_any(2).match_  :=  0.U
  io.trigger_pkt_any(2).store    := 0.U
  io.trigger_pkt_any(2).load     := 0.U
  io.trigger_pkt_any(2).execute  := 0.U
  io.trigger_pkt_any(2).m        := 0.U
  io.trigger_pkt_any(2).tdata2   := 0.U

  io.trigger_pkt_any(3).select  :=  0.U
  io.trigger_pkt_any(3).match_  :=  0.U
  io.trigger_pkt_any(3).store    := 0.U
  io.trigger_pkt_any(3).load     := 0.U
  io.trigger_pkt_any(3).execute  := 0.U
  io.trigger_pkt_any(3).m        := 0.U
  io.trigger_pkt_any(3).tdata2   := 0.U

  io.dec_tlu_ic_diag_pkt.icache_wrdata   := 0.U
  io.dec_tlu_ic_diag_pkt.icache_dicawics := 0.U
  io.dec_tlu_ic_diag_pkt.icache_rd_valid := 0.U
  io.dec_tlu_ic_diag_pkt.icache_wr_valid := 0.U
  io.dec_tlu_br0_r_pkt.valid         :=0.U
  io.dec_tlu_br0_r_pkt.hist          :=0.U
  io.dec_tlu_br0_r_pkt.br_error      :=0.U
  io.dec_tlu_br0_r_pkt.br_start_error:=0.U
  io.dec_tlu_br0_r_pkt.way           :=0.U
  io.dec_tlu_br0_r_pkt.middle        :=0.U

    io.dec_dbg_cmd_done        :=0.U
    io.dec_dbg_cmd_fail        :=0.U
    io.dec_tlu_dbg_halted      :=0.U
    io.dec_tlu_debug_mode      :=0.U
    io.dec_tlu_resume_ack      :=0.U
    io.dec_tlu_debug_stall     :=0.U
    io.dec_tlu_flush_noredir_r :=0.U
    io.dec_tlu_mpc_halted_only :=0.U
    io.dec_tlu_flush_leak_one_r:=0.U
    io.dec_tlu_flush_err_r     :=0.U
    io.dec_tlu_flush_extint    :=0.U
    io.dec_tlu_meihap          :=0.U
    io.o_cpu_halt_status        :=0.U
    io.o_cpu_halt_ack           :=0.U
    io.o_cpu_run_ack            :=0.U
    io.o_debug_mode_status      :=0.U
  io.mpc_debug_halt_ack       :=0.U
  io.mpc_debug_run_ack        :=0.U
  io.debug_brkpt_status       :=0.U
  io.dec_tlu_meicurpl         :=0.U
  io.dec_tlu_meipt            :=0.U
  io.dec_csr_rddata_d         :=0.U
  io.dec_csr_legal_d          :=0.U
  //dec_tlu_br0_r_pkt      :=0.U
  io.dec_tlu_i0_kill_writeb_wb :=0.U
  io.dec_tlu_flush_lower_wb   :=0.U
  io.dec_tlu_i0_commit_cmt    :=0.U
  io.dec_tlu_i0_kill_writeb_r :=0.U
  io.dec_tlu_flush_lower_r    :=0.U
  io.dec_tlu_flush_path_r     :=0.U
  io.dec_tlu_fence_i_r        :=0.U
  io.dec_tlu_wr_pause_r       :=0.U
  io.dec_tlu_flush_pause_r    :=0.U
  io.dec_tlu_presync_d        :=0.U
  io.dec_tlu_postsync_d       :=0.U
  io.dec_tlu_mrac_ff          :=0.U
  io.dec_tlu_force_halt       :=0.U
  io.dec_tlu_perfcnt0         :=0.U
  io.dec_tlu_perfcnt1         :=0.U
  io.dec_tlu_perfcnt2         :=0.U
  io.dec_tlu_perfcnt3         :=0.U
  io.dec_tlu_i0_exc_valid_wb1 :=0.U
  io.dec_tlu_i0_valid_wb1     :=0.U
  io.dec_tlu_int_valid_wb1    :=0.U
  io.dec_tlu_exc_cause_wb1    :=0.U
  io.dec_tlu_mtval_wb1        :=0.U
  io.dec_tlu_external_ldfwd_disable  :=0.U
  io.dec_tlu_sideeffect_posted_disable  :=0.U
  io.dec_tlu_core_ecc_disable       :=0.U
  io.dec_tlu_bpred_disable          :=0.U
  io.dec_tlu_wb_coalescing_disable  :=0.U
  io.dec_tlu_pipelining_disable     :=0.U
  io.dec_tlu_dma_qos_prty           :=0.U
  io.dec_tlu_misc_clk_override      :=0.U
  io.dec_tlu_dec_clk_override       :=0.U
  io.dec_tlu_ifu_clk_override       :=0.U
  io.dec_tlu_lsu_clk_override       :=0.U
  io.dec_tlu_bus_clk_override       :=0.U
  io.dec_tlu_pic_clk_override       :=0.U
  io.dec_tlu_dccm_clk_override      :=0.U
  io.dec_tlu_icm_clk_override       :=0.U

}
object dec_tlu extends App {
  chisel3.Driver.execute(args,() => new el2_dec_tlu_ctl())
}

