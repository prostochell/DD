library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_counter_3bit is
end tb_counter_3bit;

architecture behavior of tb_counter_3bit is

    -- 1. Оголошення вашого компонента
    component counter_3b
        port(
            clk    : in  std_logic;
            reset  : in  std_logic;
            enable : in  std_logic;
            count  : out std_logic_vector(2 downto 0)
        );
    end component;

    -- 2. Внутрішні сигнали
    signal clk      : std_logic := '0';
    signal reset    : std_logic := '0';
    signal enable   : std_logic := '0';
    signal count    : std_logic_vector(2 downto 0);

    -- Сигнал для безпечної зупинки симуляції (сумісно з VHDL-93)
    signal sim_done : boolean := false; 

    constant clk_period : time := 10 ns;

begin

    -- 3. Підключення вашого дизайну
    uut: counter_3b
        port map (
            clk    => clk,
            reset  => reset,
            enable => enable,
            count  => count
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
        wait;
    end process;

    -- 5. Генерація тестових сигналів
    stim_proc: process
    begin
        report "--- SIMULATION START ---";
        
        -- Чекаємо один такт для ініціалізації
        wait for clk_period;

        -- Тест 1: Перевірка скидання (Reset)
        reset <= '1';
        enable <= '0';
        wait for clk_period;
        report "Test 1 (Reset): Expected count = 000";
        assert count = "000" report "Error in Test 1: Reset failed!" severity error;

        -- Тест 2: Вимкнений Enable (Лічильник не повинен рахувати)
        reset <= '0';
        enable <= '0';
        wait for clk_period;
        report "Test 2 (Enable = 0): Expected count = 000 (Hold)";
        assert count = "000" report "Error in Test 2: Counter changed when enable was 0!" severity error;

        -- Тест 3: Увімкнений Enable (Має порахувати до 1)
        enable <= '1';
        wait for clk_period;
        report "Test 3 (Count = 1): Expected count = 001";
        assert count = "001" report "Error in Test 3: Failed to count to 1!" severity error;

        -- Тест 4: Рахуємо далі до максимуму (чекаємо 6 тактів: 2, 3, 4, 5, 6, 7)
        wait for clk_period * 6;
        report "Test 4 (Count = 7): Expected count = 111";
        assert count = "111" report "Error in Test 4: Failed to reach max value (7)!" severity error;

        -- Тест 5: Переповнення (Rollover). Наступний такт має скинути лічильник в 000
        wait for clk_period;
        report "Test 5 (Rollover): Expected count = 000";
        assert count = "000" report "Error in Test 5: Rollover failed!" severity error;

        -- Тест 6: Пріоритет Reset під час рахування
        wait for clk_period * 3; -- Даємо дорахувати до 3 (011)
        reset <= '1';            -- Раптово активуємо Reset
        wait for clk_period;
        report "Test 6 (Reset Priority): Expected count = 000";
        assert count = "000" report "Error in Test 6: Reset failed to clear counter!" severity error;

        report "--- SIMULATION SUCCESSFULLY COMPLETED ---";
        
        -- Безпечна зупинка генератора тактових імпульсів
        sim_done <= true; 
        wait;
    end process;

end behavior;