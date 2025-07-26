entity inversor_8bits is
    port(
        y     : in  bit_vector(7 downto 0);
        nao_y : out bit_vector(7 downto 0)
    );
end entity;

architecture inversor of inversor_8bits is
begin
    nao_y <= not y;
end architecture;

        