library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux_2_1_a is
    port (
        A : in std_logic;
        B : in std_logic;
        SEL : in std_logic;
        Y : out std_logic);
end mux_2_1_a;

architecture arch_mux_2_1 of mux_2_1_a is
begin
    with (sel) select
    Y <= A when '0',
        B when '1',
        'X' when others;
end architecture;