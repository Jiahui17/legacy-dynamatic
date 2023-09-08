Library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity delay_buffer is
	generic (
			  SIZE: integer := 32);
	port(
	clk, rst : in std_logic; 
	valid_in : in std_logic;
	ready_in : in std_logic;
	valid_out : out std_logic);
end entity;

architecture arch of delay_buffer is

	type mem is array (SIZE - 1 downto 0) of std_logic;
	signal regs : mem;

begin 

	gen_assignements : for i in 0 to SIZE - 1 generate 

		first_assignment : if i = 0 generate 
		process (clk) begin
			if rising_edge(clk) then
				if (rst = '1') then
					regs(i) <= '0';
				elsif (ready_in = '1') then
					regs(i) <= valid_in;
				end if;
			end if;
		end process;
	end generate first_assignment;

	other_assignments : if i > 0 generate
	process (clk) begin
		if rising_edge(clk) then
			if (rst = '1') then
				regs(i) <= '0';
			elsif (ready_in = '1') then
				regs(i) <= regs(i - 1);
			end if;
		end if;
	end process;
end generate other_assignments;

end generate gen_assignements;

valid_out <= regs(SIZE - 1);

end architecture;


library IEEE;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;
use work.customTypes.all;
use IEEE.math_real."ceil";
use IEEE.math_real."log2";

-- Jiahui 07.09.2023: a one-slot buffer that holds the token for at least
-- LATENCY number of cycles. note that when LATENCY = 1,
-- the II of this unit is 1/2 (since it has only a
-- single slot)

entity delayer is
	generic(
			 INPUTS        : integer;
			 OUTPUTS       : integer;
			 DATA_SIZE_IN  : integer;
			 DATA_SIZE_OUT : integer;
			 LATENCY       : integer := 4
		 );
	port (
	clk, rst      : in  std_logic;
	dataInArray   : in  data_array(INPUTS - 1 downto 0)(DATA_SIZE_IN - 1 downto 0);
	dataOutArray  : out data_array(0 downto 0)(DATA_SIZE_OUT - 1 downto 0);
	pValidArray   : in  std_logic_vector(INPUTS - 1 downto 0);
	nReadyArray   : in  std_logic_vector(0 downto 0);
	validArray    : out std_logic_vector(0 downto 0);
	readyArray    : out std_logic_vector(INPUTS - 1 downto 0)
);

end delayer;

architecture arch of delayer is
	constant counter_width : integer := integer(ceil(log2(real(LATENCY))));
	signal full_reg    : std_logic := '0';
	signal data_reg    : std_logic_vector(DATA_SIZE_IN-1 downto 0) := (others => '0');
	signal count_down  : std_logic_vector(counter_width - 1 downto 0) := (others => '0');
	signal output_transfer : std_logic := '0';
	signal input_transfer  : std_logic := '0';

	signal valid_internal : std_logic := '0';
	signal ready_internal : std_logic := '0';
	constant COUNTER_ZERO : std_logic_vector(counter_width - 1 downto 0) := (others => '0');

	signal one: std_logic_vector (0 downto 0) := "1";
	signal zero: std_logic_vector (0 downto 0) := "0";

	signal b_counter_zero : std_logic := '0';
begin
	assert INPUTS  = 1 severity failure;
	assert OUTPUTS = 1 severity failure;
	assert LATENCY  > 0 severity failure;
	assert DATA_SIZE_IN  > 0 severity failure;
	assert DATA_SIZE_OUT > 0 severity failure;

	output_transfer <= (valid_internal and nReadyArray(0));
	input_transfer <= (pValidArray(0) and ready_internal);
	ready_internal <= (not full_reg);

	b_counter_zero <= '1' when (count_down = COUNTER_ZERO) else '0';


	p_update_counter : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst) or (output_transfer) then
				-- count_down starts at LATENCY - 1 (because it takes 1
				-- cycle to make full_reg = 1)
				count_down <= std_logic_vector(to_unsigned(LATENCY - 1, counter_width));
			elsif (full_reg) and (not b_counter_zero) then
				count_down <= std_logic_vector(unsigned(count_down) - to_unsigned(1, counter_width));
			end if;
		end if;
	end process;

	p_update_full_reg : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst) then
				full_reg <= '0';
			elsif (output_transfer) then
				full_reg <= '0';
			elsif (input_transfer) then
				full_reg <= '1';
			end if;
		end if;
	end process;

	p_update_data_reg : process (clk)
	begin
		if (rising_edge(clk)) then
			if (rst) then
				data_reg <= (others => '0');
			elsif (input_transfer) then
				data_reg <= dataInArray(0);
			end if;
		end if;
	end process;

	validArray(0) <= valid_internal;
	readyArray(0) <= ready_internal;

	valid_internal <= b_counter_zero and full_reg;

end arch;
