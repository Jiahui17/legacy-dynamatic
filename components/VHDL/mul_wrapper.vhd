
-----------------------------------------------------------------------
-- int mul wrapper
-----------------------------------------------------------------------

Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.customTypes.all;

entity mul_op is
Generic (
 INPUTS: integer; OUTPUTS: integer; DATA_SIZE_IN: integer; DATA_SIZE_OUT: integer
);
port (
  clk : IN STD_LOGIC;
  rst : IN STD_LOGIC;
  pValidArray : IN std_logic_vector(1 downto 0);
  nReadyArray : in std_logic_vector(0 downto 0);
  validArray : out std_logic_vector(0 downto 0);
  readyArray : OUT std_logic_vector(1 downto 0);
  dataInArray : in data_array (1 downto 0)(DATA_SIZE_IN-1 downto 0); 
  dataOutArray : out data_array (0 downto 0)(DATA_SIZE_OUT-1 downto 0));
end entity;

architecture arch of mul_op is

-- multiplier latency (4 or 8)
constant LATENCY : integer := 2;
--constant LATENCY : integer := 8;

	-- NOTE: This multiplier is used for the experiment for FPGA'24 (we target CP = 6)
	component dynamatic_units_6ns_mul_32s_32s_32_3_1 is
		generic (
				  ID : INTEGER := 1;
				  NUM_STAGE : INTEGER := LATENCY + 1;
				  din0_WIDTH : INTEGER := 32;
				  din1_WIDTH : INTEGER := 32;
				  dout_WIDTH : INTEGER := 32
			  );
		port (
			     clk : IN STD_LOGIC;
			     reset : IN STD_LOGIC;
			     ce : IN STD_LOGIC;
			     din0 : IN STD_LOGIC_VECTOR(din0_WIDTH - 1 DOWNTO 0);
			     din1 : IN STD_LOGIC_VECTOR(din1_WIDTH - 1 DOWNTO 0);
			     dout : OUT STD_LOGIC_VECTOR(dout_WIDTH - 1 DOWNTO 0));
	end component;


signal join_valid : STD_LOGIC;

signal buff_valid, oehb_valid, oehb_ready : STD_LOGIC;
signal oehb_dataOut, oehb_datain : std_logic_vector(0 downto 0);


begin 
join: entity work.join(arch) generic map(2)
port map( pValidArray,  
oehb_ready,                        
join_valid,                  
  readyArray);   

--        -- instantiated multiplier (work.mul_4_stage or work.mul_8_stage)
--multiply_unit:  entity work.mul_4_stage(behav) generic map (INPUTS, OUTPUTS, DATA_SIZE_IN, DATA_SIZE_OUT)
----multiply_unit:  entity work.mul_8_stage(behav) generic map (INPUTS, OUTPUTS, DATA_SIZE_IN, DATA_SIZE_OUT)
--port map (
--clk => clk,
--ce => oehb_ready,
--a => dataInArray(0),
--b => dataInArray(1),
--p => dataOutArray(0));

mul_ip : component dynamatic_units_6ns_mul_32s_32s_32_3_1
port map(
		  clk => clk,
		  reset => rst,
		  ce => oehb_ready,
		  din0 => dataInArray(0),
		  din1 => dataInArray(1),
		  dout => dataOutArray(0)
	  );

buff: entity work.delay_buffer(arch) generic map(LATENCY-1)
port map(clk,
rst,
join_valid,
oehb_ready,
buff_valid);

oehb: entity work.OEHB(arch) generic map (1, 1, 1, 1)
        port map (
        --inputspValidArray
            clk => clk, 
            rst => rst, 
            pValidArray(0)  => buff_valid, -- real or speculatef condition (determined by merge1)
            nReadyArray(0) => nReadyArray(0),    
            validArray(0) => validArray(0), 
        --outputs
            readyArray(0) => oehb_ready,   
            dataInArray(0) => oehb_datain,
            dataOutArray(0) => oehb_dataOut
        );

end architecture;

