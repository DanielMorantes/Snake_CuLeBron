LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------
ENTITY VSYNC IS
    GENERIC     (  N       	:  INTEGER  := 2);
	 PORT        (  clk     	:  IN       STD_LOGIC;
	                rst    	  	:  IN       STD_LOGIC;
						 ena   		:  IN       STD_LOGIC;
						 Vvid_on		:  OUT      STD_LOGIC;
						 VSync_s		:  OUT      STD_LOGIC;
						 y_pixel    :  OUT 		 STD_LOGIC_VECTOR(8 DOWNTO 0));
END ENTITY;
-------------------------------------

ARCHITECTURE rtl OF VSYNC IS
	 CONSTANT ZERO    		:  UNSIGNED(9  DOWNTO  0) :="0000000000";
    CONSTANT END_PIX 		:  UNSIGNED(9  DOWNTO  0) :="1000001100";
	 CONSTANT END_IMG			:  UNSIGNED(9  DOWNTO  0) :="0111011111";
	 CONSTANT END_FRONT		:  UNSIGNED(9  DOWNTO  0) :="0111101001";
	 CONSTANT END_RETRACE	:  UNSIGNED(9  DOWNTO  0) :="0111101011";	 

	 SIGNAL count_s          :  UNSIGNED(8  DOWNTO  0);
	 SIGNAL count_next       :  UNSIGNED(8  DOWNTO  0);
	 SIGNAL pixel_s          :  UNSIGNED(8  DOWNTO  0);
	 SIGNAL pixel_next       :  UNSIGNED(8  DOWNTO  0);
	 

BEGIN
							 
	count_next  <=  (OTHERS  =>   '0')  WHEN  count_s = END_PIX    ELSE
	                   count_s + 1         WHEN  (ena ='1')   ELSE
							 count_s;
							 
	pixel_next <=  (OTHERS  =>   '0')  WHEN  pixel_s = END_IMG   ELSE
	                   pixel_s + 1      WHEN  (ena ='1' AND count_s<=END_IMG )   ELSE
							 pixel_s;
							 

    PROCESS(clk,rst)
		  VARIABLE temp_count      :   UNSIGNED(8  DOWNTO  0);
		  VARIABLE temp_pix    :   UNSIGNED(8  DOWNTO  0);
	 BEGIN
	    IF(rst='1')  THEN
			 temp_count  :=  (OTHERS   =>  '0');
			 temp_pix    :=  (OTHERS   =>  '0');
		
		 ELSIF(rising_edge(clk))  THEN
		    IF (ena='1') THEN
			    temp_count      :=  count_next;
				 temp_pix   :=  pixel_next;
			 END IF;
		END IF;
		y_pixel       <=  STD_LOGIC_VECTOR(temp_pix);
		count_s       <=  temp_count;
		pixel_s       <=  temp_pix;
	END PROCESS;
	
	Vvid_on <= '1' WHEN (count_s>=ZERO AND count_s<=END_IMG) ELSE
				  '0' WHEN count_s>=END_IMG;

	VSync_s <= '1' WHEN (count_s <= END_FRONT OR count_s> END_RETRACE) ELSE	
	           '0' WHEN (count_s > END_FRONT AND count_s<=END_RETRACE);

END ARCHITECTURE;