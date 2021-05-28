LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------
ENTITY timer_move IS
    GENERIC     (  N        :  INTEGER  := 4);
	 PORT        (  clk      :  IN       STD_LOGIC;
						 ena      :  IN       STD_LOGIC;
						 sync_clr :  IN       STD_LOGIC;
						 level    :  IN       STD_LOGIC_VECTOR(3 DOWNTO 0);
						 max_tick :  OUT      STD_LOGIC);

						 
END ENTITY;
-------------------------------------

ARCHITECTURE rtl OF timer_move IS

	 --SIGNAL count_s        :  INTEGER RANGE 0 to (2**N - 1);
	 
	 SIGNAL count_s          :  UNSIGNED(22  DOWNTO  0);
	 SIGNAL count_next       :  UNSIGNED(22  DOWNTO  0);
	 SIGNAL count_next_deci  :  UNSIGNED(N-1  DOWNTO  0);
	 SIGNAL count_s_deci     :  UNSIGNED(N-1  DOWNTO  0);
	 SIGNAL vel              :  UNSIGNED(N-1  DOWNTO  0);
	 
BEGIN

	WITH level SELECT 
			vel <=
			"1111" WHEN "0000",	-- 0
			"1111" WHEN "0001",	-- 1
			"1111" WHEN "0010",	-- 2
			"1111" WHEN "0011",	-- 3
			"0111" WHEN "0100",	-- 4
			"0111" WHEN "0101",	-- 5
			"0111" WHEN "0110",	-- 6
			"0111" WHEN "0111",	-- 7
			"0011" WHEN "1000",	-- 8
			"0011" WHEN "1001",	-- 9
			"0011" WHEN "1010",	-- 10
			"0011" WHEN "1011",	-- 11
			"0001" WHEN "1100",	-- 12
			"0001" WHEN "1101",	-- 13
			"0001" WHEN "1110",	-- 14
			"0001" WHEN "1111";	-- 15

    -- NEXT STATE LOGIC
	 count_next  <=    (OTHERS  =>   '0')  WHEN  (count_s = 5000000 OR sync_clr = '1')    ELSE
	                   count_s + 1         WHEN  (ena ='1')   ELSE
							 count_s;
							 
	 count_next_deci  <=  (OTHERS  =>   '0')  WHEN  (count_s_deci = vel OR sync_clr = '1')    ELSE
	                   count_s_deci + 1      WHEN  (ena ='1' AND count_s = 5000000)   ELSE
							 count_s_deci;
							 

								
    PROCESS(clk)
	     VARIABLE temp        :   UNSIGNED(22  DOWNTO  0);
		  VARIABLE temp_deci   :   UNSIGNED(N-1  DOWNTO  0);
	 BEGIN
	    IF(rising_edge(clk))  THEN
		    IF (ena='1') THEN
			    temp       :=  count_next;
				 temp_deci  :=  count_next_deci;
			 END IF;
		END IF;
		count_s       <=  temp;
		count_s_deci  <=  temp_deci;
	END PROCESS;
	
	max_tick <= '1'  when count_s_deci = vel ELSE  '0';

END ARCHITECTURE;