library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity counter_3b is
    port (
        clk : in std_logic;
        reset : in std_logic;
        enable : in std_logic;
        count : out std_logic_vector(2 downto 0)
    );
end counter_3b;


architecture ripple_arch of counter_3b is
    signal q_int : std_logic_vector(2 downto 0) := "000";
begin

    FF0_PROC: process (clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                q_int(0) <= '0';
            else
                if enable = '1' then
                    q_int(0) <= not q_int(0);
                end if;
            end if;
        end if;
    end process;

    FF1_PROC: process (q_int(0), reset)
    begin

        if reset = '1' then
            q_int(1) <= '0';
        elsif falling_edge(q_int(0)) then
            q_int(1) <= not q_int(1);
        end if;
    end process;

    FF2_PROC: process (q_int(1), reset)
    begin
        if reset = '1' then
            q_int(2) <= '0';
        elsif falling_edge(q_int(1)) then
            q_int(2) <= not q_int(2);
        end if;
    end process;

    count <= q_int;

end architecture;


/*
architecture counter_3b_arch of counter_3b is
    signal count_uns : unsigned(2 downto 0) := "000";
begin

    COUNT_PROC: process (clk)
    begin
        if rising_edge(clk) then

            if reset = '1' then
                count_uns <= "000";

            elsif enable = '1' then
                count_uns <= count_uns + 1;
            end if;

        end if;
    end process;

    count <= std_logic_vector(count_uns);

end architecture;
*/