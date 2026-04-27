entity mux_2_1 is
    port(   A, B, SEL : in bit;
                    Y : out bit);
end mux_2_1;

architecture arch_mux_2_1 of mux_2_1 is
    begin
        Y <= (A and not(SEL)) or (B and SEL);
end architecture; 
