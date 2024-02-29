
        module tb;
        reg clock;
        reg reset;
        reg a;
        reg b;

        NOI dut (.clock(clock),
                    .reset(reset),
                    .a(a),
                    .b(b));

        always #5 clock = ~clock;

        initial begin
            reset <= 1;
            {clock, a, b} <= 0;

            repeat(2) @(posedge clock);
            reset <= 0;
            
            // Bitvector execution
    
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
                a <= 0;
                b <= 0;
                @(posedge clock);
        
            repeat(2) @(posedge clock);
            #20 $finish;
        end
        endmodule
    