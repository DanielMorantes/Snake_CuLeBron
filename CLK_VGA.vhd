library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity clk_VGA is
	port
	(	reset	: in std_logic;
		clk: in std_logic;
		Q		: out std_logic
	);
end clk_VGA;

architecture rtl of clk_VGA is
	signal q_s: std_logic_vector(3 downto 0):= (others=>'0');
begin
	process(reset,clk) is
	begin
		if (reset = '1')then
			q_s <= (others=>'0');
		elsif(rising_edge(clk)) then
			q_s <= q_s + 1;
		end if;
	end process;
	Q <= q_s(0);
end rtl;