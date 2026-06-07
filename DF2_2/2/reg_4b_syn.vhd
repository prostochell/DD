library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_4b_syn is
    port (
        D : in std_logic_vector (3 downto 0);
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        Q : out std_logic_vector (3 downto 0)
    );
end reg_4b_syn;

architecture arch_reg_4b_syn of reg_4b_syn is
begin
    REG_PROC : process (clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then
                Q <= (others => '0');
            else
                if (enable = '1') then
                    Q <= D;
                end if;
            end if;

        end if;
    end process;

end architecture;