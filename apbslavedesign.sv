// Code your design here
module apbslave(
  input pclk,
  input prstn,
  input [31:0] pwdata,
  input [7:0] paddr,
  input psel,
  input penable,
  input pwrite,
  output reg [31:0] prdata
);
  
  
  reg [31:0] mem [0:255];
  
  reg [1:0] state;
  reg [1:0] idle;
  reg [1:0] setup;
  reg [1:0] write;
  reg [1:0] read;
  
  always @(posedge pclk or negedge prstn)
    begin
      if(!prstn) begin
        prdata <= 0;
      end else begin
        case(state)
          idle : begin
            prdata <= 0;
            state <= setup;
          end
          setup : begin
            prdata <= 0;
            if(psel & !penable) begin
              if(pwrite) begin
                state <= write;
              end else begin
                state <= read;
              end
            end
          end
          write : begin
            if(psel & penable & pwrite) begin
              mem[paddr] <= pwdata;
            end
            state <= setup;
          end
          read : begin
            if(psel & penable & !pwrite) begin
              prdata <= mem[paddr];
            end
            state <= setup;
          end
        endcase
      end
    end
endmodule
          
            

  
