//write read sequence 
    //perform 3 reads and 3 writes

`ifndef GUARD_WR_RD_SEQ
`define GUARD_WR_RD_SEQ 

class write_read_seq extends base_seq;

    function new (fifo_writer writer=null, fifo_reader reader=null);
        super.new(writer, reader);
    endfunction

    virtual task body();
        super.body();
        $info("WR_RD_SEQ:BODY BEGIN");
        fork
            begin
                write(3);
            end
            begin
                read(3);
            end
        join
        $info("WR_RD_SEQ:BODY END");
    endtask

endclass
`endif