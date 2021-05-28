 LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
-------------------------------------------------------
ENTITY culebra_control IS
   PORT(    clk         :   IN   STD_LOGIC;
	         move        :   IN   STD_LOGIC;
	         dir         :   IN   STD_LOGIC_VECTOR(1 downto 0);  --DIR "00" ARRIBA "01" ABAJO  "10" IZQUIERDA  "11" DERECHA
	         rst         :   IN   STD_LOGIC;
				cabeza      :  OUT  STD_LOGIC_VECTOR(4 downto 0); --Manejo de direcciones
            cola        :  OUT  STD_LOGIC_VECTOR(4 downto 0);
				food_x		:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				food_y		:  IN STD_LOGIC_VECTOR(3 DOWNTO 0);
				wr_en       :   OUT  STD_LOGIC;
				w_data_x    :   OUT  STD_LOGIC_VECTOR(3 DOWNTO 0);
				w_data_y    :   OUT  STD_LOGIC_VECTOR(3 DOWNTO 0); 
				crecer      :  OUT STD_LOGIC;
				muerte      :   OUT  STD_LOGIC
	);	

END ENTITY;

ARCHITECTURE functional OF culebra_control IS

SIGNAL culehead       :  unsigned(4 downto 0); --Manejo de direcciones
SIGNAL culetail       :  unsigned(4 downto 0);
SIGNAL culehead_next  :  unsigned(4 downto 0);
SIGNAL culetail_next  :  unsigned(4 downto 0);


SIGNAL culehead_x        :   unsigned(3 downto 0); --Manejo de datos
SIGNAL culehead_y        :   unsigned(3 downto 0);
SIGNAL culehead_x_next   :   unsigned(3 downto 0); 
SIGNAL culehead_y_next   :   unsigned(3 downto 0);

signal save  : STD_LOGIC;
signal dir_actual : unsigned(1 downto 0);
signal muerte_s : STD_LOGIC;
SIGNAL crecer_s:  STD_LOGIC;


  BEGIN
  culehead_next  <=  (1 => '1', 0 => '0', OTHERS => '0')  WHEN  rst = '1' ELSE               --CAMBIO DE SIZE  *OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO******
                     (OTHERS => '0') WHEN culehead = 14  ELSE
	                   culehead+1;
							 
  culetail_next  <=  (OTHERS => '0')  WHEN  rst = '1'  ELSE
                     (OTHERS => '0') WHEN culetail = 14  ELSE 
							 culetail WHEN crecer_s = '1' ELSE
	                   culetail+1;
							 
  culehead_x_next  <=  (2 => '1', 0 => '1', OTHERS => '0') WHEN rst = '1' ELSE    --CAMBIO DE SIZE *OOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOO******
							  culehead_x + 1 WHEN ((dir = "11" and  NOT (dir_actual = 2)) OR (dir = "10" and (dir_actual = 3)))  ELSE
                       culehead_x - 1 WHEN ((dir = "10" and  NOT (dir_actual = 3)) OR (dir = "11" and (dir_actual = 2))) ELSE
							  culehead_x     WHEN ((dir = "00") OR (dir = "01"));
							  
  culehead_y_next  <=  (1 => '1', 2 => '1', OTHERS => '0') WHEN rst = '1'   ELSE     
                       culehead_y + 1 WHEN ((dir = "00" and  NOT (dir_actual = 1)) OR (dir = "01" and(dir_actual = 0))) ELSE --Para que la serpiente no desafíe las leyes de la física
                       culehead_y - 1 WHEN ((dir = "01" and  NOT (dir_actual = 0))  OR (dir = "00" and(dir_actual = 1)))   ELSE
							  culehead_y     WHEN ((dir = "11") OR (dir = "10"));
							  
   dir_actual   <=  (1 => '1', 0 => '1')    WHEN rst = '1'             ELSE
	                 (1 => '0', 0 => '0')    WHEN (dir = "00" and  NOT (dir_actual = 1))  ELSE --Para que la serpiente no desafíe las leyes de la física
                    (0 => '1', 1 => '0') 	  WHEN (dir = "01" and  NOT (dir_actual = 0))  ELSE
						  (1 => '1', 0 => '1')    WHEN (dir = "11" and  NOT (dir_actual = 2))  ELSE
                    (1 => '1', 0 => '0')    WHEN (dir = "10" and  NOT (dir_actual = 3))  ELSE
						  dir_actual;
						  
	
	
	crecer_s <= '1' WHEN (culehead_x = unsigned(food_x) AND culehead_y = unsigned(food_y)) ELSE 
				   '0';
					
PROCESS(clk, rst, move)
BEGIN
   IF(rising_edge(clk))   THEN
	   IF(move = '1' or rst = '1')   THEN
    	   culehead <= culehead_next;
	      culetail <= culetail_next;
	    	culehead_x <= culehead_x_next;
	      culehead_y <= culehead_y_next;	
		   save <= '1';
		
		  crecer <= crecer_s;
		  muerte <= muerte_s;
				
	   ELSE
	      save <= '0';
		END IF;
	END IF;
	
	w_data_x <= STD_LOGIC_VECTOR(culehead_x);
	w_data_y <= STD_LOGIC_VECTOR(culehead_y);
	cabeza <= STD_LOGIC_VECTOR(culehead);
	cola <= STD_LOGIC_VECTOR(culetail);
	
	END PROCESS;   

	--muerte <= muerte_s;
	wr_en <= '1' WHEN save = '1' ELSE '0';
	
	muerte_s <= '1' WHEN (culehead_x = 15 ) OR (culehead_y = 15 )  ELSE 
				'0'; 
	
	

	
END ARCHITECTURE;