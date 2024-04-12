library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity lab1VHDL_tb is 
end;

architecture lab1VHDL_tb_architecture of lab1VHDL_tb is
    component lab1VHDL
        port (
            in_a: in std_logic;
            in_b: in std_logic;
            a_e_b: out std_logic
        );
    end component;

    signal in_a, in_b, a_e_b: std_logic;

begin

    uut: lab1VHDL port map (
        in_a => in_a,
        in_b => in_b,
        a_e_b => a_e_b
    );

    process
    begin

        in_a <= '0';
        in_b <= '1';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '0';
        wait for 50 ns;
        in_a <= '0';
        in_b <= '1';
        wait for 50 ns;
        in_a <= '1';
        in_b <= '0';
        wait for 50 ns;
        wait;
    end process;
end architecture;




    