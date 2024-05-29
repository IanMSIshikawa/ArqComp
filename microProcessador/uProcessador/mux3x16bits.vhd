library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity mux3x16bits is
    port (
        selector: in unsigned (1 downto 0);
        op0: in unsigned (15 downto 0);
        op1: in unsigned (15 downto 0);
        op2: in unsigned (15 downto 0);
        result: out unsigned (15 downto 0)
        
    );
end entity;

architecture a_mux3x16bits of mux3x16bits is

begin

    result <=   op0 when selector = "00" else
                op1 when selector = "01" else
                op2 when selector = "10" else 
                "0000000000000000";
    

end architecture;