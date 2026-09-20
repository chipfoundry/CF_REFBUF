`timescale 1ns / 1ps

// Ideal functional model of analog leaf CF_REFBUF_core.
// Drop this file in place of hdl/gl/CF_REFBUF_core.v for simulation.
// Do not add it to OpenLane VERILOG_FILES.
//
// Analog voltages are Verilog real backdoors (1-bit pins stay digital):
//   ref_1v2_v, out_v
//
// Assumed protocol (ideal, not silicon-verified):
//   * pd high or switchon low → output off, out_v = 0, out is 0
//   * else out_v follows ref_1v2_v (unity)
//   * switchoff is ~switchon
// Boost, channel mux, and analog accuracy are not modeled.

module CF_REFBUF_core (
    out,
    switchoff,
    pd,
    switchon,
    boost,
    ch_cont,
    ch1,
    ch2,
    ref_1v2,
    nbias,
    ng,
    vpwr,
    vpwre,
    vgnd,
    vpb,
    vpbe,
    vnb
);
    output out;
    output switchoff;
    input pd;
    input switchon;
    input boost;
    input ch_cont;
    input ch1;
    input ch2;
    input ref_1v2;
    input nbias;
    input ng;
    input vpwr;
    input vpwre;
    input vgnd;
    input vpb;
    input vpbe;
    input vnb;

    localparam real V_PRESENT = 0.05;
    localparam real REF_DEFAULT = 1.2;

    real ref_1v2_v;
    real out_v;

    wire active = ~pd & switchon;

    initial begin
        ref_1v2_v = REF_DEFAULT;
        out_v = 0.0;
    end

    always @(*) begin
        if (active)
            out_v = ref_1v2_v;
        else
            out_v = 0.0;
    end

    assign out = (active && (out_v > V_PRESENT)) ? 1'b1 : 1'b0;
    assign switchoff = ~switchon;
endmodule
