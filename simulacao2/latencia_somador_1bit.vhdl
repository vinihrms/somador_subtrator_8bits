entity somador_1bit is
    port(
        a    : in  bit;
        b    : in  bit;
        s    : out bit;
        cin  : in  bit;
        cout : out bit
    );
end entity;

architecture soma of somador_1bit is
begin
    -- soma binária de 1 bit (2 XORs em cascata)
    s <= (a xor b) xor cin after 2*4 ns;
    -- carry out (ANDs em paralelo + OR)
    cout <= (a and b) or (a and cin) or (b and cin) after 2*4 ns;
end architecture;
