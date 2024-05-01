library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity bankReg_tb is

end;

architecture a_bankReg_tb of bankReg_tb is

    component bankReg is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        writeEnable: in std_logic;
        readReg1, readReg2, writeReg: in unsigned (2 downto 0);
        writeData: in unsigned (15 downto 0);
        dataReg1, dataReg2: out unsigned (15 downto 0) 
        
    );
end component;

    signal clk_tb, reset_tb, writeEnable_tb : std_logic := '0';
    signal writeData_tb, dataReg1_tb, dataReg2_tb : unsigned (15 downto 0) := "0000000000000000";
    signal readReg1_tb, readReg2_tb, writeReg_tb: unsigned (2 downto 0):= "000";
    signal period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    
     
begin

    tb: bankReg port map (
        clk => clk_tb,
        reset => reset_tb,
        writeEnable  => writeEnable_tb,
        readReg1 => readReg1_tb, 
        readReg2 => readReg2_tb, 
        writeReg => writeReg_tb,
        writeData => writeData_tb,
        dataReg1 => dataReg1_tb, 
        dataReg2 => dataReg2_tb 
        
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
        writeEnable_tb <= '0';
        readReg1_tb <= "000";
        readReg2_tb <= "001";
        writeReg_tb <= "001";
        writeData_tb <= "1111111111111111";
        wait for 100 ns;
        writeEnable_tb <= '1';
        readReg1_tb <= "001";
        readReg2_tb <= "010";
        writeReg_tb <= "001";
        writeData_tb <= "1111111111111111";
        wait for 100 ns;
        writeEnable_tb <= '1';
        readReg1_tb <= "001";
        readReg2_tb <= "010";
        writeReg_tb <= "010";
        writeData_tb <= "1111111111111111";
        wait for 100 ns;                     
        writeEnable_tb <= '0';
        readReg1_tb <= "001";
        readReg2_tb <= "010";
        writeReg_tb <= "001";
        writeData_tb <= "1111111111111111";
        wait;
   end process;


    

end architecture;