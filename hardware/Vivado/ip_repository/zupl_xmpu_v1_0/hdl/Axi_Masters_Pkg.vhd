----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02/10/2024 19:45:03 AM
-- Design Name: 
-- Module Name: Axi_Masters_Pkg - 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;


package axi_masters_package is
    -------------------------------------------------------------------------------
    --Constants
    -------------------------------------------------------------------------------
	constant C_MASTERS         : integer := 50;
	constant C_REGIONS_LIMIT   : integer := 16;
	constant C_ZERO_MASTERS    : std_logic_vector(C_MASTERS-1 downto 0) := (others => '0');
	--MASTER IDs
	constant MID_RPU0     : std_logic_vector(15 downto 0) := x"0000";
	constant MID_RPU1     : std_logic_vector(15 downto 0) := x"0010";
	constant MID_PMU      : std_logic_vector(15 downto 0) := x"0040";
	constant MID_USB0     : std_logic_vector(15 downto 0) := x"0060";
	constant MID_USB1     : std_logic_vector(15 downto 0) := x"0061";
	constant MID_DAP_APB  : std_logic_vector(15 downto 0) := x"0062";
	constant MID_LPD_DMA0 : std_logic_vector(15 downto 0) := x"0068";
	constant MID_LPD_DMA1 : std_logic_vector(15 downto 0) := x"0069";
	constant MID_LPD_DMA2 : std_logic_vector(15 downto 0) := x"006A";
	constant MID_LPD_DMA3 : std_logic_vector(15 downto 0) := x"006B";
	constant MID_LPD_DMA4 : std_logic_vector(15 downto 0) := x"006C";
	constant MID_LPD_DMA5 : std_logic_vector(15 downto 0) := x"006D";
	constant MID_LPD_DMA6 : std_logic_vector(15 downto 0) := x"006E";
	constant MID_LPD_DMA7 : std_logic_vector(15 downto 0) := x"006F";
	constant MID_SD0      : std_logic_vector(15 downto 0) := x"0070";
	constant MID_SD1      : std_logic_vector(15 downto 0) := x"0071";
	constant MID_NAND     : std_logic_vector(15 downto 0) := x"0072";
	constant MID_QSPI     : std_logic_vector(15 downto 0) := x"0073";
	constant MID_GEM0     : std_logic_vector(15 downto 0) := x"0074";
	constant MID_GEM1     : std_logic_vector(15 downto 0) := x"0075";
	constant MID_GEM2     : std_logic_vector(15 downto 0) := x"0076";
	constant MID_GEM3     : std_logic_vector(15 downto 0) := x"0077";
	constant MID_APU      : std_logic_vector(15 downto 0) := x"0080";
	constant MID_SATA0    : std_logic_vector(15 downto 0) := x"00C0";
	constant MID_SATA1    : std_logic_vector(15 downto 0) := x"00C1";
	constant MID_GPU      : std_logic_vector(15 downto 0) := x"00C4";
	constant MID_DAP_AXI  : std_logic_vector(15 downto 0) := x"00C5";
	constant MID_PCIE     : std_logic_vector(15 downto 0) := x"00D0";
	constant MID_DP_DMA0  : std_logic_vector(15 downto 0) := x"00E0";
	constant MID_DP_DMA1  : std_logic_vector(15 downto 0) := x"00E1";
	constant MID_DP_DMA2  : std_logic_vector(15 downto 0) := x"00E2";
	constant MID_DP_DMA3  : std_logic_vector(15 downto 0) := x"00E3";
	constant MID_DP_DMA4  : std_logic_vector(15 downto 0) := x"00E4";
	constant MID_DP_DMA5  : std_logic_vector(15 downto 0) := x"00E5";
	constant MID_FPD_DMA0 : std_logic_vector(15 downto 0) := x"00E8";
	constant MID_FPD_DMA1 : std_logic_vector(15 downto 0) := x"00E9";
	constant MID_FPD_DMA2 : std_logic_vector(15 downto 0) := x"00EA";
	constant MID_FPD_DMA3 : std_logic_vector(15 downto 0) := x"00EB";
	constant MID_FPD_DMA4 : std_logic_vector(15 downto 0) := x"00EC";
	constant MID_FPD_DMA5 : std_logic_vector(15 downto 0) := x"00ED";
	constant MID_FPD_DMA6 : std_logic_vector(15 downto 0) := x"00EE";
	constant MID_FPD_DMA7 : std_logic_vector(15 downto 0) := x"00EF";
	constant MID_HPC0_FPD : std_logic_vector(15 downto 0) := x"0200";
	constant MID_HPC1_FPD : std_logic_vector(15 downto 0) := x"0240";
	constant MID_HP0_FPD  : std_logic_vector(15 downto 0) := x"0280";
	constant MID_HP1_FPD  : std_logic_vector(15 downto 0) := x"02C0";
	constant MID_HP2_FPD  : std_logic_vector(15 downto 0) := x"0300";
	constant MID_HP3_FPD  : std_logic_vector(15 downto 0) := x"0340";
	constant MID_PL_LPD   : std_logic_vector(15 downto 0) := x"0380";
	constant MID_ACE_FPD  : std_logic_vector(15 downto 0) := x"03C0";
	--MASTER ID MASKs
	constant MSK_RPU0     : std_logic_vector(15 downto 0) := x"03F0";
	constant MSK_RPU1     : std_logic_vector(15 downto 0) := x"03F0";
	constant MSK_PMU      : std_logic_vector(15 downto 0) := x"03EE";
	-- MSK_PMU (0x03EE) combines PMU, CSU and CSU_DMA
	constant MSK_USB0     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_USB1     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_DAP_APB  : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_LPD_DMA0 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_LPD_DMA1 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_LPD_DMA2 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_LPD_DMA3 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_LPD_DMA4 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_LPD_DMA5 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_LPD_DMA6 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_LPD_DMA7 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_SD0      : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_SD1      : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_NAND     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_QSPI     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_GEM0     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_GEM1     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_GEM2     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_GEM3     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_APU      : std_logic_vector(15 downto 0) := x"03C0";
	constant MSK_SATA0    : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_SATA1    : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_GPU      : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_DAP_AXI  : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_PCIE     : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_DP_DMA0  : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_DP_DMA1  : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_DP_DMA2  : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_DP_DMA3  : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_DP_DMA4  : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_DP_DMA5  : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_FPD_DMA0 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_FPD_DMA1 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_FPD_DMA2 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_FPD_DMA3 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_FPD_DMA4 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_FPD_DMA5 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_FPD_DMA6 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_FPD_DMA7 : std_logic_vector(15 downto 0) := x"03FF";
	constant MSK_HPC0_FPD : std_logic_vector(15 downto 0) := x"03C0";
	constant MSK_HPC1_FPD : std_logic_vector(15 downto 0) := x"03C0";
	constant MSK_HP0_FPD  : std_logic_vector(15 downto 0) := x"03C0";
	constant MSK_HP1_FPD  : std_logic_vector(15 downto 0) := x"03C0";
	constant MSK_HP2_FPD  : std_logic_vector(15 downto 0) := x"03C0";
	constant MSK_HP3_FPD  : std_logic_vector(15 downto 0) := x"03C0";
	constant MSK_PL_LPD   : std_logic_vector(15 downto 0) := x"03C0";
	constant MSK_ACE_FPD  : std_logic_vector(15 downto 0) := x"03C0";
	--SECURE MASTER ID INDEX
	constant NUM_RPU0     : integer := 0;
	constant NUM_RPU1     : integer := 1;
	constant NUM_PMU      : integer := 2;
	constant NUM_USB0     : integer := 3;
	constant NUM_USB1     : integer := 4;
	constant NUM_DAP_APB  : integer := 5;
	constant NUM_LPD_DMA0 : integer := 6;
	constant NUM_LPD_DMA1 : integer := 6;
	constant NUM_LPD_DMA2 : integer := 7;
	constant NUM_LPD_DMA3 : integer := 7;
	constant NUM_LPD_DMA4 : integer := 8;
	constant NUM_LPD_DMA5 : integer := 8;
	constant NUM_LPD_DMA6 : integer := 9;
	constant NUM_LPD_DMA7 : integer := 9;
	constant NUM_SD0      : integer := 10;
	constant NUM_SD1      : integer := 11;
	constant NUM_NAND     : integer := 12;
	constant NUM_QSPI     : integer := 13;
	constant NUM_GEM0     : integer := 14;
	constant NUM_GEM1     : integer := 15;
	constant NUM_GEM2     : integer := 16;
	constant NUM_GEM3     : integer := 17;
	constant NUM_APU      : integer := 18;
	constant NUM_SATA0    : integer := 19;
	constant NUM_SATA1    : integer := 20;
	constant NUM_GPU      : integer := 21;
	constant NUM_DAP_AXI  : integer := 22;
	constant NUM_PCIE     : integer := 23;
	constant NUM_DP_DMA0  : integer := 24;
	constant NUM_DP_DMA1  : integer := 24;
	constant NUM_DP_DMA2  : integer := 25;
	constant NUM_DP_DMA3  : integer := 25;
	constant NUM_DP_DMA4  : integer := 26;
	constant NUM_DP_DMA5  : integer := 26;
	constant NUM_FPD_DMA0 : integer := 27;
	constant NUM_FPD_DMA1 : integer := 27;
	constant NUM_FPD_DMA2 : integer := 28;
	constant NUM_FPD_DMA3 : integer := 28;
	constant NUM_FPD_DMA4 : integer := 29;
	constant NUM_FPD_DMA5 : integer := 29;
	constant NUM_FPD_DMA6 : integer := 30;
	constant NUM_FPD_DMA7 : integer := 30;

     -------------------------------------------------------------------------------
    --Type Definitions
    -------------------------------------------------------------------------------
    type addr_array is array (0 to C_REGIONS_LIMIT-1) of std_logic_vector(39 downto 0);
    type reg_array is array (0 to C_REGIONS_LIMIT-1) of std_logic_vector(31 downto 0);
    type mid_array is array (0 to C_MASTERS-1) of std_logic_vector(15 downto 0);
    type master_array is array (0 to C_REGIONS_LIMIT-1) of std_logic_vector(0 to C_MASTERS-1);
    type prot_array is array (0 to C_REGIONS_LIMIT-1) of std_logic_vector(2 downto 0);
   -------------------------------------------------------------------------------
    --Initializations
    -------------------------------------------------------------------------------
    constant MID_INIT : mid_array := (  MID_RPU0,
                                        MID_RPU1,
                                        MID_PMU,
                                        MID_USB0,
                                        MID_USB1,
                                        MID_DAP_APB,
                                        MID_LPD_DMA0,
                                        MID_LPD_DMA1,
                                        MID_LPD_DMA2,
                                        MID_LPD_DMA3,
                                        MID_LPD_DMA4,
                                        MID_LPD_DMA5,
                                        MID_LPD_DMA6,
                                        MID_LPD_DMA7,
                                        MID_SD0,
                                        MID_SD1,
                                        MID_NAND,
                                        MID_QSPI,
                                        MID_GEM0,
                                        MID_GEM1,
                                        MID_GEM2,
                                        MID_GEM3,
                                        MID_APU,
                                        MID_SATA0,
                                        MID_SATA1,
                                        MID_GPU,
                                        MID_DAP_AXI,
                                        MID_PCIE,
                                        MID_DP_DMA0,
                                        MID_DP_DMA1,
                                        MID_DP_DMA2,
                                        MID_DP_DMA3,
                                        MID_DP_DMA4,
                                        MID_DP_DMA5,
                                        MID_FPD_DMA0,
                                        MID_FPD_DMA1,
                                        MID_FPD_DMA2,
                                        MID_FPD_DMA3,
                                        MID_FPD_DMA4,
                                        MID_FPD_DMA5,
                                        MID_FPD_DMA6,
                                        MID_FPD_DMA7,
                                        MID_HPC0_FPD,
                                        MID_HPC1_FPD,
                                        MID_HP0_FPD,
                                        MID_HP1_FPD,
                                        MID_HP2_FPD,
                                        MID_HP3_FPD,
                                        MID_PL_LPD,
                                        MID_ACE_FPD
                                        );
                                        
     constant MSK_INIT : mid_array := ( MSK_RPU0,
                                        MSK_RPU1,
                                        MSK_PMU,
                                        MSK_USB0,
                                        MSK_USB1,
                                        MSK_DAP_APB,
                                        MSK_LPD_DMA0,
                                        MSK_LPD_DMA1,
                                        MSK_LPD_DMA2,
                                        MSK_LPD_DMA3,
                                        MSK_LPD_DMA4,
                                        MSK_LPD_DMA5,
                                        MSK_LPD_DMA6,
                                        MSK_LPD_DMA7,
                                        MSK_SD0,
                                        MSK_SD1,
                                        MSK_NAND,
                                        MSK_QSPI,
                                        MSK_GEM0,
                                        MSK_GEM1,
                                        MSK_GEM2,
                                        MSK_GEM3,
                                        MSK_APU,
                                        MSK_SATA0,
                                        MSK_SATA1,
                                        MSK_GPU,
                                        MSK_DAP_AXI,
                                        MSK_PCIE,
                                        MSK_DP_DMA0,
                                        MSK_DP_DMA1,
                                        MSK_DP_DMA2,
                                        MSK_DP_DMA3,
                                        MSK_DP_DMA4,
                                        MSK_DP_DMA5,
                                        MSK_FPD_DMA0,
                                        MSK_FPD_DMA1,
                                        MSK_FPD_DMA2,
                                        MSK_FPD_DMA3,
                                        MSK_FPD_DMA4,
                                        MSK_FPD_DMA5,
                                        MSK_FPD_DMA6,
                                        MSK_FPD_DMA7,
                                        MSK_HPC0_FPD,
                                        MSK_HPC1_FPD,
                                        MSK_HP0_FPD,
                                        MSK_HP1_FPD,
                                        MSK_HP2_FPD,
                                        MSK_HP3_FPD,
                                        MSK_PL_LPD,
                                        MSK_ACE_FPD
                                        );
                                       
end axi_masters_package;
