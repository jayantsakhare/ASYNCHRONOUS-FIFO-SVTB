package fifo_pkg;
    `include "fifo_tran.sv"
    typedef mailbox #(fifo_tran) fifo_mbox;
    `include "fifo_sb.sv"
    `include "fifo_writer.sv"
    `include "fifo_reader.sv"
    `include "base_seq.sv"
    `include "fifo_env.sv"
    `include "write_read_seq.sv"
    `include "reset_in_between_seq.sv"
endpackage
