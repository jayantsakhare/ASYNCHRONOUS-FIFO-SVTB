program base_test (fifo_wif.WR_MP wif,fifo_rif.RD_MP rif);
    
    fifo_env env;

    write_read_seq seq;

    task start();
        run();
        env.start();
    endtask

    function void run();
        env=new(wif,rif);
        seq=new();
        env.get_seq(seq);
    endfunction

    initial begin
        start();
    end
endprogram
