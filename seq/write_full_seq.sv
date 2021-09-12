class write_full_seq extends base_seq;

    function new (fifo_writer writer, fifo_reader reader);
        super.new(writer, reader);
    endfunction

    task body();
        super.body();
        $info("WR_FULL_SEQ:BODY BEGIN");
        repeat(8)
            write();
        read();
        $info("WR_FULL_SEQ:BODY END");
    endtask

endclass