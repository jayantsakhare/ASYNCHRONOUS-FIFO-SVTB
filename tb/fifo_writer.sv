class fifo_writer;

    virtual fifo_wif.WR_MP wif;
    fifo_mbox wrt2sb;
    fifo_sb sb;

    function new(virtual fifo_wif.WR_MP fifo_wif,fifo_mbox wrt2sb,fifo_sb sb);
        this.wif=fifo_wif;
        this.wrt2sb=wrt2sb;
        this.sb=sb;
    endfunction

    task write();
        fifo_tran txn;
        $display("FIFO_WRITER:WRITE BEGIN");
        txn=new();
        txn.randomize();
        txn.display("writer");
        wif.WR.winc<=1'b1;
        wif.WR.wdata<=txn.data;
        wrt2sb.put(txn);
        sb.sb_write();
        @(wif.WR);
        wif.WR.winc<=1'b0;
        wif.WR.wdata<=7'b0;
        $display("FIFO_WRITER:WRITE END");
    endtask

    task reset();
        $display("FIFO_WRITER:RESET BEGIN");
        @(wif.WR);
        wif.WR.wrst_n<=1'b0;
        @(wif.WR);
        wif.WR.wrst_n<=1'b1; 
        $display("FIFO_WRITER:RESET END");
    endtask

endclass