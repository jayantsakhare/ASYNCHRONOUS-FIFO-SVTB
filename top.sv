//top file includes
//  1. FIFO DUT instance
//  2. Clock generation
//  3. test class instance
//  4. Interface instances  

`ifndef GUARD_TOP
`define GUARD_TOP

import fifo_pkg::*;

`include "fifo_wif.sv"
`include "fifo_rif.sv"
`include "reset_in_between_test.sv"
module top();

    bit rclk_top;
    bit wclk_top;


    //top clock generation
    //read clock
    initial begin
        forever begin
            #50 rclk_top=~rclk_top;
        end
    end
    //write clock
    initial begin
        forever begin
            #30 wclk_top=~wclk_top;
        end
    end


    //interface instances
    fifo_wif #(.DSIZE(8)) fifo_wif(.wclk(wclk_top));
    fifo_rif #(.DSIZE(8)) fifo_rif(.rclk(rclk_top));

    //DUT instance
    beh_fifo FIFO(
                .rdata(fifo_rif.rdata),
                .wfull(fifo_wif.wfull),
                .rempty(fifo_rif.rempty),
                .wdata(fifo_wif.wdata),
                .winc(fifo_wif.winc), 
                .wclk(wclk_top), 
                .wrst_n(fifo_wif.wrst_n),
                .rinc(fifo_rif.rinc), 
                .rclk(rclk_top), 
                .rrst_n(fifo_rif.rrst_n)
            );

    //testcase instance
    reset_in_between_test test;


    //FSDB Dump
    initial begin
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars();
    end

    initial begin
        test=new(fifo_wif.WR_MP, fifo_rif.RD_MP);
        fork
            begin
                test.start();
                #50;
            end
            #2000;
        join_any
        $finish;
    end

endmodule
`endif 
