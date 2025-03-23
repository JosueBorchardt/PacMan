library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity board is
   Port (
      clk       : in  STD_LOGIC;
      reset     : in  STD_LOGIC;
		pixel_x   : in INTEGER range 0 to 1279;
      pixel_y   : in INTEGER range 0 to 1023;
		
		--vga_R, vga_G, vga_B: out STD_LOGIC_VECTOR(9 downto 0)
		pixel_color: out INTEGER range 0 to 6
      

--      vga_HS    : out STD_LOGIC;
--      vga_VS    : out STD_LOGIC;

--		  
--      --PIXEL_COLOR : out STD_LOGIC_VECTOR(11 downto 0)
   );
end board;

architecture Behavioral of board is

	type pacman_board_type is array (0 to 30, 0 to 27) of integer range 0 to 5;
	signal pacman_board : pacman_board_type := (
		(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1), -- 0
		(1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,1), -- 1
		(1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1), -- 2
		(1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1), -- 3
		(1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1), -- 4
		(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1), -- 5
		(1,2,1,1,1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,2,1), -- 6
		(1,2,1,1,1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,2,1), -- 7
		(1,2,2,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,2,2,1), -- 8
		(1,1,1,1,1,1,2,1,1,1,1,1,0,1,1,0,1,1,1,1,1,2,1,1,1,1,1,1), -- 9
		(1,1,1,1,1,1,2,1,1,1,1,1,0,1,1,0,1,1,1,1,1,2,1,1,1,1,1,1), -- 10
		(1,1,1,1,1,1,2,1,1,0,0,0,0,0,0,0,0,0,0,1,1,2,1,1,1,1,1,1), -- 11
		(1,1,1,1,1,1,2,1,1,0,1,1,1,1,1,1,1,1,0,1,1,2,1,1,1,1,1,1), -- 12
		(1,1,1,1,1,1,2,1,1,0,1,1,0,0,0,0,1,1,0,1,1,2,1,1,1,1,1,1), -- 13
		(1,0,0,0,0,0,2,0,0,0,1,0,0,0,0,0,0,1,0,0,0,2,0,0,0,0,0,1), -- 14
		(1,1,1,1,1,1,2,1,1,0,1,1,0,0,0,0,1,1,0,1,1,2,1,1,1,1,1,1), -- 15
		(1,1,1,1,1,1,2,1,1,0,1,1,1,1,1,1,1,1,0,1,1,2,1,1,1,1,1,1), -- 16
		(1,1,1,1,1,1,2,1,1,0,0,0,0,0,0,0,0,0,0,1,1,2,1,1,1,1,1,1), -- 17
		(1,1,1,1,1,1,2,1,1,0,1,1,1,1,1,1,1,1,0,1,1,2,1,1,1,1,1,1), -- 18
		(1,1,1,1,1,1,2,1,1,0,1,1,1,1,1,1,1,1,0,1,1,2,1,1,1,1,1,1), -- 19
		(1,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,1), -- 20
		(1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1), -- 21
		(1,2,1,1,1,1,2,1,1,1,1,1,2,1,1,2,1,1,1,1,1,2,1,1,1,1,2,1), -- 22
		(1,2,2,2,1,1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1,1,2,2,2,1), -- 23
		(1,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,1,2,1,1,2,1,1,1), -- 24
		(1,1,1,2,1,1,2,1,1,2,1,1,1,1,1,1,1,1,2,1,1,2,1,1,2,1,1,1), -- 25
		(1,2,2,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,1,1,2,2,2,2,2,2,1), -- 26
		(1,2,1,1,1,1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,1,1,1,1,1,1,2,1), -- 27
		(1,2,1,1,1,1,1,1,1,1,1,1,2,1,1,2,1,1,1,1,1,1,1,1,1,1,2,1), -- 28
		(1,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,2,1), -- 29
		(1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1)  -- 30
   );
	
	type block_board_type is array (0 to 29, 0 to 27) of integer range 0 to 1;
	signal block_board : block_board_type := (
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,1,1,1,1,1,1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0),  
		(0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0) 
   );
	
	signal x_position: INTEGER range 0 to 30;
	signal y_position: INTEGER range 0 to 27;
	
	constant START_X 	  : INTEGER := 192;	
	constant END_X  	  : INTEGER := 1088;
	constant START_Y 	  : INTEGER := 16;
	constant END_Y 	  : INTEGER := 1008;
	
	signal out_board_x, out_board_y: STD_LOGIC := '1';
	
	signal cout_pixel_x_block, cout_pixel_y_block : INTEGER range 0 to 31 := 0;
	
begin
	
	process(clk)
	begin
		if reset = '1' then
			pixel_color = 0;
		elsif rising_edge then
			if out_board_x or out_board_y then
				pixel_color = 0;			
			elsif pacman_board(x_position)(y_position) = 1 then
				pixel_color <= block_board(cout_pixel_y_block)(cout_pixel_x_block);
			end if;
			
			
		end if;
	end process;

--	0 - vazio
--	1 - azul
--	2 - amarelo
--	3 - branco
--	4 - rosa
--	5 - ciano
--	6 - vermelho
	block_print_controller: process(clk)
	begin
		if reset = '1' then
			cout_pixel_x_block <= 0;
			cout_pixel_y_block <= 0;
		elsif rising_edge(clk) then
			if pixel_x = START_X then
				cout_pixel_x_block <= 0;
			else
				cout_pixel_x_block <= cout_pixel_x_block + 1;
			end if;
			
			if pixel_y = START_Y then
				cout_pixel_y_block <= 0;
			elsif pixel_x = END_X then
				cout_pixel_y_block <= cout_pixel_y_block + 1;
			end if;
		end if;
	end process;

	positon: process(clk)
		variable var_x_position, var_y_position, start_position_x, start_position_y : INTEGER range 0 to 30;
		--variable var_x_position_std, var_y_position_std: STD_LOGIC_VECTOR(31 downto 0);
		variable var_aux_x, var_aux_y        : STD_LOGIC_VECTOR(31 downto 0);
	begin
		if reset = '1' then
			out_board_x = '1';
			out_board_y = '1';
		elsif rising_edge(clk) then
		
			if pixel_x < START_X or pixel_x > END_X then
				out_board_x <= '1';
				x_position <= 0;
				
			else 
				out_board_x <= '0';
				
				--start_position_x := x_position - START_X;
				var_aux_x := conv_std_logic_vector(x_position - START_X, 32);
				var_x_position_std := "00000" & var_aux_x(31 downto 5);
				var_x_position := conv_integer(unsigned(var_x_position_std));
				
				x_position <= var_x_position;
			end if;
			
			if pixel_y < START_Y or pixel_y > END_Y then
				out_board_y <= '1';
				y_position <= 0;;
				
			else 
				out_board_y <= '0';
				
				--var_y_position :=  (y_position - START_Y) srl 5;
				--start_position_y := y_position - START_Y;
				var_aux_y := conv_std_logic_vector(y_position - START_Y, 32);
				var_y_position_std := "00000" & var_aux_y(31 downto 5);
				var_y_position := conv_integer(unsigned(var_y_position_std));
				
				y_position <= var_y_position;
			end if; 
			
		end if;
	end process;

end Behavioral;