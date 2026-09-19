// tb.v
// self checking tb for alu.v

module tb;

reg [3:0] t_a,t_b;
reg t_op;
wire [3:0] t_result;

alu dut(.a(t_a),.b(t_b),.op(t_op),.result(t_result));

function [3:0] expected;
input [3:0] a,b;
input op;
begin
if(op==0)
expected=a+b;
else
expected=a-b;
end
endfunction

initial begin

$display("\n=== Testing Sensitivity List (Bug 1) ===");

t_a=4'd5;
t_b=4'd3;
t_op=0;
#5;

$display("a=%d b=%d op=0 (add): result=%d, expected=%d %s",
t_a,t_b,t_result,expected(t_a,t_b,0),
(t_result==expected(t_a,t_b,0))?"✓ PASS":"✗ FAIL");

t_op=1;
#5;

$display("a=%d b=%d op=1 (sub): result=%d, expected=%d %s",
t_a,t_b,t_result,expected(t_a,t_b,1),
(t_result==expected(t_a,t_b,1))?"✓ PASS":"✗ FAIL");


$display("\n=== Testing Subtract Path (Bug 2) ===");

t_op=1;

t_a=4'd7;
t_b=4'd3;
#5;
$display("a=%d b=%d op=1 (sub): result=%d, expected=%d %s",
t_a,t_b,t_result,expected(t_a,t_b,1),
(t_result==expected(t_a,t_b,1))?"✓ PASS":"✗ FAIL");

t_a=4'd12;
t_b=4'd5;
#5;
$display("a=%d b=%d op=1 (sub): result=%d, expected=%d %s",
t_a,t_b,t_result,expected(t_a,t_b,1),
(t_result==expected(t_a,t_b,1))?"✓ PASS":"✗ FAIL");

t_a=4'd4;
t_b=4'd9;
#5;
$display("a=%d b=%d op=1 (sub): result=%d, expected=%d %s",
t_a,t_b,t_result,expected(t_a,t_b,1),
(t_result==expected(t_a,t_b,1))?"✓ PASS":"✗ FAIL");


$display("\n=== Testing Add Path (should pass) ===");

t_op=0;
t_a=4'd6;
t_b=4'd9;
#5;

$display("a=%d b=%d op=0 (add): result=%d, expected=%d %s",
t_a,t_b,t_result,expected(t_a,t_b,0),
(t_result==expected(t_a,t_b,0))?"✓ PASS":"✗ FAIL");

$finish;
end

initial
$monitor($time," a=%d b=%d op=%b | result=%d (expected=%d)",
t_a,t_b,t_op,t_result,expected(t_a,t_b,t_op));

endmodule
