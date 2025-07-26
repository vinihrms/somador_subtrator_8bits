entity mux2x8 is
    port(
        a  : in  bit_vector (7 downto 0);
        b  : in  bit_vector (7 downto 0);
        sel : in  bit;
        y : out bit_vector (7 downto 0)   -- saída por comando de seleção
    );
end entity;

architecture comuta of mux2x8 is
begin
    -- comando vhdl de seleção de sinais
    y <= a when sel = '0' else b;

end architecture;
