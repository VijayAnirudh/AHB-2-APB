// Code your testbench here
// or browse Examples
`timescale 1ns/1ps
module tb;
//----------------------AHB Slave Interface---------------------
reg HCLK, HRESETn, HSELAPB, HWRITE;
reg [1:0]HTRANS;
reg [31:0]HADDR, HWDATA;
wire HRESP;
wire [31:0]HRDATA;
//-----------------------APB Output Signals---------------------
reg [31:0]PRDATA;
wire PSEL, PENABLE, PWRITE, HREADY; 
wire [31:0]PADDR, PWDATA;
always #1 HCLK=~HCLK;
initial
begin
  $dumpfile("dump.vcd");
 $dumpvars;
end
initial
begin
 //--------------------Single Read Transfer--------------------
 HCLK=1'b1;
 HRESETn=1'b0;
 #2 HRESETn=1'b1;
 HWRITE=1'b0;
 HSELAPB=1'b1;
 HTRANS=2'b10;
 HADDR=32;
 #2.1 HWRITE=1'bx;
 HSELAPB=1'b0;
 HTRANS=2'bxx;
 HADDR=32'hxxxx_xxxx;
 #1.9 PRDATA=16;
 #200 $finish;
 
end
ahb2apb DUT(HCLK, HRESETn, HSELAPB, HADDR, HWRITE, HTRANS, 
HWDATA, HRESP, HRDATA, HREADY, PRDATA, PSEL, PENABLE, 
PADDR, PWRITE, PWDATA);
endmodule
