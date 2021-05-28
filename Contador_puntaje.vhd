LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------
ENTITY ContadorPuntaje IS
    GENERIC     (  N        :  INTEGER  := 4);
	 PORT        (  clk      :  IN       STD_LOGIC;
	                rst      :  IN       STD_LOGIC;
						 crecer   :  IN       STD_LOGIC;
						 --max_tick  :  OUT      STD_LOGIC;
						 puntaje  :  OUT      STD_LOGIC_VECTOR(N-1  DOWNTO  0));
END ENTITY;
-------------------------------------

ARCHITECTURE rtl OF ContadorPuntaje IS
    CONSTANT ONES      :  UNSIGNED(N-1  DOWNTO  0)  :=  (OTHERS => '1');		
	 	 	 
	 SIGNAL count_s     :  UNSIGNED(N-1  DOWNTO  0);
	 SIGNAL count_next  :  UNSIGNED(N-1  DOWNTO  0);
	 SIGNAL crecer_s    :  STD_LOGIC;
	 
BEGIN

    -- NEXT STATE LOGIC
	 count_next  <=   (OTHERS => '1') WHEN rst = '1' ELSE 
							 count_s + 1         WHEN  (crecer ='1')   ELSE
							 count_s;
							
    PROCESS(clk,rst, crecer, crecer_s)
	 VARIABLE crecer_s_temp        :   STD_LOGIC;
	 VARIABLE temp        :    UNSIGNED(N-1  DOWNTO  0);
	 BEGIN
	    IF(rst='1')  THEN
		    temp   :=  (OTHERS   =>  '0');
		 ELSIF(rising_edge(clk))  THEN
		    IF (crecer = '1' AND crecer_s = '0') THEN
			    temp  :=  count_next;
				 crecer_s_temp := '1';
			 END IF;
			 
			 if(crecer = '0') THEN
			   crecer_s_temp := '0';
			 end if;
		END IF;
		
		puntaje  <=  STD_LOGIC_VECTOR(temp);
		count_s  <=  temp;
		
		crecer_s <=  crecer_s_temp ;
		
	END PROCESS;
	
	--  OUTPUT LOGIC
	--max_tick <= '1'  when count_s = ONES    ELSE  '0';
	

END ARCHITECTURE;