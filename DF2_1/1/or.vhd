entity or_gate is
        port(A : in  bit;
             B : in  bit;
             Y : out bit);

end or_gate;

architecture arch_or_gate of or_gate is

    begin
        Y <= A or B; 

end architecture;
