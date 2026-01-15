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
--  /   /         Filename: Axi_Monitor.vhd         
-- /___/   /\     Timestamp: $DateTime: 2024/02/10 19:45:05 $
-- \   \  /  \
--  \___\/\___\
--
--
-- Purpose: This module implements the AXI monitor for the XMPU PL Instance 
-- and monitors AXI transactions for unauthorized access attempts.
--
-- Instantiates   : Axi_Masters
-- Requirements Addressed :  
--------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
--use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library xil_defaultlib;
use xil_defaultlib.axi_masters_package.all;

entity Axi_Monitor is
	generic (
        C_REGIONS_MAX    : integer := 16;
        -- Parameters of Axi Slave Bus Interface S00_AXI
        C_S00_AXI_ADDR_WIDTH	: integer	:= 40;
        C_S00_AXI_AWUSER_WIDTH	: integer	:= 16;
        C_S00_AXI_ARUSER_WIDTH	: integer	:= 16
	);
    port (
        S00_AXI_aclk	  : in std_logic;
        S00_AXI_aresetn	  : in std_logic;
        S00_AXI_awaddr	  : in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
        S00_AXI_awuser	  : in std_logic_vector(C_S00_AXI_AWUSER_WIDTH-1 downto 0);
        S00_AXI_awvalid	  : in std_logic;
        S00_AXI_awready	  : in std_logic;
        S00_AXI_awprot    : in std_logic_vector(2 downto 0);
        S00_AXI_araddr	  : in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
        S00_AXI_aruser	  : in std_logic_vector(C_S00_AXI_ARUSER_WIDTH-1 downto 0);
        S00_AXI_arvalid	  : in std_logic;
        S00_AXI_arready	  : in std_logic;
        S00_AXI_arprot    : in std_logic_vector(2 downto 0);
        S00_AXI_rlast     : in std_logic;
        S00_AXI_bvalid	  : in std_logic;
        M00_AXI_araddr    : out std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
        M00_AXI_arvalid	  : out std_logic;
        M00_AXI_arprot    : out std_logic_vector(2 downto 0);
        M00_AXI_awready	  : in std_logic;
        M00_AXI_awaddr    : out std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
        M00_AXI_awvalid	  : out std_logic;
        M00_AXI_awprot    : out std_logic_vector(2 downto 0);
        --CONFIGURATION REGISTER PORTS
        CTRL_REG          : in std_logic_vector(31 downto 0);
        ERR_STATUS1_REG   : in std_logic_vector(31 downto 0);
        ERR_STATUS2_REG   : in std_logic_vector(31 downto 0);
        POISON_REG        : in std_logic_vector(31 downto 0);
        ISR_REG           : in std_logic_vector(31 downto 0);
        IMR_REG           : in std_logic_vector(31 downto 0);
        IEN_REG           : in std_logic_vector(31 downto 0);
        IDS_REG           : in std_logic_vector(31 downto 0);
        LOCK_REG          : in std_logic_vector(31 downto 0);
        BYPASS_REG        : in std_logic_vector(31 downto 0);
        REGIONS_REG       : in std_logic_vector(31 downto 0);
        R00_START_REG     : in std_logic_vector(31 downto 0);
        R00_END_REG       : in std_logic_vector(31 downto 0);
        R00_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R00_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R01_START_REG     : in std_logic_vector(31 downto 0);
        R01_END_REG       : in std_logic_vector(31 downto 0);
        R01_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R01_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R02_START_REG     : in std_logic_vector(31 downto 0);
        R02_END_REG       : in std_logic_vector(31 downto 0);
        R02_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R02_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R03_START_REG     : in std_logic_vector(31 downto 0);
        R03_END_REG       : in std_logic_vector(31 downto 0);
        R03_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R03_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R04_START_REG     : in std_logic_vector(31 downto 0);
        R04_END_REG       : in std_logic_vector(31 downto 0);
        R04_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R04_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R05_START_REG     : in std_logic_vector(31 downto 0);
        R05_END_REG       : in std_logic_vector(31 downto 0);
        R05_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R05_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R06_START_REG     : in std_logic_vector(31 downto 0);
        R06_END_REG       : in std_logic_vector(31 downto 0);
        R06_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R06_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R07_START_REG     : in std_logic_vector(31 downto 0);
        R07_END_REG       : in std_logic_vector(31 downto 0);
        R07_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R07_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R08_START_REG     : in std_logic_vector(31 downto 0);
        R08_END_REG       : in std_logic_vector(31 downto 0);
        R08_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R08_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R09_START_REG     : in std_logic_vector(31 downto 0);
        R09_END_REG       : in std_logic_vector(31 downto 0);
        R09_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R09_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R10_START_REG     : in std_logic_vector(31 downto 0);
        R10_END_REG       : in std_logic_vector(31 downto 0);
        R10_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R10_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R11_START_REG     : in std_logic_vector(31 downto 0);
        R11_END_REG       : in std_logic_vector(31 downto 0);
        R11_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R11_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R12_START_REG     : in std_logic_vector(31 downto 0);
        R12_END_REG       : in std_logic_vector(31 downto 0);
        R12_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R12_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R13_START_REG     : in std_logic_vector(31 downto 0);
        R13_END_REG       : in std_logic_vector(31 downto 0);
        R13_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R13_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R14_START_REG     : in std_logic_vector(31 downto 0);
        R14_END_REG       : in std_logic_vector(31 downto 0);
        R14_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R14_CONFIG_REG    : in std_logic_vector(31 downto 0);
        R15_START_REG     : in std_logic_vector(31 downto 0);
        R15_END_REG       : in std_logic_vector(31 downto 0);
        R15_MASTERS_REG   : in std_logic_vector(31 downto 0);
        R15_CONFIG_REG    : in std_logic_vector(31 downto 0);
        VALID             : out STD_LOGIC;
        READ_BLOCKED      : out std_logic;
        WRITE_BLOCKED     : out std_logic;
        ACTIVE_REGION     : out std_logic_vector(7 downto 0)
    );
end Axi_Monitor;

architecture STRUCTURE of Axi_Monitor is

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
		AWUSER          : in std_logic_vector(C_S00_AXI_AWUSER_WIDTH-1 downto 0);
        SEC_MASTERS     : in STD_LOGIC_VECTOR(31 downto 0);
        RPROT_OUT       : out STD_LOGIC_VECTOR (2 downto 0);
        WPROT_OUT       : out STD_LOGIC_VECTOR (2 downto 0);
        READ_SECURE     : out std_logic;
        WRITE_SECURE    : out std_logic
        );
    end component Axi_Masters;
    
    --Internal Signals
    signal CLK                  : std_logic;
    signal VALID_SIG            : std_logic; 
    signal VALID_SIG_REG        : std_logic; 
    signal ARVALID              : std_logic; 
    signal AWVALID              : std_logic; 
    signal ARVALID_FF           : std_logic; 
    signal AWVALID_FF           : std_logic; 
    signal ARREADY              : std_logic; 
    signal AWREADY              : std_logic; 
    signal MID                  : std_logic_vector(9 downto 0); 
    signal READ_ADDR            : std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0); 
    signal WRITE_ADDR           : std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0); 
    signal AXI_ARADDR           : std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0); 
    signal AXI_AWADDR           : std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0); 
    signal SINK_ADDR            : std_logic_vector(39 downto 0); 
    signal AXI_BLOCK            : std_logic_vector(1 downto 0); 
    signal AXI_READ             : std_logic; 
    signal AXI_WRITE            : std_logic; 
    signal write_block          : std_logic;
    signal read_block           : std_logic;
    signal int_rprot_1          : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal int_wprot_1          : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal rprot_sig            : std_logic_vector(2 downto 0);
    signal wprot_sig            : std_logic_vector(2 downto 0);
    signal rd_reg_sel           : integer;
    signal wr_reg_sel           : integer;
    signal rd_active_region_sig : std_logic_vector(7 downto 0);
    signal wr_active_region_sig : std_logic_vector(7 downto 0);
    
    --Control Signals
    signal DefRdAllowed         : std_logic;
    signal DefWrAllowed         : std_logic;
    signal PoisonAddressEn      : std_logic;
    signal PoisonAttributeEn    : std_logic;
    signal ExternalSinkEn       : std_logic;
    signal PoisonAxiResp        : std_logic_vector(1 downto 0);
    signal AddressHigh          : std_logic_vector(7 downto 0);
    
    --Secure Regions
    signal read_region_trig     : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal write_region_trig    : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal read_secure          : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal write_secure         : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal axi_read_block_sig   : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal axi_write_block_sig  : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal axi_read_allow_sig   : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal axi_write_allow_sig  : std_logic_vector(C_REGIONS_MAX-1 downto 0);
    signal sec_rprot            : prot_array;
    signal sec_wprot            : prot_array;
    
    --Address Arrays
    signal reg_addr_base        : addr_array;
    signal reg_addr_high        : addr_array;
    
    --Secure Masters
    signal secure_masters       : master_array;
    signal det_sec_master       : std_logic_vector(0 to C_MASTERS-1);
    signal REG_MASTERS          : reg_array;
    signal REG_CONFIG           : reg_array;
    
    --Master ID Arrays
    signal master_ids           : mid_array;
    signal mid_masks            : mid_array;

	------------------------------------------------
	---- Functions
	------------------------------------------------
    function FIND_ONE ( input : std_logic_vector(C_REGIONS_MAX-1 downto 0)) return integer is
        variable v_bit_one : boolean;
        variable v_bit_pos : integer;
        variable v_i : integer;
    begin
        v_bit_one := FALSE;
        v_bit_pos := C_REGIONS_MAX;
        for v_i in 0 TO C_REGIONS_MAX-1 loop
            if ((input(v_i) = '1') and (v_bit_one = FALSE)) then
                v_bit_one := TRUE;
                v_bit_pos := v_i;
            end if;
        end loop;
        return v_bit_pos;
    end function;
      
    -- Purpose: This function converts numerical offset to high address.
    function f_ADDR_OFFSET (
            r_BASE : std_logic_vector(31 downto 0);
            r_OFFSET : integer)
        return std_logic_vector is
            variable v_ADDR_TEMP : unsigned(31 downto 0);
            variable v_OFFSET_TEMP : unsigned(31 downto 0);
    begin
        v_OFFSET_TEMP := to_unsigned(r_OFFSET,22) & "0000000000";
        v_ADDR_TEMP := v_OFFSET_TEMP + unsigned(r_BASE);
        return std_logic_vector(v_ADDR_TEMP);
    end;


begin

    
    --AXI Inputs
    AXI_READ            <= S00_AXI_arvalid;
    AXI_WRITE           <= S00_AXI_awvalid;
    READ_ADDR           <= S00_AXI_araddr;
    WRITE_ADDR          <= S00_AXI_awaddr;
    
    -- Control Inputs
    DefRdAllowed        <= CTRL_REG(0);
    DefWrAllowed        <= CTRL_REG(1); 
    PoisonAddressEn     <= CTRL_REG(2);
    PoisonAttributeEn   <= CTRL_REG(3);
    ExternalSinkEn      <= CTRL_REG(4);
    PoisonAxiResp       <= CTRL_REG(6 downto 5);
    SINK_ADDR           <=  POISON_REG & X"00";
    
    --Set Master IDs
    master_ids          <= MID_INIT;
    mid_masks           <= MSK_INIT;
    
    -- Region Masters Array
    REG_MASTERS( 0)     <= R00_MASTERS_REG;
    REG_MASTERS( 1)     <= R01_MASTERS_REG;
    REG_MASTERS( 2)     <= R02_MASTERS_REG;
    REG_MASTERS( 3)     <= R03_MASTERS_REG;
    REG_MASTERS( 4)     <= R04_MASTERS_REG;
    REG_MASTERS( 5)     <= R05_MASTERS_REG;
    REG_MASTERS( 6)     <= R06_MASTERS_REG;
    REG_MASTERS( 7)     <= R07_MASTERS_REG;
    REG_MASTERS( 8)     <= R08_MASTERS_REG;
    REG_MASTERS( 9)     <= R09_MASTERS_REG;
    REG_MASTERS(10)     <= R10_MASTERS_REG;
    REG_MASTERS(11)     <= R11_MASTERS_REG;
    REG_MASTERS(12)     <= R12_MASTERS_REG;
    REG_MASTERS(13)     <= R13_MASTERS_REG;
    REG_MASTERS(14)     <= R14_MASTERS_REG;
    REG_MASTERS(15)     <= R15_MASTERS_REG;

    -- Region Config Array
    REG_CONFIG( 0)      <= R00_CONFIG_REG;
    REG_CONFIG( 1)      <= R01_CONFIG_REG;
    REG_CONFIG( 2)      <= R02_CONFIG_REG;
    REG_CONFIG( 3)      <= R03_CONFIG_REG;
    REG_CONFIG( 4)      <= R04_CONFIG_REG;
    REG_CONFIG( 5)      <= R05_CONFIG_REG;
    REG_CONFIG( 6)      <= R06_CONFIG_REG;
    REG_CONFIG( 7)      <= R07_CONFIG_REG;
    REG_CONFIG( 8)      <= R08_CONFIG_REG;
    REG_CONFIG( 9)      <= R09_CONFIG_REG;
    REG_CONFIG(10)      <= R10_CONFIG_REG;
    REG_CONFIG(11)      <= R11_CONFIG_REG;
    REG_CONFIG(12)      <= R12_CONFIG_REG;
    REG_CONFIG(13)      <= R13_CONFIG_REG;
    REG_CONFIG(14)      <= R14_CONFIG_REG;
    REG_CONFIG(15)      <= R15_CONFIG_REG;
    
    --Region 0 Addresses
    reg_addr_base(0)    <= R00_START_REG & x"00";
    reg_addr_high(0)    <= R00_END_REG & x"FF";
    
    --Region 1 Addresses
    reg_addr_base(1)    <= R01_START_REG & x"00";
    reg_addr_high(1)    <= R01_END_REG & x"FF";  
    
    --Region 2 Addresses
    reg_addr_base(2)    <= R02_START_REG & x"00";
    reg_addr_high(2)    <= R02_END_REG & x"FF";  
    
    --Region 3 Addresses
    reg_addr_base(3)    <= R03_START_REG & x"00";
    reg_addr_high(3)    <= R03_END_REG & x"FF";  
    
    --Region 4 Addresses
    reg_addr_base(4)    <= R04_START_REG & x"00";
    reg_addr_high(4)    <= R04_END_REG & x"FF";  
    
    --Region 5 Addresses
    reg_addr_base(5)    <= R05_START_REG & x"00";
    reg_addr_high(5)    <= R05_END_REG & x"FF";  
    
    --Region 6 Addresses
    reg_addr_base(6)    <= R06_START_REG & x"00";
    reg_addr_high(6)    <= R06_END_REG & x"FF";  
    
    --Region 7 Addresses
    reg_addr_base(7)    <= R07_START_REG & x"00";
    reg_addr_high(7)    <= R07_END_REG & x"FF";  
    
    --Region 8 Addresses
    reg_addr_base(8)    <= R08_START_REG & x"00";
    reg_addr_high(8)    <= R08_END_REG & x"FF";  
    
    --Region 9 Addresses
    reg_addr_base(9)    <= R09_START_REG & x"00";
    reg_addr_high(9)    <= R09_END_REG & x"FF";  
    
    --Region 10 Addresses
    reg_addr_base(10)   <= R10_START_REG & x"00";
    reg_addr_high(10)   <= R10_END_REG & x"FF";  
    
    --Region 11 Addresses
    reg_addr_base(11)   <= R11_START_REG & x"00";
    reg_addr_high(11)   <= R11_END_REG & x"FF";  
    
    --Region 12 Addresses
    reg_addr_base(12)   <= R12_START_REG & x"00";
    reg_addr_high(12)   <= R12_END_REG & x"FF";  
    
    --Region 13 Addresses
    reg_addr_base(13)   <= R13_START_REG & x"00";
    reg_addr_high(13)   <= R13_END_REG & x"FF";  
    
    --Region 14 Addresses
    reg_addr_base(14)   <= R14_START_REG & x"00";
    reg_addr_high(14)   <= R14_END_REG & x"FF";  
    
    --Region 15 Addresses
    reg_addr_base(15)   <= R15_START_REG & x"00";
    reg_addr_high(15)   <= R15_END_REG & x"FF";  
    
    -- Internal Axi Clock
    CLK                 <= S00_AXI_aclk;
    VALID_SIG           <= AXI_READ OR AXI_WRITE;
    
    REGION: for reg_i in 0 to C_REGIONS_MAX-1 generate
        -- Instantiation of Axi Masters Detection Circuit
        AXI_MASTERS_inst : Axi_Masters
            generic map (
                C_S00_AXI_AWUSER_WIDTH	=> C_S00_AXI_AWUSER_WIDTH,
		        C_S00_AXI_ARUSER_WIDTH	=> C_S00_AXI_ARUSER_WIDTH
            )
            port map (
                ARPROT          => S00_AXI_arprot,
                ARUSER	        => S00_AXI_aruser,
                AWPROT          => S00_AXI_awprot,
                AWUSER	        => S00_AXI_awuser,
                SEC_MASTERS     => REG_MASTERS(reg_i),
                RPROT_OUT       => sec_rprot(reg_i),
                WPROT_OUT       => sec_wprot(reg_i),
                READ_SECURE     => read_secure(reg_i),
                WRITE_SECURE    => write_secure(reg_i)
            );
            
        
        --Identify reads from secured region addresses.
        proc_read_det: process(READ_ADDR)
        variable Enable : std_logic := '0';
        begin
            Enable := REG_CONFIG(reg_i)(0);
            if (Enable = '1') then
                if ((READ_ADDR >= (reg_addr_base(reg_i))) and (READ_ADDR < (reg_addr_high(reg_i)))) then
                    read_region_trig(reg_i) <= '1';
                else
                    read_region_trig(reg_i) <= '0';
                end if;
            else
                read_region_trig(reg_i) <= '0';
           end if;
        end process proc_read_det;
        
        --Identify writes to secured region addresses.
        proc_write_det: process(WRITE_ADDR)
        variable Enable : std_logic := '0';
        begin
            Enable := REG_CONFIG(reg_i)(0);
            if (Enable = '1') then
                if ((WRITE_ADDR >= (reg_addr_base(reg_i))) and (WRITE_ADDR < (reg_addr_high(reg_i)))) then
                    write_region_trig(reg_i) <= '1';
                else
                    write_region_trig(reg_i) <= '0';
                end if;
            else
                write_region_trig(reg_i) <= '0';
           end if;
        end process proc_write_det;
        
        --Detect Axi Read Blocks
        proc_axi_read_block: process(AXI_READ, read_region_trig(reg_i), read_secure(reg_i))
        variable v_block_read : std_logic:= '0';
        variable RdAllowed : std_logic:= '0';
        variable RegionNS : std_logic:= '0';
        variable NSCheckType : std_logic:= '0';
        variable MidCheckDisable : std_logic:= '0';
        variable MidMatch : std_logic := '0';
        begin
            RdAllowed := REG_CONFIG(reg_i)(1);
            RegionNS := REG_CONFIG(reg_i)(3);
            NSCheckType := REG_CONFIG(reg_i)(4);
            MidCheckDisable := REG_CONFIG(reg_i)(5);
            MidMatch := read_secure(reg_i);
            v_block_read := ((AXI_READ) and (read_region_trig(reg_i)));
            if (v_block_read = '1') then
                if (RegionNS = '1') then
                    if (NSCheckType = '1') then
                        if (S00_AXI_arprot(1) = '0') then
                            axi_read_block_sig(reg_i) <= '1';
                            axi_read_allow_sig(reg_i) <= '0';
                        else
                            if (RdAllowed = '1') then
                                axi_read_block_sig(reg_i) <= '0';
                                axi_read_allow_sig(reg_i) <= '1';
                            else
                                axi_read_block_sig(reg_i) <= '1';
                                axi_read_allow_sig(reg_i) <= '0';
                            end if;
                        end if;
                    else
                        if (RdAllowed = '1') then
                            axi_read_block_sig(reg_i) <= '0';
                            axi_read_allow_sig(reg_i) <= '1';
                        else
                            axi_read_block_sig(reg_i) <= '1';
                            axi_read_allow_sig(reg_i) <= '0';
                        end if;
                    end if;
                else -- region Secure
                    if (MidCheckDisable = '1') then
                        if (S00_AXI_arprot(1) = '1') then
                            axi_read_block_sig(reg_i) <= '1';
                            axi_read_allow_sig(reg_i) <= '0';
                        else
                            if (RdAllowed = '1') then
                                axi_read_block_sig(reg_i) <= '0';
                                axi_read_allow_sig(reg_i) <= '1';
                            else
                                axi_read_block_sig(reg_i) <= '1';
                                axi_read_allow_sig(reg_i) <= '0';
                            end if;
                        end if;
                    else
                        if ((S00_AXI_arprot(1) = '1') or (MidMatch = '0')) then
                            axi_read_block_sig(reg_i) <= '1';
                            axi_read_allow_sig(reg_i) <= '0';
                        else
                            if (RdAllowed = '1') then
                                axi_read_block_sig(reg_i) <= '0';
                                axi_read_allow_sig(reg_i) <= '1';
                            else
                                axi_read_block_sig(reg_i) <= '1';
                                axi_read_allow_sig(reg_i) <= '0';
                            end if;
                        end if;
                    end if;
                end if;
            else
                axi_read_block_sig(reg_i) <= '0';
                axi_read_allow_sig(reg_i) <= '0';
            end if;
        end process proc_axi_read_block;
        
        --Detect Axi Write Blocks
        proc_axi_write_block: process(AXI_WRITE, write_region_trig(reg_i), write_secure(reg_i))
        variable v_block_write : std_logic:= '0';
        variable WrAllowed : std_logic:= '0';
        variable RegionNS : std_logic:= '0';
        variable NSCheckType : std_logic:= '0';
        variable MidCheckDisable : std_logic:= '0';
        variable MidMatch : std_logic := '0';
        begin
            WrAllowed := REG_CONFIG(reg_i)(2);
            RegionNS := REG_CONFIG(reg_i)(3);
            NSCheckType := REG_CONFIG(reg_i)(4);
            MidCheckDisable := REG_CONFIG(reg_i)(5);
            MidMatch := write_secure(reg_i);
            v_block_write:= ((AXI_WRITE) and (write_region_trig(reg_i)));
            if (v_block_write = '1') then
                if (RegionNS = '1') then
                    if (NSCheckType = '1') then
                        if (S00_AXI_awprot(1) = '0') then
                            axi_write_block_sig(reg_i) <= '1';
                            axi_write_allow_sig(reg_i) <= '0';
                        else
                            if (WrAllowed = '1') then
                                axi_write_block_sig(reg_i) <= '0';
                                axi_write_allow_sig(reg_i) <= '1';
                            else
                                axi_write_block_sig(reg_i) <= '1';
                                axi_write_allow_sig(reg_i) <= '0';
                            end if;
                        end if;
                    else
                        if (WrAllowed = '1') then
                            axi_write_block_sig(reg_i) <= '0';
                            axi_write_allow_sig(reg_i) <= '1';
                        else
                            axi_write_block_sig(reg_i) <= '1';
                            axi_write_allow_sig(reg_i) <= '0';
                        end if;
                    end if;
                else -- region Secure
                    if (MidCheckDisable = '1') then
                        if (S00_AXI_awprot(1) = '1') then
                            axi_write_block_sig(reg_i) <= '1';
                            axi_write_allow_sig(reg_i) <= '0';
                        else
                            if (WrAllowed = '1') then
                                axi_write_block_sig(reg_i) <= '0';
                                axi_write_allow_sig(reg_i) <= '1';
                            else
                                axi_write_block_sig(reg_i) <= '1';
                                axi_write_allow_sig(reg_i) <= '0';
                            end if;
                        end if;
                    else
                        if ((S00_AXI_awprot(1) = '1') or (MidMatch = '0')) then
                            axi_write_block_sig(reg_i) <= '1';
                            axi_write_allow_sig(reg_i) <= '0';
                        else
                            if (WrAllowed = '1') then
                                axi_write_block_sig(reg_i) <= '0';
                                axi_write_allow_sig(reg_i) <= '1';
                            else
                                axi_write_block_sig(reg_i) <= '1';
                                axi_write_allow_sig(reg_i) <= '0';
                            end if;
                        end if;
                    end if;
                end if;
            else
                axi_write_block_sig(reg_i) <= '0';
                axi_write_allow_sig(reg_i) <= '0';
            end if;
        end process proc_axi_write_block;
        
    end generate REGION;

    --Select Region Read Protection Signal
    read_region_sel: process(read_region_trig)
    begin
        rd_reg_sel <= FIND_ONE(read_region_trig);
        rd_active_region_sig <= std_logic_vector(to_unsigned(rd_reg_sel, 8));
    end process read_region_sel;
    rd_prot_sel: process(CLK, rd_reg_sel)
    begin
        if rising_edge(CLK) then 
            if ((rd_reg_sel < 16) and (PoisonAttributeEn = '1')) then
                if ((axi_read_block_sig(rd_reg_sel) = '1')) then
                    rprot_sig <= sec_rprot(rd_reg_sel);
                else
                    rprot_sig <= S00_AXI_arprot;
                end if;
            else
                rprot_sig <= S00_AXI_arprot;
            end if;
        end if;
    end process rd_prot_sel;

    --Select Region Write Protection Signal
    write_region_sel: process(write_region_trig)
    begin
        wr_reg_sel <= FIND_ONE(write_region_trig);
        wr_active_region_sig <= std_logic_vector(to_unsigned(wr_reg_sel, 8));
    end process write_region_sel;
    wr_prot_sel: process(CLK, wr_reg_sel)
    begin
        if rising_edge(CLK) then 
            if ((wr_reg_sel < 16) and (PoisonAttributeEn = '1')) then
                if ((axi_write_block_sig(wr_reg_sel) = '1')) then
                    wprot_sig <= sec_wprot(wr_reg_sel);
                else
                    wprot_sig <= S00_AXI_awprot;
                end if;
            else
                wprot_sig <= S00_AXI_awprot;
            end if;
        end if;
    end process wr_prot_sel;


    -- Register Valid Signal
    proc_reg_valid: process (CLK)
    begin
        if rising_edge(CLK) then
            VALID_SIG_REG <= VALID_SIG;
        end if;
    end process proc_reg_valid;
    
    --Delay stage for AWReady
    proc_axi_awready_in: process(CLK)
    begin
        if rising_edge(CLK) then
            AWREADY <= S00_AXI_awready;
        end if;    
    end process proc_axi_awready_in;
    
    --Delay stage for AWValid
    proc_axi_wvalid_out: process(S00_AXI_awready, AWREADY, AXI_WRITE, CLK)
    begin
        if ((AWVALID = '1') and (AWREADY = '1') and ((AXI_WRITE = '0') or (S00_AXI_awready = '0'))) then
            AWVALID_FF <= '0';
            AWVALID <= '0';
        elsif rising_edge(CLK) then
            AWVALID_FF <= AXI_WRITE;
            if ((AWVALID = '1') and (M00_AXI_awready = '1')) then
                AWVALID <= '0';
            else 
                AWVALID <= AWVALID_FF;
            end if;
        end if;    
    end process proc_axi_wvalid_out;
    
    --Delay stage for ARReady
    proc_axi_arready_in: process(CLK)
    begin
        if rising_edge(CLK) then
            ARREADY <= S00_AXI_arready;
        end if;    
    end process proc_axi_arready_in;
    
    --Delay stage for ARValid
    axi_rvalid_out: process(S00_AXI_arready, ARREADY, AXI_READ, CLK)
    begin
        if ((ARVALID = '1') and (ARREADY = '1') and ((AXI_READ = '0') or (S00_AXI_arready = '0'))) then
            ARVALID_FF <= '0';
            ARVALID <= '0';
        elsif rising_edge(CLK) then
            ARVALID_FF <= AXI_READ;
            ARVALID <= ARVALID_FF;
        end if;    
    end process axi_rvalid_out;
        
    proc_poison_read_trxn: process(CLK)
    begin
        if rising_edge(CLK) then
            if (AXI_READ = '1') then
                if (read_region_trig = "0000000000000000") then
                    --Misses Regions
                    if (DefRdAllowed = '1') then
                        read_block <= '0';
                    else
                        read_block <= '1';
                    end if;
                    AXI_ARADDR <= READ_ADDR;
                else
                    --Hits Region
                    if ((axi_read_allow_sig /= "0000000000000000")) then
                        read_block <= '0';
                        AXI_ARADDR <= READ_ADDR;
                    else
                        if ((axi_read_block_sig /= "0000000000000000")) then
                            --Blocked by any region hit
                            if (PoisonAddressEn = '1') then
                                --Poison by Address
                                if (ExternalSinkEn = '0') then
                                    --Divert transaction to internal sink
                                    read_block <= '1';
                                    AXI_ARADDR <= READ_ADDR;
                                else
                                    --Divert transaction to external sink
                                    read_block <= '0';
                                    -- Use bottom nibble of address for alignment
                                    AXI_ARADDR <= SINK_ADDR(C_S00_AXI_ADDR_WIDTH-1 downto 8) & READ_ADDR(7 downto 0);
                                end if;
                            else
                                read_block <= '0';
                                AXI_ARADDR <= READ_ADDR;
                            end if;
                        else
                            read_block <= '0';
                            AXI_ARADDR <= READ_ADDR;
                        end if;
                    end if;
                end if;
            else
                if (S00_AXI_rlast = '1') then
                    read_block <= '0';
                end if;
            end if;
        end if;    
    end process proc_poison_read_trxn;

    proc_poison_write_trxn: process(CLK)
    begin
        if rising_edge(CLK) then
                if (AXI_WRITE = '1') then
                    if (write_region_trig = "0000000000000000") then
                        --Misses Regions
                        if (DefWrAllowed = '1') then
                            write_block <= '0';
                        else
                            write_block <= '1';
                        end if;
                        AXI_AWADDR <= WRITE_ADDR;
                    else
                        --Hits Region
                        if ((axi_write_allow_sig /= "0000000000000000")) then
                            write_block <= '0';
                            AXI_AWADDR <= WRITE_ADDR;
                        else
                            if ((axi_write_block_sig /= "0000000000000000")) then 
                                --Blocked by any region hit
                                if (PoisonAddressEn = '1') then
                                    --Poison by Address
                                    if (ExternalSinkEn = '0') then
                                        --Divert transaction to internal sink
                                        write_block <= '1';
                                        AXI_AWADDR <= WRITE_ADDR;
                                    else
                                        --Divert transaction to external sink
                                        write_block <= '0';
                                        AXI_AWADDR <= SINK_ADDR(C_S00_AXI_ADDR_WIDTH-1 downto 8) & WRITE_ADDR(7 downto 0);
                                    end if;
                                else
                                    write_block <= '0';
                                    AXI_AWADDR <= WRITE_ADDR;
                                end if;
                            else
                                write_block <= '0';
                                AXI_AWADDR <= WRITE_ADDR;
                            end if;
                        end if;
                    end if;
                else
                    if (S00_AXI_bvalid = '1') then
                        write_block <= '0';
                    end if;
                end if;
        end if;    
    end process proc_poison_write_trxn;

    --Outputs
    VALID           <= VALID_SIG;
    READ_BLOCKED    <= read_block;
    WRITE_BLOCKED   <= write_block;
    ACTIVE_REGION   <= (others => '0'); --active_region_sig;
    M00_AXI_arvalid <= ARVALID;
    M00_AXI_awvalid <= AWVALID;
    M00_AXI_arprot  <= rprot_sig;
    M00_AXI_awprot  <= wprot_sig;
    M00_AXI_araddr  <= AXI_ARADDR;
    M00_AXI_awaddr  <= AXI_AWADDR;
   
end STRUCTURE;
