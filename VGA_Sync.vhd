LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------
ENTITY VGA_sync IS
    GENERIC     (  N       	:  INTEGER  := 2);
	 PORT        (  clk     	:  IN       STD_LOGIC;
	                rst    	  	:  IN       STD_LOGIC;
						 ena   		:  IN       STD_LOGIC;
						 video_on   :  OUT      STD_LOGIC;
						 x_pixel    :  OUT 		STD_LOGIC_VECTOR(9 DOWNTO 0);
						 y_pixel    :  OUT      STD_LOGIC_VECTOR(8 DOWNTO 0);
						 hsync		:  OUT      STD_LOGIC;
						 vsync      :  OUT      STD_LOGIC);
END ENTITY VGA_sync;
-------------------------------------
ARCHITECTURE functional OF VGA_sync IS

SIGNAL next_row : STD_LOGIC;
SIGNAL hvid_on, vvid_on : STD_LOGIC;
SIGNAL ena_v : STD_LOGIC;
SIGNAL pixel_clk: STD_LOGIC;

BEGIN

ena_v <= ena AND next_row;

clk_VGA: ENTITY work.clk_VGA
	 PORT MAP    (
		reset => rst,
		clk => clk,	
		Q	=> pixel_clk);
		

hsync_b: ENTITY work.HSync
    GENERIC MAP (  N   => N)
	 PORT MAP    (  clk   		=> pixel_clk, 
	                rst    		=> rst,
						 ena    		=> ena,
						 Hvid_on		=> hvid_on,
						 HSync_s		=> hsync,
						 Next_row 	=> next_row,
						 x_pixel    => x_pixel);
						 
						 
vsync_b: ENTITY work.VSync
    GENERIC MAP (  N  => N)
	 PORT MAP    (  clk     	=> pixel_clk,
	                rst    	  	=> rst, 
						 ena   		=> ena_v, 
						 Vvid_on		=> Vvid_on,
						 VSync_s		=> vsync,
						 y_pixel    => y_pixel);
						
						
video_on <= vvid_on AND hvid_on;
						 
END ARCHITECTURE functional;