// Verilog HDL for "CF_REFBUF", "CF_REFBUF" "behavioral"
// Blackbox stub for top-level integration. Analog behavior is not modeled.
// Ports match public abstract MACRO CF_REFBUF and timing/lib/CF_REFBUF_*.lib.

module CF_REFBUF (
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

    assign out = ~pd & switchon & vpwr;
    assign switchoff = 1'b0;

endmodule
