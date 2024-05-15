library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity processador_tb is

end;

architecture a_processador_tb of processador_tb is

    component microProcessor is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        memToReg, ULASrc1: in unsigned (1 downto 0);
        memoryData, PC: in unsigned (15 downto 0);
        carry, overflow: out std_logic;
        ULAFinal: out unsigned (15 downto 0) 
    );
end component;

    signal clk_tb, reset_tb: std_logic:= '0';
    signal memToReg_tb, ULASrc1_tb: unsigned (1 downto 0):="00";
    signal memoryData_tb, PC_tb, imm_tb: unsigned (15 downto 0):="0000000000000000";
    signal readReg1_tb, readReg2_tb, writeReg_tb: unsigned (2 downto 0):="000";
    signal ULAFinal_tb: unsigned (15 downto 0) :="0000000000000000";
    signal period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    
     
begin

    memToReg_tb <= "00";
    ULASrc1_tb <= "01";
        
    tb: microProcessor port map (
        clk => clk_tb,
        reset => reset_tb,
        memToReg => memToReg_tb,
        ULASrc1 => ULASrc1_tb, 
        memoryData => memoryData_tb, 
        PC => PC_tb, 
        ULAFinal => ULAFinal_tb 
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