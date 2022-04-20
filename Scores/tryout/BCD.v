module BCD(
    q, 

    clk, // scoring clock, debate whether to add 
    en, // end of life
    clr // end of life -- collision signal
);


    output [31:0] q; // 5 x 4 bits

    input clk, en, clr;  

    reg[3:0] q7, q6, q5, q4, q3, q2, q1, q0; // 5 bits - 4 MSB, 0 LSB

    initial 
    begin
        q7 = 4'b0000;
        q6 = 4'b0000;
        q5 = 4'b0000;
        q4 = 4'b0000;
        q3 = 4'b0000;
        q2 = 4'b0000;
        q1 = 4'b0000;
        q0 = 4'b0000;
    end 

    always @(posedge clk)
    begin
        if (clr) begin
            q7 <= 4'b0000;
            q6 <= 4'b0000;
            q5 <= 4'b0000;
            q4 <= 4'b0000;
            q3 <= 4'b0000;
            q2 <= 4'b0000;
            q1 <= 4'b0000;
            q0 <= 4'b0000;
        end
        else if (en) begin

            //q0
            if (q0 < 9) begin 
                q0 <= q0 + 1;
            end
            else begin

                // q1
                if (q1 < 9) begin
                    q1 <= q1 + 1;
                end
                else begin

                    // q2
                    if (q2 < 9) begin
                        q2 <= q2 + 1;
                    end
                    else begin

                        // q3 
                        if (q3 < 9) begin
                            q3 <= q3 + 1;
                        end
                        else begin

                            // q4
                            if (q4 < 9) begin
                                q4 <= q4 + 1;
                            end
                            else begin

                                // q5
                                if (q5 < 9) begin
                                    q5 <= q5 + 1;
                                end
                                else begin

                                    //q6
                                    if (q6 < 9) begin
                                        q6 <= q6 + 1;
                                    end
                                    else begin

                                        //q7
                                        if (q7 < 9) begin
                                            q7 <= q7 + 1;
                                        end
                                        else begin
                                            q7 <= 4'b0;
                                        end

                                        q6 <= 4'b0;
                                    end

                                    q5 <= 4'b0;
                                end

                                q4 <= 4'b0;
                            end
                            
                            q3 <= 4'b0;
                        end

                        q2 <= 4'b0;
                    end

                    q1 <= 4'b0;
                end

                q0 <= 4'b0;
            end
        end
        // q0 <= clr? 0 : ((q0 < 9)? q0 + 1 : 0);
        // q1 <= clr? 0 : ((q0 < 9)? q1 : ((q1 < 9) ? (q1 + 1) : 0));
    end

    assign q[31:28] = q7;
    assign q[27:24] = q6;
    assign q[23:20] = q5;
    assign q[19:16] = q4;
    assign q[15:12] = q3;
    assign q[11:8]  = q2;
    assign q[7:4]   = q1;
    assign q[3:0]   = q0;
    
endmodule 