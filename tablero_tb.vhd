LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------
ENTITY tablero_tb IS
END ENTITY tablero_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF tablero_tb IS



SIGNAL      clk_tb         :      STD_LOGIC;
SIGNAL      rst_tb         :      STD_LOGIC;
SIGNAL		r_data_y_tb    :      STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL	   r_data_x_tb    :      STD_LOGIC_VECTOR(3 DOWNTO 0);
	
SIGNAL      pos_y_tb       :      STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL      pos_x_tb       :      STD_LOGIC_VECTOR(3 DOWNTO 0);
				
SIGNAL      cabeza_tb      :      STD_LOGIC_VECTOR(4 downto 0); --Manejo de direcciones
SIGNAL      cola_tb        :      STD_LOGIC_VECTOR(4 downto 0);
SIGNAL      r_addr_tb      :      STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL      white_tb       :      STD_LOGIC;




BEGIN



DUT: ENTITY work.tablero

PORT MAP ( clk      => clk_tb,
           rst      => rst_tb,
			  r_addr   => r_addr_tb,
			  r_data_y => r_data_y_tb,
			  r_data_x => r_data_x_tb,
			  pos_y    => pos_y_tb,
			  pos_x    => pos_x_tb,
			  cabeza   => cabeza_tb,
			  cola     => cola_tb,
			  white    => white_tb);



signal_generation: PROCESS
BEGIN



-- TEST VECTOR START 1
rst_tb <= '1';
r_data_x_tb <="0010";
r_data_y_tb <="0001";
pos_x_tb  <="0001";
pos_y_tb  <="0010";
cabeza_tb <="00011";
cola_tb   <="00001";
WAIT FOR 40 ns;


rst_tb <= '0';
r_data_x_tb <="0010";
r_data_y_tb <="0001";
pos_x_tb  <="0001";
pos_y_tb  <="0010";
cabeza_tb <="00011";
cola_tb   <="00001";
WAIT FOR 40 ns;


rst_tb <= '0';
r_data_x_tb <="0011";
r_data_y_tb <="0001";
pos_x_tb  <="0010";
pos_y_tb  <="0001";
cabeza_tb <="00011";
cola_tb   <="00001";
WAIT FOR 20 ns;

rst_tb <= '0';
r_data_x_tb <="0011";
r_data_y_tb <="0001";
pos_x_tb  <="0010";
pos_y_tb  <="0011";
cabeza_tb <="00011";
cola_tb   <="00001";
WAIT FOR 20 ns;

rst_tb <= '0';
r_data_x_tb <="0011";
r_data_y_tb <="0001";
pos_x_tb  <="0011";
pos_y_tb  <="0001";
cabeza_tb <="00011";
cola_tb   <="00001";
WAIT FOR 20 ns;

rst_tb <= '0';
r_data_x_tb <="0011";
r_data_y_tb <="0001";
pos_x_tb  <="0010";
pos_y_tb  <="0011";
cabeza_tb <="00011";
cola_tb   <="00001";
WAIT FOR 20 ns;


END PROCESS signal_generation;



END ARCHITECTURE testbench;