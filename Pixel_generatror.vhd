LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;
LIBRARY lpm;
USE lpm.lpm_components.all;


-------------------------------------------------------
ENTITY pixel_generator IS
	PORT(    clk         :   IN   STD_LOGIC;
	         white       :   IN   STD_LOGIC;
				red         :   IN   STD_LOGIC;
	         video_on    :   IN   STD_LOGIC;
				muerte      :   IN   STD_LOGIC;
				crecer      :   IN   STD_LOGIC;
				x_pixel     :   IN   STD_LOGIC_VECTOR(9  DOWNTO 0);
				y_pixel     :   IN   STD_LOGIC_VECTOR(8  DOWNTO 0);
				food_x 		:  IN std_logic_vector (3 downto 0);
				food_y	   :  IN std_logic_vector (3 downto 0);
				pos_y       :   IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
				pos_x       :   IN   STD_LOGIC_VECTOR(3 DOWNTO 0);
				r           :   OUT  STD_LOGIC;
				g           :   OUT  STD_LOGIC;
				b           :   OUT  STD_LOGIC
	);		
END ENTITY;
--------------------------------------------------------

ARCHITECTURE rtl OF pixel_generator IS
   
	SIGNAL red_s         :   std_LOGIC_VECTOR(639 downto 0);
	SIGNAL green_s       :   std_LOGIC_VECTOR(639 downto 0);
	SIGNAL blue_s        :   std_LOGIC_VECTOR(639 downto 0);
	
BEGIN
 
green: lpm_rom
    GENERIC MAP(
            lpm_widthad    => 9,
            lpm_outdata => "UNREGISTERED",
            lpm_address_control => "REGISTERED",
            lpm_file        => "green_imageB.mif",
            lpm_width    => 640)
    PORT MAP (
            inclock   =>clk,
            address   =>y_pixel,
            q         =>green_s );
				


r <=   '1' WHEN ((white = '1') AND video_on = '1')  Else '0';	
	
g <=   '1' WHEN ((white = '1' OR red = '1') AND video_on = '1' and muerte = '0')  Else green_s(to_integer(unsigned(x_pixel))) WHEN (video_on = '1' AND muerte = '0') ELSE '0';	
	
b <=   '1' WHEN ((white = '1' OR red = '1') AND video_on = '1' and muerte = '0' and crecer = '0')  Else '0';	

		
END ARCHITECTURE;