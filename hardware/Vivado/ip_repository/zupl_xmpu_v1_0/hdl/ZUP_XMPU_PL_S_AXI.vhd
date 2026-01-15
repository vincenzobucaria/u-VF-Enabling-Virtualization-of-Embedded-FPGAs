-------------------------------------------------------------------------------
--                            XILINX PROPRIETARY
-------------------------------------------------------------------------------
-- NOTICE : This document contains Proprietary Information.  The receiving party
-- shall not disclose this Proprietary Information to any third party except its
-- employees, consultants, independent sales representatives and affiliates, and
-- employees and consultants, independent sales representatives of affiliates that
-- (a) have a legitimate "need to know", and (b) are subject to confidentiality
-- obligations no less restrictive than those set forth between Xilinx and the
-- receiving party.  The Receiving Party shall exercise the same degree of care
-- in protecting this Proprietary Information that it uses for its own Proprietary
-- Information of a similar nature, but in no event less than reasonable care. 
------------------------------------------------------------------------------
-- Copyright (c) 2020 Xilinx, Inc.
-- All Rights Reserved
-------------------------------------------------------------------------------
--   ____  ____
--  /   /\/   /
-- /___/  \  /    Vendor: Xilinx                 
-- \   \   \/     Version: 1.0 for Zynq UltraScale Plus MPSoC
--  \   \         Application : PL Axi Memory Protection Unit 
--  /   /         Filename: ZUP_ZMPU_PL_S_AXI.vhd         
-- /___/   /\     Timestamp: $DateTime: 2020/03/02 10:38:05 $
-- \   \  /  \
--  \___\/\___\
--
--
-- Purpose: This module implements the AXI Slave run-time configuration interface for 
-- the XMPU PL Instance.
--
-- Instantiates   : Axi_Monitor, SINK_S_AXI
-- Requirements Addressed :  
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_misc.all;
library xil_defaultlib;
use xil_defaultlib.xmpu_pl_package.all;

entity ZUP_XMPU_PL_S_AXI is
	generic (
		-- Users to add parameters here
        C_CTRL_REG_VAL          : std_logic_vector(31 downto 0):= C_CTRL_REG_INIT     ;
        C_POISON_REG_VAL        : std_logic_vector(31 downto 0):= C_POISON_REG_INIT   ;
        C_IMR_REG_VAL           : std_logic_vector(31 downto 0):= C_IMR_REG_INIT      ;
        C_LOCK_REG_VAL          : std_logic_vector(31 downto 0):= C_LOCK_REG_INIT     ;
        C_BYPASS_REG_VAL        : std_logic_vector(31 downto 0):= C_BYPASS_REG_INIT   ;
        C_R00_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R00_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R00_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R00_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R01_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R01_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R01_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R01_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R02_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R02_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R02_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R02_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R03_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R03_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R03_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R03_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R04_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R04_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R04_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R04_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R05_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R05_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R05_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R05_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R06_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R06_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R06_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R06_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R07_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R07_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R07_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R07_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R08_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R08_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R08_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R08_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R09_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R09_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R09_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R09_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R10_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R10_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R10_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R10_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R11_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R11_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R11_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R11_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R12_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R12_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R12_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R12_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R13_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R13_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R13_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R13_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R14_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R14_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R14_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R14_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R15_START_REG_VAL     : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R15_END_REG_VAL       : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R15_MASTERS_REG_VAL   : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R15_CONFIG_REG_VAL    : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of ID for for write address, write data, read address and read data
		C_S_AXI_ID_WIDTH          : integer	:= 1;
		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH	      : integer	:= 32;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH	      : integer	:= 9;
		-- Width of optional user defined signal in write address channel
		C_S_AXI_AWUSER_WIDTH	  : integer	:= 0;
		-- Width of optional user defined signal in read address channel
		C_S_AXI_ARUSER_WIDTH	  : integer	:= 0;
		-- Width of optional user defined signal in write data channel
		C_S_AXI_WUSER_WIDTH	      : integer	:= 0;
		-- Width of optional user defined signal in read data channel
		C_S_AXI_RUSER_WIDTH	      : integer	:= 0;
		-- Width of optional user defined signal in write response channel
		C_S_AXI_BUSER_WIDTH	      : integer	:= 0;
        -- Sensitivity of IRQ: 0 - EDGE, 1 - LEVEL
        C_IRQ_SENSITIVITY         : integer  := 1;
        -- Sub-type of IRQ: [0 - FALLING_EDGE, 1 - RISING_EDGE : if C_IRQ_SENSITIVITY is EDGE(0)] 
        -- and [ 0 - LEVEL_LOW, 1 - LEVEL_HIGH : if C_IRQ_SENSITIVITY is LEVEL(1) ]
        C_IRQ_ACTIVE_STATE        : integer  := 1
	);
	port (
		-- Users to add ports here
        config_reg_out          : out reg_array;
        axi_blocked             : in std_logic_vector(1 downto 0);
        err_status1_in          : in std_logic_vector(31 downto 0);
        err_status2_in          : in std_logic_vector(31 downto 0);
        
		-- User ports ends
		-- Do not modify the ports beyond this line

		-- Global Clock Signal
		S_AXI_ACLK	            : in std_logic;
		-- Global Reset Signal. This Signal is Active LOW
		S_AXI_ARESETN	        : in std_logic;
		-- Write Address ID
		S_AXI_AWID	            : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		-- Write address
		S_AXI_AWADDR	        : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Burst length. The burst length gives the exact number of transfers in a burst
		S_AXI_AWLEN	            : in std_logic_vector(7 downto 0);
		-- Burst size. This signal indicates the size of each transfer in the burst
		S_AXI_AWSIZE	        : in std_logic_vector(2 downto 0);
		-- Burst type. The burst type and the size information, 
        -- determine how the address for each transfer within the burst is calculated.
		S_AXI_AWBURST	        : in std_logic_vector(1 downto 0);
		-- Lock type. Provides additional information about the
        -- atomic characteristics of the transfer.
		S_AXI_AWLOCK	        : in std_logic;
		-- Memory type. This signal indicates how transactions
        -- are required to progress through a system.
		S_AXI_AWCACHE	        : in std_logic_vector(3 downto 0);
		-- Protection type. This signal indicates the privilege
        -- and security level of the transaction, and whether
        -- the transaction is a data access or an instruction access.
		S_AXI_AWPROT	        : in std_logic_vector(2 downto 0);
		-- Quality of Service, QoS identifier sent for each
        -- write transaction.
		S_AXI_AWQOS	            : in std_logic_vector(3 downto 0);
		-- Region identifier. Permits a single physical interface
        -- on a slave to be used for multiple logical interfaces.
		S_AXI_AWREGION	        : in std_logic_vector(3 downto 0);
		-- Optional User-defined signal in the write address channel.
		S_AXI_AWUSER	        : in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		-- Write address valid. This signal indicates that
        -- the channel is signaling valid write address and
        -- control information.
		S_AXI_AWVALID	        : in std_logic;
		-- Write address ready. This signal indicates that
        -- the slave is ready to accept an address and associated
        -- control signals.
		S_AXI_AWREADY	        : out std_logic;
		-- Write Data
		S_AXI_WDATA	            : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Write strobes. This signal indicates which byte
        -- lanes hold valid data. There is one write strobe
        -- bit for each eight bits of the write data bus.
		S_AXI_WSTRB	            : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		-- Write last. This signal indicates the last transfer
        -- in a write burst.
		S_AXI_WLAST	            : in std_logic;
		-- Optional User-defined signal in the write data channel.
		S_AXI_WUSER	            : in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		-- Write valid. This signal indicates that valid write
        -- data and strobes are available.
		S_AXI_WVALID	        : in std_logic;
		-- Write ready. This signal indicates that the slave
        -- can accept the write data.
		S_AXI_WREADY	        : out std_logic;
		-- Response ID tag. This signal is the ID tag of the
        -- write response.
		S_AXI_BID	            : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		-- Write response. This signal indicates the status
        -- of the write transaction.
		S_AXI_BRESP	            : out std_logic_vector(1 downto 0);
		-- Optional User-defined signal in the write response channel.
		S_AXI_BUSER	            : out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		-- Write response valid. This signal indicates that the
        -- channel is signaling a valid write response.
		S_AXI_BVALID	        : out std_logic;
		-- Response ready. This signal indicates that the master
        -- can accept a write response.
		S_AXI_BREADY	        : in std_logic;
		-- Read address ID. This signal is the identification
        -- tag for the read address group of signals.
		S_AXI_ARID	            : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		-- Read address. This signal indicates the initial
        -- address of a read burst transaction.
		S_AXI_ARADDR	        : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		-- Burst length. The burst length gives the exact number of transfers in a burst
		S_AXI_ARLEN	            : in std_logic_vector(7 downto 0);
		-- Burst size. This signal indicates the size of each transfer in the burst
		S_AXI_ARSIZE	        : in std_logic_vector(2 downto 0);
		-- Burst type. The burst type and the size information, 
        -- determine how the address for each transfer within the burst is calculated.
		S_AXI_ARBURST	        : in std_logic_vector(1 downto 0);
		-- Lock type. Provides additional information about the
        -- atomic characteristics of the transfer.
		S_AXI_ARLOCK	        : in std_logic;
		-- Memory type. This signal indicates how transactions
        -- are required to progress through a system.
		S_AXI_ARCACHE	        : in std_logic_vector(3 downto 0);
		-- Protection type. This signal indicates the privilege
        -- and security level of the transaction, and whether
        -- the transaction is a data access or an instruction access.
		S_AXI_ARPROT	        : in std_logic_vector(2 downto 0);
		-- Quality of Service, QoS identifier sent for each
        -- read transaction.
		S_AXI_ARQOS	            : in std_logic_vector(3 downto 0);
		-- Region identifier. Permits a single physical interface
        -- on a slave to be used for multiple logical interfaces.
		S_AXI_ARREGION	        : in std_logic_vector(3 downto 0);
		-- Optional User-defined signal in the read address channel.
		S_AXI_ARUSER	        : in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		-- Write address valid. This signal indicates that
        -- the channel is signaling valid read address and
        -- control information.
		S_AXI_ARVALID	        : in std_logic;
		-- Read address ready. This signal indicates that
        -- the slave is ready to accept an address and associated
        -- control signals.
		S_AXI_ARREADY	        : out std_logic;
		-- Read ID tag. This signal is the identification tag
        -- for the read data group of signals generated by the slave.
		S_AXI_RID	            : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		-- Read Data
		S_AXI_RDATA	            : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		-- Read response. This signal indicates the status of
        -- the read transfer.
		S_AXI_RRESP	            : out std_logic_vector(1 downto 0);
		-- Read last. This signal indicates the last transfer
        -- in a read burst.
		S_AXI_RLAST	            : out std_logic;
		-- Optional User-defined signal in the read address channel.
		S_AXI_RUSER	            : out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		-- Read valid. This signal indicates that the channel
        -- is signaling the required read data.
		S_AXI_RVALID	        : out std_logic;
		-- Read ready. This signal indicates that the master can
        -- accept the read data and response information.
		S_AXI_RREADY	        : in std_logic;
        -- interrupt out port
        irq                     : out std_logic
	);
end ZUP_XMPU_PL_S_AXI;

architecture arch_imp of ZUP_XMPU_PL_S_AXI is

  -- Number of Interrupts
  constant C_NUM_OF_INTR        : integer  := 3;
  -- Each bit corresponds to Sensitivity of interrupt :  0 - EDGE, 1 - LEVEL
  constant C_INTR_SENSITIVITY   : std_logic_vector  := x"0000000000000000";
  -- Each bit corresponds to Sub-type of INTR: [0 - FALLING_EDGE, 1 - RISING_EDGE : 
  -- if C_INTR_SENSITIVITY is EDGE(0)] and [ 0 - LEVEL_LOW, 1 - LEVEL_LOW : 
  -- if C_INTR_SENSITIVITY is LEVEL(1) ]
  constant C_INTR_ACTIVE_STATE  : std_logic_vector  := x"FFFFFFFFFFFFFFFF";
  
	-- component declaration
	component Axi_Masters is
		generic (
		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_AWUSER_WIDTH	: integer	:= 16;
		C_S00_AXI_ARUSER_WIDTH	: integer	:= 16
	);
    Port ( 
        ARPROT          : in STD_LOGIC_VECTOR (2 downto 0);
		ARUSER	        : in std_logic_vector(C_S00_AXI_ARUSER_WIDTH-1 downto 0);
        AWPROT          : in STD_LOGIC_VECTOR (2 downto 0);
		AWUSER	        : in std_logic_vector(C_S00_AXI_AWUSER_WIDTH-1 downto 0);
        SEC_MASTERS     : in STD_LOGIC_VECTOR(31 downto 0);
        RPROT_OUT       : out STD_LOGIC_VECTOR (2 downto 0);
        WPROT_OUT       : out STD_LOGIC_VECTOR (2 downto 0);
        READ_SECURE     : out std_logic;
        WRITE_SECURE    : out std_logic
        );
    end component Axi_Masters;
		
    --------------------------------------------------
    ---- Signals for Interrupt register space 
    --------------------------------------------------
    ---- Number of Slave Registers ?
    signal reg_global_intr_en : std_logic_vector(0 downto 0);           
    signal reg_intr_en        : std_logic_vector(C_NUM_OF_INTR-1 downto 0);
    signal reg_intr_sts       : std_logic_vector(C_NUM_OF_INTR-1 downto 0);
    signal reg_intr_ack       : std_logic_vector(C_NUM_OF_INTR-1 downto 0);
    signal reg_intr_pending   : std_logic_vector(C_NUM_OF_INTR-1 downto 0);
    
    signal intr               : std_logic_vector(C_NUM_OF_INTR-1 downto 0);
    signal det_intr           : std_logic_vector(C_NUM_OF_INTR-1 downto 0);
    
    signal intr_reg_wren      : std_logic;
    
    signal intr_all           : std_logic;
    signal intr_ack_all       : std_logic;
    signal s_irq              : std_logic;
    signal intr_ack_all_ff    : std_logic;

	-- AXI4FULL signals
	signal axi_aruser	      : std_logic_vector(16-1 downto 0):= (others => '0');
	signal axi_awuser	      : std_logic_vector(16-1 downto 0):= (others => '0');
	signal axi_awaddr	      : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_awready	      : std_logic;
	signal axi_wready	      : std_logic;
	signal axi_bresp	      : std_logic_vector(1 downto 0);
	signal axi_buser	      : std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
	signal axi_bvalid	      : std_logic;
	signal axi_araddr	      : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
	signal axi_arready	      : std_logic;
	signal axi_rdata	      : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal axi_rresp	      : std_logic_vector(1 downto 0);
	signal axi_rlast	      : std_logic;
	signal axi_ruser	      : std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
	signal axi_rvalid	      : std_logic;
	-- aw_wrap_en determines wrap boundary and enables wrapping
	signal  aw_wrap_en        : std_logic; 
	-- ar_wrap_en determines wrap boundary and enables wrapping
	signal  ar_wrap_en        : std_logic;
	-- aw_wrap_size is the size of the write transfer, the
	-- write address wraps to a lower address if upper address
	-- limit is reached
	signal aw_wrap_size       : integer;
	-- ar_wrap_size is the size of the read transfer, the
	-- read address wraps to a lower address if upper address
	-- limit is reached
	signal ar_wrap_size       : integer;
	-- The axi_awv_awr_flag flag marks the presence of write address valid
	signal axi_awv_awr_flag   : std_logic;
	--The axi_arv_arr_flag flag marks the presence of read address valid
	signal axi_arv_arr_flag   : std_logic;
	-- The axi_awlen_cntr internal write address counter to keep track of beats in a burst transaction
	signal axi_awlen_cntr     : std_logic_vector(7 downto 0);
	--The axi_arlen_cntr internal read address counter to keep track of beats in a burst transaction
	signal axi_arlen_cntr     : std_logic_vector(7 downto 0);
	signal axi_arburst        : std_logic_vector(2-1 downto 0);
	signal axi_awburst        : std_logic_vector(2-1 downto 0);
	signal axi_arlen          : std_logic_vector(8-1 downto 0);
	signal axi_awlen          : std_logic_vector(8-1 downto 0);
	--local parameter for addressing 32 bit / 64 bit C_S_AXI_DATA_WIDTH
	--ADDR_LSB is used for addressing 32/64 bit registers/memories
	--ADDR_LSB = 2 for 32 bits (n downto 2) 
	--ADDR_LSB = 3 for 42 bits (n downto 3)

	constant ADDR_LSB          : integer := (C_S_AXI_DATA_WIDTH/32)+ 1;
	constant OPT_MEM_ADDR_BITS : integer := 6;
	constant USER_NUM_MEM      : integer := 1;
	constant low               : std_logic_vector (C_S_AXI_ADDR_WIDTH - 1 downto 0) := "000000000";
	------------------------------------------------
	---- Signals for user logic memory space example
	--------------------------------------------------
	signal mem_address         : std_logic_vector(OPT_MEM_ADDR_BITS downto 0);
	signal mem_select          : std_logic_vector(USER_NUM_MEM-1 downto 0);
	type word_array is array (0 to USER_NUM_MEM-1) of std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
	signal mem_data_out        : word_array;

	signal i               : integer;
	signal j               : integer;
	signal mem_byte_index  : integer;
	type BYTE_RAM_TYPE is array (0 to 127) of std_logic_vector(7 downto 0);
	
	
	------------------------------------------------
	---- Signals for user logic register space
	------------------------------------------------
    signal config_reg              : reg_array;
	signal reg_rden                : std_logic;
	signal reg_wren                : std_logic;
	signal slv_reg_wren            : std_logic;
	signal maj_addr                : std_logic;
	signal min_addr                : std_logic_vector(5 downto 0);
	signal region                  : std_logic_vector(3 downto 0);
	signal region_reg              : std_logic_vector(1 downto 0);
	signal regions_en              : std_logic_vector(15 downto 0);
	signal write_blocked           : std_logic;
	signal read_blocked            : std_logic;
    signal slv_rprot               : std_logic_vector(2 downto 0);
    signal slv_wprot               : std_logic_vector(2 downto 0);
	signal ctrl_reg                : std_logic_vector(31 downto 0);
	signal errs1_reg               : std_logic_vector(31 downto 0);
	signal errs2_reg               : std_logic_vector(31 downto 0);
	signal poison_reg              : std_logic_vector(31 downto 0);
	signal isr_reg                 : std_logic_vector(31 downto 0);
	signal imr_reg                 : std_logic_vector(31 downto 0);
	signal ien_reg                 : std_logic_vector(31 downto 0);
	signal ids_reg                 : std_logic_vector(31 downto 0);
	signal lock_reg                : std_logic_vector(31 downto 0);
	signal bypass_reg              : std_logic_vector(31 downto 0);
	signal regions_reg             : std_logic_vector(31 downto 0);
	signal r_start_reg             : reg_array;
	signal r_end_reg               : reg_array;
	signal r_masters_reg           : reg_array;
	signal r_config_reg            : reg_array;
	signal lock_registers          : std_logic;
	signal lock_bypass             : std_logic;
	signal write_allowed           : std_logic;
	signal isr_reg_data            : std_logic_vector(7 downto 0);
	signal update_isr_reg          : std_logic;
	signal update_isr_reg_en       : std_logic;
	signal isr_event               : std_logic;
	signal update_imr_reg          : std_logic;
	signal update_imr_reg_en       : std_logic;
	signal update_region_reg       : std_logic;
	signal update_region_reg_en    : std_logic;
	

	------------------------------------------------
	---- Functions
	------------------------------------------------
  function COUNT_ONES_16BIT ( input : std_logic_vector(15 downto 0)) return integer is
    variable v_ones_count : integer;
    variable v_i : integer;
  begin
    v_ones_count := 0;
    for v_i in 0 TO 15 loop
        if (input(v_i) = '1') then
            v_ones_count := v_ones_count +1;
        end if;
    end loop;
    return v_ones_count;
  end function;

begin
	-- I/O Connections assignments
	config_reg_out     <= config_reg;
	write_blocked      <= axi_blocked(1);
	read_blocked       <= axi_blocked(0);
    
	S_AXI_AWREADY	   <= axi_awready;
	S_AXI_WREADY	   <= axi_wready;
	S_AXI_BRESP	       <= axi_bresp;
	S_AXI_BUSER	       <= axi_buser;
	S_AXI_BVALID	   <= axi_bvalid;
	S_AXI_ARREADY	   <= axi_arready;
	S_AXI_RDATA	       <= axi_rdata;
	S_AXI_RRESP	       <= axi_rresp;
	S_AXI_RLAST	       <= axi_rlast;
	S_AXI_RUSER	       <= axi_ruser;
	S_AXI_RVALID	   <= axi_rvalid;
	S_AXI_BID          <= S_AXI_AWID;
	S_AXI_RID          <= S_AXI_ARID;
	aw_wrap_size       <= ((C_S_AXI_DATA_WIDTH)/8 * to_integer(unsigned(axi_awlen))); 
	ar_wrap_size       <= ((C_S_AXI_DATA_WIDTH)/8 * to_integer(unsigned(axi_arlen))); 
	aw_wrap_en         <= '1' when (((axi_awaddr AND std_logic_vector(to_unsigned(aw_wrap_size,C_S_AXI_ADDR_WIDTH))) 
	                           XOR std_logic_vector(to_unsigned(aw_wrap_size,C_S_AXI_ADDR_WIDTH))) = low) else '0';
	ar_wrap_en         <= '1' when (((axi_araddr AND std_logic_vector(to_unsigned(ar_wrap_size,C_S_AXI_ADDR_WIDTH))) 
	                           XOR std_logic_vector(to_unsigned(ar_wrap_size,C_S_AXI_ADDR_WIDTH))) = low) else '0';

    -- Axi Master IDs
	axi_aruser(C_S_AXI_ARUSER_WIDTH-1 downto 0) <= S_AXI_ARUSER;
	axi_awuser(C_S_AXI_AWUSER_WIDTH-1 downto 0) <= S_AXI_AWUSER;
    
    -- Instantiation of Axi Masters Detection Circuit
    AXI_MASTERS_inst : Axi_Masters
        --generic map (
        --)
        port map (
            ARPROT          => S_AXI_ARPROT,
            ARUSER	        => axi_aruser,
            AWPROT          => S_AXI_AWPROT,
            AWUSER	        => axi_awuser,
            SEC_MASTERS     => bypass_reg,
            RPROT_OUT       => slv_rprot,
            WPROT_OUT       => slv_wprot,
            READ_SECURE     => OPEN,
            WRITE_SECURE    => OPEN
        );

	-- Implement axi_awready generation

	-- axi_awready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_awready is
	-- de-asserted when reset is low.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awready <= '0';
	      axi_awv_awr_flag <= '0';
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and axi_awv_awr_flag = '0' and axi_arv_arr_flag = '0') then
	        -- slave is ready to accept an address and
	        -- associated control signals
	        axi_awv_awr_flag  <= '1'; -- used for generation of bresp() and bvalid
	        axi_awready <= '1';
	      elsif (S_AXI_WLAST = '1' and axi_wready = '1') then 
	      -- preparing to accept next address after current write burst tx completion
	        axi_awv_awr_flag  <= '0';
	      else
	        axi_awready <= '0';
	      end if;
	    end if;
	  end if;         
	end process; 
	-- Implement axi_awaddr latching

	-- This process is used to latch the address when both 
	-- S_AXI_AWVALID and S_AXI_WVALID are valid. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_awaddr <= (others => '0');
	      axi_awburst <= (others => '0'); 
	      axi_awlen <= (others => '0'); 
	      axi_awlen_cntr <= (others => '0');
	    else
	      if (axi_awready = '0' and S_AXI_AWVALID = '1' and axi_awv_awr_flag = '0') then
	      -- address latching 
	        axi_awaddr <= S_AXI_AWADDR(C_S_AXI_ADDR_WIDTH - 1 downto 0);  ---- start address of transfer
	        axi_awlen_cntr <= (others => '0');
	        axi_awburst <= S_AXI_AWBURST;
	        axi_awlen <= S_AXI_AWLEN;
	      elsif((axi_awlen_cntr <= axi_awlen) and axi_wready = '1' and S_AXI_WVALID = '1') then     
	        axi_awlen_cntr <= std_logic_vector (unsigned(axi_awlen_cntr) + 1);

	        case (axi_awburst) is
	          when "00" => -- fixed burst
	            -- The write address for all the beats in the transaction are fixed
	            axi_awaddr     <= axi_awaddr;       ----for awsize = 4 bytes (010)
	          when "01" => --incremental burst
	            -- The write address for all the beats in the transaction are increments by awsize
	            axi_awaddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB) <= std_logic_vector (unsigned(axi_awaddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB)) + 1);--awaddr aligned to 4 byte boundary
	            axi_awaddr(ADDR_LSB-1 downto 0)  <= (others => '0');  ----for awsize = 4 bytes (010)
	          when "10" => --Wrapping burst
	            -- The write address wraps when the address reaches wrap boundary 
	            if (aw_wrap_en = '1') then
	              axi_awaddr <= std_logic_vector (unsigned(axi_awaddr) - (to_unsigned(aw_wrap_size,C_S_AXI_ADDR_WIDTH)));                
	            else 
	              axi_awaddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB) <= std_logic_vector (unsigned(axi_awaddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB)) + 1);--awaddr aligned to 4 byte boundary
	              axi_awaddr(ADDR_LSB-1 downto 0)  <= (others => '0');  ----for awsize = 4 bytes (010)
	            end if;
	          when others => --reserved (incremental burst for example)
	            axi_awaddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB) <= std_logic_vector (unsigned(axi_awaddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB)) + 1);--for awsize = 4 bytes (010)
	            axi_awaddr(ADDR_LSB-1 downto 0)  <= (others => '0');
	        end case;        
	      end if;
	    end if;
	  end if;
	end process;
	-- Implement axi_wready generation

	-- axi_wready is asserted for one S_AXI_ACLK clock cycle when both
	-- S_AXI_AWVALID and S_AXI_WVALID are asserted. axi_wready is 
	-- de-asserted when reset is low. 

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_wready <= '0';
	    else
	      if (axi_wready = '0' and S_AXI_WVALID = '1' and axi_awv_awr_flag = '1') then
	        axi_wready <= '1';
	        -- elsif (axi_awv_awr_flag = '0') then
	      elsif (S_AXI_WLAST = '1' and axi_wready = '1') then 

	        axi_wready <= '0';
	      end if;
	    end if;
	  end if;         
	end process; 
	-- Implement write response logic generation

	-- The write response and response valid signals are asserted by the slave 
	-- when axi_wready, S_AXI_WVALID, axi_wready and S_AXI_WVALID are asserted.  
	-- This marks the acceptance of address and indicates the status of 
	-- write transaction.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_bvalid  <= '0';
	      axi_bresp  <= "00"; --need to work more on the responses
	      axi_buser <= (others => '0');
	    else
	      if (axi_awv_awr_flag = '1' and axi_wready = '1' and S_AXI_WVALID = '1' and axi_bvalid = '0' and S_AXI_WLAST = '1' ) then
	        axi_bvalid <= '1';
	        axi_bresp  <= "00"; 
	      elsif (S_AXI_BREADY = '1' and axi_bvalid = '1') then  
	      --check if bready is asserted while bvalid is high)
	        axi_bvalid <= '0';                      
	      end if;
	    end if;
	  end if;         
	end process; 
	-- Implement axi_arready generation

	-- axi_arready is asserted for one S_AXI_ACLK clock cycle when
	-- S_AXI_ARVALID is asserted. axi_awready is 
	-- de-asserted when reset (active low) is asserted. 
	-- The read address is also latched when S_AXI_ARVALID is 
	-- asserted. axi_araddr is reset to zero on reset assertion.

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_arready <= '0';
	      axi_arv_arr_flag <= '0';
	    else
	      if (axi_arready = '0' and S_AXI_ARVALID = '1' and axi_awv_awr_flag = '0' and axi_arv_arr_flag = '0') then
	        axi_arready <= '1';
	        axi_arv_arr_flag <= '1';
	      elsif (axi_rvalid = '1' and S_AXI_RREADY = '1' and (axi_arlen_cntr = axi_arlen)) then 
	      -- preparing to accept next address after current read completion
	        axi_arv_arr_flag <= '0';
	      else
	        axi_arready <= '0';
	      end if;
	    end if;
	  end if;         
	end process; 
	-- Implement axi_araddr latching

	--This process is used to latch the address when both 
	--S_AXI_ARVALID and S_AXI_RVALID are valid. 
	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then 
	    if S_AXI_ARESETN = '0' then
	      axi_araddr <= (others => '0');
	      axi_arburst <= (others => '0');
	      axi_arlen <= (others => '0'); 
	      axi_arlen_cntr <= (others => '0');
	      axi_rlast <= '0';
	      axi_ruser <= (others => '0');
	    else
	      if (axi_arready = '0' and S_AXI_ARVALID = '1' and axi_arv_arr_flag = '0') then
	        -- address latching 
	        axi_araddr <= S_AXI_ARADDR(C_S_AXI_ADDR_WIDTH - 1 downto 0); ---- start address of transfer
	        axi_arlen_cntr <= (others => '0');
	        axi_rlast <= '0';
	        axi_arburst <= S_AXI_ARBURST;
	        axi_arlen <= S_AXI_ARLEN;
	      elsif((axi_arlen_cntr <= axi_arlen) and axi_rvalid = '1' and S_AXI_RREADY = '1') then     
	        axi_arlen_cntr <= std_logic_vector (unsigned(axi_arlen_cntr) + 1);
	        axi_rlast <= '0';      
	     
	        case (axi_arburst) is
	          when "00" =>  -- fixed burst
	            -- The read address for all the beats in the transaction are fixed
	            axi_araddr     <= axi_araddr;      ----for arsize = 4 bytes (010)
	          when "01" =>  --incremental burst
	            -- The read address for all the beats in the transaction are increments by awsize
	            axi_araddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB) <= std_logic_vector (unsigned(axi_araddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB)) + 1); --araddr aligned to 4 byte boundary
	            axi_araddr(ADDR_LSB-1 downto 0)  <= (others => '0');  ----for awsize = 4 bytes (010)
	          when "10" =>  --Wrapping burst
	            -- The read address wraps when the address reaches wrap boundary 
	            if (ar_wrap_en = '1') then   
	              axi_araddr <= std_logic_vector (unsigned(axi_araddr) - (to_unsigned(ar_wrap_size,C_S_AXI_ADDR_WIDTH)));
	            else 
	              axi_araddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB) <= std_logic_vector (unsigned(axi_araddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB)) + 1); --araddr aligned to 4 byte boundary
	              axi_araddr(ADDR_LSB-1 downto 0)  <= (others => '0');  ----for awsize = 4 bytes (010)
	            end if;
	          when others => --reserved (incremental burst for example)
	            axi_araddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB) <= std_logic_vector (unsigned(axi_araddr(C_S_AXI_ADDR_WIDTH - 1 downto ADDR_LSB)) + 1);--for arsize = 4 bytes (010)
			  axi_araddr(ADDR_LSB-1 downto 0)  <= (others => '0');
	        end case;         
	      elsif((axi_arlen_cntr = axi_arlen) and axi_rlast = '0' and axi_arv_arr_flag = '1') then  
	        axi_rlast <= '1';
	      elsif (S_AXI_RREADY = '1') then  
	        axi_rlast <= '0';
	      end if;
	    end if;
	  end if;
	end  process;  
	-- Implement axi_arvalid generation

	-- axi_rvalid is asserted for one S_AXI_ACLK clock cycle when both 
	-- S_AXI_ARVALID and axi_arready are asserted. The slave registers 
	-- data are available on the axi_rdata bus at this instance. The 
	-- assertion of axi_rvalid marks the validity of read data on the 
	-- bus and axi_rresp indicates the status of read transaction.axi_rvalid 
	-- is deasserted on reset (active low). axi_rresp and axi_rdata are 
	-- cleared to zero on reset (active low).  

	process (S_AXI_ACLK)
	begin
	  if rising_edge(S_AXI_ACLK) then
	    if S_AXI_ARESETN = '0' then
	      axi_rvalid <= '0';
	      axi_rresp  <= "00";
	    else
	      if (axi_arv_arr_flag = '1' and axi_rvalid = '0') then
	        axi_rvalid <= '1';
	        axi_rresp  <= "00"; -- 'OKAY' response
	      elsif (axi_rvalid = '1' and S_AXI_RREADY = '1') then
	        axi_rvalid <= '0';
	      end  if;      
	    end if;
	  end if;
	end  process;
	-- ------------------------------------------
	-- -- Example code to access user logic memory region
	-- ------------------------------------------

	--Output register or memory read data

	process(mem_data_out, axi_rvalid ) is
	begin
	  if (axi_rvalid = '1') then
	    -- When there is a valid read address (S_AXI_ARVALID) with 
	    -- acceptance of read address by the slave (axi_arready), 
	    -- output the read dada 
	    axi_rdata <= mem_data_out(0);  -- memory range 0 read data
	  else
	    axi_rdata <= (others => '0');
	  end if;  
	end process;

	-- Add user logic here
	reg_wren <= axi_wready and S_AXI_WVALID ;
	reg_rden <= axi_arv_arr_flag ;
	
	-- Store Data to Register
	
	-- Writeable Registers
	maj_addr <= axi_awaddr(8);
	min_addr <= axi_awaddr(7 downto 2);
	region   <= axi_awaddr(7 downto 4);
	region_reg <= axi_awaddr(3 downto 2);
	slv_reg_wren <= axi_wready and S_AXI_WVALID; -- and axi_awready and S_AXI_AWVALID;
	lock_registers <= lock_reg(0);
	lock_bypass <= not slv_wprot(1);
	--write_allowed <= (not lock_registers or lock_bypass);
	
	process(lock_registers, lock_bypass)
	variable use_mid : boolean := (C_S_AXI_AWUSER_WIDTH > 9);
	begin
	   if (use_mid) then
	       write_allowed <= (not lock_registers or lock_bypass);
	   else
	       write_allowed <= (not lock_registers);
	   end if;
	end process;
	
    process (S_AXI_ACLK)
    variable register_num : integer;
    variable region_num : integer;
    variable region_reg_num : integer;
    begin
        register_num := to_integer(unsigned(min_addr));
        region_num := to_integer(unsigned(region));
        region_reg_num := to_integer(unsigned(region_reg));
        if rising_edge(S_AXI_ACLK) then 
            if S_AXI_ARESETN = '0' then
                ctrl_reg            <= C_CTRL_REG_VAL;
                --errs1_reg         <= C_ERRS1_REG_INIT;
                --errs2_reg         <= C_ERRS2_REG_INIT;
                poison_reg          <= C_POISON_REG_VAL;
                --isr_reg           <= C_ISR_REG_INIT;
                --imr_reg           <= C_IMR_REG_INIT;
                ien_reg             <= C_IEN_REG_INIT;
                ids_reg             <= C_IDS_REG_INIT;
                lock_reg            <= C_LOCK_REG_VAL;
                bypass_reg          <= C_BYPASS_REG_VAL;
                --regions_reg       <= C_REGIONS_REG_INIT;
                r_start_reg  (0)    <= C_R00_START_REG_VAL;
                r_end_reg    (0)    <= C_R00_END_REG_VAL;
                r_masters_reg(0)    <= C_R00_MASTERS_REG_VAL;
                r_config_reg (0)    <= C_R00_CONFIG_REG_VAL;
                r_start_reg  (1)    <= C_R01_START_REG_VAL;
                r_end_reg    (1)    <= C_R01_END_REG_VAL;
                r_masters_reg(1)    <= C_R01_MASTERS_REG_VAL;
                r_config_reg (1)    <= C_R01_CONFIG_REG_VAL;
                r_start_reg  (2)    <= C_R02_START_REG_VAL;
                r_end_reg    (2)    <= C_R02_END_REG_VAL;
                r_masters_reg(2)    <= C_R02_MASTERS_REG_VAL;
                r_config_reg (2)    <= C_R02_CONFIG_REG_VAL;
                r_start_reg  (3)    <= C_R03_START_REG_VAL;
                r_end_reg    (3)    <= C_R03_END_REG_VAL;
                r_masters_reg(3)    <= C_R03_MASTERS_REG_VAL;
                r_config_reg (3)    <= C_R03_CONFIG_REG_VAL;
                r_start_reg  (4)    <= C_R04_START_REG_VAL;
                r_end_reg    (4)    <= C_R04_END_REG_VAL;
                r_masters_reg(4)    <= C_R04_MASTERS_REG_VAL;
                r_config_reg (4)    <= C_R04_CONFIG_REG_VAL;
                r_start_reg  (5)    <= C_R05_START_REG_VAL;
                r_end_reg    (5)    <= C_R05_END_REG_VAL;
                r_masters_reg(5)    <= C_R05_MASTERS_REG_VAL;
                r_config_reg (5)    <= C_R05_CONFIG_REG_VAL;
                r_start_reg  (6)    <= C_R06_START_REG_VAL;
                r_end_reg    (6)    <= C_R06_END_REG_VAL;
                r_masters_reg(6)    <= C_R06_MASTERS_REG_VAL;
                r_config_reg (6)    <= C_R06_CONFIG_REG_VAL;
                r_start_reg  (7)    <= C_R07_START_REG_VAL;
                r_end_reg    (7)    <= C_R07_END_REG_VAL;
                r_masters_reg(7)    <= C_R07_MASTERS_REG_VAL;
                r_config_reg (7)    <= C_R07_CONFIG_REG_VAL;
                r_start_reg  (8)    <= C_R08_START_REG_VAL;
                r_end_reg    (8)    <= C_R08_END_REG_VAL;
                r_masters_reg(8)    <= C_R08_MASTERS_REG_VAL;
                r_config_reg (8)    <= C_R08_CONFIG_REG_VAL;
                r_start_reg  (9)    <= C_R09_START_REG_VAL;
                r_end_reg    (9)    <= C_R09_END_REG_VAL;
                r_masters_reg(9)    <= C_R09_MASTERS_REG_VAL;
                r_config_reg (9)    <= C_R09_CONFIG_REG_VAL;
                r_start_reg  (10)    <= C_R10_START_REG_VAL;
                r_end_reg    (10)    <= C_R10_END_REG_VAL;
                r_masters_reg(10)    <= C_R10_MASTERS_REG_VAL;
                r_config_reg (10)    <= C_R10_CONFIG_REG_VAL;
                r_start_reg  (11)    <= C_R11_START_REG_VAL;
                r_end_reg    (11)    <= C_R11_END_REG_VAL;
                r_masters_reg(11)    <= C_R11_MASTERS_REG_VAL;
                r_config_reg (11)    <= C_R11_CONFIG_REG_VAL;
                r_start_reg  (12)    <= C_R12_START_REG_VAL;  
                r_end_reg    (12)    <= C_R12_END_REG_VAL;    
                r_masters_reg(12)    <= C_R12_MASTERS_REG_VAL;
                r_config_reg (12)    <= C_R12_CONFIG_REG_VAL; 
                r_start_reg  (13)    <= C_R13_START_REG_VAL;  
                r_end_reg    (13)    <= C_R13_END_REG_VAL;    
                r_masters_reg(13)    <= C_R13_MASTERS_REG_VAL;
                r_config_reg (13)    <= C_R13_CONFIG_REG_VAL; 
                r_start_reg  (14)    <= C_R14_START_REG_VAL;  
                r_end_reg    (14)    <= C_R14_END_REG_VAL;    
                r_masters_reg(14)    <= C_R14_MASTERS_REG_VAL;
                r_config_reg (14)    <= C_R14_CONFIG_REG_VAL; 
                r_start_reg  (15)    <= C_R15_START_REG_VAL;  
                r_end_reg    (15)    <= C_R15_END_REG_VAL;    
                r_masters_reg(15)    <= C_R15_MASTERS_REG_VAL;
                r_config_reg (15)    <= C_R15_CONFIG_REG_VAL; 
                update_isr_reg      <= '0';
                update_isr_reg_en   <= '0';
                isr_reg_data  <= (others => '0');
                update_imr_reg <= '0';
                update_imr_reg_en <= '0';
                update_region_reg <= '0';
                update_region_reg_en <= '0';
            else
                --slv_reg_wren_reg    <= '0';
                if (slv_reg_wren = '1') then
                    --slv_reg_wren_reg          <= '1';
                    if (maj_addr = '0') then
                    --CONFIGURATION CONTROL REGISTERS
                        case register_num is
                        when C_CTRL_REG_NUM =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( (S_AXI_WSTRB(byte_index) = '1') and (write_allowed = '1') ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    ctrl_reg(byte_index*8+7 downto byte_index*8) <= 
                                        C_CTRL_REG_MASK(byte_index*8+7 downto byte_index*8) and 
                                        S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                                end if;
                            end loop;
                        when C_POISON_REG_NUM =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( (S_AXI_WSTRB(byte_index) = '1') and (write_allowed = '1') ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    poison_reg(byte_index*8+7 downto byte_index*8) <= 
                                        C_POISON_REG_MASK(byte_index*8+7 downto byte_index*8) and 
                                        S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                                end if;
                            end loop;
                        when C_ISR_REG_NUM =>
                            --for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( S_AXI_WSTRB(0) = '1' ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    isr_reg_data <= S_AXI_WDATA(7 downto 0);
                                    reg_intr_ack <= S_AXI_WDATA(3 downto 1);
                                    update_isr_reg_en <= '1';
                                end if;
                            --end loop;
                        when C_IEN_REG_NUM =>
                            --for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( S_AXI_WSTRB(0) = '1' ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    ien_reg(7 downto 0) <= S_AXI_WDATA(7 downto 0);
                                    update_imr_reg_en <= '1';
                                end if;
                            --end loop;
                        when C_IDS_REG_NUM =>
                            --for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( S_AXI_WSTRB(0) = '1' ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    ids_reg(7 downto 0) <= S_AXI_WDATA(7 downto 0);
                                    update_imr_reg_en <= '1';
                                end if;
                            --end loop;
                        when C_LOCK_REG_NUM =>
                            --for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( (S_AXI_WSTRB(0) = '1') and (write_allowed = '1') ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    lock_reg(7 downto 0) <= S_AXI_WDATA(7 downto 0);
                                end if;
                            --end loop;
                        when C_BYPASS_REG_NUM =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( (S_AXI_WSTRB(byte_index) = '1') and (write_allowed = '1') ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    bypass_reg(byte_index*8+7 downto byte_index*8) <= 
                                        C_BYPASS_REG_MASK(byte_index*8+7 downto byte_index*8) and 
                                        S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                                end if;
                            end loop;
                        when others => NULL;
                        end case;
                    else
                    --REGION REGISTERS
                        case region_reg_num is
                        when C_R_START_REG_NUM =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( (S_AXI_WSTRB(byte_index) = '1') and (write_allowed = '1') ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    r_start_reg(region_num)(byte_index*8+7 downto byte_index*8) <= 
                                        C_R_START_REG_MASK(byte_index*8+7 downto byte_index*8) and 
                                        S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                               end if;
                            end loop;
                        when C_R_END_REG_NUM =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( (S_AXI_WSTRB(byte_index) = '1') and (write_allowed = '1') ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    r_end_reg(region_num)(byte_index*8+7 downto byte_index*8) <= 
                                        C_R_END_REG_MASK(byte_index*8+7 downto byte_index*8) and 
                                        S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                                end if;
                            end loop;
                        when C_R_MASTERS_REG_NUM =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( (S_AXI_WSTRB(byte_index) = '1') and (write_allowed = '1') ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    r_masters_reg(region_num)(byte_index*8+7 downto byte_index*8) <= 
                                        C_R_MASTERS_REG_MASK(byte_index*8+7 downto byte_index*8) and 
                                        S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                                end if;
                            end loop;
                        when C_R_CONFIG_REG_NUM =>
                            for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                                if ( (S_AXI_WSTRB(byte_index) = '1') and (write_allowed = '1') ) then
                                    -- Respective byte enables are asserted as per write strobes                   
                                    r_config_reg(region_num)(byte_index*8+7 downto byte_index*8) <= 
                                        C_R_CONFIG_REG_MASK(byte_index*8+7 downto byte_index*8) and 
                                        S_AXI_WDATA(byte_index*8+7 downto byte_index*8);
                                end if;
                            end loop;
                            update_region_reg_en <= '1';
                       when others => NULL;
                        end case;
                    end if;
                else
                    if (update_isr_reg_en = '1') then
                        update_isr_reg <= '1';
                        update_isr_reg_en <= '0';
                        reg_intr_ack <= (others => '0'); 
                    elsif (update_imr_reg_en = '1') then
                        update_imr_reg <= '1';
                        update_imr_reg_en <= '0';
                    elsif (update_region_reg_en = '1') then
                        update_region_reg <= '1';
                        update_region_reg_en <= '0';
                    else
                        update_isr_reg <= '0';
                        update_imr_reg <= '0';
                        update_region_reg <= '0';
                        ien_reg <= C_IEN_REG_INIT;
                        ids_reg <= C_IDS_REG_INIT;
                    end if;
                end if;
            end if;
        end if;
    end process;
       
    --Update Status Registers
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then 
            if S_AXI_ARESETN = '0' then
                errs1_reg <= C_ERRS1_REG_INIT;
                errs2_reg <= C_ERRS2_REG_INIT;
            elsif (axi_blocked /= "00") then
                errs1_reg <= err_status1_in;
                errs2_reg <= err_status2_in;
            end if;
        end if;
    end process;
       
    --Update ISR Register
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then 
            if S_AXI_ARESETN = '0' then
                isr_reg    <= C_ISR_REG_INIT;
                isr_event  <= '0';
            elsif (update_isr_reg = '1') then
                isr_reg(7 downto 0) <= isr_reg(7 downto 0) and not isr_reg_data;
                --end if;
            elsif (read_blocked = '1' and isr_event = '0') then
                isr_reg(1) <= not imr_reg(1);
                isr_reg(3) <= not imr_reg(3);
                isr_event  <= '1';
            elsif (write_blocked = '1' and isr_event = '0') then
                isr_reg(2) <= not imr_reg(2);
                isr_reg(3) <= not imr_reg(3);
                isr_event  <= '1';
            else
                isr_event  <= '0';
            end if;
        end if;
    end process;
        
    --Update IMR Register
    process (S_AXI_ACLK)
    begin
        if rising_edge(S_AXI_ACLK) then 
            if S_AXI_ARESETN = '0' then
                imr_reg    <= C_IMR_REG_VAL;
            elsif (update_imr_reg = '1') then
                imr_reg(7 downto 0) <= (imr_reg(7 downto 0) and 
                    not ien_reg(7 downto 0)) or ids_reg(7 downto 0);
            end if;
        end if;
    end process;
    
    --Update Regions Register
    EN_REGIONS: for i in 0 to 15 generate
        regions_en(i) <= r_config_reg(i)(0);
    end generate EN_REGIONS;
    
    process (S_AXI_ACLK)
    variable region_count : integer;
    begin
        region_count := COUNT_ONES_16BIT(regions_en);
        if rising_edge(S_AXI_ACLK) then 
            if S_AXI_ARESETN = '0' then
                regions_reg    <= C_REGIONS_REG_INIT;
            elsif (update_region_reg = '1') then
                regions_reg <= C_REGIONS_REG_MASK and 
                    std_logic_vector(to_unsigned(region_count, 32));
            end if;
        end if;
    end process;
    
    -- Read Data from Register
	   process( S_AXI_ACLK ) is
    variable register_num : integer;
    begin
        register_num := to_integer(unsigned(axi_araddr(8 downto 2)));
        if ( rising_edge (S_AXI_ACLK) ) then
	        if ( reg_rden = '1') then 
                for byte_index in 0 to (C_S_AXI_DATA_WIDTH/8-1) loop
                    mem_data_out(0)((byte_index*8+7) downto byte_index*8) <= 
                            config_reg(register_num)((byte_index*8+7) downto byte_index*8);
                end loop;
	        end if;
	    end if;
	end process;
    
    -- Process Interrupts
    reg_intr_en <= not imr_reg(3 downto 1);
    reg_global_intr_en(0) <= '1';
    
    gen_intr_statpen_reg  : for i in 0 to (C_NUM_OF_INTR - 1) generate                      
    begin                                                                           
        process (S_AXI_ACLK)                                                          
        begin                                                                         
          if rising_edge(S_AXI_ACLK) then                                             
            if ((S_AXI_ARESETN = '0') or (reg_intr_ack(i) = '1')) then                   
              reg_intr_sts(i) <= '0';                                                 
            else                                                                      
              reg_intr_sts(i) <= det_intr(i);                                         
            end if;                                                                   
          end if;                                                                     
        end process;                                                                  
                                                                                          
        process (S_AXI_ACLK)                                                          
        begin                                                                         
          if rising_edge(S_AXI_ACLK) then                                             
            if ((S_AXI_ARESETN = '0') or  (reg_intr_ack(i) = '1')) then                   
              reg_intr_pending(i) <= '0';                                             
            else                                                                      
                reg_intr_pending(i) <= reg_intr_sts(i) and reg_intr_en(i);            
            end if;                                                                   
          end if;                                                                     
        end process;                                                                  
                                                                              
      end generate gen_intr_statpen_reg;                                                

      -- map the interrupt inputs to the interrupt bus
      process( S_AXI_ACLK ) is                                                           
        begin                                                                            
          if (rising_edge (S_AXI_ACLK)) then                                             
            if ( S_AXI_ARESETN = '0') then                                               
              intr <= (others => '0');                                                   
            else                                                                         
              intr <=  isr_reg(3) & isr_reg(2) & isr_reg(1);
            end if;                                                                      
          end if;                                                                        
      end process;                                                                       
    
    -- detects interrupt in any intr input                                           
    process (S_AXI_ACLK)                                                             
      variable temp : std_logic;                                                     
      begin                                                                          
        if (rising_edge (S_AXI_ACLK)) then                                           
          if( S_AXI_ARESETN = '0' or intr_ack_all_ff = '1') then                     
            intr_all <= '0';                                                         
          else                                                                       
            intr_all <= or_reduce(reg_intr_pending);                              
          end if;                                                                    
        end if;                                                                      
    end process;                                                                     
                                                                                     
    -- detects intr ack in any reg_intr_ack reg bits                                 
    process (S_AXI_ACLK)                                                             
      variable temp : std_logic;                                                     
      begin                                                                          
        if (rising_edge (S_AXI_ACLK)) then                                           
          if( S_AXI_ARESETN = '0' or intr_ack_all_ff = '1') then                     
            intr_ack_all <= '0';                                                     
          else                                                                       
            intr_ack_all <= or_reduce(reg_intr_ack);                              
          end if;                                                                    
        end if;                                                                      
    end process;                                                                     
                                                                                     
      process( S_AXI_ACLK ) is                                                           
        begin                                                                            
          if (rising_edge (S_AXI_ACLK)) then                                             
            if ( S_AXI_ARESETN = '0') then                                               
              intr_ack_all_ff <= '0';                                                    
            else                                                                         
              intr_ack_all_ff <= intr_ack_all;                                           
            end if;                                                                      
         end if;                                                                         
      end process;                                                                       
                                                                                         
                                                                                         
      gen_intr_detection  : for i in 0 to (C_NUM_OF_INTR - 1) generate                   
        signal s_irq_lvl: std_logic;                                                     
        begin                                                                            
          gen_intr_level_detect: if (C_INTR_SENSITIVITY(i) = '1') generate               
          begin                                                                          
              gen_intr_active_high_detect: if (C_INTR_ACTIVE_STATE(i) = '1') generate    
              begin                                                                      
                                                                                         
                process( S_AXI_ACLK ) is                                                 
                  begin                                                                  
                    if (rising_edge (S_AXI_ACLK)) then                                   
                      if ( S_AXI_ARESETN = '0' or reg_intr_ack(i) = '1') then            
                        det_intr(i) <= '0';                                              
                      else                                                               
                        if (intr(i) = '1') then                                          
                          det_intr(i) <= '1';                                            
                        end if;                                                          
                     end if;                                                             
                   end if;                                                               
                end process;                                                             
              end generate gen_intr_active_high_detect;                                  
                                                                                         
              gen_intr_active_low_detect: if (C_INTR_ACTIVE_STATE(i) = '0') generate     
                process( S_AXI_ACLK ) is                                                 
                  begin                                                                  
                    if (rising_edge (S_AXI_ACLK)) then                                   
                      if ( S_AXI_ARESETN = '0' or reg_intr_ack(i) = '1') then            
                        det_intr(i) <= '0';                                              
                      else                                                               
                        if (intr(i) = '0') then                                          
                          det_intr(i) <= '1';                                            
                        end if;                                                          
                      end if;                                                            
                    end if;                                                              
                end process;                                                             
              end generate gen_intr_active_low_detect;                                   
                                                                                         
          end generate gen_intr_level_detect;                                            
                                                                                         
                                                                                
          gen_intr_edge_detect: if (C_INTR_SENSITIVITY(i) = '0') generate                
            signal intr_edge : std_logic_vector (C_NUM_OF_INTR-1 downto 0);              
            signal intr_ff : std_logic_vector (C_NUM_OF_INTR-1 downto 0);                
            signal intr_ff2 : std_logic_vector (C_NUM_OF_INTR-1 downto 0);               
            begin                                                                        
              gen_intr_rising_edge_detect: if (C_INTR_ACTIVE_STATE(i) = '1') generate    
              begin                                                                      
                process( S_AXI_ACLK ) is                                                 
                  begin                                                                  
                    if (rising_edge (S_AXI_ACLK)) then                                   
                      if ( S_AXI_ARESETN = '0') then --or reg_intr_ack(i) = '1') then            
                        intr_ff(i) <= '0';                                               
                        intr_ff2(i) <= '0';                                              
                      else                                                               
                        intr_ff(i) <= intr(i);                                           
                        intr_ff2(i) <= intr_ff(i);                                       
                     end if;                                                             
                    end if;                                                              
                end process;                                                             
                                                                                         
                intr_edge(i) <= intr_ff(i) and (not intr_ff2(i));                        
                                                                                         
                process( S_AXI_ACLK ) is                                                 
                  begin                                                                  
                   if (rising_edge (S_AXI_ACLK)) then                                    
                     if ( S_AXI_ARESETN = '0' or reg_intr_ack(i) = '1') then             
                       det_intr(i) <= '0';                                               
                     elsif (intr_edge(i) = '1') then                                     
                       det_intr(i) <= '1';                                               
                     end if;                                                             
                   end if;                                                               
                 end process;                                                            
                                                                                         
              end generate gen_intr_rising_edge_detect;                                  
                                                                                         
              gen_intr_falling_edge_detect: if (C_INTR_ACTIVE_STATE(i) = '0') generate   
              begin                                                                      
                process( S_AXI_ACLK ) is                                                 
                  begin                                                                  
                    if (rising_edge (S_AXI_ACLK)) then                                   
                      if ( S_AXI_ARESETN = '0') then --or reg_intr_ack(i) = '1') then            
                        intr_ff(i) <= '0';                                               
                        intr_ff2(i) <= '0';                                              
                      else                                                               
                        intr_ff(i) <= intr(i);                                           
                        intr_ff2(i) <= intr_ff(i);                                       
                      end if;                                                            
                    end if;                                                              
                end process;                                                             
                                                                                         
                intr_edge(i) <= intr_ff2(i) and (not intr_ff(i));                        
                                                                                         
                process( S_AXI_ACLK ) is                                                 
                  begin                                                                  
                    if (rising_edge (S_AXI_ACLK)) then                                   
                      if ( S_AXI_ARESETN = '0' or reg_intr_ack(i) = '1') then            
                        det_intr(i) <= '0';                                              
                      elsif (intr_edge(i) = '1') then                                    
                        det_intr(i) <= '1';                                              
                      end if;                                                            
                    end if;                                                              
                end process;                                                             
              end generate gen_intr_falling_edge_detect;                                 
                                                                                         
          end generate gen_intr_edge_detect;                                             
                                                                                         
          -- IRQ generation logic                                                        
                                                                                         
         gen_irq_level: if (C_IRQ_SENSITIVITY = 1) generate                              
         begin                                                                           
             irq_level_high: if (C_IRQ_ACTIVE_STATE = 1) generate                        
             begin                                                                       
               process( S_AXI_ACLK ) is                                                  
                 begin                                                                   
                   if (rising_edge (S_AXI_ACLK)) then                                    
                     if ( S_AXI_ARESETN = '0' or intr_ack_all = '1') then                
                       s_irq_lvl <= '0';                                                 
                     elsif (intr_all = '1' and reg_global_intr_en(0) = '1') then         
                       s_irq_lvl <= '1';                                                 
                    end if;                                                              
                   end if;                                                               
               end process;                                                              
                                                                                         
               s_irq <= s_irq_lvl;                                                       
             end generate irq_level_high;                                                
                                                                                         
                                                                                        
             irq_level_low: if (C_IRQ_ACTIVE_STATE = 0) generate                         
                process( S_AXI_ACLK ) is                                                 
                  begin                                                                  
                    if (rising_edge (S_AXI_ACLK)) then                                   
                      if ( S_AXI_ARESETN = '0' or intr_ack_all = '1') then               
                        s_irq_lvl <= '1';                                                
                      elsif (intr_all = '1' and reg_global_intr_en(0) = '1') then        
                        s_irq_lvl <= '0';                                                
                     end if;                                                             
                   end if;                                                               
                 end process;                                                            
                                                                                         
               s_irq <= s_irq_lvl;                                                       
             end generate irq_level_low;                                                 
                                                                                         
         end generate gen_irq_level;                                                     
                                                                                         
                                                                                         
         gen_irq_edge: if (C_IRQ_SENSITIVITY = 0) generate                               
                                                                                         
         signal s_irq_lvl_ff:std_logic;                                                  
         begin                                                                           
             irq_rising_edge: if (C_IRQ_ACTIVE_STATE = 1) generate                       
             begin                                                                       
               process( S_AXI_ACLK ) is                                                  
                 begin                                                                   
                   if (rising_edge (S_AXI_ACLK)) then                                    
                     if ( S_AXI_ARESETN = '0' or intr_ack_all = '1') then                
                       s_irq_lvl <= '0';                                                 
                       s_irq_lvl_ff <= '0';                                              
                     elsif (intr_all = '1' and reg_global_intr_en(0) = '1') then         
                       s_irq_lvl <= '1';                                                 
                       s_irq_lvl_ff <= s_irq_lvl;                                        
                    end if;                                                              
                  end if;                                                                
               end process;                                                              
                                                                                         
               s_irq <= s_irq_lvl and (not s_irq_lvl_ff);                                
             end generate irq_rising_edge;                                               
                                                                                         
             irq_falling_edge: if (C_IRQ_ACTIVE_STATE = 0) generate                      
             begin                                                                       
               process( S_AXI_ACLK ) is                                                  
                 begin                                                                   
                   if (rising_edge (S_AXI_ACLK)) then                                    
                     if ( S_AXI_ARESETN = '0' or intr_ack_all = '1') then                
                       s_irq_lvl <= '1';                                                 
                       s_irq_lvl_ff <= '1';                                              
                     elsif (intr_all = '1' and reg_global_intr_en(0) = '1') then         
                       s_irq_lvl <= '0';                                                 
                       s_irq_lvl_ff <= s_irq_lvl;                                        
                     end if;                                                             
                   end if;                                                               
               end process;                                                              
                                                                                         
               s_irq <= not (s_irq_lvl_ff and (not s_irq_lvl));                          
             end generate irq_falling_edge;                                              
                                                                                         
         end generate gen_irq_edge;                                                      
                                                                                         
         irq <= s_irq;                                                              
      end generate gen_intr_detection;                                                   
    
    
    -- Read Data from Register
    -- CONFIGURATION REGISTERS OUT
    config_reg(C_CTRL_REG_NUM)          <= ctrl_reg;
    config_reg(C_ERR_STATUS1_REG_NUM)   <= errs1_reg;
    config_reg(C_ERR_STATUS2_REG_NUM)   <= errs2_reg;
    config_reg(C_POISON_REG_NUM)        <= poison_reg;
    config_reg(C_ISR_REG_NUM)           <= isr_reg;
    config_reg(C_IMR_REG_NUM)           <= imr_reg;
    config_reg(C_IEN_REG_NUM)           <= ien_reg;
    config_reg(C_IDS_REG_NUM)           <= ids_reg;
    config_reg(C_LOCK_REG_NUM)          <= lock_reg;
    config_reg(C_BYPASS_REG_NUM)        <= bypass_reg;
    config_reg(C_REGIONS_REG_NUM)       <= regions_reg;
    REGION_REGS: for n in 0 to 15 generate
    begin
        config_reg((4*n)+C_R00_START_REG_NUM)   <= r_start_reg(n);
        config_reg((4*n)+C_R00_END_REG_NUM)     <= r_end_reg(n);
        config_reg((4*n)+C_R00_MASTERS_REG_NUM) <= r_masters_reg(n);
        config_reg((4*n)+C_R00_CONFIG_REG_NUM)  <= r_config_reg(n);
    end generate REGION_REGS;
    
    
	-- User logic ends

end arch_imp;
