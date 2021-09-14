class write_read_seq extends base_seq;

    function new (fifo_writer writer=null, fifo_reader reader=null);
        super.new(writer, reader);
    endfunction

    virtual task body();
        super.body();
        $info("WR_RD_SEQ:BODY BEGIN");
        write();
        read();
        $info("WR_RD_SEQ:BODY END");
    endtask

endclass