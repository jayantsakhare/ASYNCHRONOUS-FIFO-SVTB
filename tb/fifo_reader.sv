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

    task read();
        $info("READER::READ BEGIN");
        txn=new();
        wait(!rif.RD.rempty)
        begin
            @(rif.RD);
            rif.RD.rinc<=1'b1;
            txn.data<=rif.RD.rdata;
            @(rif.RD);
            rif.RD.rinc<=1'b0;
            txn.display("reader"); 
            rdr2sb.put(txn);
            sb.sb_read();
            $info("READER::READ END");
        end
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