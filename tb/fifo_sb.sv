//scoreboard class

`ifndef GUARD_SB
`define GUARD_SB

class fifo_sb;

    fifo_mbox wrt2sb;
    fifo_mbox rdr2sb;

    fifo_tran r_txn,r_txn_temp;
    fifo_tran w_txn,w_txn_temp;

    //queues to store read and write received transactions
    fifo_tran wr_q[$];
    fifo_tran rd_q[$]; 

    function new (fifo_mbox wrt2sb, fifo_mbox rdr2sb);
        this.wrt2sb=wrt2sb;
        this.rdr2sb=rdr2sb;
    endfunction

    //gets read data from reader and copies to queue
    task sb_read();
        r_txn=new();
        rdr2sb.get(r_txn_temp);
		r_txn.data=r_txn_temp.data;
        rd_q.push_back(r_txn);
    endtask

    //gets write data from writer and copies to queue
    task sb_write();
        w_txn=new();
        wrt2sb.get(w_txn_temp);
		w_txn.data=w_txn_temp.data;
        wr_q.push_back(w_txn);
    endtask

    //compares collected write and read data
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
`endif