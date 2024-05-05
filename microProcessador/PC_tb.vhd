library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity PC_tb is
    
end entity PC_tb;

architecture a_PC_tb of PC_tb is

    component PC is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            writeEnable : in std_logic;
            data_in : in unsigned (15 downto 0);
            data_out : out unsigned (15 downto 0)
        );
    end component;

    signal clk_tb, rst_tb, wr_en_tb : std_logic := '0';
    signal data_in_tb, data_out_tb : unsigned( 15 downto 0) := "0000000000000000";
    signal period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
begin

    tb: PC port map (
        clk => clk_tb,
        reset => rst_tb,
        writeEnable => wr_en_tb,
        data_in => data_in_tb,
        data_out => data_out_tb
    );

    reset_global: process
    begin
        rst_tb <= '1';
        wait for period_time*2; 
        rst_tb <= '0';
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

    wr_en_tb <= '1';




    

end architecture;