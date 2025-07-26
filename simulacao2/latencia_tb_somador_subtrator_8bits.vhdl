entity tb_somador_subtrator_8bits is
end entity;

architecture testbench of tb_somador_subtrator_8bits is
    component somador_subtrator_8bits is 
        port(
            a        : in  bit_vector(7 downto 0);
            b        : in  bit_vector(7 downto 0);
            sel      : in  bit;
            s        : out bit_vector(7 downto 0);
            overflow : out bit
        );
    end component;
    
    signal x, y, s  : bit_vector(7 downto 0);
    signal overflow : bit;
    signal op       : bit;
begin 
    u_somador : somador_subtrator_8bits port map(
        a        => x,
        b        => y,
        sel      => op,
        s        => s,
        overflow => overflow
    );
    
    tb : process
    begin
            --0x00 + 0xFF
            x <= "00000000";
            y <= "11111111";
            op <= '0';
            wait for 100 ns;

            --x00 – 0xFF
            op <= '1';
            wait for 100 ns;
            

            --0xFF + 0x01
            x <= "11111111";
            y <= "00000001";
            op <= '0';
            wait for 100 ns;
            
            --0xFF – 0x01
            op <= '1';
            wait for 100 ns; 

            -- 0xFE + 0xFE
            x <= "11111110";
            y <= "11111110";
            op <= '0';
            wait for 100 ns;
            
            -- 0xFF + 0xFF
            x <= "11111111";
            y <= "11111111";
            op <= '0';
            wait for 100 ns;
            
            --casos intermediarios
            x <= "00011111";
            y <= "01000000";
            op <= '1';
            wait for 100 ns;
            
            x <= "00000000";
            y <= "00000001";
            wait for 100 ns;
            
            x <= "11100000";
            y <= "00011111";
            op <= '0';
            wait for 100 ns;
        
        wait;
    end process;
end architecture;