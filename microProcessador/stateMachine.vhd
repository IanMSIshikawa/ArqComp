library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity stateMachine is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        state : out std_logic
        
    );
end entity stateMachine;


architecture a_stateMachine of stateMachine is
    
signal state_s : std_logic := '0';


begin

    process (clk, reset)
    begin

        if reset = '1' then
            state_s <= '0';
        elsif rising_edge(clk) then
            state_s <= not state_s;            
        end if;
        
    end process;

    state <= state_s;

    

end architecture;