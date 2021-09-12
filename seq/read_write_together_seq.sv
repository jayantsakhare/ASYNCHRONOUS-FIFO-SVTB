class read_write_together_seq extends base_seq;

    function new (fifo_writer writer, fifo_reader reader);
        super.new(writer, reader);
    endfunction

    task body();
        super.body();
        $info("RD_WR_TOGETHER_SEQ:BODY BEGIN");
        write();
        fork 
            read();
            write();
        join
        $info("RD_WR_TOGETHER_SEQ:BODY END");
    endtask

endclass