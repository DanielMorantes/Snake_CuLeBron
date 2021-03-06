LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------
ENTITY HSYNC IS
    GENERIC     (  N       	:  INTEGER  := 2);
	 PORT        (  clk     	:  IN       STD_LOGIC;
	                rst    	  	:  IN       STD_LOGIC;
						 ena   		:  IN       STD_LOGIC;
						 Hvid_on		:  OUT      STD_LOGIC;
						 HSync_s		:  OUT      STD_LOGIC;
						 Next_row   :  OUT      STD_LOGIC;
						 x_pixel    :  OUT 		 STD_LOGIC_VECTOR(9 DOWNTO 0));
END ENTITY;
-------------------------------------

ARCHITECTURE rtl OF HSYNC IS
	 CONSTANT ZERO    		:  UNSIGNED(9  DOWNTO  0) :="0000000000";
    CONSTANT END_PIX 		:  UNSIGNED(9  DOWNTO  0) :="1100011111";
	 CONSTANT END_IMG			:  UNSIGNED(9  DOWNTO  0) :="1001111111";
	 CONSTANT END_FRONT		:  UNSIGNED(9  DOWNTO  0) :="1010001111";
	 CONSTANT END_RETRACE	:  UNSIGNED(9  DOWNTO  0) :="1011101111";	 
	 
	 SIGNAL clk_s           :  UNSIGNED(1  DOWNTO  0);
	 SIGNAL clk_next        :  UNSIGNED(1  DOWNTO  0);
	 SIGNAL count_s          :  UNSIGNED(9  DOWNTO  0);
	 SIGNAL count_next       :  UNSIGNED(9  DOWNTO  0);
	 SIGNAL pixel_s          :  UNSIGNED(9  DOWNTO  0);
	 SIGNAL pixel_next       :  UNSIGNED(9  DOWNTO  0);
	 

BEGIN
							 
	 count_next  <=  (OTHERS  =>   '0')  WHEN  count_s = END_PIX    ELSE
	                   count_s + 1         WHEN  (ena ='1')   ELSE
							 count_s;
							 
	 pixel_next <=  (OTHERS  =>   '0')  WHEN  pixel_s = END_IMG   ELSE
	                   pixel_s + 1      WHEN  (ena ='1' AND count_s<END_IMG )   ELSE
							 pixel_s;
							 

    PROCESS(clk,rst)
		  VARIABLE temp_count      :   UNSIGNED(9  DOWNTO  0);
		  VARIABLE temp_pix    :   UNSIGNED(9  DOWNTO  0);
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
		x_pixel       <=  STD_LOGIC_VECTOR(temp_pix);
		count_s       <=  temp_count;
		pixel_s       <=  temp_pix;
	END PROCESS;
	
	Hvid_on <= '1' WHEN (count_s>=ZERO AND count_s<=END_IMG) ELSE
				  '0' WHEN count_s>=END_IMG;

	HSync_s <= '1' WHEN (count_s <= END_FRONT OR count_s> END_RETRACE) ELSE	
	           '0' WHEN (count_s > END_FRONT AND count_s<=END_RETRACE);
	
WITH count_s SELECT 
	Next_row <= '1' WHEN END_PIX,
					'0' WHEN OTHERS;

END ARCHITECTURE;