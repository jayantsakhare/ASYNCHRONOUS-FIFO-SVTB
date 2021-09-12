class reset_during_read_seq extends base_seq;

    function new (fifo_writer writer, fifo_reader reader);
        super.new(writer, reader);
    endfunction

    task body();
        super.body();
        $info("RST_DURING_RD_SEQ:BODY BEGIN");
        write();
        fork
            read();
            reset();
        join
        $info("RST_DURING_RD_SEQ:BODY END");
    endtask

endclass