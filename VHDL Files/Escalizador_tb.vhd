LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------
ENTITY Escalizador_tb IS
END ENTITY Escalizador_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF Escalizador_tb IS



SIGNAL	         clk_tb         :      STD_LOGIC;
SIGNAL				x_pixel_tb     :      STD_LOGIC_VECTOR(9  DOWNTO 0);
SIGNAL				y_pixel_tb     :      STD_LOGIC_VECTOR(8  DOWNTO 0);
SIGNAL				pos_y_tb       :      STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL				pos_x_tb       :      STD_LOGIC_VECTOR(3 DOWNTO 0);


BEGIN



DUT: ENTITY work.Escalizador

PORT MAP (  clk      => clk_tb,
            x_pixel => x_pixel_tb,
				y_pixel => y_pixel_tb,
				pos_x => pos_x_tb,
				pos_y => pos_y_tb);



signal_generation: PROCESS
BEGIN



-- TEST VECTOR START 1
x_pixel_tb <="0000000000";
y_pixel_tb <="000000000";
WAIT FOR 20 ns;

x_pixel_tb <="0001100010";
y_pixel_tb <="000000000";
WAIT FOR 20 ns;

x_pixel_tb <="0001111110";
y_pixel_tb <="000000000";
WAIT FOR 20 ns;

x_pixel_tb <="0010001100";
y_pixel_tb <="000000000";
WAIT FOR 20 ns;

x_pixel_tb <="0010110100";
y_pixel_tb <="000000000";
WAIT FOR 20 ns;

x_pixel_tb <="0011010010";
y_pixel_tb <="000000000";
WAIT FOR 20 ns;

x_pixel_tb <="0011110000";
y_pixel_tb <="000000000";
WAIT FOR 20 ns;

x_pixel_tb <="0100001110";
y_pixel_tb <="000000000";
WAIT FOR 20 ns;



END PROCESS signal_generation;



END ARCHITECTURE testbench;