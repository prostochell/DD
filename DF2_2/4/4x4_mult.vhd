    library ieee;
    use ieee.std_logic_1164.all;
    use ieee.numeric_std.all;

    entity mult_4x4 is
        port (
            A : in std_logic_vector(3 downto 0);
            B : in std_logic_vector(3 downto 0);
            P : out std_logic_vector(7 downto 0)
        );
    end mult_4x4;

    architecture mult_4x4_arch of mult_4x4 is

        type pp_matrix is array (0 to 3) of std_logic_vector(3 downto 0);
        signal PP : pp_matrix;

        type sum_matrix is array (0 to 2) of std_logic_vector(3 downto 0);
        signal S_out  : sum_matrix;              
        signal Add_in : sum_matrix;             
        signal C_out  : std_logic_vector(0 to 2);

    begin

        GEN_PP_ROW : for i in 0 to 3 generate
            GEN_PP_COL : for j in 0 to 3 generate
                PP(i)(j) <= A(j) and B(i);
            end generate GEN_PP_COL;
        end generate GEN_PP_ROW;

        P(0) <= PP(0)(0);

        GEN_ADDERS: for i in 0 to 2 generate

            GEN_IN0: if i = 0 generate
                Add_in(i) <= '0' & PP(0)(3 downto 1);
            end generate;

            GEN_IN_REST: if i > 0 generate
                Add_in(i) <= C_out(i-1) & S_out(i-1)(3 downto 1);
            end generate;

            adder_inst: entity work.f_adder_4b
                port map (
                    A     => Add_in(i),
                    B     => PP(i + 1),
                    S     => S_out(i),
                    C_out => C_out(i)
                );

            P(i + 1) <= S_out(i)(0);

        end generate GEN_ADDERS;

        P(4) <= S_out(2)(1);
        P(5) <= S_out(2)(2);
        P(6) <= S_out(2)(3);
        P(7) <= C_out(2);

    end architecture;


    /*
    architecture mult_4x4_arch of mult_4x4 is

        type signal_matrix is array (0 to 3) of std_logic_vector(3 downto 0);

        signal PP : signal_matrix;
        signal S : signal_matrix;
        signal C : signal_matrix;

        signal X_in : signal_matrix;
        signal Y_in : signal_matrix;
        signal C_in : signal_matrix;

    begin

        GEN_PP_ROW : for i in 0 to 3 generate
            GEN_PP_COL : for j in 0 to 3 generate
                PP(i)(j) <= A(j) and B(i);
            end generate GEN_PP_COL;
        end generate GEN_PP_ROW;
        S(0) <= PP(0);
        C(0) <= "0000";
        GEN_ROWS : for i in 1 to 3 generate
            GEN_COLS : for j in 0 to 3 generate

                X_in(i)(j) <= PP(i)(j);

                GEN_Y_REGULAR : if j < 3 generate
                    Y_in(i)(j) <= S(i - 1)(j + 1);
                end generate GEN_Y_REGULAR;

                GEN_Y_LAST : if j = 3 generate
                    Y_in(i)(j) <= C(i - 1)(3);
                end generate GEN_Y_LAST;
                GEN_CIN_FIRST : if j = 0 generate
                    C_in(i)(j) <= '0';
                end generate GEN_CIN_FIRST;

                GEN_CIN_REGULAR : if j > 0 generate
                    C_in(i)(j) <= C(i)(j - 1);
                end generate GEN_CIN_REGULAR;
                S(i)(j) <= X_in(i)(j) xor Y_in(i)(j) xor C_in(i)(j);
                C(i)(j) <= (X_in(i)(j) and Y_in(i)(j)) or
                (C_in(i)(j) and (X_in(i)(j) xor Y_in(i)(j)));

            end generate GEN_COLS;
        end generate GEN_ROWS;

        P(0) <= S(0)(0);
        P(1) <= S(1)(0);
        P(2) <= S(2)(0);
        P(3) <= S(3)(0);

        P(4) <= S(3)(1);
        P(5) <= S(3)(2);
        P(6) <= S(3)(3);
        P(7) <= C(3)(3);

    end Structural;
    */