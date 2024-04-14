library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ULA is
    port (
        selector: in unsigned (1 downto 0);
        inputA: in unsigned (15 downto 0);
        inputB: in unsigned (15 downto 0);
        result: out unsigned (15 downto 0);
        carry, overflow, smaller, bigger, equal: out std_logic
    );
end entity;

architecture arch_ULA of ULA is

signal sum17 : unsigned (16 downto 0):= "00000000000000000";
signal sub17 : unsigned (16 downto 0):= "00000000000000000";
signal inputA17 : unsigned (16 downto 0):= "00000000000000000";
signal inputB17 : unsigned (16 downto 0):= "00000000000000000";
signal overflowSumNeg, overflowSumPos, overflowSub : std_logic := '0';



begin

    --aumentando os vetores para tratar carry e overflow
    inputA17 <= '0' & inputA;
    inputB17 <= '0' & inputB;
    sum17 <= inputA17+inputB17;
    sub17 <= inputA17-inputB17;

    --tratando carry
    carry <= sum17(16);

    --tratando overflow 

    overflowSumNeg <= inputA(15) and inputB(15) and sum17(16);
    overflowSumPos <= not inputA(15) and not inputB(15) and sum17(15);
    overflowSub <= inputA(15) and not inputB(15) and sub17(16);

    overflow <= '1' when (overflowSumNeg or overflowSumPos or overflowSub) = '1' else
                '0';

    --smaller and bigger and equal
    bigger <=   '1' when inputA > inputB else 
                '0';
    smaller <=  '1' when inputA < inputB else 
                '0';
    equal <=    '1' when inputA = inputB else
                '0';

    -- selector code
    -- 00 -> sum
    -- 01 -> sub
    -- 10 -> and
    -- 11 -> or

    result <=   inputA+inputB when selector = "00" else
                inputA-inputB when selector = "01" else
                inputA and inputB when selector = "10" else
                inputA or inputB when selector = "11" else
                "0000000000000000";
    



    

end architecture;