library verilog;
use verilog.vl_types.all;
entity video_controller is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        vga_HS          : out    vl_logic;
        vga_VS          : out    vl_logic;
        pixel_x         : out    vl_logic_vector(10 downto 0);
        pixel_y         : out    vl_logic_vector(9 downto 0)
    );
end video_controller;
