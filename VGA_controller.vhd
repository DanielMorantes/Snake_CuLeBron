LIBRARY IEEE;
USE ieee.std_logic_1164.all;
use ieee.numeric_std.all;
------------------------------------
ENTITY VGA_controller  IS
    GENERIC     (  N       	:  INTEGER  := 2;
	                N2         : INTEGER := 4
	                 );
	 PORT        (  clk     	:  IN       STD_LOGIC;
	                rst   	  	:  IN       STD_LOGIC;
						 ena   		:  IN       STD_LOGIC;
						 arriba     :  IN       STD_LOGIC; 
						 abajo      :  IN       STD_LOGIC;
						 izquierda  :  IN       STD_LOGIC;
						 derecha    :  IN       STD_LOGIC;
						 hsync		:  OUT      STD_LOGIC;
						 vsync      :  OUT      STD_LOGIC;
						 r          :  OUT      STD_LOGIC_VECTOR(3 DOWNTO 0);
						 g          :  OUT      STD_LOGIC_VECTOR(3 DOWNTO 0);
						 b          :  OUT      STD_LOGIC_VECTOR(3 DOWNTO 0);
						 sseg1      :  OUT      STD_LOGIC_VECTOR(6  DOWNTO  0);
						 sseg2      :  OUT      STD_LOGIC_VECTOR(6  DOWNTO  0);
						 sseg3      :  OUT      STD_LOGIC_VECTOR(6  DOWNTO  0);
						 sseg4      :  OUT      STD_LOGIC_VECTOR(6  DOWNTO  0);
						 muerte_pacho      :  OUT      STD_LOGIC);
END ENTITY VGA_controller;
-------------------------------------
ARCHITECTURE functional OF VGA_controller IS

SIGNAL x_pixel: STD_LOGIC_VECTOR(9 DOWNTO 0);
SIGNAL y_pixel: STD_LOGIC_VECTOR(8 DOWNTO 0);
SIGNAL video_on: STD_LOGIC;
SIGNAL r_s, g_s, b_s: STD_LOGIC;

SIGNAL dir_s : STD_LOGIC_VECTOR(1 DOWNTO 0);

SIGNAL wr_en_s : STD_LOGIC;
SIGNAL cabeza_s : STD_LOGIC_VECTOR(4 downto 0);
SIGNAL cola_s : STD_LOGIC_VECTOR(4 downto 0);

SIGNAL r_addr_s : STD_LOGIC_VECTOR(4 downto 0);
SIGNAL r_data_y_s  :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL r_data_x_s  :  STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL w_data_x_s : STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL w_data_y_s : STD_LOGIC_VECTOR(3 DOWNTO 0);


SIGNAL move_s  : STD_LOGIC;
SIGNAL white_s, red_s  : STD_LOGIC;

SIGNAL muerte_s   : STD_LOGIC;
SIGNAL muerte2  : STD_LOGIC;
SIGNAL muerte : STD_LOGIC;

SIGNAL cabeza_x: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL cabeza_y: STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL pos_y_s  :  STD_LOGIC_VECTOR(3 DOWNTO 0) ;  --Estasd organizarán la matriz
SIGNAL pos_x_s  :  STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL food_x: STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL food_y: STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL crecer_s, nueva_comida : std_LOGIC;
SIGNAL puntaje_s : STD_LOGIC_VECTOR(3 DOWNTO 0);

SIGNAL bcd0_s, bcd1_s, bcd2_s, bcd3_s: std_logic_vector(3 downto 0);

SIGNAL rst_s: STD_LOGIC;

BEGIN

muerte_pacho <= muerte2;
	
Escalizador: ENTITY work.Escalizador
	PORT MAP    (  clk   		=> clk,
                  pos_x	       => pos_x_s,
						pos_y         => pos_y_s,
	               x_pixel    		=> x_pixel,
					   y_pixel      => y_pixel );
 	

tablero: ENTITY work.tablero 
	 PORT MAP    (  clk   		=> clk, 
	                rst   		=> wr_en_s,  --Sí, rst_s con wr_en, consulten con Pacho antes de cambiar esto
						 x_pixel    => x_pixel,
					    y_pixel     => y_pixel,
						 r_addr     =>   r_addr_s,
						 cabeza     =>   cabeza_s,
						 cola       =>   cola_s,
						 food_x     =>  food_x,
						 food_y     =>  food_y,
						 white      =>    white_s,
						 red        =>   red_s, 
						 pos_x      =>    pos_x_s,
						 pos_y      =>    pos_y_s,
						 crecer     => crecer_s,
						 r_data_y	=>    r_data_y_s , --ENtradas en este caso
						 r_data_x   =>    r_data_x_s,
						 cabeza_x   =>    w_data_x_s,
						 cabeza_y   =>    w_data_y_s,
						 nueva_comida => nueva_comida,
						 Muerte     =>    Muerte_s );


culebra: ENTITY work.culebra 
	 PORT MAP    (  clk   		=> clk, 
	                rst    		=> rst_s or muerte,
						 wr_en      => wr_en_s,
						 w_addr     => cabeza_s,
						 r_addr     =>  r_addr_s,
						 w_data_y   => w_data_y_s,
						 w_data_x   => w_data_x_s,
						 r_data_y	=>   r_data_y_s ,
						 r_data_x   =>   r_data_x_s);
											 

culebra_control: ENTITY work.culebra_control 
	 PORT MAP    (  clk   		=> clk, 
	                rst    		=> rst_s or muerte,
						 move    	=> move_s,
						 dir        => dir_s,
						 food_x     => food_x,
						 food_y     => food_y,
						 cabeza     => cabeza_s,
						 cola    	=> cola_s,
						 wr_en	   => wr_en_s,
						 w_data_y   => w_data_y_s,
						 w_data_x   => w_data_x_s,
						 crecer     => crecer_s,
						 muerte     => muerte2
						 );
						 
						 
						 
culebra_debouncer: ENTITY work.culebra_debouncer 
	 PORT MAP    (  clk   		=> clk, 
	                rst    		=> rst_s,
						 upin    	=> arriba,
						 downin     => abajo,
						 leftin     => izquierda,
						 rightin    => derecha,
						 dir        => dir_s);
												 	
						 				 
timer_move: ENTITY work.timer_move 
	 PORT MAP    (  clk   		=> clk, 
	                sync_clr   => rst_s,
						 ena     	=> '1',
						 level      => puntaje_s,
						 max_tick   => move_s);				 
							
						 
VGA_sync: ENTITY work.VGA_sync 
	 GENERIC MAP    (  N   => N)
	 PORT MAP    (  clk   		=> clk, 
	                rst    		=> rst_s,
						 ena    		=> ena,
						 video_on   => video_on,
						 x_pixel    => x_pixel,
						 y_pixel		=> y_pixel,
						 hsync		=> hsync,
						 vsync      => vsync);

Pixel_generator: ENTITY work.Pixel_generator
	 PORT MAP    (    clk         => clk,
	                  white     =>  white_s,
							red       =>  red_s,
							video_on   => video_on,
							muerte     => muerte_s,
							crecer     => crecer_s,
							x_pixel    => x_pixel,
							y_pixel    => y_pixel,
							food_x 	  => food_x,
							food_y	  => food_y,
							pos_y      => pos_x_s,
							pos_x      => pos_y_s,
							r          => r_s,
							g          => g_s, 
							b          => b_s);
							
Aleatorio: entity work.AleatorioGeneral 
	PORT MAP(	clk	 => clk,
					n_food => rst_s or crecer_s or nueva_comida,
					rand_x_out => food_x,
					rand_y_out => food_y
					);

ContPuntaje: ENTITY work.ContadorPuntaje 
    GENERIC MAP    (  N  => N2)
	 PORT MAP    (  clk     => move_s,
	                rst     => rst_s or muerte,
						 --max_tick => fin,
						 crecer  => crecer_s,
						 puntaje  => puntaje_s);
						 
bin_to_BCD: ENTITY work.binary_BCD
	 generic map(N => N2)
    port map(
        clk => clk, 
		  reset => rst,
        binary_in => puntaje_s,
        bcd0 => bcd0_s,
		  bcd1 => bcd1_s,
		  bcd2 => bcd2_s,
		  bcd3 => bcd3_s
    );			

bin_to_sseg1: ENTITY work.bin_to_sseg
		PORT MAP ( data  => bcd0_s,
						sseg 	=> sseg1);
						
bin_to_sseg2: ENTITY work.bin_to_sseg
		PORT MAP ( data  => bcd1_s,
						sseg 	=> sseg2);
						
bin_to_sseg3: ENTITY work.bin_to_sseg
		PORT MAP ( data  => bcd2_s,
						sseg 	=> sseg3);

bin_to_sseg4: ENTITY work.bin_to_sseg
		PORT MAP ( data  => bcd3_s,
						sseg 	=> sseg4);
						
muerte <= muerte_s or muerte2;
--puntaje <= puntaje_s;
rst_s <= rst;
							
r <= (OTHERS  =>   '1')  WHEN  r_s = '1' ELSE (OTHERS  =>   '0');
g <= (OTHERS  =>   '1')  WHEN  g_s = '1' ELSE (OTHERS  =>   '0');
b <= (OTHERS  =>   '1')  WHEN  b_s = '1' ELSE (OTHERS  =>   '0');
						 
END ARCHITECTURE functional;