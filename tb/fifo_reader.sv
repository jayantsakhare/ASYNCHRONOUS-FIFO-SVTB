class fifo_reader #(parameter DSIZE=8);

    virtual fifo_rif.RD_MP rif;
    fifo_tran txn;
    fifo_mbox rdr2sb;
    fifo_sb sb;
    function new (virtual fifo_rif.RD_MP fifo_rif, fifo_mbox rdr2sb, fifo_sb sb);
        this.rif=fifo_rif;
        this.rdr2sb=rdr2sb;
        this.sb=sb;
    endfunction

    task read(int n);
        $info("READER::READ BEGIN");
        txn=new();
		repeat(n)
        begin
			@(negedge rif.rclk iff (rif.RD.rempty==1'b0))
            rif.RD.rinc<=1'b1;
            @(rif.RD);
            txn.data=rif.RD.rdata;
            txn.display("reader"); 
            rdr2sb.put(txn);
            sb.sb_read();
        end
        rif.RD.rinc<=1'b0;
        $info("READER::READ END");
    endtask

    task reset();
        $info("READER::RESET BEGIN");
        @(rif.RD);
        rif.RD.rrst_n<=1'b0;
        @(rif.RD);
        rif.RD.rrst_n<=1'b1;
        $info("READER::RESET END");
    endtask

endclass