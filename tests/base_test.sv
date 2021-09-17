// base test class 

`ifndef GUARD_BASE_TEST
`define GUARD_BASE_TEST

class base_test;
    
    fifo_env env;
    virtual fifo_wif.WR_MP wif;
    virtual fifo_rif.RD_MP rif;
    base_seq seq;

    function new (virtual fifo_wif.WR_MP wif,virtual fifo_rif.RD_MP rif);
        this.wif=wif;
        this.rif=rif;        
        env=new(wif,rif);
        seq=new();
        env.get_seq(seq);
    endfunction

    task start();
        env.start();
    endtask

endclass
`endif
