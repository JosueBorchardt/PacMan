library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

package components is

		-- Components
		
		component pll_108MHZ
			Port (
				areset		: IN STD_LOGIC  := '0'; -- Reset assíncrono
				inclk0		: IN STD_LOGIC  := '0'; -- Clock de entrada
				c0				: OUT STD_LOGIC ;			-- Clock de saída gerado pelo PLL	
				locked		: OUT STD_LOGIC         -- Indica se o PLL está estável
			);
		end component;
		
		component video_controller
			Port (
				clk       : in  STD_LOGIC;
				reset     : in  STD_LOGIC;
				vga_HS    : out STD_LOGIC;
				vga_VS    : out STD_LOGIC;
				pixel_x   : out INTEGER range 0 to 1279;
				pixel_y   : out INTEGER range 0 to 1023
			);
		end component;

		component board
			Port (
			clk       : in  STD_LOGIC;
			reset     : in  STD_LOGIC;
			pixel_x   : in INTEGER range 0 to 1279;
			pixel_y   : in INTEGER range 0 to 1023;	
			--vga_R, vga_G, vga_B: out STD_LOGIC_VECTOR(9 downto 0)
			pixel_color: out INTEGER range 0 to 6
			--vga_HS    : out STD_LOGIC;
			--vga_VS    : out STD_LOGIC;
			);
		end component;
		
end package;