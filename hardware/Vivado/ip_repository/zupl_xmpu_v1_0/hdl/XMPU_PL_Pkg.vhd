----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2019 12:25:11 PM
-- Design Name: 
-- Module Name: XMPU_PL_Pkg - xmpu_pl_package
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


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

package xmpu_pl_package is

    -------------------------------------------------------------------------------
    --Constants
    -------------------------------------------------------------------------------
	constant C_REGISTERS_MAX       : integer := 128;
	constant C_CTRL_REG_NUM        : integer := 0;
	constant C_ERR_STATUS1_REG_NUM : integer := 1;
	constant C_ERR_STATUS2_REG_NUM : integer := 2;
	constant C_POISON_REG_NUM      : integer := 3;
	constant C_ISR_REG_NUM         : integer := 4;
	constant C_IMR_REG_NUM         : integer := 5;
	constant C_IEN_REG_NUM         : integer := 6;
	constant C_IDS_REG_NUM         : integer := 7;
	constant C_LOCK_REG_NUM        : integer := 8;
	constant C_BYPASS_REG_NUM      : integer := 9;
	constant C_REGIONS_REG_NUM     : integer := 10;
	constant C_R00_START_REG_NUM   : integer := 64;
	constant C_R00_END_REG_NUM     : integer := 65;
	constant C_R00_MASTERS_REG_NUM : integer := 66;
	constant C_R00_CONFIG_REG_NUM  : integer := 67;
	constant C_R01_START_REG_NUM   : integer := 68;
	constant C_R01_END_REG_NUM     : integer := 69;
	constant C_R01_MASTERS_REG_NUM : integer := 70;
	constant C_R01_CONFIG_REG_NUM  : integer := 71;
	constant C_R02_START_REG_NUM   : integer := 72;
	constant C_R02_END_REG_NUM     : integer := 73;
	constant C_R02_MASTERS_REG_NUM : integer := 74;
	constant C_R02_CONFIG_REG_NUM  : integer := 75;
	constant C_R03_START_REG_NUM   : integer := 76;
	constant C_R03_END_REG_NUM     : integer := 77;
	constant C_R03_MASTERS_REG_NUM : integer := 78;
	constant C_R03_CONFIG_REG_NUM  : integer := 79;
	constant C_R04_START_REG_NUM   : integer := 80;
	constant C_R04_END_REG_NUM     : integer := 81;
	constant C_R04_MASTERS_REG_NUM : integer := 82;
	constant C_R04_CONFIG_REG_NUM  : integer := 83;
	constant C_R05_START_REG_NUM   : integer := 84;
	constant C_R05_END_REG_NUM     : integer := 85;
	constant C_R05_MASTERS_REG_NUM : integer := 86;
	constant C_R05_CONFIG_REG_NUM  : integer := 87;
	constant C_R06_START_REG_NUM   : integer := 88;
	constant C_R06_END_REG_NUM     : integer := 89;
	constant C_R06_MASTERS_REG_NUM : integer := 90;
	constant C_R06_CONFIG_REG_NUM  : integer := 91;
	constant C_R07_START_REG_NUM   : integer := 92;
	constant C_R07_END_REG_NUM     : integer := 93;
	constant C_R07_MASTERS_REG_NUM : integer := 94;
	constant C_R07_CONFIG_REG_NUM  : integer := 95;
	constant C_R08_START_REG_NUM   : integer := 96;
	constant C_R08_END_REG_NUM     : integer := 97;
	constant C_R08_MASTERS_REG_NUM : integer := 98;
	constant C_R08_CONFIG_REG_NUM  : integer := 99;
	constant C_R09_START_REG_NUM   : integer := 100;
	constant C_R09_END_REG_NUM     : integer := 101;
	constant C_R09_MASTERS_REG_NUM : integer := 102;
	constant C_R09_CONFIG_REG_NUM  : integer := 103;
	constant C_R10_START_REG_NUM   : integer := 104;
	constant C_R10_END_REG_NUM     : integer := 105;
	constant C_R10_MASTERS_REG_NUM : integer := 106;
	constant C_R10_CONFIG_REG_NUM  : integer := 107;
	constant C_R11_START_REG_NUM   : integer := 108;
	constant C_R11_END_REG_NUM     : integer := 109;
	constant C_R11_MASTERS_REG_NUM : integer := 110;
	constant C_R11_CONFIG_REG_NUM  : integer := 111;
	constant C_R12_START_REG_NUM   : integer := 112;
	constant C_R12_END_REG_NUM     : integer := 113;
	constant C_R12_MASTERS_REG_NUM : integer := 114;
	constant C_R12_CONFIG_REG_NUM  : integer := 115;
	constant C_R13_START_REG_NUM   : integer := 116;
	constant C_R13_END_REG_NUM     : integer := 117;
	constant C_R13_MASTERS_REG_NUM : integer := 118;
	constant C_R13_CONFIG_REG_NUM  : integer := 119;
	constant C_R14_START_REG_NUM   : integer := 120;
	constant C_R14_END_REG_NUM     : integer := 121;
	constant C_R14_MASTERS_REG_NUM : integer := 122;
	constant C_R14_CONFIG_REG_NUM  : integer := 123;
	constant C_R15_START_REG_NUM   : integer := 124;
	constant C_R15_END_REG_NUM     : integer := 125;
	constant C_R15_MASTERS_REG_NUM : integer := 126;
	constant C_R15_CONFIG_REG_NUM  : integer := 127;
	
	constant C_R_START_REG_NUM   : integer := 0;
	constant C_R_END_REG_NUM     : integer := 1;
	constant C_R_MASTERS_REG_NUM : integer := 2;
	constant C_R_CONFIG_REG_NUM  : integer := 3;
	
	constant C_CTRL_REG_INIT       : std_logic_vector(31 downto 0):= X"0000006F";
	constant C_ERRS1_REG_INIT      : std_logic_vector(31 downto 0):= X"00000000";
	constant C_ERRS2_REG_INIT      : std_logic_vector(31 downto 0):= X"00000000";
	constant C_POISON_REG_INIT     : std_logic_vector(31 downto 0):= X"00000000";
	constant C_ISR_REG_INIT        : std_logic_vector(31 downto 0):= X"00000000";
	constant C_IMR_REG_INIT        : std_logic_vector(31 downto 0):= X"0000000E";
	constant C_IEN_REG_INIT        : std_logic_vector(31 downto 0):= X"00000000";
	constant C_IDS_REG_INIT        : std_logic_vector(31 downto 0):= X"00000000";
	constant C_LOCK_REG_INIT       : std_logic_vector(31 downto 0):= X"00000000";
	constant C_BYPASS_REG_INIT     : std_logic_vector(31 downto 0):= X"00000004";
	constant C_REGIONS_REG_INIT    : std_logic_vector(31 downto 0):= X"00000000";
	constant C_R_START_REG_INIT    : std_logic_vector(31 downto 0):= X"00000000";
	constant C_R_END_REG_INIT      : std_logic_vector(31 downto 0):= X"00000000";
	constant C_R_MASTERS_REG_INIT  : std_logic_vector(31 downto 0):= X"00000004";
	constant C_R_CONFIG_REG_INIT   : std_logic_vector(31 downto 0):= X"00000006";
	
	constant C_CTRL_REG_MASK       : std_logic_vector(31 downto 0):= X"00FF007F";
	--constant C_ERRS1_REG_MASK      : std_logic_vector(31 downto 0):= X"00000000";
	--constant C_ERRS2_REG_MASK      : std_logic_vector(31 downto 0):= X"00000000";
	constant C_POISON_REG_MASK     : std_logic_vector(31 downto 0):= X"FFFFFFFF";
	constant C_ISR_REG_MASK        : std_logic_vector(31 downto 0):= X"0000000E";
	--constant C_IMR_REG_MASK        : std_logic_vector(31 downto 0):= X"0000000E";
	constant C_IEN_REG_MASK        : std_logic_vector(31 downto 0):= X"0000000E";
	constant C_IDS_REG_MASK        : std_logic_vector(31 downto 0):= X"0000000E";
	constant C_LOCK_REG_MASK       : std_logic_vector(31 downto 0):= X"00000001";
	constant C_BYPASS_REG_MASK     : std_logic_vector(31 downto 0):= X"00040007";
	constant C_REGIONS_REG_MASK    : std_logic_vector(31 downto 0):= X"0000001F";
	constant C_R_START_REG_MASK    : std_logic_vector(31 downto 0):= X"FFFFFFFF";
	constant C_R_END_REG_MASK      : std_logic_vector(31 downto 0):= X"FFFFFFFF";
	constant C_R_MASTERS_REG_MASK  : std_logic_vector(31 downto 0):= X"7FFFFFFF";
	constant C_R_CONFIG_REG_MASK   : std_logic_vector(31 downto 0):= X"0000003F";
	
    -------------------------------------------------------------------------------
    --Type Definitions
    -------------------------------------------------------------------------------
    type reg_array is array (0 to C_REGISTERS_MAX-1) of std_logic_vector(31 downto 0);


end xmpu_pl_package;
