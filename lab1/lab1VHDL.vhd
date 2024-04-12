library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity lab1VHDL is
    port (
        in_a: in std_logic;
        in_b: in std_logic;
        a_e_b: out std_logic        
    );
end entity;

architecture lab1VHDL_architecture of lab1VHDL is

begin
    a_e_b <= in_a and in_b;
    

end architecture;
