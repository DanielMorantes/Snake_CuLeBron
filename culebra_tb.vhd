LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------
ENTITY culebra_tb IS
END ENTITY culebra_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF culebra_tb IS



SIGNAL clk_tb      :  STD_LOGIC;
SIGNAL rst_tb      :  STD_LOGIC;
SIGNAL r_addr_tb   :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL r_data_x_tb   :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL r_data_y_tb   :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL wr_en_tb      :  STD_LOGIC;
SIGNAL w_addr_tb     :  STD_LOGIC_VECTOR(4 DOWNTO 0);
SIGNAL w_data_y_tb   :   STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL w_data_x_tb   :   STD_LOGIC_VECTOR(3 DOWNTO 0);




BEGIN



DUT: ENTITY work.culebra

PORT MAP ( clk      => clk_tb,
           rst      => rst_tb,
			  r_addr   => r_addr_tb,
			  r_data_y => r_data_y_tb,
			  r_data_x => r_data_x_tb,
			  wr_en    => wr_en_tb,
			  w_addr   => w_addr_tb,
			  w_data_y => w_data_y_tb,
			  w_data_x => w_data_x_tb);



signal_generation: PROCESS
BEGIN



-- TEST VECTOR START 1
rst_tb <= '0';
wr_en_tb  <= '0';
w_addr_tb <= "00000";
r_addr_tb <= "00000";
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
WAIT FOR 40 ns;



-- TEST VECTOR START 1
rst_tb <= '1';
r_addr_tb <= "00000";
wr_en_tb  <= '0';
w_addr_tb <= "00000";
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
r_addr_tb <= "00000";
wr_en_tb  <= '0';
w_addr_tb <= "00000";
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
r_addr_tb <= "00001";
wr_en_tb <= '0';
w_addr_tb <= "00000";
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
r_addr_tb <= "00010";
wr_en_tb  <= '0';
w_addr_tb <= "00000";
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
r_addr_tb <= "00011";
wr_en_tb  <= '0';
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
w_addr_tb <= "00000";
WAIT FOR 20 ns;


-- TEST VECTOR START 1
rst_tb <= '0';
r_addr_tb <= "00011";
wr_en_tb  <= '1';
w_addr_tb <= "00001";
w_data_x_tb <="1111";
w_data_y_tb  <="0111";
WAIT FOR 20 ns;



-- TEST VECTOR START 1
rst_tb <= '0';
r_addr_tb <= "00000";
wr_en_tb  <= '0';
w_addr_tb <= "00000";
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
r_addr_tb <= "00001";
wr_en_tb <= '0';
w_addr_tb <= "00000";
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
r_addr_tb <= "00010";
wr_en_tb  <= '0';
w_addr_tb <= "00000";
w_data_x_tb <="0000";
w_data_y_tb  <="0000";
WAIT FOR 20 ns;



END PROCESS signal_generation;



END ARCHITECTURE testbench;