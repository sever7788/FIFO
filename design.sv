module FIFO
  #(parameter width = 4, length = 5
)
 (
    input logic clk,
    input logic rstn,
    input logic push,
    input logic pop,
    input logic [width-1:0] data,
    output logic full,
    output logic empty,
    output logic [width-1:0] SRAM [length-1:0],
    output logic [width-1:0] out
);
    localparam ptr_len = $clog2(length);

    //logic [length-1:0] SRAM [width-1:0];
    logic [ptr_len - 1:0] pop_ptr;
    logic [ptr_len - 1:0] push_ptr;
    logic [ptr_len - 1:0] pop_ptr_next;
    logic [ptr_len - 1:0] push_ptr_next;
    logic flg;
    logic ptr_equal;

    always_ff @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            for(int i = 0; i < length; i++)
                SRAM[i]  <= '0;
            pop_ptr  <= '0;
            push_ptr <= '0;
            flg <= 1'b0;
        end else begin
            push_ptr <= push_ptr_next;
            pop_ptr  <= pop_ptr_next;
            if(!full && push) begin
                SRAM[push_ptr] <= data;
            end
            if(pop && !empty) begin

            end
            if(push_ptr_next == pop_ptr_next) begin
                if(push)
                    flg <= 1'b1;
            end else if(pop)
                flg <= 1'b0;
        end
    end

    always_comb begin
        push_ptr_next = (!full && push) ? ((push_ptr == (length - 1)) ? '0 : push_ptr + 1) : push_ptr;
        pop_ptr_next =  (pop && !empty) ? ((pop_ptr == (length - 1)) ? '0 : pop_ptr + 1) : pop_ptr;
        ptr_equal = push_ptr == pop_ptr;
        empty = ptr_equal && !flg;
        full  = ptr_equal && flg;
        out = empty ? '0 : SRAM[pop_ptr];
    end
endmodule