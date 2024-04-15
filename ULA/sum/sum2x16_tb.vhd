library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum2x16_tb is
end;

architecture a_sum2x16_tb of sum2x16_tb is
    
    component sum2x16 
        port (
            inputA: in unsigned (15 downto 0);
            inputB: in unsigned (15 downto 0);
            result: out unsigned (15 downto 0)
            
        );
    end component;
    
    signal in_a, in_b, final: unsigned (15 downto 0);

begin

    teste: sum2x16 port map(
        inputA => in_a,
        inputB => in_b,
        result => final);

process

begin
    in_a <= "0000000000000001";
    in_b <= "0000000000000000";
    wait for 50 ns;
    in_a <= "0000000000000001";
    in_b <= "1111111111111111";
    wait for 50 ns;
    wait;



end process;
    

end architecture;