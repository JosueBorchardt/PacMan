library verilog;
use verilog.vl_types.all;
entity video_controller_vlg_sample_tst is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        sampler_tx      : out    vl_logic
    );
end video_controller_vlg_sample_tst;
