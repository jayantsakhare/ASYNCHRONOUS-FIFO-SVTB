//read fifo till empty toggles

`ifndef GUARD_RD_EMPTY
`define GUARD_RD_EMPTY

class read_empty_seq extends base_seq;

    function new (fifo_writer writer, fifo_reader reader);
        super.new(writer, reader);
    endfunction

    task body();
        super.body();
        $info("RD_EMPTY_SEQ:BODY BEGIN");
        repeat(8)
            write();
        repeat(8)
            read();
        $info("RD_EMPTY_SEQ:BODY END");
    endtask

endclass
`endif