class fifo_env;

    fifo_reader rdr;
    fifo_writer wrtr;

    base_seq seq;

    mailbox #(fifo_tran) wrt2sb;
    mailbox #(fifo_tran) rdr2sb;

    fifo_sb sb;

    virtual fifo_wif.WR_MP wif;
    virtual fifo_rif.RD_MP rif;

    function new (virtual fifo_wif.WR_MP fifo_wif,virtual fifo_rif.RD_MP fifo_rif);
        this.wif=fifo_wif;
        this.rif=fifo_rif;
        wrt2sb=new(8);
        rdr2sb=new(8);
        sb=new(wrt2sb,rdr2sb);
        rdr=new(this.rif,this.rdr2sb,this.sb);
        wrtr=new(this.wif,this.wrt2sb,this.sb);
        seq=new(this.wrtr,this.rdr);
        
    endfunction

    function void get_seq(base_seq seq);
        this.seq=seq;
        this.seq.writer=this.wrtr;
        this.seq.reader=this.rdr;
    endfunction

    task start();
        seq.body();
        sb.compare();
    endtask

endclass
