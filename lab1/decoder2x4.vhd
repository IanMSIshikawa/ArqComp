library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity decoder2x4 is
    port (
        x1: in std_logic;
        x2: in std_logic;
        y1: out std_logic;
        y2: out std_logic;
        y3: out std_logic;
        y4: out std_logic

    );
end entity decoder2x4;

architecture decoder2x4_a of decoder2x4 is

begin
    y1 <= not x1 and not x2;
    y2 <= x1 and not x2;
    y3 <= not x1 and x2;
    y4 <= x1 and x2;
    

end architecture;