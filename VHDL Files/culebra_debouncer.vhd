LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
-------------------------------------------------------
ENTITY culebra_debouncer IS
   PORT(    clk         :   IN   STD_LOGIC;
	         rst         :   IN   STD_LOGIC;
				upin        :   IN   STD_LOGIC;
				downin      :   IN   STD_LOGIC;
				leftin      :   IN   STD_LOGIC;
				rightin     :   IN   STD_LOGIC;
				
				dir      :   OUT   STD_LOGIC_VECTOR(1 DOWNTO 0)
	);	

END ENTITY;

ARCHITECTURE rtl OF culebra_debouncer IS

  SIGNAL up_sig    : STD_LOGIC;
  SIGNAL down_sig  : STD_LOGIC;
  SIGNAL right_sig : STD_LOGIC;
  SIGNAL left_sig  : STD_LOGIC;
 

BEGIN

   --WRITE PROCESS
  write_process  :  PROCESS(clk, rst, upin, leftin, rightin, downin)
  BEGIN
     IF(rising_edge(clk ))   THEN
	     IF  (rst = '1')  THEN
		     dir <= "11";
		 END IF;
			  
		  IF  (leftin = '1')  THEN
		     dir <= "10";
		  
	    END IF;
		 IF  (upin = '1')  THEN
		     dir <= "00";
		  
	    END IF;
		 IF  (rightin = '1')  THEN
		     dir <= "11";
		  
	    END IF;
		 IF  (downin = '1')  THEN
		     dir <= "01";
		  
	    END IF;
     END IF;
	END PROCESS;   
	
	


END ARCHITECTURE;