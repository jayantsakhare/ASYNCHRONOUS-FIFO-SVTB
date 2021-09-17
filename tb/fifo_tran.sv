//fifo transaction class

`ifndef GUARD_TRAN
`define GAURD_TRAN

class fifo_tran #(parameter DSIZE=8);

    rand logic [DSIZE-1:0] data;

    //displays the transaction data
    function void display(string name="");
        $display("%s:%t FIFO_TRANS DATA=%d",name,$time,this.data);
    endfunction

endclass
`endif