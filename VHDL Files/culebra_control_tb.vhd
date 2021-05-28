LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
---------------------------------------------------------
ENTITY culebra_control_tb IS
END ENTITY culebra_control_tb;
---------------------------------------------------------
ARCHITECTURE testbench OF culebra_control_tb IS



SIGNAL clk_tb      :  STD_LOGIC;
SIGNAL rst_tb      :  STD_LOGIC;
SIGNAL move_tb        :     STD_LOGIC;
SIGNAL dir_tb         :    STD_LOGIC_VECTOR(1 downto 0);  --DIR "00" ARRIBA "01" ABAJO  "10" IZQUIERDA  "11" DERECHA
SIGNAL wr_en_tb       :    STD_LOGIC;
SIGNAL w_data_x_tb    :    STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL w_data_y_tb    :    STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL cabeza_tb      :   STD_LOGIC_VECTOR(4 downto 0); --Manejo de direcciones
        SIGNAL    cola_tb        :   STD_LOGIC_VECTOR(4 downto 0);


BEGIN



DUT: ENTITY work.culebra_control

PORT MAP ( clk      => clk_tb,
           rst      => rst_tb,
			  move     => move_tb,
			  dir      => dir_tb,
			  wr_en    => wr_en_tb,
			  w_data_y => w_data_y_tb,
			  cabeza => cabeza_tb,
			  cola => cola_tb,
			  w_data_x => w_data_x_tb);



signal_generation: PROCESS
BEGIN



-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '0';
dir_tb    <= "00";
WAIT FOR 40 ns;

-- TEST VECTOR START 1
rst_tb <= '1';
move_tb   <= '0';
dir_tb    <= "00";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '0';
dir_tb    <= "11";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '1';
dir_tb    <= "01";
WAIT FOR 20 ns;


-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '0';
dir_tb    <= "01";
WAIT FOR 20 ns;


-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '1';
dir_tb    <= "00";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '0';
dir_tb    <= "01";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '1';
dir_tb    <= "11";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '0';
dir_tb    <= "11";
WAIT FOR 40 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '1';
dir_tb    <= "10";
WAIT FOR 20 ns;

-- TEST VECTOR START 1
rst_tb <= '0';
move_tb   <= '0';
dir_tb    <= "00";
WAIT FOR 40 ns;



END PROCESS signal_generation;



END ARCHITECTURE testbench;