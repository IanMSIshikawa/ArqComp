library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity uProcessador_tb is

end;

architecture a_uProcessador_tb of uProcessador_tb is

    component uProcessador is
    port (
        clk   : in std_logic;
        reset : in std_logic 
    );
end component;

    signal clk_tb, reset_tb: std_logic:= '0';
    signal period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    
     
begin
        
    tb: uProcessador port map (
        clk => clk_tb,
        reset => reset_tb
    );

    reset_global: process
    begin
        reset_tb <= '1';
        wait for period_time*2; 
        reset_tb <= '0';
        wait;
    end process;
    
    sim_time_proc: process
    begin
        wait for 500 us;        
        finished <= '1';
        wait;
    end process sim_time_proc;
    clk_proc: process
    begin                       
        while finished /= '1' loop
            clk_tb <= '0';
            wait for period_time/2;
            clk_tb <= '1';
            wait for period_time/2;
        end loop;
        wait;
    end process clk_proc;


end architecture;