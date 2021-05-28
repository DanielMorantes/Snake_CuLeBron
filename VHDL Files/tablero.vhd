LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
-------------------------------------------------------
ENTITY tablero IS
   PORT(    
	
            clk         :   IN   STD_LOGIC;
	         rst         :   IN   STD_LOGIC;
				x_pixel     :   IN   STD_LOGIC_VECTOR(9  DOWNTO 0);
				y_pixel     :   IN   STD_LOGIC_VECTOR(8  DOWNTO 0); 
				r_data_y    :   IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
				r_data_x    :   IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
				food_x 		:  IN std_logic_vector (3 downto 0);
				food_y	   :  IN std_logic_vector (3 downto 0);
				pos_y       :   IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
				pos_x       :   IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
				cabeza      :   IN   STD_LOGIC_VECTOR(4 downto 0); --Manejo de direcciones
            cola        :   IN   STD_LOGIC_VECTOR(4 downto 0);
				cabeza_x    :  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
			   cabeza_y     :  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				crecer      :   IN std_LOGIC;
				r_addr      :   OUT  STD_LOGIC_VECTOR(4 DOWNTO 0);
				white       :   OUT  STD_LOGIC;
				red         :   OUT  STD_LOGIC;
				nueva_comida :  OUT  STD_LOGIC;
				Muerte      :   OUT  STD_LOGIC
	);	

END ENTITY;

ARCHITECTURE rtl OF tablero IS

    TYPE mem_2d_type IS ARRAY (0 TO 14, 0 TO 14) OF STD_LOGIC; --Registros de 15 partes de x, cada uno guarda los 15 bits de y
    SIGNAL memory_table_f         :   mem_2d_type;
	 SIGNAL memory_table_c         :   mem_2d_type;
    SIGNAL cuenta_culebra       :  UNSIGNED(4 downto 0);
	 SIGNAL cuenta_culebra_next  :  UNSIGNED(4 downto 0);
	 SIGNAL cuenta_recorrido     :  STD_LOGIC;
	 SIGNAL cuenta_recorrido_next     :  STD_LOGIC;
	 SIGNAL muerte_s, nueva_comida_s                  : STD_LOGIC;
 

BEGIN
   -- NEXT STATE LOGIC
   
	cuenta_culebra_next  <=  UNSIGNED(cola)        WHEN  (cuenta_culebra = UNSIGNED(cabeza) or rst ='1')     ELSE
	                         "00000"               WHEN  cuenta_culebra = 14  ELSE
	                         cuenta_culebra + 1;
									 
	muerte_s <= '1' WHEN ((cuenta_culebra /= UNSIGNED(cabeza)) AND cabeza_x = r_data_x AND cabeza_y = r_data_y) ELSE 
				   '0';
					
	nueva_comida_s <= '1' WHEN ((cuenta_culebra /= UNSIGNED(cabeza)) AND food_x = r_data_x AND food_y = r_data_y) ELSE 
						   '0';
						
--WRITE PROCESS
  write_process  :  PROCESS(clk, rst)
  BEGIN
     IF(rising_edge(clk))   THEN
	  -----------------------------------------------------------------------------------
	     cuenta_culebra       <=  cuenta_culebra_next;
		  
		 IF (crecer = '0') 	THEN				
	     memory_table_f(to_integer(unsigned(food_x)),to_integer(unsigned(food_y)))   <=  '1';
		 END IF;
		 
		  memory_table_c(to_integer(unsigned(r_data_x)),to_integer(unsigned(r_data_y)))  <=  '1';
		  
	     muerte <= muerte_s;
		  nueva_comida <= nueva_comida_s;
		  
     END IF;
	  
	  IF  (x_pixel = "0000000000" AND y_pixel= "000000000")  THEN
		     memory_table_f<= (others => (others => '0'));
			  memory_table_c<= (others => (others => '0'));
			  
	  END IF;	
	END PROCESS;   
	
	--READ
	r_addr <= STD_LOGIC_VECTOR(cuenta_culebra);
	
	white <= memory_table_c(to_integer(unsigned(pos_x)),to_integer(unsigned(pos_y)));
	
	red <= memory_table_f(to_integer(unsigned(pos_x)),to_integer(unsigned(pos_y)));


END ARCHITECTURE;

