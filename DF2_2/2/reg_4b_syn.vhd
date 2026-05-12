library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity reg_4b_syn is
    port (
        D   : in  std_logic_vector (3 downto 0);
        CLK : in  std_logic;
        R   : in  std_logic;
        EN  : in  std_logic;
        Q   : out std_logic_vector (3 downto 0)
    );
end reg_4b_syn;

architecture behavior of reg_4b_syn is
begin
    REG_PROC: process (CLK) 
    begin
        if rising_edge(CLK) then 
            if (R = '1') then
                Q <= x"0";
            elsif (EN = '1') then
                Q <= D;
            end if;
            
        end if;
    end process;

end architecture;