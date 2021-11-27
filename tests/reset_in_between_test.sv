//

`ifndef __RESET_IN_BETWEEN_TEST_SV
`define __RESET_IN_BETWEEN_TEST_SV

class reset_in_between_test;

    fifo_env env;
    virtual fifo_wif.WR_MP wif;
    virtual fifo_rif.RD_MP rif;
    reset_in_between_seq seq;

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
