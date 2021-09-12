class fifo_tran #(parameter DSIZE=8);

    rand logic [DSIZE-1:0] data;

    function void display(string name="");
        $display("%s:%t FIFO_TRANS DATA=%d",name,$time,this.data);
    endfunction

endclass