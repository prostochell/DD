library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2_1_b is
    port (
        A : in std_logic;
        B : in std_logic;
        SEL : in std_logic;
        Y : out std_logic);
end mux_2_1_b;

architecture arch_mux_2_1 of mux_2_1_b is
begin
    Y <= A when SEL = '0' else B;
end architecture;В