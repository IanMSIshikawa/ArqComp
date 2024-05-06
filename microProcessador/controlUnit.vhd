library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity controlUnit is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        rom_clk : out std_logic;
        pc_clk : out std_logic
        
    );
end entity controlUnit;

architecture a_controlUnit of controlUnit is

    component stateMachine is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            state : out std_logic
        );
    end component;

    signal state_s : std_logic := '0';
    
begin

    sm: stateMachine port map (
        clk => clk,
        reset => reset,
        state => state_s
    );

    rom_clk <= state_s;
    pc_clk <= not state_s;
    




    

end architecture;