entity f_adder_1b is
    port (A, B, C_in : in bit;
            S, C_out : out bit);
end f_adder_1b;

architecture arch_f_adder_1b of f_adder_1b is
    signal n1 : bit;
    begin
        n1 <= A xor B;
        S <= n1 xor C_in;
        C_out <= (A and B) or (n1 and C_in);

end architecture;
