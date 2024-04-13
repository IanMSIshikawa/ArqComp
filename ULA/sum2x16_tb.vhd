library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
-- use ieee.math_real.all;

entity sum2x16_tb is
end;

architecture a_sum2x16_tb of sum2x16_tb is
    
    component sum2x16 
        port (
            in_a: in unsigned (15 downto 0);
            in_b: in unsigned (15 downto 0);
            result: out unsigned (15 downto 0)
            
        );
    end component;
    
    signal in_a, in_b, result: unsigned (15 downto 0);

begin

    uut: sum2x16 port map(
        in_a => in_a,
        in_b => in_b,
        result => result);

process

begin
    in_a <= "0000000000000001";
    in_b <= "0000000000000000";
    wait for 10 ns;
    in_a <= "0000000000000001";
    in_b <= "1111111111111111";
    wait;



end process;
    

end architecture;