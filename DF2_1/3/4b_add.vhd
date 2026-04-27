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

entity f_adder_4b is
    port (    A, B : in  bit_vector (3 downto 0); 
                 S : out bit_vector (3 downto 0);
             C_out : out bit);
end f_adder_4b;

architecture arch_f_adder_4b of f_adder_4b is

    component f_adder_1b 
        port (A, B, C_in : in  bit;
                S, C_out : out bit);
        end component;

    signal C1, C2, C3 : bit;

    begin
        A0 : f_adder_1b port map (A(0), B(0), '0', S(0), C1);
        A1 : f_adder_1b port map (A(1), B(1),  C1, S(1), C2);
        A2 : f_adder_1b port map (A(2), B(2),  C2, S(2), C3);
        A3 : f_adder_1b port map (A(3), B(3),  C3, S(3), C_out);

end architecture;