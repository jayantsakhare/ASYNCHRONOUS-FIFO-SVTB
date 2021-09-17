//reset during write seq
    //resets paralley with write operation

`ifndef GUARD_RST_WRITE
`define GUARD_RST_WRITE

class reset_during_write_seq extends base_seq;

    function new (fifo_writer writer, fifo_reader reader);
        super.new(writer, reader);
    endfunction

    task body();
        super.body();
        $info("RST_DURING_WR_SEQ:BODY BEGIN");
        write();
        fork
            write();
            reset();
        join
        $info("RST_DURING_WR_SEQ:BODY END");
    endtask

endclass
`endif