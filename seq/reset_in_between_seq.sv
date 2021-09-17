//reset in between sequence
    //resets FIFO between reads & writes

`ifndef GUARD_RST_IN_BETWN
`define GUARD_RST_IN_BETWN

class reset_in_between_seq extends base_seq;

    function new (fifo_writer writer, fifo_reader reader);
        super.new(writer, reader);
    endfunction

    task body();
        super.body();
        $info("RST_IN_BETWEEN_SEQ:BODY BEGIN");
            write();
            read();
            reset();
            write();
            read();
        $info("RESET_IN_BETWEEN_SEQ:BODY END");
    endtask

endclass
`endif