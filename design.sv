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
    logic ptr_equal;

    always_ff @(posedge clk or negedge rstn) begin
        if(!rstn) begin
            for(int i = 0; i < length; i++)
                SRAM[i]  <= '0;
            empty    <=  1;
            pop_ptr  <= '0;
            push_ptr <= '0;
        end else begin
            if(!full && push) begin
                SRAM[push_ptr] <= data;
                push_ptr <= push_ptr == (length - 1) ? '0 : push_ptr + 1;
                empty <= 0;
            end
            if(pop && !empty) begin
                pop_ptr <= pop_ptr == (length - 1) ? '0 : pop_ptr + 1;
            end
        end
    end

    always_ff @(posedge ptr_equal) begin
        if(pop)
            empty <= 1;
    end

    assign ptr_equal = push_ptr == pop_ptr;
    assign full  = ptr_equal && !empty;
    assign out = empty ? '0 : SRAM[pop_ptr];
endmodule