class base_seq;

    fifo_writer writer;
    fifo_reader reader;
   
    
    function new (fifo_writer writer=null, fifo_reader reader=null);
        this.reader=reader;
        this.writer=writer;
    endfunction

    task reset();
        fork
            this.writer.reset();
            this.reader.reset();
        join
            @(reader.rif.RD);
    endtask

   task write(int n);
    this.writer.write(n);
   endtask

   task read(int n);
    this.reader.read(n);
   endtask

   virtual task body();
    $info("BASE_SEQ::BODY BEGIN");
        reset();
        //write();
        //read();
    $info("BASE_SEQ::BODY END");
   endtask


endclass