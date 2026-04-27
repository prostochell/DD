entity mux4_1 is 
    port (A, B, C, D : in bit;
          Sel : in bit_vector (1 downto 0);
          Y  : out);
end mux4_1;

architecture arch_mux_4_1 of mux4_1 is

    begin
        with (sel) select
         Y <= A when "00",
              B when "01",
              C when "10",
              D when "11";
end architecture;