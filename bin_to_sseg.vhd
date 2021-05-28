LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
-----------------------------------------------------------
ENTITY bin_to_sseg IS
PORT 	  ( data       : IN      STD_LOGIC_VECTOR(3  DOWNTO  0);
			 sseg 		: OUT     std_logic_vector(6 DOWNTO 0));
END ENTITY bin_to_sseg;
-----------------------------------------------------------
ARCHITECTURE functional OF bin_to_sseg IS
BEGIN
	


WITH data SELECT 
		sseg <=
		"1000000" WHEN "0000",	-- 0
		"1111001" WHEN "0001",	-- 1
		"0100100" WHEN "0010",	-- 2
		"0110000" WHEN "0011",	-- 3
		"0011001" WHEN "0100",	-- 4
		"0010010" WHEN "0101",	-- 5
		"0000010" WHEN "0110",	-- 6
		"1111000" WHEN "0111",	-- 7
		"0000000" WHEN "1000",	-- 8
		"0010000" WHEN "1001",	-- 9
		"0110110" WHEN "1010",	-- 10
		"1001001" WHEN "1011",	-- 11
		"0011100" WHEN OTHERS;  -- v


END ARCHITECTURE;
