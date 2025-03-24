library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.components.all;

entity pacman_game is
   Port (
		clk_altera    : in  STD_LOGIC;
		clk_out       : out  STD_LOGIC;
		reset			  : in STD_LOGIC;
      vga_HS        : out STD_LOGIC;
		vga_VS        : out STD_LOGIC;
		
		vga_R         : out std_LOGIC_VECTOR(9 downto 0);
		vga_G			  : out std_LOGIC_VECTOR(9 downto 0);
		vga_B			  : out std_LOGIC_VECTOR(9 downto 0);
		vga_clk		  : out std_LOGIC;
		vga_sync		  : out std_LOGIC;
		vga_blank     : out STD_LOGIC;
		
      --pixel_x  	  : out INTEGER range 0 to 1279; -- ?????
      --pixel_y  	  : out INTEGER range 0 to 1023;  -- ?????
		
		pixel_color	: out INTEGER range 0 to 6		
		  
      --PIXEL_COLOR : out STD_LOGIC_VECTOR(11 downto 0)
   );
end pacman_game;

architecture Behavioral of pacman_game is

	signal sig_inclk0, sig_c0, sig_locked : std_logic;
	signal sig_HS, sig_VS: STD_LOGIC; 
	
begin
	---------------------------------
	------- CLOCK 108MHZ ------------
	---------------------------------
	clk_108MHz: pll_108MHZ
		port map (
			areset => reset,
			inclk0 => clk_altera, -- clock de entrada
			c0 => sig_c0,			 -- clock de saida
			locked => sig_locked
	);
	
	clk_out <= sig_c0; -- clock de saida (c0)
	vga_clk<= sig_c0;
	
	---------------------------------
	------- VIDEO CONTROLLER --------
	---------------------------------
	videocontroller: video_controller
		port map (
			clk => sig_c0,
			reset => reset,
			vga_HS => sig_HS,			
			vga_VS => sig_VS,
			vga_BL => vga_blank,
			--pixel_x => pixel_x, 
			--pixel_y => pixel_y, 
			vga_R => vga_R,
			vga_G => vga_G,
			vga_B => vga_B,
			pixel_color => pixel_color
	);	
	
--	vga_R <= "0000000000";
--	vga_G <= "0000000000";
--	vga_B <= "1111111111";
	vga_sync <= '0';
	vga_HS <= sig_HS;
	vga_VS <= sig_VS;
	
end Behavioral;