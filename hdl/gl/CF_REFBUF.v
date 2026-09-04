// Verilog HDL for "CF_REFBUF", "CF_REFBUF" "behavioral"
// Blackbox stub for top-level integration. Analog behavior is not modeled.
// Ports match public abstract MACRO CF_REFBUF.

module CF_REFBUF (
    out,
    bias_out,
    switchoff,
    PD,
    PDB,
    swon,
    hys_buf_bar,
    nbias,
    ref1v2,
    ng,
    vpwr,
    vpwre,
    vgnd,
    vpb,
    vpbe,
    vnb
);
    output out;
    output bias_out;
    output switchoff;
    input PD;
    input PDB;
    input swon;
    input hys_buf_bar;
    input nbias;
    input ref1v2;
    input ng;
    input vpwr;
    input vpwre;
    input vgnd;
    input vpb;
    input vpbe;
    input vnb;

    assign out = ~PD & swon & vpwr;
    assign bias_out = ~PD & vpwr;
    assign switchoff = 1'b0;

endmodule
