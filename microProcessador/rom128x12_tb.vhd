library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity rom128x12_tb is

end entity;

architecture a_rom128x12_tb of rom128x12_tb is

component rom128x12 is
    port (
        clk      : in std_logic;
        endereco : in unsigned(11 downto 0);
        dado     : out unsigned(15 downto 0)         
    );
end component;

signal clk_tb : std_logic := '1';
signal endereco_tb : unsigned (11 downto 0);
signal dado_tb : unsigned (15 downto 0);
signal period_time : time := 100 ns;
signal finished : std_logic := '0';


begin
    
    tb: rom128x12 port map (
        clk => clk_tb,
        endereco => endereco_tb,
        dado => dado_tb
    );

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
   process                      
   begin
        wait for 200 ns;
            endereco_tb <= "000000000001";        
        wait for 100 ns;
            endereco_tb <= "000000000010";
        wait for 100 ns;
            endereco_tb <= "000000000011";
        wait;
   end process;

    

end architecture;