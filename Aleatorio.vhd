library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;

entity Aleatorio is
	PORT(	clk		:	in std_logic;
			n_food	:  in std_logic;
			rand_x_out:  out std_logic_vector (3 downto 0));
end Aleatorio;

architecture Behavioral of Aleatorio is
begin
	process(clk, n_food)
	variable rand_temp: std_logic_vector(3 downto 0):= ((3)=>'1',others=>'0');
	variable temp: std_logic:= '0';
	
	begin
	if rising_edge(clk) then
		temp := rand_temp(3) XOR rand_temp(2);
		rand_temp(3 DOWNTO 1) := rand_temp(2 DOWNTO 0);
		rand_temp(0) := temp;
	end if;
	if (n_food = '1') THEN
	case rand_temp IS
		when "0000" | "0001" | "0011" => rand_x_out <= "1011";
		when "1100" | "1101" | "1110" => rand_x_out <= "1100";
		when others => rand_x_out <= rand_temp;
	END CASE;
	END IF;
end process;
	
end Behavioral;