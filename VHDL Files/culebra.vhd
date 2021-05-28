LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
-------------------------------------------------------
ENTITY culebra IS
	GENERIC( DATA_WIDTH  :  integer := 4;
	         ADDR_WIDTH  :  integer := 4);
   PORT(    

	         clk         :   IN   STD_LOGIC;
	         rst         :   IN   STD_LOGIC;
				wr_en       :   IN   STD_LOGIC;
				w_addr      :   IN   STD_LOGIC_VECTOR(4 DOWNTO 0);
				r_addr      :   IN   STD_LOGIC_VECTOR(4 DOWNTO 0);
				w_data_y    :   IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
				w_data_x    :   IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
				r_data_y    :   OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
				r_data_x    :   OUT  STD_LOGIC_VECTOR(3 DOWNTO 0)
					
	);

END ENTITY;

ARCHITECTURE rtl OF culebra IS

    TYPE mem_2d_type IS ARRAY (0 TO 2**ADDR_WIDTH-1) OF STD_LOGIC_VECTOR(DATA_WIDTH-1 DOWNTO 0); --Registros de 32 partes de la culebra, cada uno guarda 4 bits en donde se escribirá la dirección en el tablero
    SIGNAL x_culebra  :   mem_2d_type;
	 SIGNAL y_culebra  :   mem_2d_type;
	 

BEGIN

   --WRITE PROCESS
  write_process  :  PROCESS(clk, rst)
  BEGIN
   IF(rst='1')  THEN
			  x_culebra(0) <= "0011";     
			  y_culebra(0) <= "0110";
			  x_culebra(1) <= "0100";
			  y_culebra(1) <= "0110";
			  x_culebra(2) <= "0101";
			  y_culebra(2) <= "0110";
			  --CAMBIO DE SIZE *OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO******
			 -- x_culebra(3) <= "0110";
			 -- y_culebra(3) <= "0110";
			 -- x_culebra(4) <= "0111";
			 -- y_culebra(4) <= "0110";
			 -- x_culebra(5) <= "1000";
			 -- y_culebra(5) <= "0110";
			 -- x_culebra(6) <= "1001"; --bit 0 bit 3
			 -- y_culebra(6) <= "0110";
		
		 ELSIF(rising_edge(clk))  THEN
		    	  IF  (wr_en = '1')  THEN
		        x_culebra(to_integer(unsigned(w_addr))) <=  w_data_x;
			  y_culebra(to_integer(unsigned(w_addr))) <=  w_data_y;
		END IF;
		END IF;
	END PROCESS;   

	
	--READ
	r_data_x <=  x_culebra(to_integer(unsigned(r_addr)));
	r_data_y <=  y_culebra(to_integer(unsigned(r_addr)));

END ARCHITECTURE;