//FIFO read interface

`ifndef GUARD_RIF
`define GUARD_RIF

interface fifo_rif #(parameter DSIZE=8) (input logic rclk);
    logic rinc;
    logic rrst_n;
    logic [DSIZE-1:0] rdata;
    logic rempty;

    clocking RD @(negedge rclk);
       default input #1ns output #1ns;
        input rdata;
        output rinc;
        output rrst_n;
        input rempty;
    endclocking

    modport RD_MP(clocking RD, input rclk);

endinterface
`endif