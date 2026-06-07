library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity p_add_sub is
    generic (
        N     : integer := 2);

    port (
        A     : in std_logic_vector (N - 1 downto 0);
        B     : in std_logic_vector (N - 1 downto 0);
        Sub_b : in std_logic;
        Res   : out std_logic_vector (N - 1 downto 0));

end p_add_sub;

architecture p_add_sub_arch of p_add_sub is

    signal B_xor : std_logic_vector(N - 1 downto 0);
    signal C     : std_logic_vector(N downto 0);
    --signal Sub_vec : std_logic_vector(N - 1 downto 0);
    --signal Sub_pad : signed(N - 1 downto 0);

begin

    gen_b : for i in 0 to N - 1 generate
        B_xor(i) <= B(i) xor Sub_b;
    end generate;

    C(0) <= Sub_b;

    gen_add : for i in 0 to N - 1 generate
        f_add_inst : entity work.f_adder_1b
        port map(
            A     => A(i),
            B     => B_xor(i),
            C_in  => C(i),
            S     => Res(i),
            C_out => C(i + 1)
        );
    end generate;

end architecture;


/* OLD
    Sub_vec <= (others => Sub_b);

    B_xor <= B xor Sub_vec;

    Sub_pad <= (0 => Sub_b, others => '0');

    Res <= std_logic_vector(signed(A) + signed(B_xor) + Sub_pad);
    */