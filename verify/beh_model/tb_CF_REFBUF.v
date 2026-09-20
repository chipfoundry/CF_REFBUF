`timescale 1ns / 1ps

module tb_CF_REFBUF;
    integer errors;

    reg vpwr;
    reg vgnd;
    reg vpwre;
    reg ng;
    reg pd;
    reg switchon;
    reg boost;
    reg ch_cont;
    reg nbias;
    wire out;
    wire switchoff;
    wire ch1;
    wire ch2;
    wire ref_1v2;

    CF_REFBUF u_buf (
        .out(out),
        .switchoff(switchoff),
        .pd(pd),
        .switchon(switchon),
        .boost(boost),
        .ch_cont(ch_cont),
        .ch1(ch1),
        .ch2(ch2),
        .ref_1v2(ref_1v2),
        .nbias(nbias),
        .ng(ng),
        .vpwr(vpwr),
        .vpwre(vpwre),
        .vgnd(vgnd)
    );

    task expect_v;
        input real got;
        input real exp;
        input real tol;
        input [8*32-1:0] tag;
        begin
            if (got < exp - tol || got > exp + tol) begin
                $display("FAIL %s got=%g exp=%g", tag, got, exp);
                errors = errors + 1;
            end else begin
                $display("PASS %s %g", tag, got);
            end
        end
    endtask

    initial begin
        errors = 0;
        vpwr = 1'b1;
        vgnd = 1'b0;
        vpwre = 1'b1;
        ng = 1'b1;
        pd = 1'b0;
        switchon = 1'b1;
        boost = 1'b0;
        ch_cont = 1'b0;
        nbias = 1'b1;
        u_buf.u_core.ref_1v2_v = 1.2;
        #1;
        expect_v(u_buf.u_core.out_v, 1.2, 1e-9, "follow 1.2");
        if (out !== 1'b1) begin
            $display("FAIL out pin not driven");
            errors = errors + 1;
        end
        if (switchoff !== 1'b0) begin
            $display("FAIL switchoff expected 0 when switchon");
            errors = errors + 1;
        end

        u_buf.u_core.ref_1v2_v = 1.0;
        #1;
        expect_v(u_buf.u_core.out_v, 1.0, 1e-9, "follow 1.0");

        pd = 1'b1;
        #1;
        expect_v(u_buf.u_core.out_v, 0.0, 1e-12, "pd");
        if (out !== 1'b0) begin
            $display("FAIL out pin not low in pd");
            errors = errors + 1;
        end

        pd = 1'b0;
        switchon = 1'b0;
        #1;
        expect_v(u_buf.u_core.out_v, 0.0, 1e-12, "switchon low");
        if (switchoff !== 1'b1) begin
            $display("FAIL switchoff expected 1 when switchon low");
            errors = errors + 1;
        end

        if (errors == 0)
            $display("CF_REFBUF behavioral self-check passed");
        else
            $display("CF_REFBUF behavioral self-check FAILED %0d", errors);
        $finish(errors != 0);
    end
endmodule
