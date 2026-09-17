// tb.v
// Testbench for lut.v -- instantiates with a parameter override
// (WIDTH=8, DEPTH=8) different from the module's defaults, then
// walks every address checking dout against the expected i*i value.

module tb;

reg  [2:0] t_sel;   // 3 bits comfortably covers DEPTH up to 8
wire [7:0] t_dout;

lut #(.WIDTH(8), .DEPTH(8)) U1 (
    .sel  (t_sel),
    .dout (t_dout)
  );

integer i;
integer expected;

initial begin
  for (i = 0; i < 8; i = i + 1) begin
    t_sel = i;
    #5;
    expected = i * i;
    if (t_dout !== expected)
      $display("MISMATCH: sel=%0d dout=%0d expected=%0d", t_sel, t_dout, expected);
    else
      $display("OK: sel=%0d dout=%0d", t_sel, t_dout);
  end
  $finish;
end

// Waveform dump configuration (DO NOT CHANGE)
string vcd_file;
initial begin
if ($value$plusargs("vcd=%s", vcd_file)) begin
$dumpfile(vcd_file);
$dumpvars(0, U1);
end
end

initial
    $monitor($time, " sel=%0d | dout=%0d", t_sel, t_dout);

endmodule