library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity p_add_sub is
    generic (
        N : integer := 2); --Count of input bits

    port (
        A     : in  std_logic_vector (N - 1 downto 0);
        B     : in  std_logic_vector (N - 1 downto 0);
        Sub_b : in  std_logic;
        Res   : out std_logic_vector (N - 1 downto 0));

end p_add_sub;

architecture p_add_sub_arch of p_add_sub is

    signal B_xor   : std_logic_vector(N - 1 downto 0);
    signal Sub_vec : std_logic_vector(N - 1 downto 0);
    signal Sub_pad : signed(N - 1 downto 0);

begin
    Sub_vec <= (others => Sub_b);

    B_xor <= B xor Sub_vec;

    Sub_pad <= (0 => Sub_b, others => '0');

    Res <= std_logic_vector(signed(A) + signed(B_xor) + Sub_pad);

end architecture;