library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity reg16bits_tb is

end;

architecture a_reg16bits_tb of reg16bits_tb is

    component reg16bits is
    port (
        clk      : in std_logic;
        rst      : in std_logic;
        wr_en    : in std_logic;
        data_in  : in unsigned(15 downto 0);
        data_out : out unsigned(15 downto 0)
        
    );
end component;

    signal clk_tb, reset_tb, wr_en_tb : std_logic := '0';
    signal data_in_tb, data_out_tb : unsigned (15 downto 0) := "0000000000000000";
    signal period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    
     
begin

    tb: reg16bits port map (
        clk => clk_tb,
        rst => reset_tb,
        wr_en => wr_en_tb,
        data_in => data_in_tb,
        data_out => data_out_tb
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
   process                      
   begin
      wait for 200 ns;
      wr_en_tb <= '0';
      data_in_tb <= "1111111111111111";
      wait for 100 ns;
      data_in_tb <= "1000110110010001";
      wr_en_tb <= '1';
      wait;                     
   end process;


    

end architecture;