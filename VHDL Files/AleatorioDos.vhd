library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;

entity AleatorioDos is
	PORT(	clk		:	in std_logic;
			n_food	:  in std_logic;
			rand_y_out:  out std_logic_vector (3 downto 0));
end AleatorioDos;

architecture Behavioral of AleatorioDos is
begin
	process(clk, n_food)
	variable rand_temp: std_logic_vector(3 downto 0):= ((1)=>'1',others=>'0');
	variable temp: std_logic:= '0';
	
	begin
	if rising_edge(clk) then
		temp := rand_temp(2) XOR rand_temp(1);
		rand_temp(3 DOWNTO 1) := rand_temp(2 DOWNTO 0);
		rand_temp(0) := temp;

	end if;
	if (n_food = '1') THEN
	case rand_temp IS
		when "1010" | "0101" | "0010" => rand_y_out <= "0110";
		when "1101" | "1011" | "1111" => rand_y_out <= "1100";
		when others => rand_y_out <= rand_temp;
	END CASE;
	
	END IF;
end process;
	
end Behavioral;