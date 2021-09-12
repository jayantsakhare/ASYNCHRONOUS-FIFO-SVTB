import fifo_pkg::*;

`include "fifo_wif.sv"
`include "fifo_rif.sv"
`include "base_test.sv"
module top();

    bit rclk_top;
    bit wclk_top;


    //top clock generation
    //read clock
    initial begin
        forever begin
            #5 rclk_top=~rclk_top;
        end
    end
    //write clock
    initial begin
        forever begin
            #3 wclk_top=~wclk_top;
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
    base_test TEST(fifo_wif.WR_MP, fifo_rif.RD_MP);


    //FSDB Dump
    initial begin
        $fsdbDumpfile("dump.fsdb");
        $fsdbDumpvars();
    end

    initial begin
        #100;
        $finish;
    end

endmodule
