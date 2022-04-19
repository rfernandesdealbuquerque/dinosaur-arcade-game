module dffe_ref(q, d, clk, en, clr);

    input d, clk, en, clr;
        
    output q;
    
    reg q;
    
    initial 
    begin
        q = 1'b0;
    end 
    
    always @(posedge clk or posedge clr) begin
    
        if (clr) begin
            q <= 1'b0;
        
        end else if (en) begin
            q <= d;
        end
    end        
   
endmodule 