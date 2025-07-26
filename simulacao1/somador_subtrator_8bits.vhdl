entity somador_subtrator_8bits is
    port(
        a        : in  bit_vector(7 downto 0);
        b        : in  bit_vector(7 downto 0);
        sel      : in  bit;
        s        : out bit_vector(7 downto 0);
        overflow : out bit
    );
end entity;

architecture estrutural of somador_subtrator_8bits is
    component soma_8b is 
        port(
            c_in  : in  bit;
            a : in  bit_vector(7 downto 0);
            b : in  bit_vector(7 downto 0);
            s     : out bit_vector(7 downto 0);
            c_out : out bit
        );
    end component;
    
    component mux2x8 is 
        port(
            a   : in  bit_vector(7 downto 0);
            b   : in  bit_vector(7 downto 0);
            sel : in  bit;
            y   : out bit_vector(7 downto 0)
        );
    end component;
    
    component inversor_8bits is
        port(
            y     : in  bit_vector(7 downto 0);
            nao_y : out bit_vector(7 downto 0)
        );
    end component;
    
    signal b_ou_nao_b : bit_vector(7 downto 0);
    signal nao_b    : bit_vector(7 downto 0);
begin
    -- inversor de 8 bits para inverter o b em caso de subtracao
    u_inversor : inversor_8bits port map(
        y     => b,
        nao_y => nao_b
    );
    
    -- o mux seleciona entre b (soma) ou ~b (subtração)
    u_mux : mux2x8 port map(
        a   => b,        -- sel=0: soma (usa b)
        b   => nao_b,    -- sel=1: subtração (usa ~b)
        sel => sel,
        y   => b_ou_nao_b
    );
    
    -- soamdor de 8 bits: A + B_ou_nao_B + carry_in
    -- para soma: sel=0, c_in=0, calcula A + B
    -- para subtração: sel=1, c_in=1, calcula A + (~B) + 1 = A - B
    u_soma : soma_8b port map(
        c_in  => sel,
        a => a,
        b => b_ou_nao_b,
        s  => s,
        c_out => overflow
    );
end architecture;