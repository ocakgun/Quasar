package lib
import chisel3._
import chisel3.util._
trait param {
  val BHT_ADDR_HI            = 	0x9
  val BHT_ADDR_LO            = 	0x2
  val BHT_ARRAY_DEPTH        = 	0x100
  val BHT_GHR_HASH_1         = 	0x0
  val BHT_GHR_SIZE           = 	0x8
  val BHT_SIZE               = 	0x200
  val BTB_ADDR_HI            = 	0x09
  val BTB_ADDR_LO            = 	0x2
  val BTB_ARRAY_DEPTH        = 	0x100
  val BTB_BTAG_FOLD          = 	0x0
  val BTB_BTAG_SIZE          = 	0x5
  val BTB_FOLD2_INDEX_HASH   = 	0x0
  val BTB_INDEX1_HI          = 	0x09
  val BTB_INDEX1_LO          = 	0x02
  val BTB_INDEX2_HI          = 	0x11
  val BTB_INDEX2_LO          = 	0x0A
  val BTB_INDEX3_HI          = 	0x19
  val BTB_INDEX3_LO          = 	0x12
  val BTB_SIZE               = 	0x200
  val BUILD_AHB_LITE         = 	0x0
  val BUILD_AXI4             = 	0x1
  val BUILD_AXI_NATIVE       = 	0x1
  val BUS_PRTY_DEFAULT       = 	0x3
  val DATA_ACCESS_ADDR0      = 	0x00000000
  val DATA_ACCESS_ADDR1      = 	0xC0000000
  val DATA_ACCESS_ADDR2      = 	0xA0000000
  val DATA_ACCESS_ADDR3      = 	0x80000000
  val DATA_ACCESS_ADDR4      = 	0x00000000
  val DATA_ACCESS_ADDR5      = 	0x00000000
  val DATA_ACCESS_ADDR6      = 	0x00000000
  val DATA_ACCESS_ADDR7      = 	0x00000000
  val DATA_ACCESS_ENABLE0    = 	0x1
  val DATA_ACCESS_ENABLE1    = 	0x1
  val DATA_ACCESS_ENABLE2    = 	0x1
  val DATA_ACCESS_ENABLE3    = 	0x1
  val DATA_ACCESS_ENABLE4    = 	0x0
  val DATA_ACCESS_ENABLE5    = 	0x0
  val DATA_ACCESS_ENABLE6    = 	0x0
  val DATA_ACCESS_ENABLE7    = 	0x0
  val DATA_ACCESS_MASK0      = 	0x7FFFFFFF
  val DATA_ACCESS_MASK1      = 	0x3FFFFFFF
  val DATA_ACCESS_MASK2      = 	0x1FFFFFFF
  val DATA_ACCESS_MASK3      = 	0x0FFFFFFF
  val DATA_ACCESS_MASK4      = 	0xFFFFFFFF
  val DATA_ACCESS_MASK5      = 	0xFFFFFFFF
  val DATA_ACCESS_MASK6      = 	0xFFFFFFFF
  val DATA_ACCESS_MASK7      = 	0xFFFFFFFF
  val DCCM_BANK_BITS         = 	0x2
  val DCCM_BITS              = 	0x10
  val DCCM_BYTE_WIDTH        = 	0x4
  val DCCM_DATA_WIDTH        = 	0x20
  val DCCM_ECC_WIDTH         = 	0x7
  val DCCM_ENABLE            = 	0x1
  val DCCM_FDATA_WIDTH       = 	0x27
  val DCCM_INDEX_BITS        = 	0xC
  val DCCM_NUM_BANKS         = 	0x04
  val DCCM_REGION            = 	0xF
  val DCCM_SADR              = 	0xF0040000
  val DCCM_SIZE              = 	0x040
  val DCCM_WIDTH_BITS        = 	0x2
  val DMA_BUF_DEPTH          = 	0x5
  val DMA_BUS_ID             = 	0x1
  val DMA_BUS_PRTY           = 	0x2
  val DMA_BUS_TAG            = 	0x1
  val FAST_INTERRUPT_REDIRECT = 0x1
  val ICACHE_2BANKS          = 	0x1
  val ICACHE_BANK_BITS       = 	0x1
  val ICACHE_BANK_HI         = 	0x3
  val ICACHE_BANK_LO         = 	0x3
  val ICACHE_BANK_WIDTH      = 	0x8
  val ICACHE_BANKS_WAY       = 	0x2
  val ICACHE_BEAT_ADDR_HI    = 	0x5
  val ICACHE_BEAT_BITS       = 	0x3
  val ICACHE_DATA_DEPTH      = 	0x0200
  val ICACHE_DATA_INDEX_LO   = 	0x4
  val ICACHE_DATA_WIDTH      = 	0x40
  val ICACHE_ECC             = 	0x1
  val ICACHE_ENABLE          = 	0x1
  val ICACHE_FDATA_WIDTH     = 	0x47
  val ICACHE_INDEX_HI        = 	0x0C
  val ICACHE_LN_SZ           = 	0x40
  val ICACHE_NUM_BEATS       = 	0x8
  val ICACHE_NUM_WAYS        = 	0x2
  val ICACHE_ONLY            = 	0x0
  val ICACHE_SCND_LAST       = 	0x6
  val ICACHE_SIZE            = 	0x010
  val ICACHE_STATUS_BITS     = 	0x1
  val ICACHE_TAG_DEPTH       = 	0x0080
  val ICACHE_TAG_INDEX_LO    = 	0x6
  val ICACHE_TAG_LO          = 	0x0D
  val ICACHE_WAYPACK         = 	0x0
  val ICCM_BANK_BITS         = 	0x2
  val ICCM_BANK_HI           = 	0x03
  val ICCM_BANK_INDEX_LO     = 	0x04
  val ICCM_BITS              = 	0x10
  val ICCM_ENABLE            = 	0x1
  val ICCM_ICACHE            = 	0x1
  val ICCM_INDEX_BITS        = 	0xC
  val ICCM_NUM_BANKS         = 	0x04
  val ICCM_ONLY              = 	0x0
  val ICCM_REGION            = 	0xE
  val ICCM_SADR              = 	0xEE000000
  val ICCM_SIZE              = 	0x040
  val IFU_BUS_ID             = 	0x1
  val IFU_BUS_PRTY           = 	0x2
  val IFU_BUS_TAG            = 	0x3
  val INST_ACCESS_ADDR0      = 	0x00000000
  val INST_ACCESS_ADDR1      = 	0xC0000000
  val INST_ACCESS_ADDR2      = 	0xA0000000
  val INST_ACCESS_ADDR3      = 	0x80000000
  val INST_ACCESS_ADDR4      = 	0x00000000
  val INST_ACCESS_ADDR5      = 	0x00000000
  val INST_ACCESS_ADDR6      = 	0x00000000
  val INST_ACCESS_ADDR7      = 	0x00000000
  val INST_ACCESS_ENABLE0    = 	0x1
  val INST_ACCESS_ENABLE1    = 	0x1
  val INST_ACCESS_ENABLE2    = 	0x1
  val INST_ACCESS_ENABLE3    = 	0x1
  val INST_ACCESS_ENABLE4    = 	0x0
  val INST_ACCESS_ENABLE5    = 	0x0
  val INST_ACCESS_ENABLE6    = 	0x0
  val INST_ACCESS_ENABLE7    = 	0x0
  val INST_ACCESS_MASK0      = 	0x7FFFFFFF
  val INST_ACCESS_MASK1      = 	0x3FFFFFFF
  val INST_ACCESS_MASK2      = 	0x1FFFFFFF
  val INST_ACCESS_MASK3      = 	0x0FFFFFFF
  val INST_ACCESS_MASK4      = 	0xFFFFFFFF
  val INST_ACCESS_MASK5      = 	0xFFFFFFFF
  val INST_ACCESS_MASK6      = 	0xFFFFFFFF
  val INST_ACCESS_MASK7      = 	0xFFFFFFFF
  val LOAD_TO_USE_PLUS1      = 	0x0
  val LSU2DMA                = 	0x0
  val LSU_BUS_ID             = 	0x1
  val LSU_BUS_PRTY           = 	0x2
  val LSU_BUS_TAG            = 	0x3
  val LSU_NUM_NBLOAD         = 	0x04
  val LSU_NUM_NBLOAD_WIDTH   = 	0x2
  val LSU_SB_BITS            = 	0x10
  val LSU_STBUF_DEPTH        = 	0x4
  val NO_ICCM_NO_ICACHE      = 	0x0
  val PIC_2CYCLE             = 	0x0
  val PIC_BASE_ADDR          = 	0xF00C0000
  val PIC_BITS               = 	0x0F
  val PIC_INT_WORDS          = 	0x1
  val PIC_REGION             = 	0xF
  val PIC_SIZE               = 	0x020
  val PIC_TOTAL_INT          = 	0x1F
  val PIC_TOTAL_INT_PLUS1    = 	0x020
  val RET_STACK_SIZE         = 	0x8
  val SB_BUS_ID              = 	0x1
  val SB_BUS_PRTY            = 	0x2
  val SB_BUS_TAG             = 	0x1
  val TIMER_LEGAL_EN         = 	0x1
  val RV_FPGA_OPTIMIZE       =  0x1
  val DIV_NEW                =  0x1
  val DIV_BIT                =  0x4
  val BTB_ENABLE             =  0x1
  val BTB_TOFFSET_SIZE       =  0x00C
  val BTB_FULLYA             =  0x00

}
