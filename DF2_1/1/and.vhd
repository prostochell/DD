entity and_gate is
        port(A : in  bit;
             B : in  bit;
             Y : out bit);

end and_gate;

architecture arch_and_gate of and_gate is

    begin
        Y <= A and B; 

end architecture;
