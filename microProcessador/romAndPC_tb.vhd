library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity romAndPC_tb is

end entity romAndPC_tb;

architecture a_romAndPC_tb of romAndPC_tb is

    component romAndPC is
        port (
            clk, reset: in std_logic;
            dataOut: out unsigned (11 downto 0)
        );
    end component;

    signal clk_tb, reset_tb : std_logic := '0';
    signal dataOut_tb : unsigned (11 downto 0);
    signal period_time : time := 100 ns;
    signal finished : std_logic := '0';

begin

    tb: romAndPC port map (
        clk => clk_tb,
        reset => reset_tb,
        dataOut => dataOut_tb
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
        wait for 10 us;        
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