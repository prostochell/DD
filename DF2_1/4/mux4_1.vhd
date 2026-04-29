library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity mux4_1 is
    port (
        A : in std_logic;
        B : in std_logic;
        C : in std_logic;
        D : in std_logic;
        Sel : in std_logic_vector (1 downto 0);
        Y : out std_logic);
end mux4_1;

architecture arch_mux_4_1 of mux4_1 is

begin
    with (sel) select
    Y <= A when "00",
        B when "01",
        C when "10",
        D when "11";
end architecture;