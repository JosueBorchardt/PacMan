library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
library work;
use work.components.all;

entity video_controller is
   Port (
      clk      	: in  STD_LOGIC;
      reset     	: in  STD_LOGIC;
      vga_HS    	: out STD_LOGIC;
      vga_VS    	: out STD_LOGIC;
      pixel_x   	: out INTEGER range 0 to 1279;
      pixel_y   	: out INTEGER range 0 to 1023;
      pixel_color	: out INTEGER range 0 to 6
   );
end video_controller;

architecture Behavioral of video_controller is
   -- Definição do tabuleiro
--   type pacman_board_type is array (0 to 30, 0 to 27) of integer;
   
--   constant pacman_board : pacman_board_type := (
--      (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
--      (1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,1),
--		(1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,1),
--      (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
--   );
	
	-------------------------
	-- Parametros de video --
	-------------------------
	constant H_TOTAL 			    : integer := 1681;
	constant H_SYNC 			    : integer := 108;
	constant H_BACK_PORCH	    : integer := 249;	
	constant H_DISPLAY_INTERVAL : integer := 1280;	-- Porção horizontal usada da tela
	constant H_FRONT_PORCH 	    : integer := 44;		

	constant V_TOTAL 			    : integer := 1066;	
	constant V_SYNC 			    : integer := 3;     -- Troca de quadro	
	constant V_BACK_PORCH	    : integer := 38;	   -- Antes
	constant V_DISPLAY_INTERVAL : integer := 1024;  -- Porção vertical usada da tela
	constant V_FRONT_PORCH 	    : integer := 1;     -- Após 
	
	-- Horizontal position (0-1680)
	signal H_Count : integer range 0 to 1680 := 0;
	-- Vertical position (0-1065)
	signal V_Count : integer range 0 to 1065 := 0;
	
	-- Sinais de sincronizaçao
	signal vga_hsync, vga_vsync : STD_LOGIC;
	
	-- Pixel que esta sendo rederizado na tela
	signal signal_pixel_x : INTEGER range 0 to 1279 := 0;
	signal signal_pixel_y : INTEGER range 0 to 1023 := 0;
	
--	signal cell_x, cell_y   : INTEGER range 0 to 27;
--	signal cell_type        : INTEGER;
	
begin

	---------------------------------
	------- BOARD --------
	---------------------------------
	boardd: board
		port map (
			clk => clk,
			reset => reset,
			pixel_x => signal_pixel_x,
			pixel_y => signal_pixel_y,
			pixel_color => pixel_color
			--vga_R, vga_G, vga_B: out STD_LOGIC_VECTOR(9 downto 0) 
			--vga_HS    : out STD_LOGIC;
			--vga_VS    : out STD_LOGIC;
	);

	HCounter: process (clk, reset) -- Qual pix será modificado na tela
	begin
		if reset = '1' then
			H_count <= 0;
			V_Count <= 0;
			vga_hsync <= '1';
			vga_vsync <= '1';
		elsif rising_edge(clk) then
			if H_count < H_TOTAL - 1 then
				H_count <= H_count + 1;
			else
				H_count <= 0;
				if V_Count < V_total - 1 then
					V_Count <= V_Count + 1;
				else
					V_Count <= 0;
				end if;
			end if;

			if (H_Count >= H_SYNC + H_BACK_PORCH) and (H_count < H_TOTAL - H_FRONT_PORCH) then
				signal_pixel_x <= signal_pixel_x + 1;
			else 
				signal_pixel_x <= 0;
			end if;
			
			if (V_count >= V_SYNC + V_BACK_PORCH) and (V_count < V_TOTAL - V_FRONT_PORCH) then
				signal_pixel_y <= signal_pixel_y + 1;
			else 
				signal_pixel_y <= 0;
			end if;
			
			if H_count < H_SYNC then
				vga_hsync <= '1';
			else 
				vga_hsync <= '0';
			end if;
			
			if V_count < V_SYNC then
				vga_vsync <= '1';
			else
				vga_vsync <= '0';
			end if;
		end if;
	end process;
	
	pixel_x <= signal_pixel_x;
	pixel_y <= signal_pixel_y;
	
	vga_HS <= vga_hsync;
	vga_VS <= vga_vsync;
	
end Behavioral;