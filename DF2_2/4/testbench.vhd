library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity tb_array_multiplier is
end tb_array_multiplier;

architecture behavior of tb_array_multiplier is

    -- 1. Оголошення вашого компонента
    component mult_4x4
        port(
            A       : in  std_logic_vector(3 downto 0);
            B       : in  std_logic_vector(3 downto 0);
            P : out std_logic_vector(7 downto 0)
        );
    end component;

    -- 2. Внутрішні сигнали
    signal A       : std_logic_vector(3 downto 0) := (others => '0');
    signal B       : std_logic_vector(3 downto 0) := (others => '0');
    signal P : std_logic_vector(7 downto 0);

begin

    -- 3. Підключення вашого дизайну
    uut: mult_4x4
        port map (
            A       => A,
            B       => B,
            P => P
        );

    -- 4. Генерація тестових сигналів
    stim_proc: process
    begin
        report "--- SIMULATION START ---";
        wait for 10 ns;

        -- Тест 1: Перевірка нулів (0 x 0)
        A <= std_logic_vector(to_unsigned(0, 4));
        B <= std_logic_vector(to_unsigned(0, 4));
        wait for 10 ns;
        report "Test 1 (0 x 0): Expected Product = 0";
        assert to_integer(unsigned(P)) = 0 report "Error in Test 1: 0 x 0 failed!" severity error;

        -- Тест 2: Максимальні значення (15 x 15 = 225)
        A <= std_logic_vector(to_unsigned(15, 4));
        B <= std_logic_vector(to_unsigned(15, 4));
        wait for 10 ns;
        report "Test 2 (15 x 15): Expected Product = 225";
        assert to_integer(unsigned(P)) = 225 report "Error in Test 2: Max value multiplication failed!" severity error;

        -- Тест 3: Випадкові значення (10 x 5 = 50)
        A <= std_logic_vector(to_unsigned(10, 4));
        B <= std_logic_vector(to_unsigned(5, 4));
        wait for 10 ns;
        report "Test 3 (10 x 5): Expected Product = 50";
        assert to_integer(unsigned(P)) = 50 report "Error in Test 3: 10 x 5 failed!" severity error;

        -- Тест 4: Випадкові значення (7 x 3 = 21)
        A <= std_logic_vector(to_unsigned(7, 4));
        B <= std_logic_vector(to_unsigned(3, 4));
        wait for 10 ns;
        report "Test 4 (7 x 3): Expected Product = 21";
        assert to_integer(unsigned(P)) = 21 report "Error in Test 4: 7 x 3 failed!" severity error;

        -- Тест 5: Множення на 1 (1 x 12 = 12)
        A <= std_logic_vector(to_unsigned(1, 4));
        B <= std_logic_vector(to_unsigned(12, 4));
        wait for 10 ns;
        report "Test 5 (1 x 12): Expected Product = 12";
        assert to_integer(unsigned(P)) = 12 report "Error in Test 5: Multiply by 1 failed!" severity error;

        report "--- SIMULATION SUCCESSFULLY COMPLETED ---";
        
        -- Зупинка симуляції (для комбінаційної логіки достатньо просто wait)
        wait;
    end process;

end behavior;