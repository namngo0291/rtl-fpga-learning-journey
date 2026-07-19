`timescale 1ns/1ps

module tb_mux2_1;

reg a;
reg b;
reg sel;
wire y;

mux2_1 uut (
    .a(a),
    .b(b),
    .sel(sel),
    .y(y)
);

initial begin
    a = 0; b = 0; sel = 0;
    #10 a = 1; b = 0; sel = 0;
    #10 a = 0; b = 1; sel = 1;
    #10 a = 1; b = 0; sel = 1;
    #10 a = 1; b = 1; sel = 0;
    #10 $finish;
end

endmodule
