library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity video_controller is
    Port (
        CLK       : in  STD_LOGIC;
        RESET     : in  STD_LOGIC;
        VGA_HS    : out STD_LOGIC;
        VGA_VS    : out STD_LOGIC;
        PIXEL_X   : out INTEGER;
        PIXEL_Y   : out INTEGER;
        PIXEL_COLOR : out STD_LOGIC_VECTOR(11 downto 0)
    );
end video_controller;

architecture Behavioral of video_controller is
   -- Definição do tabuleiro
   type pacman_board_type is array (0 to 30, 0 to 27) of integer;
   
   constant pacman_board : pacman_board_type := (
      (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1),
      (1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,1),
		(1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,1),
      (1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)
   );
	
	-------------------------
	-- Parametros de video --
	-------------------------
	-- original do barth
	constant H_TOTAL 			: integer := 1693;
	constant H_SYNC 			: integer := 112;	
	constant H_BACK_PORCH	: integer := 256;
	constant H_DISPLAY_INTERVAL : integer := 1280;	-- Porção horizontal usada da tela
	constant H_FRONT_PORCH 	: integer := 45;

	constant V_TOTAL 			: integer := 1066;	
	constant V_SYNC 			: integer := 3;      -- Troca de quadro	
	constant V_BACK_PORCH	: integer := 38;	   -- Antes
	constant V_DISPLAY_INTERVAL : integer := 1024;    -- Porção vertical usada da tela
	constant V_FRONT_PORCH 	: integer := 1;      -- Após 
	
	-- Horizontal position (0-1667)
	signal H_Count : integer range 0 to 1280 := 0;
	-- Vertical position (0-1065)
	signal V_Count : integer range 0 to 1024 := 0;
	
   signal pixel_x, pixel_y : INTEGER range 0 to 1066;
   signal cell_x, cell_y   : INTEGER range 0 to 27;
   signal cell_type        : INTEGER;
	
begin

	HCounter: process (countclk, reset) -- Qual pix será modificado na tela
	begin
		if reset = '1' then
			H_count <= 0;
			V_Count <= 0;
--			vga_hsync <= '1';
--			vga_vsync <= '1';
		elsif rising_edge(CLK) then
			
			if H_count < H_TOTAL - 1 then
				H_count <= H_count + 1;
			else
				H_count <= 0;
				if V_Count < Vtotal - 1 then
					V_Count <= V_Count + 1;
				else
					V_Count <= 0;
				end if;
			end if;

		end if;
	end process;

end Behavioral;