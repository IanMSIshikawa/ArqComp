library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity sum2x16 is
    port (
        in_a: in unsigned (15 downto 0);
        in_b: in unsigned (15 downto 0);
        result: out unsigned (15 downto 0);
        carry: out std_logic;
        overflow: out std_logic
    );
end entity;

architecture a_sum2x16 of sum2x16 is

signal bigResult: unsigned (16 downto 0);

begin
    bigResult <= in_a + in_b;
    result <= bigResult (15 downto 0);
    

    

end architecture;