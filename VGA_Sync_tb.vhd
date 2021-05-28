LIBRARY IEEE;
USE ieee.std_logic_1164.all;
------------------------------------
ENTITY VGA_sync_tb IS
    GENERIC     (  N       	:  INTEGER  := 2);
END ENTITY VGA_sync_tb;
-------------------------------------
ARCHITECTURE testbench OF VGA_sync_tb IS

	 SIGNAL clk_tb    		:       STD_LOGIC;
	 SIGNAL rst_tb    	  	:       STD_LOGIC;
	 SIGNAL ena_tb   			:       STD_LOGIC;
	 SIGNAL video_on_tb 	   :      STD_LOGIC;
	 SIGNAL x_pixel_tb   	:  		STD_LOGIC_VECTOR(9 DOWNTO 0);
	 SIGNAL y_pixel_tb   	:       STD_LOGIC_VECTOR(8 DOWNTO 0);
	 SIGNAL hsync_tb			:        STD_LOGIC;
	 SIGNAL vsync_tb        :        STD_LOGIC;

BEGIN

DUT: ENTITY work.VGA_sync
    GENERIC MAP  (  N  => N)
	 PORT MAP    (  clk  => clk_tb,
	                rst  => rst_tb,
						 ena   => ena_tb,
						 video_on   => video_on_tb,
						 x_pixel    => x_pixel_tb,
						 y_pixel    => y_pixel_tb,
						 hsync		=> hsync_tb,
						 vsync      => vsync_tb);

signal_generation: PROCESS
BEGIN

-- TEST VECTOR START
rst_tb     <=   '1';	
ena_tb     <=   '0';
WAIT FOR 100 ns;

-- TEST VECTOR RUN
rst_tb     <=   '0';	
ena_tb     <=   '1';
WAIT FOR 15000 ms;

END PROCESS signal_generation;
						 
END ARCHITECTURE testbench;