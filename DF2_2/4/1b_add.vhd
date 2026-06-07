library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity f_adder_1b is
    port (
        A : in std_logic;
        B : in std_logic;
        C_in : in std_logic;
        S : out std_logic;
        C_out : out std_logic);
end f_adder_1b;

architecture arch_f_adder_1b of f_adder_1b is
    signal n1 : std_logic;
begin
    n1 <= A xor B;
    S <= n1 xor C_in;
    C_out <= (A and B) or (n1 and C_in);

end architecture;