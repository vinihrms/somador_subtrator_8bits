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
    -- soma binária de 1 bit
    s <= (a xor b) xor cin;
    -- carry out
    cout <= (a and b) or (a and cin) or (b and cin);
end architecture;
