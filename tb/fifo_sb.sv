class fifo_sb;

    fifo_mbox wrt2sb;
    fifo_mbox rdr2sb;

    fifo_tran r_txn;
    fifo_tran w_txn;

    //ques to store read and write received transactions
    fifo_tran wr_q[$];
    fifo_tran rd_q[$]; 

    function new (fifo_mbox wrt2sb, fifo_mbox rdr2sb);
        this.wrt2sb=wrt2sb;
        this.rdr2sb=rdr2sb;
    endfunction

    task sb_read();
        r_txn=new();
        rdr2sb.get(r_txn);
        rd_q.push_back(r_txn);
    endtask

    task sb_write();
        w_txn=new();
        wrt2sb.get(w_txn);
        wr_q.push_back(w_txn);
    endtask

    function compare();
        if(wr_q.size()!=rd_q.size()) begin
            $warning("SB:COMPARE QUEUE SIZES DO NOT MATCH");
            return 0;
        end
        else begin
            foreach(wr_q[i]) begin
                if(wr_q[i].data!=rd_q[i].data) begin
                    $warning("SB:COMPARE %d index does not match %b %b",i,wr_q[i].data,rd_q[i].data);
                end else begin
                    $info("SB:COMPARE %d index match %b %b",i,wr_q[i].data,rd_q[i].data);
                end
            end
        end 
    endfunction


endclass