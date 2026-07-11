// Project : Traffic Light Controller using Moore FSM
// Author  : Sahasra Putta
// Description:
// Controls a two-road traffic junction using a Moore FSM.
// Each road alternates between Green, Yellow and Red lights
// based on a programmable timer

// Traffic Light Controller Module
module trafficlight_FSM(
input clk,
input reset,
output reg A_GREEN_TIME,
output reg A_YELLOW_TIME,
output reg A_RED_TIME,
output reg B_GREEN_TIME,
output reg B_YELLOW_TIME,
output reg B_RED_TIME
);
// State Encoding
localparam A_GREEN = 2'b00;
localparam A_YELLOW = 2'b01;
localparam B_GREEN = 2'b10;
localparam B_YELLOW = 2'b11;
// Traffic Light Timing Parameters
localparam GREEN_TIME = 4'd9;
localparam YELLOW_TIME = 4'd2;
// Present State and Next State Registers
reg[1 : 0]state;
reg[1 : 0]next_state;
// State Register
// Updates the current state on every rising edge of the clock.
// On reset, FSM starts from Road A Green state
always @(posedge clk or posedge reset)
begin
if (reset)
 state <= A_GREEN;
 else 
 state <= next_state;
end
// Timer Counter
// Counts the number of clock cycles spent in each state.
reg [3:0]counter;
// Counter Logic
// Resets when the state duration expires,
// otherwise increments every clock cycle.
always @(posedge clk or posedge reset)
begin 
if (reset)
 counter <= 4'b0000;
 else if ( (state==A_GREEN && counter==GREEN_TIME) ||    
  (state==A_YELLOW && counter==YELLOW_TIME ) ||
  (state==B_GREEN && counter==GREEN_TIME) ||
  (state==B_YELLOW && counter==YELLOW_TIME ) )
 counter <= 4'b0000;
 else 
 counter <= counter +1;
end
// Next State Logic
// Determines the next traffic light state
// based on the current state and timer value.
always @(*)
begin
next_state = state;
case(state)
A_GREEN:
begin
if (counter >= GREEN_TIME )
 next_state= A_YELLOW;
end
A_YELLOW: 
begin
if ( counter >= YELLOW_TIME )
 next_state = B_GREEN;
end 
B_GREEN: 
begin
if ( counter >= GREEN_TIME )
 next_state = B_YELLOW;
end
B_YELLOW: 
begin
if (counter >= YELLOW_TIME )
next_state = A_GREEN; 
end 
endcase
end
// Output Logic (Moore FSM)
// Outputs depend only on the current state.
always @(*)
begin
// FSM Sequence
// A_GREEN -> A_YELLOW -> B_GREEN -> B_YELLOW -> A_GREEN
case(state)
 A_GREEN:
 begin
  A_GREEN_TIME=1;
  A_YELLOW_TIME=0;
  A_RED_TIME=0;
  B_GREEN_TIME=0;
  B_YELLOW_TIME=0;
  B_RED_TIME=1;
  end
 A_YELLOW:
 begin
  A_GREEN_TIME=0;
  A_YELLOW_TIME=1;
  A_RED_TIME=0;
  B_GREEN_TIME=0;
  B_YELLOW_TIME=0;
  B_RED_TIME=1;
  end
 B_GREEN:
 begin
  A_GREEN_TIME=0;
  A_YELLOW_TIME=0;
  A_RED_TIME=1;
  B_GREEN_TIME=1;
  B_YELLOW_TIME=0;
  B_RED_TIME=0;
  end
 B_YELLOW:
 begin
  A_GREEN_TIME=0;
  A_YELLOW_TIME=0;
  A_RED_TIME=1;
  B_GREEN_TIME=0;
  B_RED_TIME=0;
  B_YELLOW_TIME=1;
  end  
 default :  
 begin
  A_GREEN_TIME=0;
  A_YELLOW_TIME=0;
  A_RED_TIME=1;
  B_GREEN_TIME=0;
  B_RED_TIME=1;
  B_YELLOW_TIME=0;
  end
 endcase
end 
endmodule

module trafficlight_FSM_tb;
reg clk;
reg reset;
wire A_GREEN_TIME;
wire A_YELLOW_TIME;
wire A_RED_TIME;
wire B_RED_TIME;
wire B_GREEN_TIME;
wire B_YELLOW_TIME;
// Instantiate Design Under Test (DUT)
trafficlight_FSM dut(
.clk(clk),
.reset(reset),
.A_GREEN_TIME(A_GREEN_TIME),
.A_YELLOW_TIME(A_YELLOW_TIME),
.A_RED_TIME(A_RED_TIME),
.B_GREEN_TIME(B_GREEN_TIME),
.B_YELLOW_TIME(B_YELLOW_TIME),
.B_RED_TIME(B_RED_TIME)
);
// Clock Generation
initial
begin
 clk = 0;
 forever 
 #5 clk= ~clk;
end
// Reset Generation
initial
begin 
 reset = 1;
 #10;
 reset = 0;
end
// Stop Simulation
initial
begin
#330;
$finish;
end
// Display Internal Signals
initial
begin
$monitor(
"Time=%0t State=%b Counter=%d AGT=%b AYT=%b ART=%b BGT=%b BYT=%b BRT=%b",
$time,
dut.state,
dut.counter,
A_GREEN_TIME,A_YELLOW_TIME,A_RED_TIME,B_GREEN_TIME,B_YELLOW_TIME,B_RED_TIME
);
end
endmodule



           