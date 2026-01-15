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
--  /   /         Filename: ZUP_ZMPU_PL_v1_0.vhd         
-- /___/   /\     Timestamp: $DateTime: 2020/03/02 10:38:05 $
-- \   \  /  \
--  \___\/\___\
--
--
-- Purpose: This module implements a PL memory and peripheral protection unit.
--
-- Instantiates   : ZUP_XMPU_PL_S_AXI, ZUP_XMPU_PL_M_AXI
-- Requirements Addressed :  
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library xil_defaultlib;
use xil_defaultlib.xmpu_pl_package.all;

entity zupl_xmpu_v1_0 is
	generic (
		-- Users to add parameters here
	    C_REGIONS_MAX          : integer := 16;
        C_CTRL_REG_VAL         : std_logic_vector(31 downto 0):= C_CTRL_REG_INIT     ;
        C_POISON_REG_VAL       : std_logic_vector(31 downto 0):= C_POISON_REG_INIT   ;
        C_IMR_REG_VAL          : std_logic_vector(31 downto 0):= C_IMR_REG_INIT      ;
        C_LOCK_REG_VAL         : std_logic_vector(31 downto 0):= C_LOCK_REG_INIT     ;
        C_BYPASS_REG_VAL       : std_logic_vector(31 downto 0):= C_BYPASS_REG_INIT   ;
        C_R00_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R00_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R00_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R00_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R01_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R01_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R01_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R01_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R02_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R02_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R02_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R02_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R03_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R03_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R03_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R03_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R04_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R04_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R04_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R04_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R05_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R05_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R05_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R05_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R06_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R06_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R06_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R06_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R07_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R07_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R07_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R07_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R08_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R08_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R08_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R08_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R09_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R09_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R09_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R09_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R10_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R10_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R10_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R10_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R11_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R11_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R11_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R11_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R12_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R12_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R12_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R12_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R13_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R13_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R13_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R13_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R14_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R14_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R14_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R14_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;
        C_R15_START_REG_VAL    : std_logic_vector(31 downto 0):= C_R_START_REG_INIT  ;
        C_R15_END_REG_VAL      : std_logic_vector(31 downto 0):= C_R_END_REG_INIT    ;
        C_R15_MASTERS_REG_VAL  : std_logic_vector(31 downto 0):= C_R_MASTERS_REG_INIT;
        C_R15_CONFIG_REG_VAL   : std_logic_vector(31 downto 0):= C_R_CONFIG_REG_INIT ;

		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S_AXI_XMPU
		C_S_AXI_XMPU_ID_WIDTH     : integer	:= 1;
		C_S_AXI_XMPU_DATA_WIDTH   : integer	:= 32;
		C_S_AXI_XMPU_ADDR_WIDTH	  : integer	:= 9;
		C_S_AXI_XMPU_AWUSER_WIDTH : integer	:= 0;
		C_S_AXI_XMPU_ARUSER_WIDTH : integer	:= 0;
		C_S_AXI_XMPU_WUSER_WIDTH  : integer	:= 0;
		C_S_AXI_XMPU_RUSER_WIDTH  : integer	:= 0;
		C_S_AXI_XMPU_BUSER_WIDTH  : integer	:= 0;

		-- Parameters of Axi Slave Bus Interface M_AXI_IN
		C_S_AXI_ID_WIDTH       : integer	:= 16;
		C_S_AXI_DATA_WIDTH     : integer	:= 32;
		C_S_AXI_ADDR_WIDTH     : integer	:= 40;
		C_S_AXI_AWUSER_WIDTH   : integer	:= 16;
		C_S_AXI_ARUSER_WIDTH   : integer	:= 16;
		C_S_AXI_WUSER_WIDTH    : integer	:= 0;
		C_S_AXI_RUSER_WIDTH    : integer	:= 0;
		C_S_AXI_BUSER_WIDTH    : integer	:= 0;

 		-- Parameters of Axi Slave Bus Interface M_AXI_IN
		--C_M_AXI_OUT_DATA_WIDTH    : integer	:= 32;
 		
 		
        -- Parameters of Axi Slave Bus Interface S_AXI_INTR
        C_IRQ_SENSITIVITY         : integer  := 1;
        C_IRQ_ACTIVE_STATE        : integer  := 1
	);
	port (
		-- Users to add ports here
        ctrl_reg_out            : out std_logic_vector(31 downto 0);
        err_status1_reg_out     : out std_logic_vector(31 downto 0);
        err_status2_reg_out     : out std_logic_vector(31 downto 0);
        poison_reg_out          : out std_logic_vector(31 downto 0);
        isr_reg_out             : out std_logic_vector(31 downto 0);
        imr_reg_out             : out std_logic_vector(31 downto 0);
        lock_reg_out            : out std_logic_vector(31 downto 0);
        lock_bypass_reg_out     : out std_logic_vector(31 downto 0);
        regions_reg_out         : out std_logic_vector(31 downto 0);
        r00_start_reg_out       : out std_logic_vector(31 downto 0);
        r00_end_reg_out         : out std_logic_vector(31 downto 0);
        r00_masters_reg_out     : out std_logic_vector(31 downto 0);
        r00_config_reg_out      : out std_logic_vector(31 downto 0);

		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S_AXI_XMPU
		s_axi_xmpu_aclk         : in std_logic;
		s_axi_xmpu_aresetn      : in std_logic;
		s_axi_xmpu_awid	        : in std_logic_vector(C_S_AXI_XMPU_ID_WIDTH-1 downto 0);
		s_axi_xmpu_awaddr       : in std_logic_vector(C_S_AXI_XMPU_ADDR_WIDTH-1 downto 0);
		s_axi_xmpu_awlen        : in std_logic_vector(7 downto 0);
		s_axi_xmpu_awsize       : in std_logic_vector(2 downto 0);
		s_axi_xmpu_awburst	    : in std_logic_vector(1 downto 0);
		s_axi_xmpu_awlock	    : in std_logic;
		s_axi_xmpu_awcache	    : in std_logic_vector(3 downto 0);
		s_axi_xmpu_awprot	    : in std_logic_vector(2 downto 0);
		s_axi_xmpu_awqos	    : in std_logic_vector(3 downto 0);
		s_axi_xmpu_awregion	    : in std_logic_vector(3 downto 0);
		s_axi_xmpu_awuser	    : in std_logic_vector(C_S_AXI_XMPU_AWUSER_WIDTH-1 downto 0);
		s_axi_xmpu_awvalid	    : in std_logic;
		s_axi_xmpu_awready	    : out std_logic;
		s_axi_xmpu_wdata	    : in std_logic_vector(C_S_AXI_XMPU_DATA_WIDTH-1 downto 0);
		s_axi_xmpu_wstrb	    : in std_logic_vector((C_S_AXI_XMPU_DATA_WIDTH/8)-1 downto 0);
		s_axi_xmpu_wlast	    : in std_logic;
		s_axi_xmpu_wuser	    : in std_logic_vector(C_S_AXI_XMPU_WUSER_WIDTH-1 downto 0);
		s_axi_xmpu_wvalid	    : in std_logic;
		s_axi_xmpu_wready	    : out std_logic;
		s_axi_xmpu_bid	        : out std_logic_vector(C_S_AXI_XMPU_ID_WIDTH-1 downto 0);
		s_axi_xmpu_bresp	    : out std_logic_vector(1 downto 0);
		s_axi_xmpu_buser	    : out std_logic_vector(C_S_AXI_XMPU_BUSER_WIDTH-1 downto 0);
		s_axi_xmpu_bvalid	    : out std_logic;
		s_axi_xmpu_bready	    : in std_logic;
		s_axi_xmpu_arid	        : in std_logic_vector(C_S_AXI_XMPU_ID_WIDTH-1 downto 0);
		s_axi_xmpu_araddr	    : in std_logic_vector(C_S_AXI_XMPU_ADDR_WIDTH-1 downto 0);
		s_axi_xmpu_arlen	    : in std_logic_vector(7 downto 0);
		s_axi_xmpu_arsize	    : in std_logic_vector(2 downto 0);
		s_axi_xmpu_arburst	    : in std_logic_vector(1 downto 0);
		s_axi_xmpu_arlock	    : in std_logic;
		s_axi_xmpu_arcache	    : in std_logic_vector(3 downto 0);
		s_axi_xmpu_arprot	    : in std_logic_vector(2 downto 0);
		s_axi_xmpu_arqos	    : in std_logic_vector(3 downto 0);
		s_axi_xmpu_arregion	    : in std_logic_vector(3 downto 0);
		s_axi_xmpu_aruser	    : in std_logic_vector(C_S_AXI_XMPU_ARUSER_WIDTH-1 downto 0);
		s_axi_xmpu_arvalid	    : in std_logic;
		s_axi_xmpu_arready	    : out std_logic;
		s_axi_xmpu_rid	        : out std_logic_vector(C_S_AXI_XMPU_ID_WIDTH-1 downto 0);
		s_axi_xmpu_rdata	    : out std_logic_vector(C_S_AXI_XMPU_DATA_WIDTH-1 downto 0);
		s_axi_xmpu_rresp	    : out std_logic_vector(1 downto 0);
		s_axi_xmpu_rlast	    : out std_logic;
		s_axi_xmpu_ruser	    : out std_logic_vector(C_S_AXI_XMPU_RUSER_WIDTH-1 downto 0);
		s_axi_xmpu_rvalid	    : out std_logic;
		s_axi_xmpu_rready	    : in std_logic;
        irq                     : out std_logic;
        
		-- Ports of Axi Slave Bus Interface M_AXI_IN
		s_axi_aclk	        : in std_logic;
		s_axi_aresetn	    : in std_logic;
		s_axi_awid	        : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		s_axi_awaddr	        : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_awlen	        : in std_logic_vector(7 downto 0);
		s_axi_awsize	        : in std_logic_vector(2 downto 0);
		s_axi_awburst	    : in std_logic_vector(1 downto 0);
		s_axi_awlock	        : in std_logic;
		s_axi_awcache	    : in std_logic_vector(3 downto 0);
		s_axi_awprot	        : in std_logic_vector(2 downto 0);
		s_axi_awqos	        : in std_logic_vector(3 downto 0);
		s_axi_awregion	    : in std_logic_vector(3 downto 0);
		s_axi_awuser	        : in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		s_axi_awvalid	    : in std_logic;
		s_axi_awready	    : out std_logic;
		s_axi_wdata	        : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_wstrb	        : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		s_axi_wlast	        : in std_logic;
		--s_axi_wuser		: in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		s_axi_wvalid	        : in std_logic;
		s_axi_wready	        : out std_logic;
		s_axi_bid	        : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		s_axi_bresp	        : out std_logic_vector(1 downto 0);
		--s_axi_buser		: out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		s_axi_bvalid	        : out std_logic;
		s_axi_bready	        : in std_logic;
		s_axi_arid	        : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		s_axi_araddr	        : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		s_axi_arlen	        : in std_logic_vector(7 downto 0);
		s_axi_arsize	        : in std_logic_vector(2 downto 0);
		s_axi_arburst	    : in std_logic_vector(1 downto 0);
		s_axi_arlock	        : in std_logic;
		s_axi_arcache	    : in std_logic_vector(3 downto 0);
		s_axi_arprot	        : in std_logic_vector(2 downto 0);
		s_axi_arqos	        : in std_logic_vector(3 downto 0);
		s_axi_arregion	    : in std_logic_vector(3 downto 0);
		s_axi_aruser	        : in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		s_axi_arvalid	    : in std_logic;
		s_axi_arready	    : out std_logic;
		s_axi_rid	        : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		s_axi_rdata	        : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		s_axi_rresp	        : out std_logic_vector(1 downto 0);
		s_axi_rlast	        : out std_logic;
		--s_axi_ruser		: out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		s_axi_rvalid	        : out std_logic;
		s_axi_rready	        : in std_logic;

		-- Ports of Axi Master Bus Interface M_AXI_OUT
		--m_axi_aclk	: in std_logic;
		--m_axi_aresetn	: in std_logic;
		m_axi_awid		: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		m_axi_awaddr	: out std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		m_axi_awlen		: out std_logic_vector(7 downto 0);
		m_axi_awsize	: out std_logic_vector(2 downto 0);
		m_axi_awburst	: out std_logic_vector(1 downto 0);
		m_axi_awlock	: out std_logic;
		m_axi_awcache	: out std_logic_vector(3 downto 0);
		m_axi_awprot	: out std_logic_vector(2 downto 0);
		m_axi_awqos		: out std_logic_vector(3 downto 0);
		m_axi_awuser	: out std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		m_axi_awvalid	: out std_logic;
		m_axi_awready	: in std_logic;
		m_axi_wdata		: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		m_axi_wstrb		: out std_logic_vector(C_S_AXI_DATA_WIDTH/8-1 downto 0);
		m_axi_wlast		: out std_logic;
		--m_axi_wuser	: out std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		m_axi_wvalid	: out std_logic;
		m_axi_wready	: in std_logic;
		m_axi_bid		: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		m_axi_bresp		: in std_logic_vector(1 downto 0);
		--m_axi_buser	: in std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		m_axi_bvalid	: in std_logic;
		m_axi_bready	: out std_logic;
		m_axi_arid		: out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		m_axi_araddr	: out std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		m_axi_arlen		: out std_logic_vector(7 downto 0);
		m_axi_arsize	: out std_logic_vector(2 downto 0);
		m_axi_arburst	: out std_logic_vector(1 downto 0);
		m_axi_arlock	: out std_logic;
		m_axi_arcache	: out std_logic_vector(3 downto 0);
		m_axi_arprot	: out std_logic_vector(2 downto 0);
		m_axi_arqos		: out std_logic_vector(3 downto 0);
		m_axi_aruser	: out std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		m_axi_arvalid	: out std_logic;
		m_axi_arready	: in std_logic;
		m_axi_rid		: in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		m_axi_rdata		: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		m_axi_rresp		: in std_logic_vector(1 downto 0);
		m_axi_rlast		: in std_logic;
		--m_axi_ruser	: in std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		m_axi_rvalid	: in std_logic;
		m_axi_rready	: out std_logic
	);
end zupl_xmpu_v1_0;

architecture arch_imp of zupl_xmpu_v1_0 is

    -- component declaration
    component ZUP_XMPU_PL_S_AXI is
        generic (
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
		C_S_AXI_ID_WIDTH	    : integer	:= 1;
		C_S_AXI_DATA_WIDTH	    : integer	:= 32;
		C_S_AXI_ADDR_WIDTH	    : integer	:= 9;
		C_S_AXI_AWUSER_WIDTH	: integer	:= 0;
		C_S_AXI_ARUSER_WIDTH	: integer	:= 0;
		C_S_AXI_WUSER_WIDTH	    : integer	:= 0;
		C_S_AXI_RUSER_WIDTH	    : integer	:= 0;
		C_S_AXI_BUSER_WIDTH	    : integer	:= 0;
        C_IRQ_SENSITIVITY       : integer  := 1;
        C_IRQ_ACTIVE_STATE      : integer  := 1
        );
        port (
        config_reg_out          : out reg_array;
        axi_blocked             : in std_logic_vector(1 downto 0);
        err_status1_in          : in std_logic_vector(31 downto 0);
        err_status2_in          : in std_logic_vector(31 downto 0);
		S_AXI_ACLK	            : in std_logic;
		S_AXI_ARESETN	        : in std_logic;
		S_AXI_AWID	            : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_AWADDR	        : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWLEN	            : in std_logic_vector(7 downto 0);
		S_AXI_AWSIZE	        : in std_logic_vector(2 downto 0);
		S_AXI_AWBURST	        : in std_logic_vector(1 downto 0);
		S_AXI_AWLOCK	        : in std_logic;
		S_AXI_AWCACHE	        : in std_logic_vector(3 downto 0);
		S_AXI_AWPROT	        : in std_logic_vector(2 downto 0);
		S_AXI_AWQOS	            : in std_logic_vector(3 downto 0);
		S_AXI_AWREGION	        : in std_logic_vector(3 downto 0);
		S_AXI_AWUSER	        : in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		S_AXI_AWVALID	        : in std_logic;
		S_AXI_AWREADY	        : out std_logic;
		S_AXI_WDATA	            : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	            : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WLAST	            : in std_logic;
		S_AXI_WUSER	            : in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		S_AXI_WVALID	        : in std_logic;
		S_AXI_WREADY	        : out std_logic;
		S_AXI_BID	            : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_BRESP	            : out std_logic_vector(1 downto 0);
		S_AXI_BUSER	            : out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		S_AXI_BVALID	        : out std_logic;
		S_AXI_BREADY	        : in std_logic;
		S_AXI_ARID	            : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_ARADDR	        : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARLEN	            : in std_logic_vector(7 downto 0);
		S_AXI_ARSIZE	        : in std_logic_vector(2 downto 0);
		S_AXI_ARBURST	        : in std_logic_vector(1 downto 0);
		S_AXI_ARLOCK	        : in std_logic;
		S_AXI_ARCACHE	        : in std_logic_vector(3 downto 0);
		S_AXI_ARPROT	        : in std_logic_vector(2 downto 0);
		S_AXI_ARQOS	            : in std_logic_vector(3 downto 0);
		S_AXI_ARREGION	        : in std_logic_vector(3 downto 0);
		S_AXI_ARUSER	        : in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		S_AXI_ARVALID	        : in std_logic;
		S_AXI_ARREADY	        : out std_logic;
		S_AXI_RID	            : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_RDATA	            : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	            : out std_logic_vector(1 downto 0);
		S_AXI_RLAST	            : out std_logic;
		S_AXI_RUSER	            : out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		S_AXI_RVALID	        : out std_logic;
		S_AXI_RREADY	        : in std_logic;
        irq                     : out std_logic
        );
    end component ZUP_XMPU_PL_S_AXI;

    component ZUP_XMPU_PL_M_AXI is
        generic (
        C_REGIONS_MAX           : integer   := 16;
        C_S_AXI_ID_WIDTH        : integer	:= 1;
        C_S_AXI_DATA_WIDTH      : integer	:= 128;
        C_S_AXI_ADDR_WIDTH	    : integer	:= 40;
        C_S_AXI_AWUSER_WIDTH	: integer	:= 16;
        C_S_AXI_ARUSER_WIDTH	: integer	:= 16
        );
        port (
        config_reg_in           : in reg_array;
        axi_block_trig          : out std_logic_vector(1 downto 0);
        err_status1_out         : out std_logic_vector(31 downto 0);
        err_status2_out         : out std_logic_vector(31 downto 0);
		S_AXI_ACLK	            : in std_logic;
		S_AXI_ARESETN	        : in std_logic;
		S_AXI_AWID	            : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_AWADDR	        : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWLEN	            : in std_logic_vector(7 downto 0);
		S_AXI_AWSIZE	        : in std_logic_vector(2 downto 0);
		S_AXI_AWBURST	        : in std_logic_vector(1 downto 0);
		S_AXI_AWLOCK	        : in std_logic;
		S_AXI_AWCACHE	        : in std_logic_vector(3 downto 0);
		S_AXI_AWPROT	        : in std_logic_vector(2 downto 0);
		S_AXI_AWQOS	            : in std_logic_vector(3 downto 0);
		--S_AXI_AWREGION	     : in std_logic_vector(3 downto 0);
		S_AXI_AWUSER	        : in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		S_AXI_AWVALID	        : in std_logic;
		S_AXI_AWREADY	        : out std_logic;
		S_AXI_WDATA	            : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	            : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WLAST	            : in std_logic;
		--S_AXI_WUSER	        : in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		S_AXI_WVALID	        : in std_logic;
		S_AXI_WREADY	        : out std_logic;
		S_AXI_BID	            : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_BRESP	            : out std_logic_vector(1 downto 0);
		--S_AXI_BUSER	        : out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		S_AXI_BVALID	        : out std_logic;
		S_AXI_BREADY	        : in std_logic;
		S_AXI_ARID	            : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_ARADDR	        : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARLEN	            : in std_logic_vector(7 downto 0);
		S_AXI_ARSIZE	        : in std_logic_vector(2 downto 0);
		S_AXI_ARBURST	        : in std_logic_vector(1 downto 0);
		S_AXI_ARLOCK	        : in std_logic;
		S_AXI_ARCACHE	        : in std_logic_vector(3 downto 0);
		S_AXI_ARPROT	        : in std_logic_vector(2 downto 0);
		S_AXI_ARQOS	            : in std_logic_vector(3 downto 0);
		--S_AXI_ARREGION	     : in std_logic_vector(3 downto 0);
		S_AXI_ARUSER	        : in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		S_AXI_ARVALID	        : in std_logic;
		S_AXI_ARREADY	        : out std_logic;
		S_AXI_RID	            : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_RDATA	            : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	            : out std_logic_vector(1 downto 0);
		S_AXI_RLAST	            : out std_logic;
		--S_AXI_RUSER	        : out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		S_AXI_RVALID	        : out std_logic;
		S_AXI_RREADY	        : in std_logic;
		--M_AXI_ACLK	          : in std_logic;
		--M_AXI_ARESETN	          : in std_logic;
		M_AXI_AWID	            : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		M_AXI_AWADDR	        : out std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_AWLEN	            : out std_logic_vector(7 downto 0);
		M_AXI_AWSIZE	        : out std_logic_vector(2 downto 0);
		M_AXI_AWBURST	        : out std_logic_vector(1 downto 0);
		M_AXI_AWLOCK	        : out std_logic;
		M_AXI_AWCACHE	        : out std_logic_vector(3 downto 0);
		M_AXI_AWPROT	        : out std_logic_vector(2 downto 0);
		M_AXI_AWQOS	            : out std_logic_vector(3 downto 0);
		M_AXI_AWUSER	        : out std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		M_AXI_AWVALID	        : out std_logic;
		M_AXI_AWREADY	        : in std_logic;
		M_AXI_WDATA             : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_WSTRB	            : out std_logic_vector(C_S_AXI_DATA_WIDTH/8-1 downto 0);
		M_AXI_WLAST	            : out std_logic;
		--M_AXI_WUSER	          : out std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		M_AXI_WVALID	        : out std_logic;
		M_AXI_WREADY	        : in std_logic;
		M_AXI_BID	            : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		M_AXI_BRESP	            : in std_logic_vector(1 downto 0);
		--M_AXI_BUSER	          : in std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		M_AXI_BVALID	        : in std_logic;
		M_AXI_BREADY	        : out std_logic;
		M_AXI_ARID	            : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		M_AXI_ARADDR	        : out std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_ARLEN	            : out std_logic_vector(7 downto 0);
		M_AXI_ARSIZE	        : out std_logic_vector(2 downto 0);
		M_AXI_ARBURST	        : out std_logic_vector(1 downto 0);
		M_AXI_ARLOCK	        : out std_logic;
		M_AXI_ARCACHE	        : out std_logic_vector(3 downto 0);
		M_AXI_ARPROT	        : out std_logic_vector(2 downto 0);
		M_AXI_ARQOS	            : out std_logic_vector(3 downto 0);
		M_AXI_ARUSER	        : out std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		M_AXI_ARVALID	        : out std_logic;
		M_AXI_ARREADY	        : in std_logic;
		M_AXI_RID	            : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		M_AXI_RDATA	            : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_RRESP	            : in std_logic_vector(1 downto 0);
		M_AXI_RLAST	            : in std_logic;
		--M_AXI_RUSER	          : in std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		M_AXI_RVALID	        : in std_logic;
		M_AXI_RREADY	        : out std_logic
		);
	end component ZUP_XMPU_PL_M_AXI;

    -- Signal Declarations
    signal config_reg_sig       : reg_array;
    signal axi_block_trig_sig   : std_logic_vector(1 downto 0);
    signal err_status1_sig      : std_logic_vector(31 downto 0);
    signal err_status2_sig      : std_logic_vector(31 downto 0);


begin


-- Instantiation of Axi Bus Interface S_AXI_XMPU
ZUP_XMPU_PL_S_AXI_inst : ZUP_XMPU_PL_S_AXI
	generic map (
        C_CTRL_REG_VAL         => C_CTRL_REG_VAL       ,
        C_POISON_REG_VAL       => C_POISON_REG_VAL     ,
        C_IMR_REG_VAL          => C_IMR_REG_VAL        ,
        C_LOCK_REG_VAL         => C_LOCK_REG_VAL       ,
        C_BYPASS_REG_VAL       => C_BYPASS_REG_VAL     ,
        C_R00_START_REG_VAL    => C_R00_START_REG_VAL  ,
        C_R00_END_REG_VAL      => C_R00_END_REG_VAL    ,
        C_R00_MASTERS_REG_VAL  => C_R00_MASTERS_REG_VAL,
        C_R00_CONFIG_REG_VAL   => C_R00_CONFIG_REG_VAL ,
        C_R01_START_REG_VAL    => C_R01_START_REG_VAL  ,
        C_R01_END_REG_VAL      => C_R01_END_REG_VAL    ,
        C_R01_MASTERS_REG_VAL  => C_R01_MASTERS_REG_VAL,
        C_R01_CONFIG_REG_VAL   => C_R01_CONFIG_REG_VAL ,
        C_R02_START_REG_VAL    => C_R02_START_REG_VAL  ,
        C_R02_END_REG_VAL      => C_R02_END_REG_VAL    ,
        C_R02_MASTERS_REG_VAL  => C_R02_MASTERS_REG_VAL,
        C_R02_CONFIG_REG_VAL   => C_R02_CONFIG_REG_VAL ,
        C_R03_START_REG_VAL    => C_R03_START_REG_VAL  ,
        C_R03_END_REG_VAL      => C_R03_END_REG_VAL    ,
        C_R03_MASTERS_REG_VAL  => C_R03_MASTERS_REG_VAL,
        C_R03_CONFIG_REG_VAL   => C_R03_CONFIG_REG_VAL ,
        C_R04_START_REG_VAL    => C_R04_START_REG_VAL  ,
        C_R04_END_REG_VAL      => C_R04_END_REG_VAL    ,
        C_R04_MASTERS_REG_VAL  => C_R04_MASTERS_REG_VAL,
        C_R04_CONFIG_REG_VAL   => C_R04_CONFIG_REG_VAL ,
        C_R05_START_REG_VAL    => C_R05_START_REG_VAL  ,
        C_R05_END_REG_VAL      => C_R05_END_REG_VAL    ,
        C_R05_MASTERS_REG_VAL  => C_R05_MASTERS_REG_VAL,
        C_R05_CONFIG_REG_VAL   => C_R05_CONFIG_REG_VAL ,
        C_R06_START_REG_VAL    => C_R06_START_REG_VAL  ,
        C_R06_END_REG_VAL      => C_R06_END_REG_VAL    ,
        C_R06_MASTERS_REG_VAL  => C_R06_MASTERS_REG_VAL,
        C_R06_CONFIG_REG_VAL   => C_R06_CONFIG_REG_VAL ,
        C_R07_START_REG_VAL    => C_R07_START_REG_VAL  ,
        C_R07_END_REG_VAL      => C_R07_END_REG_VAL    ,
        C_R07_MASTERS_REG_VAL  => C_R07_MASTERS_REG_VAL,
        C_R07_CONFIG_REG_VAL   => C_R07_CONFIG_REG_VAL ,
        C_R08_START_REG_VAL    => C_R08_START_REG_VAL  ,
        C_R08_END_REG_VAL      => C_R08_END_REG_VAL    ,
        C_R08_MASTERS_REG_VAL  => C_R08_MASTERS_REG_VAL,
        C_R08_CONFIG_REG_VAL   => C_R08_CONFIG_REG_VAL ,
        C_R09_START_REG_VAL    => C_R09_START_REG_VAL  ,
        C_R09_END_REG_VAL      => C_R09_END_REG_VAL    ,
        C_R09_MASTERS_REG_VAL  => C_R09_MASTERS_REG_VAL,
        C_R09_CONFIG_REG_VAL   => C_R09_CONFIG_REG_VAL ,
        C_R10_START_REG_VAL    => C_R10_START_REG_VAL  ,
        C_R10_END_REG_VAL      => C_R10_END_REG_VAL    ,
        C_R10_MASTERS_REG_VAL  => C_R10_MASTERS_REG_VAL,
        C_R10_CONFIG_REG_VAL   => C_R10_CONFIG_REG_VAL ,
        C_R11_START_REG_VAL    => C_R11_START_REG_VAL  ,
        C_R11_END_REG_VAL      => C_R11_END_REG_VAL    ,
        C_R11_MASTERS_REG_VAL  => C_R11_MASTERS_REG_VAL,
        C_R11_CONFIG_REG_VAL   => C_R11_CONFIG_REG_VAL ,
        C_R12_START_REG_VAL    => C_R12_START_REG_VAL  ,
        C_R12_END_REG_VAL      => C_R12_END_REG_VAL    ,
        C_R12_MASTERS_REG_VAL  => C_R12_MASTERS_REG_VAL,
        C_R12_CONFIG_REG_VAL   => C_R12_CONFIG_REG_VAL ,
        C_R13_START_REG_VAL    => C_R13_START_REG_VAL  ,
        C_R13_END_REG_VAL      => C_R13_END_REG_VAL    ,
        C_R13_MASTERS_REG_VAL  => C_R13_MASTERS_REG_VAL,
        C_R13_CONFIG_REG_VAL   => C_R13_CONFIG_REG_VAL ,
        C_R14_START_REG_VAL    => C_R14_START_REG_VAL  ,
        C_R14_END_REG_VAL      => C_R14_END_REG_VAL    ,
        C_R14_MASTERS_REG_VAL  => C_R14_MASTERS_REG_VAL,
        C_R14_CONFIG_REG_VAL   => C_R14_CONFIG_REG_VAL ,
        C_R15_START_REG_VAL    => C_R15_START_REG_VAL  ,
        C_R15_END_REG_VAL      => C_R15_END_REG_VAL    ,
        C_R15_MASTERS_REG_VAL  => C_R15_MASTERS_REG_VAL,
        C_R15_CONFIG_REG_VAL   => C_R15_CONFIG_REG_VAL ,
		C_S_AXI_ID_WIDTH	   => C_S_AXI_XMPU_ID_WIDTH,
		C_S_AXI_DATA_WIDTH	   => C_S_AXI_XMPU_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	   => C_S_AXI_XMPU_ADDR_WIDTH,
		C_S_AXI_AWUSER_WIDTH   => C_S_AXI_XMPU_AWUSER_WIDTH,
		C_S_AXI_ARUSER_WIDTH   => C_S_AXI_XMPU_ARUSER_WIDTH,
		C_S_AXI_WUSER_WIDTH	   => C_S_AXI_XMPU_WUSER_WIDTH,
		C_S_AXI_RUSER_WIDTH	   => C_S_AXI_XMPU_RUSER_WIDTH,
		C_S_AXI_BUSER_WIDTH	   => C_S_AXI_XMPU_BUSER_WIDTH,
        C_IRQ_SENSITIVITY      => C_IRQ_SENSITIVITY,
        C_IRQ_ACTIVE_STATE     => C_IRQ_ACTIVE_STATE
	)
	port map (
	    config_reg_out         => config_reg_sig,
	    axi_blocked            => axi_block_trig_sig,
	    err_status1_in         => err_status1_sig,
	    err_status2_in         => err_status2_sig,
		S_AXI_ACLK	           => s_axi_xmpu_aclk,
		S_AXI_ARESETN	       => s_axi_xmpu_aresetn,
		S_AXI_AWID	           => s_axi_xmpu_awid,
		S_AXI_AWADDR	       => s_axi_xmpu_awaddr,
		S_AXI_AWLEN	           => s_axi_xmpu_awlen,
		S_AXI_AWSIZE	       => s_axi_xmpu_awsize,
		S_AXI_AWBURST	       => s_axi_xmpu_awburst,
		S_AXI_AWLOCK	       => s_axi_xmpu_awlock,
		S_AXI_AWCACHE	       => s_axi_xmpu_awcache,
		S_AXI_AWPROT	       => s_axi_xmpu_awprot,
		S_AXI_AWQOS	           => s_axi_xmpu_awqos,
		S_AXI_AWREGION	       => s_axi_xmpu_awregion,
		S_AXI_AWUSER	       => s_axi_xmpu_awuser,
		S_AXI_AWVALID	       => s_axi_xmpu_awvalid,
		S_AXI_AWREADY	       => s_axi_xmpu_awready,
		S_AXI_WDATA	           => s_axi_xmpu_wdata,
		S_AXI_WSTRB	           => s_axi_xmpu_wstrb,
		S_AXI_WLAST	           => s_axi_xmpu_wlast,
		S_AXI_WUSER	           => s_axi_xmpu_wuser,
		S_AXI_WVALID	       => s_axi_xmpu_wvalid,
		S_AXI_WREADY	       => s_axi_xmpu_wready,
		S_AXI_BID	           => s_axi_xmpu_bid,
		S_AXI_BRESP	           => s_axi_xmpu_bresp,
		S_AXI_BUSER	           => s_axi_xmpu_buser,
		S_AXI_BVALID	       => s_axi_xmpu_bvalid,
		S_AXI_BREADY	       => s_axi_xmpu_bready,
		S_AXI_ARID	           => s_axi_xmpu_arid,
		S_AXI_ARADDR	       => s_axi_xmpu_araddr,
		S_AXI_ARLEN	           => s_axi_xmpu_arlen,
		S_AXI_ARSIZE	       => s_axi_xmpu_arsize,
		S_AXI_ARBURST	       => s_axi_xmpu_arburst,
		S_AXI_ARLOCK	       => s_axi_xmpu_arlock,
		S_AXI_ARCACHE	       => s_axi_xmpu_arcache,
		S_AXI_ARPROT	       => s_axi_xmpu_arprot,
		S_AXI_ARQOS	           => s_axi_xmpu_arqos,
		S_AXI_ARREGION	       => s_axi_xmpu_arregion,
		S_AXI_ARUSER	       => s_axi_xmpu_aruser,
		S_AXI_ARVALID	       => s_axi_xmpu_arvalid,
		S_AXI_ARREADY	       => s_axi_xmpu_arready,
		S_AXI_RID	           => s_axi_xmpu_rid,
		S_AXI_RDATA	           => s_axi_xmpu_rdata,
		S_AXI_RRESP	           => s_axi_xmpu_rresp,
		S_AXI_RLAST	           => s_axi_xmpu_rlast,
		S_AXI_RUSER	           => s_axi_xmpu_ruser,
		S_AXI_RVALID	       => s_axi_xmpu_rvalid,
		S_AXI_RREADY	       => s_axi_xmpu_rready,
		irq                    => irq
	);

-- Instantiation of Axi Bus Interface M_AXI_IN
ZUP_XMPU_PL_M_AXI_inst : ZUP_XMPU_PL_M_AXI
	generic map (
	    C_REGIONS_MAX          => C_REGIONS_MAX,
		C_S_AXI_ID_WIDTH	   => C_S_AXI_ID_WIDTH,
		C_S_AXI_DATA_WIDTH	   => C_S_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	   => C_S_AXI_ADDR_WIDTH,
		C_S_AXI_AWUSER_WIDTH   => C_S_AXI_AWUSER_WIDTH,
		C_S_AXI_ARUSER_WIDTH   => C_S_AXI_ARUSER_WIDTH
	)
	port map (
	-- Add user logic here
	    config_reg_in          => config_reg_sig,
	    axi_block_trig         => axi_block_trig_sig,
	    err_status1_out        => err_status1_sig,
	    err_status2_out        => err_status2_sig,
	-- User logic ends
		S_AXI_ACLK	           => s_axi_aclk,
		S_AXI_ARESETN	       => s_axi_aresetn,
		S_AXI_AWID	           => s_axi_awid,
		S_AXI_AWADDR	       => s_axi_awaddr,
		S_AXI_AWLEN	           => s_axi_awlen,
		S_AXI_AWSIZE	       => s_axi_awsize,
		S_AXI_AWBURST	       => s_axi_awburst,
		S_AXI_AWLOCK	       => s_axi_awlock,
		S_AXI_AWCACHE	       => s_axi_awcache,
		S_AXI_AWPROT	       => s_axi_awprot,
		S_AXI_AWQOS	           => s_axi_awqos,
		--S_AXI_AWREGION	     => s_axi_awregion,
		S_AXI_AWUSER	       => s_axi_awuser,
		S_AXI_AWVALID	       => s_axi_awvalid,
		S_AXI_AWREADY	       => s_axi_awready,
		S_AXI_WDATA	           => s_axi_wdata,
		S_AXI_WSTRB	           => s_axi_wstrb,
		S_AXI_WLAST	           => s_axi_wlast,
		--S_AXI_WUSER	        => s_axi_wuser,
		S_AXI_WVALID	       => s_axi_wvalid,
		S_AXI_WREADY	       => s_axi_wready,
		S_AXI_BID	           => s_axi_bid,
		S_AXI_BRESP	           => s_axi_bresp,
		--S_AXI_BUSER	        => s_axi_buser,
		S_AXI_BVALID	       => s_axi_bvalid,
		S_AXI_BREADY	       => s_axi_bready,
		S_AXI_ARID	           => s_axi_arid,
		S_AXI_ARADDR	       => s_axi_araddr,
		S_AXI_ARLEN	           => s_axi_arlen,
		S_AXI_ARSIZE	       => s_axi_arsize,
		S_AXI_ARBURST	       => s_axi_arburst,
		S_AXI_ARLOCK	       => s_axi_arlock,
		S_AXI_ARCACHE	       => s_axi_arcache,
		S_AXI_ARPROT	       => s_axi_arprot,
		S_AXI_ARQOS	           => s_axi_arqos,
		--S_AXI_ARREGION	     => s_axi_arregion,
		S_AXI_ARUSER	       => s_axi_aruser,
		S_AXI_ARVALID	       => s_axi_arvalid,
		S_AXI_ARREADY	       => s_axi_arready,
		S_AXI_RID	           => s_axi_rid,
		S_AXI_RDATA	           => s_axi_rdata,
		S_AXI_RRESP	           => s_axi_rresp,
		S_AXI_RLAST	           => s_axi_rlast,
		--S_AXI_RUSER	        => s_axi_ruser,
		S_AXI_RVALID	       => s_axi_rvalid,
		S_AXI_RREADY	       => s_axi_rready,
		--M_AXI_ACLK	       => m_axi_aclk,
		--M_AXI_ARESETN	         => m_axi_aresetn,
		M_AXI_AWID	           => m_axi_awid,
		M_AXI_AWADDR	       => m_axi_awaddr,
		M_AXI_AWLEN	           => m_axi_awlen,
		M_AXI_AWSIZE	       => m_axi_awsize,
		M_AXI_AWBURST	       => m_axi_awburst,
		M_AXI_AWLOCK	       => m_axi_awlock,
		M_AXI_AWCACHE	       => m_axi_awcache,
		M_AXI_AWPROT	       => m_axi_awprot,
		M_AXI_AWQOS	           => m_axi_awqos,
		M_AXI_AWUSER	       => m_axi_awuser,
		M_AXI_AWVALID	       => m_axi_awvalid,
		M_AXI_AWREADY	       => m_axi_awready,
		M_AXI_WDATA	           => m_axi_wdata,
		M_AXI_WSTRB	           => m_axi_wstrb,
		M_AXI_WLAST	           => m_axi_wlast,
		--M_AXI_WUSER	        => m_axi_wuser,
		M_AXI_WVALID	       => m_axi_wvalid,
		M_AXI_WREADY	       => m_axi_wready,
		M_AXI_BID	           => m_axi_bid,
		M_AXI_BRESP	           => m_axi_bresp,
		--M_AXI_BUSER	        => m_axi_buser,
		M_AXI_BVALID	       => m_axi_bvalid,
		M_AXI_BREADY	       => m_axi_bready,
		M_AXI_ARID	           => m_axi_arid,
		M_AXI_ARADDR	       => m_axi_araddr,
		M_AXI_ARLEN	           => m_axi_arlen,
		M_AXI_ARSIZE	       => m_axi_arsize,
		M_AXI_ARBURST	       => m_axi_arburst,
		M_AXI_ARLOCK	       => m_axi_arlock,
		M_AXI_ARCACHE	       => m_axi_arcache,
		M_AXI_ARPROT	       => m_axi_arprot,
		M_AXI_ARQOS	           => m_axi_arqos,
		M_AXI_ARUSER	       => m_axi_aruser,
		M_AXI_ARVALID	       => m_axi_arvalid,
		M_AXI_ARREADY	       => m_axi_arready,
		M_AXI_RID	           => m_axi_rid,
		M_AXI_RDATA	           => m_axi_rdata,
		M_AXI_RRESP	           => m_axi_rresp,
		M_AXI_RLAST	           => m_axi_rlast,
		--M_AXI_RUSER	         => m_axi_ruser,
		M_AXI_RVALID	       => m_axi_rvalid,
		M_AXI_RREADY	       => m_axi_rready
	);

    -- Add user logic here
    ctrl_reg_out        <= config_reg_sig(C_CTRL_REG_NUM);
    err_status1_reg_out <= config_reg_sig(C_ERR_STATUS1_REG_NUM);
    err_status2_reg_out <= config_reg_sig(C_ERR_STATUS2_REG_NUM);
    poison_reg_out      <= config_reg_sig(C_POISON_REG_NUM);
    lock_reg_out        <= config_reg_sig(C_LOCK_REG_NUM);
    isr_reg_out         <= config_reg_sig(C_ISR_REG_NUM);
    imr_reg_out         <= config_reg_sig(C_IMR_REG_NUM);
    lock_bypass_reg_out <= config_reg_sig(C_BYPASS_REG_NUM);
    regions_reg_out     <= config_reg_sig(C_REGIONS_REG_NUM);
    r00_start_reg_out   <= config_reg_sig(C_R00_START_REG_NUM);
    r00_end_reg_out     <= config_reg_sig(C_R00_END_REG_NUM);
    r00_masters_reg_out <= config_reg_sig(C_R00_MASTERS_REG_NUM);
    r00_config_reg_out  <= config_reg_sig(C_R00_CONFIG_REG_NUM);

    -- User logic ends

end arch_imp;
