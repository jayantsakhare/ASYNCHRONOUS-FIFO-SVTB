//fifo writer agent class 

`ifndef GUARD_WRITER
`define GUARD_WRITER

class fifo_writer;

    virtual fifo_wif.WR_MP wif;
    fifo_mbox wrt2sb;
    fifo_sb sb;

    function new(virtual fifo_wif.WR_MP fifo_wif,fifo_mbox wrt2sb,fifo_sb sb);
        this.wif=fifo_wif;
        this.wrt2sb=wrt2sb;
        this.sb=sb;
    endfunction

    //writes n transactions to DUT
    task write(int n);
        fifo_tran txn;
        $display("%t FIFO_WRITER:WRITE BEGIN %d",$realtime,n);
        txn=new();
		@(wif.WR);
        wif.WR.winc<=1'b1;
		repeat(n)
		begin
        txn.randomize();
        txn.display("writer");
        wif.WR.wdata<=txn.data;
			@(wif.WR);
        wrt2sb.put(txn);
        sb.sb_write();
		end
        wif.WR.winc<=1'b0;
        $display("%t FIFO_WRITER:WRITE END",$realtime);
    endtask

    //resets the write side
    task reset();
        $display("FIFO_WRITER:RESET BEGIN");
        @(wif.WR);
        wif.WR.wrst_n<=1'b0;
        @(wif.WR);
        wif.WR.wrst_n<=1'b1; 
        $display("FIFO_WRITER:RESET END");
    endtask

endclass
`endif