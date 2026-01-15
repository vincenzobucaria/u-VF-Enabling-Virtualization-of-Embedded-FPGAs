library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Pmod_JA1_arbiter_AXI is
	generic (
		-- Users to add parameters here
        N_PINS       : positive := 8;    -- numero di pad fisici
        N_VPIN_TOTAL : positive := 16;    -- numero totale di pin virtuali
        MAP_WIDTH    : positive := 5;    -- bit per mapping
        SYNC_INPUT   : boolean  := true;  -- true=sincronizza input (consigliato), false=input combinatorio
		-- User parameters ends
		-- Do not modify the parameters beyond this line


		-- Parameters of Axi Slave Bus Interface S00_AXI
		C_S00_AXI_DATA_WIDTH	: integer	:= 32;
		C_S00_AXI_ADDR_WIDTH	: integer	:= 4
	);
	port (
		-- Users to add ports here
        vpin_o       : in  std_logic_vector(N_VPIN_TOTAL - 1 downto 0);
        vpin_t       : in  std_logic_vector(N_VPIN_TOTAL - 1 downto 0);
        vpin_i       : out std_logic_vector(N_VPIN_TOTAL - 1 downto 0);
        led_oe: out std_logic;
        -- Physical pins
        pad_io       : inout std_logic_vector(N_PINS - 1 downto 0);
		-- User ports ends
		-- Do not modify the ports beyond this line


		-- Ports of Axi Slave Bus Interface S00_AXI
		s00_axi_aclk	: in std_logic;
		s00_axi_aresetn	: in std_logic;
		s00_axi_awaddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_awprot	: in std_logic_vector(2 downto 0);
		s00_axi_awvalid	: in std_logic;
		s00_axi_awready	: out std_logic;
		s00_axi_wdata	: in std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_wstrb	: in std_logic_vector((C_S00_AXI_DATA_WIDTH/8)-1 downto 0);
		s00_axi_wvalid	: in std_logic;
		s00_axi_wready	: out std_logic;
		s00_axi_bresp	: out std_logic_vector(1 downto 0);
		s00_axi_bvalid	: out std_logic;
		s00_axi_bready	: in std_logic;
		s00_axi_araddr	: in std_logic_vector(C_S00_AXI_ADDR_WIDTH-1 downto 0);
		s00_axi_arprot	: in std_logic_vector(2 downto 0);
		s00_axi_arvalid	: in std_logic;
		s00_axi_arready	: out std_logic;
		s00_axi_rdata	: out std_logic_vector(C_S00_AXI_DATA_WIDTH-1 downto 0);
		s00_axi_rresp	: out std_logic_vector(1 downto 0);
		s00_axi_rvalid	: out std_logic;
		s00_axi_rready	: in std_logic
	);
end Pmod_JA1_arbiter_AXI;

architecture arch_imp of Pmod_JA1_arbiter_AXI is

	-- component declaration
	component Pmod_JA1_arbiter_AXI_slave_lite_v1_0_S00_AXI is
		generic (
		C_S_AXI_DATA_WIDTH	: integer	:= 32;
		C_S_AXI_ADDR_WIDTH	: integer	:= 4;
		N_PINS       : positive := 8;    -- numero di pad fisici
        N_VPIN_TOTAL : positive := 16;    -- numero totale di pin virtuali
        MAP_WIDTH    : positive := 5;    -- bit per mapping
        SYNC_INPUT   : boolean  := true  -- true=sincronizza input (consigliato), false=input combinatorio
		);
		port (
		S_AXI_ACLK	: in std_logic;
		S_AXI_ARESETN	: in std_logic;
		S_AXI_AWADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_AWPROT	: in std_logic_vector(2 downto 0);
		S_AXI_AWVALID	: in std_logic;
		S_AXI_AWREADY	: out std_logic;
		S_AXI_WDATA	: in std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_WSTRB	: in std_logic_vector((C_S_AXI_DATA_WIDTH/8)-1 downto 0);
		S_AXI_WVALID	: in std_logic;
		S_AXI_WREADY	: out std_logic;
		S_AXI_BRESP	: out std_logic_vector(1 downto 0);
		S_AXI_BVALID	: out std_logic;
		S_AXI_BREADY	: in std_logic;
		S_AXI_ARADDR	: in std_logic_vector(C_S_AXI_ADDR_WIDTH-1 downto 0);
		S_AXI_ARPROT	: in std_logic_vector(2 downto 0);
		S_AXI_ARVALID	: in std_logic;
		S_AXI_ARREADY	: out std_logic;
		S_AXI_RDATA	: out std_logic_vector(C_S_AXI_DATA_WIDTH-1 downto 0);
		S_AXI_RRESP	: out std_logic_vector(1 downto 0);
		S_AXI_RVALID	: out std_logic;
		S_AXI_RREADY	: in std_logic;
		vpin_o       : in  std_logic_vector(N_VPIN_TOTAL - 1 downto 0);
        vpin_t       : in  std_logic_vector(N_VPIN_TOTAL - 1 downto 0);
        vpin_i       : out std_logic_vector(N_VPIN_TOTAL - 1 downto 0);
        led_oe: out std_logic;
        pad_io       : inout std_logic_vector(N_PINS - 1 downto 0)
		);
	end component Pmod_JA1_arbiter_AXI_slave_lite_v1_0_S00_AXI;

begin

-- Instantiation of Axi Bus Interface S00_AXI
Pmod_JA1_arbiter_AXI_slave_lite_v1_0_S00_AXI_inst : Pmod_JA1_arbiter_AXI_slave_lite_v1_0_S00_AXI
	generic map (
		C_S_AXI_DATA_WIDTH	=> C_S00_AXI_DATA_WIDTH,
		C_S_AXI_ADDR_WIDTH	=> C_S00_AXI_ADDR_WIDTH,
		-- Users to add parameters here
        N_PINS => N_PINS,
        N_VPIN_TOTAL => N_VPIN_TOTAL,
        MAP_WIDTH   => MAP_WIDTH,
        SYNC_INPUT   => SYNC_INPUT
	)
	port map (
		S_AXI_ACLK	=> s00_axi_aclk,
		S_AXI_ARESETN	=> s00_axi_aresetn,
		S_AXI_AWADDR	=> s00_axi_awaddr,
		S_AXI_AWPROT	=> s00_axi_awprot,
		S_AXI_AWVALID	=> s00_axi_awvalid,
		S_AXI_AWREADY	=> s00_axi_awready,
		S_AXI_WDATA	=> s00_axi_wdata,
		S_AXI_WSTRB	=> s00_axi_wstrb,
		S_AXI_WVALID	=> s00_axi_wvalid,
		S_AXI_WREADY	=> s00_axi_wready,
		S_AXI_BRESP	=> s00_axi_bresp,
		S_AXI_BVALID	=> s00_axi_bvalid,
		S_AXI_BREADY	=> s00_axi_bready,
		S_AXI_ARADDR	=> s00_axi_araddr,
		S_AXI_ARPROT	=> s00_axi_arprot,
		S_AXI_ARVALID	=> s00_axi_arvalid,
		S_AXI_ARREADY	=> s00_axi_arready,
		S_AXI_RDATA	=> s00_axi_rdata,
		S_AXI_RRESP	=> s00_axi_rresp,
		S_AXI_RVALID	=> s00_axi_rvalid,
		S_AXI_RREADY	=> s00_axi_rready,
		vpin_o => vpin_o,
        vpin_t => vpin_t,
        vpin_i => vpin_i,    
        led_oe => led_oe,
        -- Physical pins
        pad_io => pad_io     
	);

	-- Add user logic here

	-- User logic ends

end arch_imp;
