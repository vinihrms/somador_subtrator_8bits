entity soma_8b is
    port(
        c_in  : in  bit;
        a     : in  bit_vector(7 downto 0);
        b     : in  bit_vector(7 downto 0);
        s     : out bit_vector(7 downto 0);
        c_out : out bit
    );
end entity;

architecture soma_8b of soma_8b is
    component somador_1bit is
        port(
            a    : in  bit;
            b    : in  bit;
            s    : out bit;
            cin  : in  bit;
            cout : out bit
        );
    end component;
    
    signal carry : bit_vector(7 downto 0);
begin
    -- bit 0 (lsb)
    u_add0 : somador_1bit port map(
        a    => a(0),
        b    => b(0),
        cin  => c_in,
        s    => s(0),
        cout => carry(0)
    );
    
    -- bit 1
    u_add1 : somador_1bit port map(
        a    => a(1),
        b    => b(1),
        cin  => carry(0),
        s    => s(1),
        cout => carry(1)
    );
    
    -- bit 2
    u_add2 : somador_1bit port map(
        a    => a(2),
        b    => b(2),
        cin  => carry(1),
        s    => s(2),
        cout => carry(2)
    );
    
    -- bit 3
    u_add3 : somador_1bit port map(
        a    => a(3),
        b    => b(3),
        cin  => carry(2),
        s    => s(3),
        cout => carry(3)
    );
    
    -- bit 4
    u_add4 : somador_1bit port map(
        a    => a(4),
        b    => b(4),
        cin  => carry(3),
        s    => s(4),
        cout => carry(4)
    );
    
    -- bit 5
    u_add5 : somador_1bit port map(
        a    => a(5),
        b    => b(5),
        cin  => carry(4),
        s    => s(5),
        cout => carry(5)
    );
    
    -- bit 6
    u_add6 : somador_1bit port map(
        a    => a(6),
        b    => b(6),
        cin  => carry(5),
        s    => s(6),
        cout => carry(6)
    );
    
    -- bit 7 (msb)
    u_add7 : somador_1bit port map(
        a    => a(7),
        b    => b(7),
        cin  => carry(6),
        s    => s(7),
        cout => carry(7)
    );
    
    -- carry out final
    c_out <= carry(7);
end architecture;
