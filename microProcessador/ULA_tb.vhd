library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ULA_tb is

end;

architecture arch_ULA_tb of ULA_tb is

    component ULA is
        port (
            selector: in unsigned (1 downto 0);
            inputA: in unsigned (15 downto 0);
            inputB: in unsigned (15 downto 0);
            result: out unsigned (15 downto 0);
            carry, overflow: out std_logic
        );
    end component;

    signal selector_tb : unsigned (1 downto 0):= "00";
    signal inputA_tb, inputB_tb, result_tb: unsigned (15 downto 0) := "0000000000000000";
    signal carry_tb, overflow_tb: std_logic:= '0'; 
    

begin

    tb: ULA port map (
        selector => selector_tb,
        inputA => inputA_tb,
        inputB => inputB_tb,
        result => result_tb,
        carry => carry_tb,
        overflow => overflow_tb
    );

    process
    begin
        --teste soma positivos
        selector_tb <= "00";
        inputA_tb <= "0000000000000111";
        inputB_tb <= "0000000000000001";
        --OK
        wait for 10 ns;
        --teste soma negativos 
        selector_tb <= "00";
        inputA_tb <= "1111111111111111";
        inputB_tb <= "1111111111111110";
        --OK
        wait for 10 ns;
        --teste soma carry
        selector_tb <= "00";
        inputA_tb <= "1111111111111111";
        inputB_tb <= "0000000000000001";
        --OK
        wait for 10 ns;
        --teste soma overflow
        selector_tb <= "00";
        inputA_tb <= "1000000000000000";
        inputB_tb <= "1111111111111111";
        --OK
        wait for 10 ns;
        --teste subtração positivos
        selector_tb <= "01";
        inputA_tb <= "0000000000000111";
        inputB_tb <= "0000000000000001";
        --OK
        wait for 10 ns;
        --teste subtração negativos
        selector_tb <= "01";
        inputA_tb <= "1111111111111000";
        inputB_tb <= "1111111111111111";
        --OK
        wait for 10 ns;
        --teste subtração overflow
        selector_tb <= "01";
        inputA_tb <= "1000000000000000";
        inputB_tb <= "0000000000000001";
        --NAO SEI SE ESTA CORRETO
        wait for 10 ns;
        --teste and 
        selector_tb <= "10";
        inputA_tb <= "0000000000000111";
        inputB_tb <= "0000000000000001";
        wait for 10 ns;
        --teste or
        selector_tb <= "11";
        inputA_tb <= "0000000000000111";
        inputB_tb <= "0000000000000001";
        wait for 10 ns;
        wait;



    end process;

    

end architecture;