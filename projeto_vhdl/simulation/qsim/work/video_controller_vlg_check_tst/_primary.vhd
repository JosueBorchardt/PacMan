library verilog;
use verilog.vl_types.all;
entity video_controller_vlg_check_tst is
    port(
        pixel_x         : in     vl_logic_vector(10 downto 0);
        pixel_y         : in     vl_logic_vector(9 downto 0);
        vga_HS          : in     vl_logic;
        vga_VS          : in     vl_logic;
        sampler_rx      : in     vl_logic
    );
end video_controller_vlg_check_tst;
