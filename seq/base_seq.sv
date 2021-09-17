//base sequence class
// performs reset

`ifndef GUARD_BASE_SEQ
`define GUARD_BASE_SEQ

class base_seq;

    fifo_writer writer;
    fifo_reader reader;
   
    function new (fifo_writer writer=null, fifo_reader reader=null);
        this.reader=reader;
        this.writer=writer;
    endfunction

    //calls reader & writer reset
    task reset();
        fork
            this.writer.reset();
            this.reader.reset();
        join
            @(reader.rif.RD);
    endtask

    //calls writer write
   task write(int n);
    this.writer.write(n);
   endtask

   //calls reader read
   task read(int n);
    this.reader.read(n);
   endtask

   //sequence body
   virtual task body();
    $info("BASE_SEQ::BODY BEGIN");
        reset();
    $info("BASE_SEQ::BODY END");
   endtask

endclass
`endif