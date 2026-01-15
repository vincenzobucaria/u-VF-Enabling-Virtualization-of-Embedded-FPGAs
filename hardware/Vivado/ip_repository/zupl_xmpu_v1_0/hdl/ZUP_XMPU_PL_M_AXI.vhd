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
--  /   /         Filename: ZUP_ZMPU_PL_M_AXI.vhd         
-- /___/   /\     Timestamp: $DateTime: 2020/03/02 10:38:05 $
-- \   \  /  \
--  \___\/\___\
--
--
-- Purpose: This module implements the AXI to AXI bridge interface for 
-- the XMPU PL Instance and monitors AXI transactions for unauthorized access attempts.
--
-- Instantiates   : Axi_Monitor, SINK_S_AXI
-- Requirements Addressed :  
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library xil_defaultlib;
use xil_defaultlib.xmpu_pl_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ZUP_XMPU_PL_M_AXI is
	generic (
		-- Users to add parameters here
	    C_REGIONS_MAX             : integer := 16;

		-- User parameters ends
		-- Do not modify the parameters beyond this line

		-- Width of ID for for write address, write data, read address and read data
		C_S_AXI_ID_WIDTH          : integer	:= 16;
		-- Width of S_AXI data bus
		C_S_AXI_DATA_WIDTH        : integer	:= 128;
		-- Width of S_AXI address bus
		C_S_AXI_ADDR_WIDTH        : integer	:= 40;
		-- Width of optional user defined signal in write address channel
		C_S_AXI_AWUSER_WIDTH      : integer	:= 16;
		-- Width of optional user defined signal in read address channel
		C_S_AXI_ARUSER_WIDTH      : integer	:= 16
		-- Width of optional user defined signal in write data channel
		--C_S_AXI_WUSER_WIDTH	: integer	:= 0;
		-- Width of optional user defined signal in read data channel
		--C_S_AXI_RUSER_WIDTH	: integer	:= 0;
		-- Width of optional user defined signal in write response channel
		--C_S_AXI_BUSER_WIDTH	: integer	:= 0
	);
	port (
        -- Users to add ports here
        config_reg_in       : in reg_array;
        axi_block_trig      : out std_logic_vector(1 downto 0);
        err_status1_out     : out std_logic_vector(31 downto 0);
        err_status2_out     : out std_logic_vector(31 downto 0);
        -- User ports ends
        -- Do not modify the ports beyond this line

        -- Global Clock Signal
        S_AXI_ACLK          : in std_logic;
        -- Global Reset Signal. This Signal is Active LOW
        S_AXI_ARESETN	    : in std_logic;
		
		--------------------------------------------------------------------------
		-- PS MASTER AXI INPUT
		--------------------------------------------------------------------------
		S_AXI_AWID    : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_AWADDR  : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWLEN	  : in std_logic_vector(7 downto 0);
		S_AXI_AWSIZE  : in std_logic_vector(2 downto 0);
		S_AXI_AWBURST : in std_logic_vector(1 downto 0);
		S_AXI_AWLOCK  : in std_logic;
		S_AXI_AWCACHE : in std_logic_vector(3 downto 0);
		S_AXI_AWPROT  : in std_logic_vector(2 downto 0);
		S_AXI_AWVALID : in std_logic;
		S_AXI_AWUSER  : in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		S_AXI_AWREADY : out std_logic;
		S_AXI_WDATA	  : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	  : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WLAST	  : in std_logic;
		S_AXI_WVALID  : in std_logic;
		S_AXI_WREADY  : out std_logic;
		S_AXI_BID	  : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_BRESP	  : out std_logic_vector(1 downto 0);
		S_AXI_BVALID  : out std_logic;
		S_AXI_BREADY  : in std_logic;
		S_AXI_ARID	  : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_ARADDR  : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARLEN	  : in std_logic_vector(7 downto 0);
		S_AXI_ARSIZE  : in std_logic_vector(2 downto 0);
		S_AXI_ARBURST : in std_logic_vector(1 downto 0);
		S_AXI_ARLOCK  : in std_logic;
		S_AXI_ARCACHE : in std_logic_vector(3 downto 0);
		S_AXI_ARPROT  : in std_logic_vector(2 downto 0);
		S_AXI_ARVALID : in std_logic;
		S_AXI_ARUSER  : in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		S_AXI_ARREADY : out std_logic;
		S_AXI_RID	  : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_RDATA	  : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	  : out std_logic_vector(1 downto 0);
		S_AXI_RLAST	  : out std_logic;
		S_AXI_RVALID  : out std_logic;
		S_AXI_RREADY  : in std_logic;
		-- Quality of Service
		S_AXI_AWQOS	  : in std_logic_vector(3 downto 0);
		S_AXI_ARQOS	  : in std_logic_vector(3 downto 0);
		
		--------------------------------------------------------------------------
		-- PS MASTER AXI OUTPUT
		--------------------------------------------------------------------------
		M_AXI_AWID	  : OUT std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		M_AXI_AWADDR  : OUT std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_AWLEN	  : OUT std_logic_vector(7 downto 0);
		M_AXI_AWSIZE  : OUT std_logic_vector(2 downto 0);
		M_AXI_AWBURST : OUT std_logic_vector(1 downto 0);
		M_AXI_AWLOCK  : OUT std_logic;
		M_AXI_AWCACHE : OUT std_logic_vector(3 downto 0);
		M_AXI_AWPROT  : OUT std_logic_vector(2 downto 0);
		M_AXI_AWVALID : OUT std_logic;
		M_AXI_AWUSER  : OUT std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		M_AXI_AWREADY : IN std_logic;
		M_AXI_WDATA	  : OUT std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_WSTRB	  : OUT std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		M_AXI_WLAST	  : OUT std_logic;
		M_AXI_WVALID  : OUT std_logic;
		M_AXI_WREADY  : IN std_logic;
		M_AXI_BID	  : IN std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		M_AXI_BRESP	  : IN std_logic_vector(1 downto 0);
		M_AXI_BVALID  : IN std_logic;
		M_AXI_BREADY  : OUT std_logic;
		M_AXI_ARID	  : OUT std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		M_AXI_ARADDR  : OUT std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		M_AXI_ARLEN	  : OUT std_logic_vector(7 downto 0);
		M_AXI_ARSIZE  : OUT std_logic_vector(2 downto 0);
		M_AXI_ARBURST : OUT std_logic_vector(1 downto 0);
		M_AXI_ARLOCK  : OUT std_logic;
		M_AXI_ARCACHE : OUT std_logic_vector(3 downto 0);
		M_AXI_ARPROT  : OUT std_logic_vector(2 downto 0);
		M_AXI_ARVALID : OUT std_logic;
		M_AXI_ARUSER  : OUT std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		M_AXI_ARREADY : IN std_logic;
		M_AXI_RID	  : IN std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		M_AXI_RDATA	  : IN std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		M_AXI_RRESP	  : IN std_logic_vector(1 downto 0);
		M_AXI_RLAST	  : IN std_logic;
		M_AXI_RVALID  : IN std_logic;
		M_AXI_RREADY  : OUT std_logic;
		-- Quality of Service
		M_AXI_AWQOS	  : OUT std_logic_vector(3 downto 0);
		M_AXI_ARQOS	  : OUT std_logic_vector(3 downto 0)
		
		
	);
end ZUP_XMPU_PL_M_AXI;

architecture Behavioral of ZUP_XMPU_PL_M_AXI is

	-- Axi_Monitor component declaration
	component Axi_Monitor is
	generic (
	    C_REGIONS_MAX           : integer := 16;
		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_ADDR_WIDTH	: integer	:= 40;
		C_S00_AXI_AWUSER_WIDTH	: integer	:= 16;
		C_S00_AXI_ARUSER_WIDTH	: integer	:= 16
	);
    port (
		S00_AXI_aclk	: in std_logic;
		S00_AXI_aresetn	: in std_logic;
		S00_AXI_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		S00_AXI_awuser	: in std_logic_vector(C_S00_AXI_AWUSER_WIDTH-1 downto 0);
		S00_AXI_awvalid	: in std_logic;
		S00_AXI_awready	: in std_logic;
		S00_AXI_awprot  : in std_logic_vector(2 downto 0);
		S00_AXI_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		S00_AXI_aruser	: in std_logic_vector(C_S00_AXI_ARUSER_WIDTH-1 downto 0);
		S00_AXI_arvalid	: in std_logic;
		S00_AXI_arready	: in std_logic;
		S00_AXI_arprot  : in std_logic_vector(2 downto 0);
		S00_AXI_rlast   : in std_logic;
		S00_AXI_bvalid	: in std_logic;
		M00_AXI_araddr  : out std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		M00_AXI_arvalid	: out std_logic;
		M00_AXI_arprot  : out std_logic_vector(2 downto 0);
		M00_AXI_awready	: in std_logic;
		M00_AXI_awaddr  : out std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		M00_AXI_awvalid	: out std_logic;
		M00_AXI_awprot  : out std_logic_vector(2 downto 0);
		--CONFIGURATION REGISTER PORTS
		CTRL_REG        : in std_logic_vector(31 downto 0);
		ERR_STATUS1_REG : in std_logic_vector(31 downto 0);
		ERR_STATUS2_REG : in std_logic_vector(31 downto 0);
		POISON_REG      : in std_logic_vector(31 downto 0);
		ISR_REG         : in std_logic_vector(31 downto 0);
		IMR_REG         : in std_logic_vector(31 downto 0);
		IEN_REG         : in std_logic_vector(31 downto 0);
		IDS_REG         : in std_logic_vector(31 downto 0);
		LOCK_REG        : in std_logic_vector(31 downto 0);
		BYPASS_REG      : in std_logic_vector(31 downto 0);
		REGIONS_REG     : in std_logic_vector(31 downto 0);
		R00_START_REG   : in std_logic_vector(31 downto 0);
		R00_END_REG     : in std_logic_vector(31 downto 0);
		R00_MASTERS_REG : in std_logic_vector(31 downto 0);
		R00_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R01_START_REG   : in std_logic_vector(31 downto 0);
		R01_END_REG     : in std_logic_vector(31 downto 0);
		R01_MASTERS_REG : in std_logic_vector(31 downto 0);
		R01_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R02_START_REG   : in std_logic_vector(31 downto 0);
		R02_END_REG     : in std_logic_vector(31 downto 0);
		R02_MASTERS_REG : in std_logic_vector(31 downto 0);
		R02_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R03_START_REG   : in std_logic_vector(31 downto 0);
		R03_END_REG     : in std_logic_vector(31 downto 0);
		R03_MASTERS_REG : in std_logic_vector(31 downto 0);
		R03_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R04_START_REG   : in std_logic_vector(31 downto 0);
		R04_END_REG     : in std_logic_vector(31 downto 0);
		R04_MASTERS_REG : in std_logic_vector(31 downto 0);
		R04_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R05_START_REG   : in std_logic_vector(31 downto 0);
		R05_END_REG     : in std_logic_vector(31 downto 0);
		R05_MASTERS_REG : in std_logic_vector(31 downto 0);
		R05_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R06_START_REG   : in std_logic_vector(31 downto 0);
		R06_END_REG     : in std_logic_vector(31 downto 0);
		R06_MASTERS_REG : in std_logic_vector(31 downto 0);
		R06_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R07_START_REG   : in std_logic_vector(31 downto 0);
		R07_END_REG     : in std_logic_vector(31 downto 0);
		R07_MASTERS_REG : in std_logic_vector(31 downto 0);
		R07_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R08_START_REG   : in std_logic_vector(31 downto 0);
		R08_END_REG     : in std_logic_vector(31 downto 0);
		R08_MASTERS_REG : in std_logic_vector(31 downto 0);
		R08_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R09_START_REG   : in std_logic_vector(31 downto 0);
		R09_END_REG     : in std_logic_vector(31 downto 0);
		R09_MASTERS_REG : in std_logic_vector(31 downto 0);
		R09_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R10_START_REG   : in std_logic_vector(31 downto 0);
		R10_END_REG     : in std_logic_vector(31 downto 0);
		R10_MASTERS_REG : in std_logic_vector(31 downto 0);
		R10_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R11_START_REG   : in std_logic_vector(31 downto 0);
		R11_END_REG     : in std_logic_vector(31 downto 0);
		R11_MASTERS_REG : in std_logic_vector(31 downto 0);
		R11_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R12_START_REG   : in std_logic_vector(31 downto 0);
		R12_END_REG     : in std_logic_vector(31 downto 0);
		R12_MASTERS_REG : in std_logic_vector(31 downto 0);
		R12_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R13_START_REG   : in std_logic_vector(31 downto 0);
		R13_END_REG     : in std_logic_vector(31 downto 0);
		R13_MASTERS_REG : in std_logic_vector(31 downto 0);
		R13_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R14_START_REG   : in std_logic_vector(31 downto 0);
		R14_END_REG     : in std_logic_vector(31 downto 0);
		R14_MASTERS_REG : in std_logic_vector(31 downto 0);
		R14_CONFIG_REG  : in std_logic_vector(31 downto 0);
		R15_START_REG   : in std_logic_vector(31 downto 0);
		R15_END_REG     : in std_logic_vector(31 downto 0);
		R15_MASTERS_REG : in std_logic_vector(31 downto 0);
		R15_CONFIG_REG  : in std_logic_vector(31 downto 0);
        VALID           : out std_logic;
        READ_BLOCKED    : out std_logic;
        WRITE_BLOCKED   : out std_logic;
        ACTIVE_REGION   : out std_logic_vector(7 downto 0)
    );
    end component Axi_Monitor;

	-- SINK_S_AXI component declaration
	component SINK_S_AXI is
	generic (
		-- Users to add parameters here
        C_S_AXI_RESP_VAL          : integer := 3;
		-- User parameters ends
		C_S_AXI_ID_WIDTH          : integer	:= 1;
		C_S_AXI_DATA_WIDTH        : integer	:= 128;
		C_S_AXI_ADDR_WIDTH        : integer	:= 40;
		C_S_AXI_AWUSER_WIDTH      : integer	:= 0;
		C_S_AXI_ARUSER_WIDTH      : integer	:= 0;
		C_S_AXI_WUSER_WIDTH	      : integer	:= 0;
		C_S_AXI_RUSER_WIDTH	      : integer	:= 0;
		C_S_AXI_BUSER_WIDTH	      : integer	:= 0
	);
	port (
		-- Users to add ports here
		AXI_RESP_VAL      : in std_logic_vector(1 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line
		S_AXI_ACLK        : in std_logic;
		S_AXI_ARESETN     : in std_logic;
		S_AXI_AWID        : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_AWADDR      : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWLEN	      : in std_logic_vector(7 downto 0);
		S_AXI_AWSIZE      : in std_logic_vector(2 downto 0);
		S_AXI_AWBURST     : in std_logic_vector(1 downto 0);
		S_AXI_AWLOCK      : in std_logic;
		S_AXI_AWCACHE     : in std_logic_vector(3 downto 0);
		S_AXI_AWPROT      : in std_logic_vector(2 downto 0);
		S_AXI_AWQOS	      : in std_logic_vector(3 downto 0);
		S_AXI_AWREGION    : in std_logic_vector(3 downto 0);
		S_AXI_AWUSER      : in std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
		S_AXI_AWVALID     : in std_logic;
		S_AXI_AWREADY     : out std_logic;
		S_AXI_WDATA	      : in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	      : in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WLAST	      : in std_logic;
		S_AXI_WUSER	      : in std_logic_vector(C_S_AXI_WUSER_WIDTH-1 downto 0);
		S_AXI_WVALID      : in std_logic;
		S_AXI_WREADY      : out std_logic;
		S_AXI_BID         : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_BRESP	      : out std_logic_vector(1 downto 0);
		S_AXI_BUSER	      : out std_logic_vector(C_S_AXI_BUSER_WIDTH-1 downto 0);
		S_AXI_BVALID      : out std_logic;
		S_AXI_BREADY      : in std_logic;
		S_AXI_ARID        : in std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_ARADDR      : in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARLEN	      : in std_logic_vector(7 downto 0);
		S_AXI_ARSIZE      : in std_logic_vector(2 downto 0);
		S_AXI_ARBURST     : in std_logic_vector(1 downto 0);
		S_AXI_ARLOCK      : in std_logic;
		S_AXI_ARCACHE     : in std_logic_vector(3 downto 0);
		S_AXI_ARPROT      : in std_logic_vector(2 downto 0);
		S_AXI_ARQOS	      : in std_logic_vector(3 downto 0);
		S_AXI_ARREGION    : in std_logic_vector(3 downto 0);
		S_AXI_ARUSER      : in std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
		S_AXI_ARVALID     : in std_logic;
		S_AXI_ARREADY     : out std_logic;
		S_AXI_RID         : out std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
		S_AXI_RDATA	      : out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	      : out std_logic_vector(1 downto 0);
		S_AXI_RLAST	      : out std_logic;
		S_AXI_RUSER	      : out std_logic_vector(C_S_AXI_RUSER_WIDTH-1 downto 0);
		S_AXI_RVALID      : out std_logic;
		S_AXI_RREADY      : in std_logic
	);
	end component SINK_S_AXI;

--------------------------------------------------------------------------
-- PS MASTER AXI SIGNALS
--------------------------------------------------------------------------
Signal AXI_AWID         : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
Signal AXI_AWADDR       : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
Signal AXI_AWLEN        : std_logic_vector(7 downto 0);
Signal AXI_AWSIZE       : std_logic_vector(2 downto 0);
Signal AXI_AWBURST      : std_logic_vector(1 downto 0);
Signal AXI_AWLOCK       : std_logic;
Signal AXI_AWCACHE      : std_logic_vector(3 downto 0);
Signal AXI_AWPROT       : std_logic_vector(2 downto 0);
Signal AXI_AWVALID      : std_logic;
Signal AXI_AWUSER       : std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
Signal AXI_AWREADY      : std_logic;
Signal AXI_AWREADY_REG  : std_logic;
Signal AXI_WDATA        : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
Signal AXI_WSTRB        : std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
Signal AXI_WLAST        : std_logic;
Signal AXI_WVALID       : std_logic;
Signal AXI_WREADY       : std_logic;
Signal AXI_BID          : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
Signal AXI_BRESP        : std_logic_vector(1 downto 0);
Signal AXI_BVALID       : std_logic;
Signal AXI_BREADY       : std_logic;
Signal AXI_ARID	        : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
Signal AXI_ARADDR       : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
Signal AXI_ARLEN        : std_logic_vector(7 downto 0);
Signal AXI_ARSIZE       : std_logic_vector(2 downto 0);
Signal AXI_ARBURST      : std_logic_vector(1 downto 0);
Signal AXI_ARLOCK       : std_logic;
Signal AXI_ARCACHE      : std_logic_vector(3 downto 0);
Signal AXI_ARPROT       : std_logic_vector(2 downto 0);
Signal AXI_ARVALID      : std_logic;
Signal AXI_ARUSER       : std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
Signal AXI_ARREADY      : std_logic;
Signal AXI_RID          : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
Signal AXI_RDATA        : std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
Signal AXI_RRESP        : std_logic_vector(1 downto 0);
Signal AXI_RLAST        : std_logic;
Signal AXI_RVALID       : std_logic;
Signal AXI_RREADY       : std_logic;
Signal AXI_AWQOS        : std_logic_vector(3 downto 0);
Signal AXI_ARQOS        : std_logic_vector(3 downto 0);

--------------------------------------------------------------------------
-- SINK AXI SIGNALS
--------------------------------------------------------------------------
Signal SINK_AXI_AWID    : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
--Signal SINK_AXI_AWADDR  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
Signal SINK_AXI_AWLEN	: std_logic_vector(7 downto 0);
Signal SINK_AXI_AWSIZE  : std_logic_vector(2 downto 0);
Signal SINK_AXI_AWBURST : std_logic_vector(1 downto 0);
Signal SINK_AXI_AWLOCK  : std_logic;
Signal SINK_AXI_AWCACHE : std_logic_vector(3 downto 0);
Signal SINK_AXI_AWPROT  : std_logic_vector(2 downto 0);
Signal SINK_AXI_AWVALID : std_logic;
Signal SINK_AXI_AWUSER  : std_logic_vector(C_S_AXI_AWUSER_WIDTH-1 downto 0);
Signal SINK_AXI_AWREADY : std_logic;
Signal SINK_AXI_WDATA	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
Signal SINK_AXI_WSTRB	: std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
Signal SINK_AXI_WLAST	: std_logic;
Signal SINK_AXI_WVALID  : std_logic;
Signal SINK_AXI_WREADY  : std_logic;
Signal SINK_AXI_BID	    : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
Signal SINK_AXI_BRESP	: std_logic_vector(1 downto 0);
Signal SINK_AXI_BVALID  : std_logic;
Signal SINK_AXI_BREADY  : std_logic;
Signal SINK_AXI_ARID	: std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
--Signal SINK_AXI_ARADDR  : std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
Signal SINK_AXI_ARLEN	: std_logic_vector(7 downto 0);
Signal SINK_AXI_ARSIZE  : std_logic_vector(2 downto 0);
Signal SINK_AXI_ARBURST : std_logic_vector(1 downto 0);
Signal SINK_AXI_ARLOCK  : std_logic;
Signal SINK_AXI_ARCACHE : std_logic_vector(3 downto 0);
Signal SINK_AXI_ARPROT  : std_logic_vector(2 downto 0);
Signal SINK_AXI_ARVALID : std_logic;
Signal SINK_AXI_ARUSER  : std_logic_vector(C_S_AXI_ARUSER_WIDTH-1 downto 0);
Signal SINK_AXI_ARREADY : std_logic;
Signal SINK_AXI_RID	    : std_logic_vector(C_S_AXI_ID_WIDTH-1 downto 0);
Signal SINK_AXI_RDATA	: std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
Signal SINK_AXI_RRESP	: std_logic_vector(1 downto 0);
Signal SINK_AXI_RLAST	: std_logic;
Signal SINK_AXI_RVALID  : std_logic;
Signal SINK_AXI_RREADY  : std_logic;
Signal SINK_AXI_AWQOS	: std_logic_vector(3 downto 0);
Signal SINK_AXI_ARQOS	: std_logic_vector(3 downto 0);

-- Internal Signals
Signal valid_sig        : std_logic;
Signal blocked_sig      : std_logic_vector(1 downto 0);
Signal blocked_reg      : std_logic_vector(1 downto 0);
Signal blocked_trig     : std_logic_vector(1 downto 0);
Signal active_reg       : std_logic_vector(7 downto 0);
Signal err_stat1_reg    : std_logic_vector(31 downto 0);
Signal err_stat2_reg    : std_logic_vector(31 downto 0);


begin


	-- I/O Connections assignments


        --------------------------------------------------------------------------
        -- PS MASTER AXI INPUT SIGNALS
        --------------------------------------------------------------------------
        -- Inputs
        AXI_AWID 	<= S_AXI_AWID;
        --AXI_AWADDR 	<= S_AXI_AWADDR;
        AXI_AWLEN 	<= S_AXI_AWLEN;
        AXI_AWSIZE 	<= S_AXI_AWSIZE;
        AXI_AWBURST <= S_AXI_AWBURST;
        AXI_AWLOCK 	<= S_AXI_AWLOCK;
        AXI_AWCACHE <= S_AXI_AWCACHE;
--        AXI_AWPROT 	<= S_AXI_AWPROT;
--        AXI_AWVALID <= S_AXI_AWVALID;
        AXI_AWUSER 	<= S_AXI_AWUSER;
        AXI_WDATA 	<= S_AXI_WDATA;
        AXI_WSTRB 	<= S_AXI_WSTRB;
        AXI_WLAST 	<= S_AXI_WLAST;
        AXI_WVALID 	<= S_AXI_WVALID;
        AXI_BREADY 	<= S_AXI_BREADY;
        AXI_ARID 	<= S_AXI_ARID;
        --AXI_ARADDR 	<= S_AXI_ARADDR;
        AXI_ARLEN 	<= S_AXI_ARLEN;
        AXI_ARSIZE 	<= S_AXI_ARSIZE;
        AXI_ARBURST <= S_AXI_ARBURST;
        AXI_ARLOCK 	<= S_AXI_ARLOCK;
        AXI_ARCACHE <= S_AXI_ARCACHE;
--        AXI_ARPROT 	<= S_AXI_ARPROT;
--        AXI_ARVALID <= S_AXI_ARVALID;
        AXI_ARUSER 	<= S_AXI_ARUSER;
        AXI_RREADY 	<= S_AXI_RREADY;
        AXI_AWQOS 	<= S_AXI_AWQOS;
        AXI_ARQOS 	<= S_AXI_ARQOS;
        -- Outputs
        S_AXI_AWREADY <= AXI_AWREADY;
        S_AXI_WREADY  <= AXI_WREADY;
        S_AXI_BID	  <= AXI_BID;
        S_AXI_BRESP	  <= AXI_BRESP;
        S_AXI_BVALID  <= AXI_BVALID;
        S_AXI_ARREADY <= AXI_ARREADY when AXI_ARVALID = '1' else '0';
        S_AXI_RID	  <= AXI_RID;
        S_AXI_RDATA	  <= AXI_RDATA;
        S_AXI_RRESP	  <= AXI_RRESP;
        S_AXI_RLAST	  <= AXI_RLAST;
        S_AXI_RVALID  <= AXI_RVALID;
        
    proc_read_sink: process(blocked_sig(0))
    begin
        if (blocked_sig(0) = '0') then
            --------------------------------------------------------------------------
            -- PS MASTER AXI OUTPUT SIGNALS
            --------------------------------------------------------------------------
            -- Sink Inputs
--            SINK_AXI_AWID 	  <= AXI_AWID;
--            --SINK_AXI_AWADDR  <= AXI_AWADDR;
--            SINK_AXI_AWLEN   <= AXI_AWLEN;
--            SINK_AXI_AWSIZE  <= AXI_AWSIZE;
--            SINK_AXI_AWBURST <= AXI_AWBURST;
--            SINK_AXI_AWLOCK  <= AXI_AWLOCK;
--            SINK_AXI_AWCACHE <= AXI_AWCACHE;
--            SINK_AXI_AWPROT  <= AXI_AWPROT;
----            SINK_AXI_AWVALID <= AXI_AWVALID;
--            SINK_AXI_AWUSER  <= AXI_AWUSER;
--            SINK_AXI_WDATA   <= AXI_WDATA;
--            SINK_AXI_WSTRB   <= AXI_WSTRB;
--            SINK_AXI_WLAST   <= AXI_WLAST;
--            SINK_AXI_WVALID  <= AXI_WVALID;
--            SINK_AXI_BREADY  <= AXI_BREADY;
            SINK_AXI_ARID 	  <= AXI_ARID;
            --SINK_AXI_ARADDR  <= AXI_ARADDR;
            SINK_AXI_ARLEN   <= AXI_ARLEN;
            SINK_AXI_ARSIZE  <= AXI_ARSIZE;
            SINK_AXI_ARBURST <= AXI_ARBURST;
            SINK_AXI_ARLOCK  <= AXI_ARLOCK;
            SINK_AXI_ARCACHE <= AXI_ARCACHE;
            SINK_AXI_ARPROT  <= AXI_ARPROT;
--            SINK_AXI_ARVALID <= AXI_ARVALID;
            SINK_AXI_ARUSER  <= AXI_ARUSER;
            SINK_AXI_RREADY  <= AXI_RREADY;
--            SINK_AXI_AWQOS   <= AXI_AWQOS;
            SINK_AXI_ARQOS   <= AXI_ARQOS;
            -- Sink Inputs
--            SINK_AXI_AWVALID <= '0';
            SINK_AXI_ARVALID <= '0';
            -- Master Outputs
--            M_AXI_AWID 	  <= AXI_AWID;
--            M_AXI_AWADDR  <= AXI_AWADDR;
--            M_AXI_AWLEN   <= AXI_AWLEN;
--            M_AXI_AWSIZE  <= AXI_AWSIZE;
--            M_AXI_AWBURST <= AXI_AWBURST;
--            M_AXI_AWLOCK  <= AXI_AWLOCK;
--            M_AXI_AWCACHE <= AXI_AWCACHE;
--            M_AXI_AWPROT  <= AXI_AWPROT;
--            M_AXI_AWVALID <= AXI_AWVALID;
--            M_AXI_AWUSER  <= AXI_AWUSER;
--            M_AXI_WDATA   <= AXI_WDATA;
--            M_AXI_WSTRB   <= AXI_WSTRB;
--            M_AXI_WLAST   <= AXI_WLAST;
--            M_AXI_WVALID  <= AXI_WVALID;
--            M_AXI_BREADY  <= AXI_BREADY;
            M_AXI_ARID 	  <= AXI_ARID;
            M_AXI_ARADDR  <= AXI_ARADDR;
            M_AXI_ARLEN   <= AXI_ARLEN;
            M_AXI_ARSIZE  <= AXI_ARSIZE;
            M_AXI_ARBURST <= AXI_ARBURST;
            M_AXI_ARLOCK  <= AXI_ARLOCK;
            M_AXI_ARCACHE <= AXI_ARCACHE;
            M_AXI_ARPROT  <= AXI_ARPROT;
            M_AXI_ARVALID <= AXI_ARVALID;
            M_AXI_ARUSER  <= AXI_ARUSER;
            M_AXI_RREADY  <= AXI_RREADY;
--            M_AXI_AWQOS   <= AXI_AWQOS;
            M_AXI_ARQOS   <= AXI_ARQOS;
            -- Master Inputs
--            AXI_AWREADY   <= M_AXI_AWREADY;
--            AXI_WREADY    <= M_AXI_WREADY;
--            AXI_BID	      <= M_AXI_BID;
--            AXI_BRESP	  <= M_AXI_BRESP;
--            AXI_BVALID    <= M_AXI_BVALID;
            AXI_ARREADY   <= M_AXI_ARREADY;
            AXI_RID	      <= M_AXI_RID;
            AXI_RDATA	  <= M_AXI_RDATA;
            AXI_RRESP	  <= M_AXI_RRESP;
            AXI_RLAST	  <= M_AXI_RLAST;
            AXI_RVALID    <= M_AXI_RVALID;
        else
            -- Master Outputs
--            M_AXI_AWID 	  <= (others => '0');
--            M_AXI_AWADDR  <= (others => '0');
--            M_AXI_AWLEN   <= (others => '0');
--            M_AXI_AWSIZE  <= (others => '0');
--            M_AXI_AWBURST <= (others => '0');
--            M_AXI_AWLOCK  <= '0';
--            M_AXI_AWCACHE <= (others => '0');
--            M_AXI_AWPROT  <= (others => '0');
--            M_AXI_AWVALID <= '0';
--            M_AXI_AWUSER  <= (others => '0');
--            M_AXI_WDATA   <= (others => '0');
--            M_AXI_WSTRB   <= (others => '0');
--            M_AXI_WLAST   <= '0';
--            M_AXI_WVALID  <= '0';
--            M_AXI_BREADY  <= '0';
            M_AXI_ARID 	  <= (others => '0');
            M_AXI_ARADDR  <= (others => '0');
            M_AXI_ARLEN   <= (others => '0');
            M_AXI_ARSIZE  <= (others => '0');
            M_AXI_ARBURST <= (others => '0');
            M_AXI_ARLOCK  <= '0';
            M_AXI_ARCACHE <= (others => '0');
            M_AXI_ARPROT  <= (others => '0');
            M_AXI_ARVALID <= '0';
            M_AXI_ARUSER  <= (others => '0');
            M_AXI_RREADY  <= '0';
--            M_AXI_AWQOS   <= (others => '0');
            M_AXI_ARQOS   <= (others => '0');
            -- Sink Inputs
--            SINK_AXI_AWID 	  <= AXI_AWID;
--            --SINK_AXI_AWADDR  <= AXI_AWADDR;
--            SINK_AXI_AWLEN   <= AXI_AWLEN;
--            SINK_AXI_AWSIZE  <= AXI_AWSIZE;
--            SINK_AXI_AWBURST <= AXI_AWBURST;
--            SINK_AXI_AWLOCK  <= AXI_AWLOCK;
--            SINK_AXI_AWCACHE <= AXI_AWCACHE;
--            SINK_AXI_AWPROT  <= AXI_AWPROT;
--            SINK_AXI_AWVALID <= AXI_AWVALID;
--            SINK_AXI_AWUSER  <= AXI_AWUSER;
--            SINK_AXI_WDATA   <= AXI_WDATA;
--            SINK_AXI_WSTRB   <= AXI_WSTRB;
--            SINK_AXI_WLAST   <= AXI_WLAST;
--            SINK_AXI_WVALID  <= AXI_WVALID;
--            SINK_AXI_BREADY  <= AXI_BREADY;
            SINK_AXI_ARID 	  <= AXI_ARID;
            --SINK_AXI_ARADDR  <= AXI_ARADDR;
            SINK_AXI_ARLEN   <= AXI_ARLEN;
            SINK_AXI_ARSIZE  <= AXI_ARSIZE;
            SINK_AXI_ARBURST <= AXI_ARBURST;
            SINK_AXI_ARLOCK  <= AXI_ARLOCK;
            SINK_AXI_ARCACHE <= AXI_ARCACHE;
            SINK_AXI_ARPROT  <= AXI_ARPROT;
            SINK_AXI_ARVALID <= AXI_ARVALID;
            SINK_AXI_ARUSER  <= AXI_ARUSER;
            SINK_AXI_RREADY  <= AXI_RREADY;
--            SINK_AXI_AWQOS   <= AXI_AWQOS;
            SINK_AXI_ARQOS   <= AXI_ARQOS;
            -- Sink Outputs
--            AXI_AWREADY   <= SINK_AXI_AWREADY;
--            AXI_WREADY    <= SINK_AXI_WREADY;
--            AXI_BID	      <= SINK_AXI_BID;
--            AXI_BRESP	  <= SINK_AXI_BRESP;
--            AXI_BVALID    <= SINK_AXI_BVALID;
            AXI_ARREADY   <= SINK_AXI_ARREADY;
            AXI_RID	      <= SINK_AXI_RID;
            AXI_RDATA	  <= SINK_AXI_RDATA;
            AXI_RRESP	  <= SINK_AXI_RRESP;
            AXI_RLAST	  <= SINK_AXI_RLAST;
            AXI_RVALID    <= SINK_AXI_RVALID;
        end if;
    end process proc_read_sink;
		
    proc_write_sink: process(blocked_sig(1))
    begin
        if (blocked_sig(1) = '0') then
            --------------------------------------------------------------------------
            -- PS MASTER AXI OUTPUT SIGNALS
            --------------------------------------------------------------------------
            -- Sink Inputs
            SINK_AXI_AWID 	  <= AXI_AWID;
            --SINK_AXI_AWADDR  <= AXI_AWADDR;
            SINK_AXI_AWLEN   <= AXI_AWLEN;
            SINK_AXI_AWSIZE  <= AXI_AWSIZE;
            SINK_AXI_AWBURST <= AXI_AWBURST;
            SINK_AXI_AWLOCK  <= AXI_AWLOCK;
            SINK_AXI_AWCACHE <= AXI_AWCACHE;
            SINK_AXI_AWPROT  <= AXI_AWPROT;
--            SINK_AXI_AWVALID <= AXI_AWVALID;
            SINK_AXI_AWUSER  <= AXI_AWUSER;
            SINK_AXI_WDATA   <= AXI_WDATA;
            SINK_AXI_WSTRB   <= AXI_WSTRB;
            SINK_AXI_WLAST   <= AXI_WLAST;
            SINK_AXI_WVALID  <= AXI_WVALID;
            SINK_AXI_BREADY  <= AXI_BREADY;
            SINK_AXI_AWQOS   <= AXI_AWQOS;
            SINK_AXI_AWVALID <= '0';
            -- Master Outputs
            M_AXI_AWID 	  <= AXI_AWID;
            M_AXI_AWADDR  <= AXI_AWADDR;
            M_AXI_AWLEN   <= AXI_AWLEN;
            M_AXI_AWSIZE  <= AXI_AWSIZE;
            M_AXI_AWBURST <= AXI_AWBURST;
            M_AXI_AWLOCK  <= AXI_AWLOCK;
            M_AXI_AWCACHE <= AXI_AWCACHE;
            M_AXI_AWPROT  <= AXI_AWPROT;
            M_AXI_AWVALID <= AXI_AWVALID;
            M_AXI_AWUSER  <= AXI_AWUSER;
            M_AXI_WDATA   <= AXI_WDATA;
            M_AXI_WSTRB   <= AXI_WSTRB;
            M_AXI_WLAST   <= AXI_WLAST;
            M_AXI_WVALID  <= AXI_WVALID;
            M_AXI_BREADY  <= AXI_BREADY;
            M_AXI_AWQOS   <= AXI_AWQOS;
            -- Master Inputs
            AXI_AWREADY   <= AXI_AWREADY_REG;
            AXI_WREADY    <= M_AXI_WREADY;
            AXI_BID	      <= M_AXI_BID;
            AXI_BRESP	  <= M_AXI_BRESP;
            AXI_BVALID    <= M_AXI_BVALID;
        else
            -- Master Outputs
            M_AXI_AWID 	  <= (others => '0');
            M_AXI_AWADDR  <= (others => '0');
            M_AXI_AWLEN   <= (others => '0');
            M_AXI_AWSIZE  <= (others => '0');
            M_AXI_AWBURST <= (others => '0');
            M_AXI_AWLOCK  <= '0';
            M_AXI_AWCACHE <= (others => '0');
            M_AXI_AWPROT  <= (others => '0');
            M_AXI_AWVALID <= '0';
            M_AXI_AWUSER  <= (others => '0');
            M_AXI_WDATA   <= (others => '0');
            M_AXI_WSTRB   <= (others => '0');
            M_AXI_WLAST   <= '0';
            M_AXI_WVALID  <= '0';
            M_AXI_BREADY  <= '0';
            M_AXI_AWQOS   <= (others => '0');
            -- Sink Inputs
            SINK_AXI_AWID 	  <= AXI_AWID;
            --SINK_AXI_AWADDR  <= AXI_AWADDR;
            SINK_AXI_AWLEN   <= AXI_AWLEN;
            SINK_AXI_AWSIZE  <= AXI_AWSIZE;
            SINK_AXI_AWBURST <= AXI_AWBURST;
            SINK_AXI_AWLOCK  <= AXI_AWLOCK;
            SINK_AXI_AWCACHE <= AXI_AWCACHE;
            SINK_AXI_AWPROT  <= AXI_AWPROT;
            SINK_AXI_AWVALID <= AXI_AWVALID;
            SINK_AXI_AWUSER  <= AXI_AWUSER;
            SINK_AXI_WDATA   <= AXI_WDATA;
            SINK_AXI_WSTRB   <= AXI_WSTRB;
            SINK_AXI_WLAST   <= AXI_WLAST;
            SINK_AXI_WVALID  <= AXI_WVALID;
            SINK_AXI_BREADY  <= AXI_BREADY;
            SINK_AXI_AWQOS   <= AXI_AWQOS;
            -- Sink Outputs
            AXI_AWREADY   <= SINK_AXI_AWREADY;
            AXI_WREADY    <= SINK_AXI_WREADY;
            AXI_BID	      <= SINK_AXI_BID;
            AXI_BRESP	  <= SINK_AXI_BRESP;
            AXI_BVALID    <= SINK_AXI_BVALID;
        end if;
    end process proc_write_sink;
		

    -- Instantiation of Axi Masters Detection Circuit
    AXI_MONITOR_inst : Axi_Monitor
        generic map (
            C_REGIONS_MAX           => C_REGIONS_MAX,
            C_S00_AXI_ADDR_WIDTH	=> C_S_AXI_ADDR_WIDTH,
            C_S00_AXI_AWUSER_WIDTH	=> C_S_AXI_AWUSER_WIDTH,
            C_S00_AXI_ARUSER_WIDTH	=> C_S_AXI_ARUSER_WIDTH
        )
        port map (
		S00_AXI_aclk	=> S_AXI_ACLK,
		S00_AXI_aresetn	=> S_AXI_ARESETN,
		S00_AXI_awaddr	=> S_AXI_AWADDR,
		S00_AXI_awuser	=> S_AXI_AWUSER,
		S00_AXI_awvalid	=> S_AXI_AWVALID,
		S00_AXI_awready	=>   AXI_AWREADY,
		S00_AXI_awprot  => S_AXI_AWPROT,
		S00_AXI_araddr	=> S_AXI_ARADDR,
		S00_AXI_aruser	=> S_AXI_ARUSER,
		S00_AXI_arvalid	=> S_AXI_ARVALID,
		S00_AXI_arready	=>   AXI_ARREADY,
		S00_AXI_arprot  => S_AXI_ARPROT,
		S00_AXI_rlast   =>   AXI_RLAST,
		S00_AXI_bvalid	=>   AXI_BVALID,
		M00_AXI_araddr  =>   AXI_ARADDR,
		M00_AXI_arvalid	=>   AXI_ARVALID,
		M00_AXI_arprot  =>   AXI_ARPROT,
		M00_AXI_awready	=> M_AXI_AWREADY,
		M00_AXI_awaddr  =>   AXI_AWADDR,
		M00_AXI_awvalid	=>   AXI_AWVALID,
		M00_AXI_awprot  =>   AXI_AWPROT,
		--CONFIGURATION REGISTER PORTS
		CTRL_REG        => config_reg_in(C_CTRL_REG_NUM       ),
		ERR_STATUS1_REG => config_reg_in(C_ERR_STATUS1_REG_NUM),
		ERR_STATUS2_REG => config_reg_in(C_ERR_STATUS2_REG_NUM),
		POISON_REG      => config_reg_in(C_POISON_REG_NUM     ),
		ISR_REG         => config_reg_in(C_ISR_REG_NUM        ),
		IMR_REG         => config_reg_in(C_IMR_REG_NUM        ),
		IEN_REG         => config_reg_in(C_IEN_REG_NUM        ),
		IDS_REG         => config_reg_in(C_IDS_REG_NUM        ),
		LOCK_REG        => config_reg_in(C_LOCK_REG_NUM       ),
		BYPASS_REG      => config_reg_in(C_BYPASS_REG_NUM     ),
		REGIONS_REG     => config_reg_in(C_REGIONS_REG_NUM    ),
		R00_START_REG   => config_reg_in(C_R00_START_REG_NUM  ),
		R00_END_REG     => config_reg_in(C_R00_END_REG_NUM    ),
		R00_MASTERS_REG => config_reg_in(C_R00_MASTERS_REG_NUM),
		R00_CONFIG_REG  => config_reg_in(C_R00_CONFIG_REG_NUM ),
		R01_START_REG   => config_reg_in(C_R01_START_REG_NUM  ),
		R01_END_REG     => config_reg_in(C_R01_END_REG_NUM    ),
		R01_MASTERS_REG => config_reg_in(C_R01_MASTERS_REG_NUM),
		R01_CONFIG_REG  => config_reg_in(C_R01_CONFIG_REG_NUM ),
		R02_START_REG   => config_reg_in(C_R02_START_REG_NUM  ),
		R02_END_REG     => config_reg_in(C_R02_END_REG_NUM    ),
		R02_MASTERS_REG => config_reg_in(C_R02_MASTERS_REG_NUM),
		R02_CONFIG_REG  => config_reg_in(C_R02_CONFIG_REG_NUM ),
		R03_START_REG   => config_reg_in(C_R03_START_REG_NUM  ),
		R03_END_REG     => config_reg_in(C_R03_END_REG_NUM    ),
		R03_MASTERS_REG => config_reg_in(C_R03_MASTERS_REG_NUM),
		R03_CONFIG_REG  => config_reg_in(C_R03_CONFIG_REG_NUM ),
		R04_START_REG   => config_reg_in(C_R04_START_REG_NUM  ),
		R04_END_REG     => config_reg_in(C_R04_END_REG_NUM    ),
		R04_MASTERS_REG => config_reg_in(C_R04_MASTERS_REG_NUM),
		R04_CONFIG_REG  => config_reg_in(C_R04_CONFIG_REG_NUM ),
		R05_START_REG   => config_reg_in(C_R05_START_REG_NUM  ),
		R05_END_REG     => config_reg_in(C_R05_END_REG_NUM    ),
		R05_MASTERS_REG => config_reg_in(C_R05_MASTERS_REG_NUM),
		R05_CONFIG_REG  => config_reg_in(C_R05_CONFIG_REG_NUM ),
		R06_START_REG   => config_reg_in(C_R06_START_REG_NUM  ),
		R06_END_REG     => config_reg_in(C_R06_END_REG_NUM    ),
		R06_MASTERS_REG => config_reg_in(C_R06_MASTERS_REG_NUM),
		R06_CONFIG_REG  => config_reg_in(C_R06_CONFIG_REG_NUM ),
		R07_START_REG   => config_reg_in(C_R07_START_REG_NUM  ),
		R07_END_REG     => config_reg_in(C_R07_END_REG_NUM    ),
		R07_MASTERS_REG => config_reg_in(C_R07_MASTERS_REG_NUM),
		R07_CONFIG_REG  => config_reg_in(C_R07_CONFIG_REG_NUM ),
		R08_START_REG   => config_reg_in(C_R08_START_REG_NUM  ),
		R08_END_REG     => config_reg_in(C_R08_END_REG_NUM    ),
		R08_MASTERS_REG => config_reg_in(C_R08_MASTERS_REG_NUM),
		R08_CONFIG_REG  => config_reg_in(C_R08_CONFIG_REG_NUM ),
		R09_START_REG   => config_reg_in(C_R09_START_REG_NUM  ),
		R09_END_REG     => config_reg_in(C_R09_END_REG_NUM    ),
		R09_MASTERS_REG => config_reg_in(C_R09_MASTERS_REG_NUM),
		R09_CONFIG_REG  => config_reg_in(C_R09_CONFIG_REG_NUM ),
		R10_START_REG   => config_reg_in(C_R10_START_REG_NUM  ),
		R10_END_REG     => config_reg_in(C_R10_END_REG_NUM    ),
		R10_MASTERS_REG => config_reg_in(C_R10_MASTERS_REG_NUM),
		R10_CONFIG_REG  => config_reg_in(C_R10_CONFIG_REG_NUM ),
		R11_START_REG   => config_reg_in(C_R11_START_REG_NUM  ),
		R11_END_REG     => config_reg_in(C_R11_END_REG_NUM    ),
		R11_MASTERS_REG => config_reg_in(C_R11_MASTERS_REG_NUM),
		R11_CONFIG_REG  => config_reg_in(C_R11_CONFIG_REG_NUM ),
		R12_START_REG   => config_reg_in(C_R12_START_REG_NUM  ),
		R12_END_REG     => config_reg_in(C_R12_END_REG_NUM    ),
		R12_MASTERS_REG => config_reg_in(C_R12_MASTERS_REG_NUM),
		R12_CONFIG_REG  => config_reg_in(C_R12_CONFIG_REG_NUM ),
		R13_START_REG   => config_reg_in(C_R13_START_REG_NUM  ),
		R13_END_REG     => config_reg_in(C_R13_END_REG_NUM    ),
		R13_MASTERS_REG => config_reg_in(C_R13_MASTERS_REG_NUM),
		R13_CONFIG_REG  => config_reg_in(C_R13_CONFIG_REG_NUM ),
		R14_START_REG   => config_reg_in(C_R14_START_REG_NUM  ),
		R14_END_REG     => config_reg_in(C_R14_END_REG_NUM    ),
		R14_MASTERS_REG => config_reg_in(C_R14_MASTERS_REG_NUM),
		R14_CONFIG_REG  => config_reg_in(C_R14_CONFIG_REG_NUM ),
		R15_START_REG   => config_reg_in(C_R15_START_REG_NUM  ),
		R15_END_REG     => config_reg_in(C_R15_END_REG_NUM    ),
		R15_MASTERS_REG => config_reg_in(C_R15_MASTERS_REG_NUM),
		R15_CONFIG_REG  => config_reg_in(C_R15_CONFIG_REG_NUM ),
        VALID           => valid_sig,
        READ_BLOCKED    => blocked_sig(0),
        WRITE_BLOCKED   => blocked_sig(1),
        ACTIVE_REGION   => OPEN
        );
        
    -- Instantiation of Axi Masters Detection Circuit
    AXI_SINK_inst : SINK_S_AXI
        generic map (
		-- Users to add parameters here
		-- User parameters ends
		C_S_AXI_ID_WIDTH	=> C_S_AXI_ID_WIDTH,
		C_S_AXI_DATA_WIDTH	=> C_S_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S_AXI_ADDR_WIDTH,
		C_S_AXI_AWUSER_WIDTH=> C_S_AXI_AWUSER_WIDTH,
		C_S_AXI_ARUSER_WIDTH=> C_S_AXI_ARUSER_WIDTH
--		C_S_AXI_WUSER_WIDTH	=>,
--		C_S_AXI_RUSER_WIDTH	=>,
--		C_S_AXI_BUSER_WIDTH	=>
        )
        port map (
		-- Users to add ports here
		AXI_RESP_VAL	=> config_reg_in(C_CTRL_REG_NUM)(6 downto 5),
		-- User ports ends
		-- Do not modify the ports beyond this line
		S_AXI_ACLK        => S_AXI_ACLK,
		S_AXI_ARESETN	  => S_AXI_ARESETN,      
		S_AXI_AWID        => SINK_AXI_AWID,  
		S_AXI_AWADDR      => S_AXI_AWADDR,  
		S_AXI_AWLEN	      => SINK_AXI_AWLEN,  
		S_AXI_AWSIZE      => SINK_AXI_AWSIZE,  
		S_AXI_AWBURST     => SINK_AXI_AWBURST,  
		S_AXI_AWLOCK      => SINK_AXI_AWLOCK ,  
		S_AXI_AWCACHE     => SINK_AXI_AWCACHE,  
		S_AXI_AWPROT      => SINK_AXI_AWPROT,  
		S_AXI_AWQOS	      => SINK_AXI_AWQOS,  
		S_AXI_AWREGION    => (others => '0'), 
		S_AXI_AWUSER      => SINK_AXI_AWUSER ,  
		S_AXI_AWVALID     => SINK_AXI_AWVALID,  
		S_AXI_AWREADY     => SINK_AXI_AWREADY,  
		S_AXI_WDATA	      => SINK_AXI_WDATA,  
		S_AXI_WSTRB	      => SINK_AXI_WSTRB,  
		S_AXI_WLAST	      => SINK_AXI_WLAST,  
		S_AXI_WUSER	      => (others => '0'),
		S_AXI_WVALID      => SINK_AXI_WVALID,  
		S_AXI_WREADY      => SINK_AXI_WREADY,  
		S_AXI_BID         => SINK_AXI_BID,  
		S_AXI_BRESP	      => SINK_AXI_BRESP	,  
		S_AXI_BUSER	      => OPEN, 
		S_AXI_BVALID      => SINK_AXI_BVALID,  
		S_AXI_BREADY      => SINK_AXI_BREADY,  
		S_AXI_ARID        => SINK_AXI_ARID,  
		S_AXI_ARADDR      => S_AXI_ARADDR,  
		S_AXI_ARLEN	      => SINK_AXI_ARLEN,  
		S_AXI_ARSIZE      => SINK_AXI_ARSIZE,  
		S_AXI_ARBURST     => SINK_AXI_ARBURST,  
		S_AXI_ARLOCK      => SINK_AXI_ARLOCK,  
		S_AXI_ARCACHE     => SINK_AXI_ARCACHE,  
		S_AXI_ARPROT      => SINK_AXI_ARPROT,  
		S_AXI_ARQOS	      => SINK_AXI_ARQOS,  
		S_AXI_ARREGION    => (others => '0'),
		S_AXI_ARUSER      => SINK_AXI_ARUSER ,  
		S_AXI_ARVALID     => SINK_AXI_ARVALID,  
		S_AXI_ARREADY     => SINK_AXI_ARREADY,  
		S_AXI_RID         => SINK_AXI_RID,  
		S_AXI_RDATA	      => SINK_AXI_RDATA,  
		S_AXI_RRESP	      => SINK_AXI_RRESP,  
		S_AXI_RLAST	      => SINK_AXI_RLAST,  
		S_AXI_RUSER	      => OPEN,  
		S_AXI_RVALID      => SINK_AXI_RVALID,  
		S_AXI_RREADY      => SINK_AXI_RREADY 
        );
        
    -- AWREADY Synchronization
    proc_awready: process(S_AXI_ACLK)
    begin
        if (S_AXI_ARESETN = '0') then
            AXI_AWREADY_REG <= '0';
        elsif rising_edge(S_AXI_ACLK) then
            if ((AXI_AWREADY_REG = '0') and (AXI_AWVALID = '1')) then 
                AXI_AWREADY_REG  <=  M_AXI_AWREADY;
            else 
                AXI_AWREADY_REG  <= '0';
            end if;
		end if;
    end process proc_awready;
    
    -- Axi Block Trigger
    proc_block: process(S_AXI_ACLK, blocked_sig)
    begin
        if (S_AXI_ARESETN = '0') then
            blocked_reg <= (others => '0');
        elsif rising_edge(S_AXI_ACLK) then
            blocked_reg <=  blocked_sig;
        end if;
        blocked_trig(0) <= blocked_sig(0) and NOT blocked_reg(0);
        blocked_trig(1) <= blocked_sig(1) and NOT blocked_reg(1);
    end process proc_block;
    
    -- Error Status Registers
    proc_err_stat: process(S_AXI_ACLK)
    begin
        if (S_AXI_ARESETN = '0') then
            err_stat1_reg <= (others => '0');
            err_stat2_reg <= (others => '0');
        elsif rising_edge(S_AXI_ACLK) then
            if (blocked_trig = "00") then
                if (S_AXI_ARVALID = '1') then
                    err_stat1_reg <= S_AXI_ARADDR(31 downto 0);
                    err_stat2_reg(C_S_AXI_ARUSER_WIDTH-1 downto 0) <= S_AXI_ARUSER;
                elsif (S_AXI_AWVALID = '1') then
                    err_stat1_reg <= S_AXI_AWADDR(31 downto 0);
                    err_stat2_reg(C_S_AXI_AWUSER_WIDTH-1 downto 0) <= S_AXI_AWUSER;
                end if;
            end if;
        end if;
    end process proc_err_stat;
    
    --------------------------------------------------------------------------
    -- CONFIGURATION RESPONSE SIGNALS
    --------------------------------------------------------------------------
    err_status1_out <= err_stat1_reg;
    err_status2_out <= err_stat2_reg;
    axi_block_trig <= blocked_trig;
	
end Behavioral;
