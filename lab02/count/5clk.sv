module cnt(input clk, input rst, input bt_add, input bt_sub, input el_add, input el_sub, output logic [7:0] leds);
always @(posedge bt_add, posedge bt_sub, negedge el_add,negedge el_sub, posedge rst)
    begin
        if(rst)
            leds <= 8'b0;
        else if(bt_add)
                leds <= leds+1'b1;
        else if(bt_sub)
                leds <= leds-1'b1;
        else if(~el_add)
                leds <= leds+1'b1;
        else if(~el_sub)
                leds <= leds-1'b1;
    end
endmodule
