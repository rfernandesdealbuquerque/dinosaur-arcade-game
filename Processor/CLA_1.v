module CLA_1(x, y, cin, sum);
    input x, y, cin;
    output sum;

    xor sum_results(sum, x, y, cin);

endmodule