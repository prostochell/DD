library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity and_gate is
    port (
        A : in STD_LOGIC;
        B : in STD_LOGIC;
        Y : OUT STD_LOGIC);

end and_gate;

architecture arch_and_gate of and_gate is

begin
    Y <= A and B;

end architecture;