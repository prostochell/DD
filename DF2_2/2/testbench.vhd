-- ==============================================================================
-- AI-generated testbench for quick verification.
-- Target: reg_4b_syn
-- ==============================================================================

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_reg_4b_syn is
end tb_reg_4b_syn;

architecture behavior of tb_reg_4b_syn is

    -- 1. Оголошення вашого компонента
    component reg_4b_syn
        port(
            D      : in  std_logic_vector(3 downto 0);
            clk    : in  std_logic;
            reset  : in  std_logic;
            enable : in  std_logic;
            Q      : out std_logic_vector(3 downto 0)
        );
    end component;

    -- 2. Внутрішні сигнали
    signal D        : std_logic_vector(3 downto 0) := (others => '0');
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal enable   : std_logic := '0';
    signal Q        : std_logic_vector(3 downto 0);

    -- Сигнал для безпечної зупинки симуляції (сумісно з VHDL-93)
    signal sim_done : boolean := false; 

    constant clk_period : time := 10 ns;

begin

    -- 3. Підключення вашого дизайну
    uut: reg_4b_syn
        port map (
            D      => D,
            clk    => clk,
            reset  => reset,
            enable => enable,
            Q      => Q
        );

    -- 4. Генерація тактового сигналу (зупиниться, коли sim_done стане true)
    clk_process: process
    begin
        while not sim_done loop
            clk <= '0';
            wait for clk_period / 2;
            clk <= '1';
            wait for clk_period / 2;
        end loop;
        wait; -- Зупиняє процес назавжди після виходу з циклу
    end process;

    -- 5. Генерація тестових сигналів
    stim_proc: process
    begin
        report "--- SIMULATION START ---";
        
        wait for clk_period;

        -- Тест 1: Перевірка синхронного скидання (reset)
        reset <= '1';
        enable <= '0';
        D <= "1010";
        wait for clk_period;
        report "Test 1 (Sync Reset): Expected Q = 0000";
        assert Q = "0000" report "Error in Test 1: Reset failed!" severity error;

        -- Тест 2: Вимкнений Enable 
        reset <= '0';
        enable <= '0';
        D <= "1100";
        wait for clk_period;
        report "Test 2 (Enable = 0): Expected Q = 0000 (Hold)";
        assert Q = "0000" report "Error in Test 2: Value changed when enable was 0!" severity error;

        -- Тест 3: Увімкнений Enable
        enable <= '1';
        D <= "1100";
        wait for clk_period;
        report "Test 3 (Enable = 1): Expected Q = 1100";
        assert Q = "1100" report "Error in Test 3: Load failed!" severity error;

        -- Тест 4: Зміна даних
        D <= "0101";
        wait for clk_period;
        report "Test 4 (Change Data): Expected Q = 0101";
        assert Q = "0101" report "Error in Test 4: Data update failed!" severity error;

        -- Тест 5: Пріоритет reset над Enable
        reset <= '1';
        enable <= '1';
        D <= "1111";
        wait for clk_period;
        report "Test 5 (Sync Reset Priority): Expected Q = 0000";
        assert Q = "0000" report "Error in Test 5: Sync reset failed to override enable!" severity error;

        report "--- SIMULATION SUCCESSFULLY COMPLETED ---";
        
        -- Даємо команду зупинити генератор тактових імпульсів
        sim_done <= true; 
        wait;
    end process;

end behavior;