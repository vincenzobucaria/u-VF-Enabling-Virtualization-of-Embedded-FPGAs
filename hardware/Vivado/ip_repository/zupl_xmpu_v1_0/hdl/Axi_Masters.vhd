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
--  /   /         Filename: Axi_Masters.vhd         
-- /___/   /\     Timestamp: $DateTime: 2020/03/02 10:38:05 $
-- \   \  /  \
--  \___\/\___\
--
--
-- Purpose: This module implements the AXI master identification check
-- for the XMPU PL Instance.
--
-- Instantiates   : 
-- Requirements Addressed :  
--------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
library xil_defaultlib;
use xil_defaultlib.axi_masters_package.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Axi_Masters is
	generic (
		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_AWUSER_WIDTH	: integer	:= 16;
		C_S00_AXI_ARUSER_WIDTH	: integer	:= 16
	);
    Port ( ARPROT       : in std_logic_vector (2 downto 0);
		   ARUSER	    : in std_logic_vector(C_S00_AXI_ARUSER_WIDTH-1 downto 0);
           AWPROT       : in std_logic_vector(2 downto 0);
		   AWUSER	    : in std_logic_vector(C_S00_AXI_AWUSER_WIDTH-1 downto 0);
           SEC_MASTERS  : in std_logic_vector(31 downto 0);
           RPROT_OUT    : out std_logic_vector(2 downto 0);
           WPROT_OUT    : out std_logic_vector(2 downto 0);
           READ_SECURE  : out std_logic;
           WRITE_SECURE : out std_logic
           );
end Axi_Masters;

architecture Behavioral of Axi_Masters is

--Secure Masters
signal secure_master_sig    : std_logic;
signal secure_masters       : std_logic_vector(0 to C_MASTERS-1);
signal det_sec_rd_master    : std_logic_vector(0 to C_MASTERS-1);
signal det_sec_wr_master    : std_logic_vector(0 to C_MASTERS-1);

--Master ID Arrays
signal master_ids           : mid_array;
signal mid_masks            : mid_array;

--AXI Master IDs
signal RMID                 : std_logic_vector(9 downto 0); 
signal WMID                 : std_logic_vector(9 downto 0); 

--Secure Signals
signal rd_secure            : std_logic;
signal wr_secure            : std_logic;

begin

    --Set Master IDs
    master_ids(0 to 49) <= MID_INIT(0 to 49);
    mid_masks  <= MSK_INIT;
    
    -- Set Secure Masters
    secure_masters(0)  <= SEC_MASTERS(NUM_RPU0   );
    secure_masters(1)  <= SEC_MASTERS(NUM_RPU1   );
    secure_masters(2)  <= SEC_MASTERS(NUM_PMU    );
    secure_masters(3)  <= SEC_MASTERS(NUM_USB0   );
    secure_masters(4)  <= SEC_MASTERS(NUM_USB1   );
    secure_masters(5)  <= SEC_MASTERS(NUM_DAP_APB);
    secure_masters(6)  <= SEC_MASTERS(NUM_LPD_DMA0);
    secure_masters(7)  <= SEC_MASTERS(NUM_LPD_DMA1);
    secure_masters(8)  <= SEC_MASTERS(NUM_LPD_DMA2);
    secure_masters(9)  <= SEC_MASTERS(NUM_LPD_DMA3);
    secure_masters(10) <= SEC_MASTERS(NUM_LPD_DMA4);
    secure_masters(11) <= SEC_MASTERS(NUM_LPD_DMA5);
    secure_masters(12) <= SEC_MASTERS(NUM_LPD_DMA6);
    secure_masters(13) <= SEC_MASTERS(NUM_LPD_DMA7);
    secure_masters(14) <= SEC_MASTERS(NUM_SD0     );
    secure_masters(15) <= SEC_MASTERS(NUM_SD1     );
    secure_masters(16) <= SEC_MASTERS(NUM_NAND    );
    secure_masters(17) <= SEC_MASTERS(NUM_QSPI    );
    secure_masters(18) <= SEC_MASTERS(NUM_GEM0    );
    secure_masters(19) <= SEC_MASTERS(NUM_GEM1    );
    secure_masters(20) <= SEC_MASTERS(NUM_GEM2    );
    secure_masters(21) <= SEC_MASTERS(NUM_GEM3    );
    secure_masters(22) <= SEC_MASTERS(NUM_APU     );
    secure_masters(23) <= SEC_MASTERS(NUM_SATA0   );
    secure_masters(24) <= SEC_MASTERS(NUM_SATA1   );
    secure_masters(25) <= SEC_MASTERS(NUM_GPU     );
    secure_masters(26) <= SEC_MASTERS(NUM_DAP_AXI );
    secure_masters(27) <= SEC_MASTERS(NUM_PCIE    );
    secure_masters(28) <= SEC_MASTERS(NUM_DP_DMA0 );
    secure_masters(29) <= SEC_MASTERS(NUM_DP_DMA1 );
    secure_masters(30) <= SEC_MASTERS(NUM_DP_DMA2 );
    secure_masters(31) <= SEC_MASTERS(NUM_DP_DMA3 );
    secure_masters(32) <= SEC_MASTERS(NUM_DP_DMA4 );
    secure_masters(33) <= SEC_MASTERS(NUM_DP_DMA5 );
    secure_masters(34) <= SEC_MASTERS(NUM_FPD_DMA0);
    secure_masters(35) <= SEC_MASTERS(NUM_FPD_DMA1);
    secure_masters(36) <= SEC_MASTERS(NUM_FPD_DMA2);
    secure_masters(37) <= SEC_MASTERS(NUM_FPD_DMA3);
    secure_masters(38) <= SEC_MASTERS(NUM_FPD_DMA4);
    secure_masters(39) <= SEC_MASTERS(NUM_FPD_DMA5);
    secure_masters(40) <= SEC_MASTERS(NUM_FPD_DMA6);
    secure_masters(41) <= SEC_MASTERS(NUM_FPD_DMA7);
    secure_masters(42) <= SEC_MASTERS(31);
    secure_masters(43) <= SEC_MASTERS(31);
    secure_masters(44) <= SEC_MASTERS(31);
    secure_masters(45) <= SEC_MASTERS(31);
    secure_masters(46) <= SEC_MASTERS(31);
    secure_masters(47) <= SEC_MASTERS(31);
    secure_masters(48) <= SEC_MASTERS(31);
    secure_masters(49) <= SEC_MASTERS(31);
    
    --Input Master IDs
    AR_MID: for i in 0 to 9 generate
        ar_user: if i < C_S00_AXI_ARUSER_WIDTH generate
            RMID(i) <= ARUSER(i);
        end generate ar_user;
        ar_user_und: if i >= C_S00_AXI_ARUSER_WIDTH generate
            RMID(i) <= '0';
        end generate ar_user_und;
    end generate AR_MID;
    
    AW_MID: for i in 0 to 9 generate
        aw_user: if i < C_S00_AXI_AWUSER_WIDTH generate
            WMID(i) <= AWUSER(i);
        end generate aw_user;
        aw_user_und: if i >= C_S00_AXI_AWUSER_WIDTH generate
            WMID(i) <= '0';
        end generate aw_user_und;
    end generate AW_MID;
    
    
    --Identify authorized Master ID Read Transactions
    RD_MASTER: for i in 0 to C_MASTERS-1 generate
        axi_rd_mid_det: process(RMID)
        begin
            if ((master_ids(i) and mid_masks(i)) = (("000000" & RMID) and mid_masks(i))) then
                det_sec_rd_master(i) <= '1';
            else
                det_sec_rd_master(i) <= '0';
            end if;
        end process axi_rd_mid_det;
    end generate RD_MASTER;
    
    --Identify authrozed Master ID Write Transactions
    WR_MASTER: for i in 0 to C_MASTERS-1 generate
        axi_wr_mid_det: process(WMID)
        begin
            if ((master_ids(i) and mid_masks(i)) = (("000000" & WMID) and mid_masks(i))) then
                det_sec_wr_master(i) <= '1';
            else
                det_sec_wr_master(i) <= '0';
            end if;
        end process axi_wr_mid_det;
    end generate WR_MASTER;
    
    --Read Security
    read_security: process(det_sec_rd_master)
    begin
        if ((det_sec_rd_master and secure_masters) = C_ZERO_MASTERS) then
            rd_secure <= '0';
        else
            rd_secure <= '1';
        end if;
    end process read_security;

    --Write Security
    write_security: process(det_sec_wr_master)
    begin
        if ((det_sec_wr_master and secure_masters) = C_ZERO_MASTERS) then
            wr_secure <= '0';
        else
            wr_secure <= '1';
        end if;
    end process write_security;
    
    --Axi Read Protection Out
    axi_rd_prot: process(rd_secure, ARPROT)
    begin
        if (rd_secure = '1') then
            RPROT_OUT <= ARPROT;
        else
            RPROT_OUT <= ARPROT OR "010";
        end if;
    end process axi_rd_prot;
    
    --Axi Write Protection Out
    axi_wr_prot: process(wr_secure, AWPROT)
    begin
        if (wr_secure = '1') then
            WPROT_OUT <= AWPROT;
        else
            WPROT_OUT <= AWPROT OR "010";
        end if;
    end process axi_wr_prot;
    
    --Security Output
    READ_SECURE <= rd_secure;
    WRITE_SECURE <= wr_secure;
    

end Behavioral;
