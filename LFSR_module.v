//Author : Ishaan Sethi
//Module for a simple 32 bit LFSR - Linear feedback shift register.

module LFSR (input clock,
             input reset, //Active reset, set state to 0.
             input enable, //Freeze register state when low.
             output [31:0] out_seq, //To generate random 32-bit sequence.
             output  out_bit); //To generate a random binary digit.
  
  parameter nbit = 32; //32 bits used.
  
  //32 bit Register initialization.
  reg [nbit-1:0] LFSR;
  
  //Certain outputs are connected to the LSB through a 4-input XNOR gate. This is what gives the LFSR the ability to generate pseudo-random sequences.
  wire feedbackpath;
  
  //Maximal state coverage can be acheived when the tap locations relate to the exponents of a primitive polynomial. 
  assign feedbackpath = ~(LFSR[nbit-1] ^ LFSR[22-1] ^ LFSR[2-1] ^ LFSR[1-1]);
  
  //Data is shifted at each rising edge.
  always @(posedge clock) begin
    
    //When Reset is high, reset the state to all zeros.
    if (reset) begin
      LFSR <= 'b0;
    end
    
    //If the LFSR is enabled, shift data forward and take input from the feedback path.
    else if (enable) begin
      LFSR <= {LFSR[nbit-2:0],feedbackpath}; 
    end
    
    //Disabled LFSR doesn't change state.
    else begin
      LFSR <= LFSR;
    end
    
  end
  
  //Connecting outputs.
  assign out_seq = LFSR;
  assign out_bit = LFSR[nbit-1];
  
endmodule