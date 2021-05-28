LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
-------------------------------------------------------
ENTITY Escalizador IS
   PORT(    
	
	         clk         :   IN   STD_LOGIC;
				x_pixel     :   IN   STD_LOGIC_VECTOR(9  DOWNTO 0);
				y_pixel     :   IN   STD_LOGIC_VECTOR(8  DOWNTO 0);
				pos_y       :   OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
				pos_x       :   OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
	);	

END ENTITY;

ARCHITECTURE rtl OF Escalizador IS

 

BEGIN

   --WRITE PROCESS
  write_process  :  PROCESS(clk)
  BEGIN
     IF(rising_edge(clk))   THEN
	  -----------------------------------------------------------------------------------
	     
	     IF  (x_pixel >= "0000000000" AND x_pixel < "0000100000")  THEN
		     pos_x <= "0000";
		  END IF;
		  IF  (x_pixel >= "0000100000" AND x_pixel < "0001000000")  THEN
		     pos_x <= "0001";
		  END IF;
		  IF  (x_pixel >= "0001000000" AND x_pixel < "0001100000")  THEN
		     pos_x <= "0010";
		  END IF;
		  IF  (x_pixel >= "0001100000" AND x_pixel < "0010000000")  THEN
		     pos_x <= "0011";
		  END IF;
		  IF  (x_pixel >= "0010000000" AND x_pixel < "0010100000")  THEN
		     pos_x <= "0100";
		  END IF;
		  IF  (x_pixel >= "0010100000" AND x_pixel < "0011000000")  THEN
		     pos_x <= "0101";
		  END IF;
		  IF  (x_pixel >= "0011000000" AND x_pixel < "0011100000")  THEN
		     pos_x <= "0110";
		  END IF;
		  IF  (x_pixel >= "0011100000" AND x_pixel < "0100000000")  THEN
		     pos_x <= "0111";
		  END IF;
		  IF  (x_pixel >= "0100000000" AND x_pixel < "0100100000")  THEN
		     pos_x <= "1000";
		  END IF;
		  IF  (x_pixel >= "0100100000" AND x_pixel < "0101000000")  THEN
		     pos_x <= "1001";
		  END IF;
		  IF  (x_pixel >= "0101000000" AND x_pixel < "0101100000")  THEN
		     pos_x <= "1010";
		  END IF;
		  IF  (x_pixel >= "0101100000" AND x_pixel < "0110000000")  THEN
		     pos_x <= "1011";
		  END IF;
		  IF  (x_pixel >= "0110000000" AND x_pixel < "0110100000")  THEN
		     pos_x <= "1100";
		  END IF;
		  IF  (x_pixel >= "0110100000" AND x_pixel < "0111000000")  THEN
		     pos_x <= "1101";
		  END IF;
		  IF  (x_pixel >= "0111000000" AND x_pixel < "0111100000")  THEN
		     pos_x <= "1110";
		  END IF;
		  IF  (x_pixel >= "0111100000" AND x_pixel < "1010000000")  THEN
		     pos_x <= "0000";
		  END IF;
		  
		  
		  
		  IF  (y_pixel >= "000000000" AND y_pixel < "000100000")  THEN
		     pos_y <= "0000";
		  END IF;
		  IF  (y_pixel >= "000100000" AND y_pixel < "001000000")  THEN
		     pos_y <= "0001";
		  END IF;
		  IF  (y_pixel >= "001000000" AND y_pixel < "001100000")  THEN
		     pos_y <= "0010";
		  END IF;
		  IF  (y_pixel >= "001100000" AND y_pixel < "010000000")  THEN
		     pos_y <= "0011";
		  END IF;
		  IF  (y_pixel >= "010000000" AND y_pixel < "010100000")  THEN
		     pos_y <= "0100";
		  END IF;
		  IF  (y_pixel >= "010100000" AND y_pixel < "011000000")  THEN
		     pos_y <= "0101";
		  END IF;
		  IF  (y_pixel >= "011000000" AND y_pixel < "011100000")  THEN
		     pos_y <= "0110";
		  END IF;
		  IF  (y_pixel >= "011100000" AND y_pixel < "100000000")  THEN
		     pos_y <= "0111";
		  END IF;
		  IF  (y_pixel >= "100000000" AND y_pixel < "100100000")  THEN
		     pos_y <= "1000";
		  END IF;
		  IF  (y_pixel >= "100100000" AND y_pixel < "101000000")  THEN
		     pos_y <= "1001";
		  END IF;
		  IF  (y_pixel >= "101000000" AND y_pixel < "101100000")  THEN
		     pos_y <= "1010";
		  END IF;
		  IF  (y_pixel >= "101100000" AND y_pixel < "110000000")  THEN
		     pos_y <= "1011";
		  END IF;
		  IF  (y_pixel >= "110000000" AND y_pixel < "110100000")  THEN
		     pos_y <= "1100";
		  END IF;
		  IF  (y_pixel >= "110100000" AND y_pixel < "111000000")  THEN
		     pos_y <= "1101";
		  END IF;
		  IF  (y_pixel >= "111000000" AND y_pixel < "111100000")  THEN
		     pos_y <= "1110";
		  END IF;
		  -----------------------------------------------------------------------------
     END IF;
	END PROCESS;   
	


END ARCHITECTURE;