library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.std_logic_unsigned.all;
use IEEE.NUMERIC_STD.all;

entity AleatorioGeneral is
	PORT(	clk		 :  in std_logic;
			n_food	 :  in std_logic;
			rand_x_out:  out std_logic_vector (3 downto 0);
			rand_y_out:  out std_logic_vector (3 downto 0));
end AleatorioGeneral;

architecture Behavioral of AleatorioGeneral is
begin
	
DUT: ENTITY work.Aleatorio
PORT MAP   ( 	clk 						=> clk,
					n_food  					=> n_food,
					rand_x_out 				=> rand_x_out);
					
DUT1: ENTITY work.AleatorioDos
PORT MAP   ( 	clk 						=> clk,
					n_food  					=> n_food,
					rand_y_out 				=> rand_y_out);
					
end Behavioral;