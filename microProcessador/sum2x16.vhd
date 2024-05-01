library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity sum2x16 is
    port (
        inputA: in unsigned (15 downto 0);
        inputB: in unsigned (15 downto 0);
        result: out unsigned (15 downto 0)
    );
end entity;

architecture a_sum2x16 of sum2x16 is


begin
    result <= inputA+inputB;
end architecture;