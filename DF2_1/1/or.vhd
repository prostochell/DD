library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity or_gate is
    port (
        A : in std_logic;
        B : in std_logic;
        Y : out std_logic);

end or_gate;

architecture arch_or_gate of or_gate is

begin
    Y <= A or B;

end architecture;