//Author : Ishaan Sethi
//Testbench for the LFSR module.
module LFSR_tb ();
  
  //I/O declarations.
  reg clk, rst, en;
  wire [31:0] outseq;
  wire outbit;
  
  initial begin
    //For use with EPWave/GTKwave.
    $dumpfile("dump.vcd");
    $dumpvars;

    //Initialization.
	clk = 1'b1;
    rst = 1'b1;
    en  = 1'b1;
    
    //Sequence of input variations to observe functionality. 
    #10  rst = 1'b0;
    #400 en  = 1'b0;
    #20  en  = 1'b1;
    #50  $finish;
    
  end
  
  always #1 clk = ~clk; //Clock Period set to 1 unit.

  LFSR LFSRtb(.clock(clk),
              .reset(rst),
              .enable(en),
              .out_seq(outseq),
              .out_bit(outbit));
               
endmodule