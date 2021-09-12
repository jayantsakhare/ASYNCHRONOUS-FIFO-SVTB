interface fifo_wif #(parameter DSIZE=8) (input logic wclk);
logic [DSIZE-1:0] wdata;
logic winc;
logic wrst_n;
logic wfull;

clocking WR @(posedge wclk);
    default input #1ps output #1ps;
    output wdata;
    output winc, wrst_n;
    input wfull;
endclocking

modport WR_MP (clocking WR,input wclk);

endinterface // fifo_wif