interface fifo_rif #(parameter DSIZE=8) (input logic rclk);
    logic rinc;
    logic rrst_n;
    logic [DSIZE-1:0] rdata;
    logic rempty;

    clocking RD @(posedge rclk);
       default input #1ps output #1ps;
        input rdata;
        output rinc;
        output rrst_n;
        input rempty;
    endclocking

    modport RD_MP(clocking RD, input rclk);

endinterface