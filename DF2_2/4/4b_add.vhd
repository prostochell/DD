library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity f_adder_4b is
    port (
        A : in std_logic_vector (3 downto 0);
        B : in std_logic_vector (3 downto 0);
        S : out std_logic_vector (3 downto 0);
        C_out : out std_logic);
end f_adder_4b;

architecture arch_f_adder_4b of f_adder_4b is

    signal C1 : std_logic;
    signal C2 : std_logic;
    signal C3 : std_logic;
    
begin
    A0 : entity work.f_adder_1b port map(A(0),
                                         B(0), 
                                         '0', 
                                         S(0), 
                                         C1);
    A1 : entity work.f_adder_1b port map(A(1), 
                                         B(1), 
                                         C1, 
                                         S(1),
                                         C2);
    A2 : entity work.f_adder_1b port map(A(2), 
                                         B(2), 
                                         C2, 
                                         S(2), 
                                         C3);
    A3 : entity work.f_adder_1b port map(A(3), 
                                         B(3), 
                                         C3, 
                                         S(3), 
                                         C_out);

end architecture;