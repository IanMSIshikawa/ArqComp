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
        carry, overflow, zero: out std_logic
    );
end entity;

architecture arch_ULA of ULA is

signal sum17 : unsigned (16 downto 0):= "00000000000000000";
signal sub17 : unsigned (16 downto 0):= "00000000000000000";
signal inputA17 : unsigned (16 downto 0):= "00000000000000000";
signal inputB17 : unsigned (16 downto 0):= "00000000000000000";
signal result_s: unsigned (15 downto 0):="0000000000000000";
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

    overflowSumNeg <= inputA(15) and inputB(15) and sum17(16) and not sum17(15);
    overflowSumPos <= not inputA(15) and not inputB(15) and sum17(15);
    overflowSub <= (selector(0) and not selector(1)) and ((not inputA(15) and inputB(15) and sub17(15)) or (inputA(15) and not inputB(15) and sub17(16)));
        

    overflow <= '1' when (overflowSumNeg or overflowSumPos or overflowSub) = '1' else
                '0';
    
    zero <= '1' when result_s = "0000000000000000" else 
            '0';

    -- selector code
    -- 00 -> sum
    -- 01 -> sub
    -- 10 -> shift right
    -- 11 -> nothing

    result_s <= inputA+inputB when selector = "00" else
                inputB-inputA when selector = "01" else
                shift_right(inputB, to_integer(inputA)) when selector = "10" else
                inputA when selector = "11" else
                "0000000000000000";
    
    result <= result_s;


    

end architecture;