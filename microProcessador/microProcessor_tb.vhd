library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity microProcessor_tb is

end;

architecture a_microProcessor_tb of microProcessor_tb is

    component microProcessor is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        writeEnable: in std_logic;
        carry, overflow: out std_logic;
        memToReg, ULASrc1, ULASrc2, ULAControl: in unsigned (1 downto 0);
        memoryData, PC, imm: in unsigned (15 downto 0);
        readReg1, readReg2, writeReg: in unsigned (2 downto 0);
        ULAFinal: out unsigned (15 downto 0) 
        
    );
end component;

    signal clk_tb, reset_tb, writeEnable_tb: std_logic:= '0';
    signal memToReg_tb, ULASrc1_tb, ULASrc2_tb, ULAControl_tb: unsigned (1 downto 0):="00";
    signal memoryData_tb, PC_tb, imm_tb: unsigned (15 downto 0):="0000000000000000";
    signal readReg1_tb, readReg2_tb, writeReg_tb: unsigned (2 downto 0):="000";
    signal ULAFinal_tb: unsigned (15 downto 0) :="0000000000000000";
    signal period_time : time := 100 ns;
    signal finished : std_logic := '0';
    
    
     
begin

    tb: microProcessor port map (
        clk => clk_tb,
        reset => reset_tb,
        writeEnable  => writeEnable_tb,
        memToReg => memToReg_tb,
        ULASrc1 => ULASrc1_tb, 
        ULASrc2 => ULASrc2_tb, 
        ULAControl => ULAControl_tb,
        memoryData => memoryData_tb, 
        PC => PC_tb, 
        imm => imm_tb,
        readReg1 => readReg1_tb, 
        readReg2=> readReg2_tb, 
        writeReg => writeReg_tb,
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
   process                      
   begin
        wait for 200 ns;
        ULASrc1_tb <= "01";
        ULASrc2_tb <= "01";
        memToReg_tb <= "00";
        ULAControl_tb <= "00";
        writeEnable_tb <= '1';
        writeReg_tb <= "001";
        readReg1_tb <= "001";
        readReg2_tb <= "010";
        --soma registrador 1 (valor 0) com 4 e armazena no registrador 1
        
        wait for 100 ns;
        ULASrc1_tb <= "01";
        ULASrc2_tb <= "00";
        memToReg_tb <= "00";
        ULAControl_tb <= "00";
        writeEnable_tb <= '1';
        writeReg_tb <= "010";
        readReg1_tb <= "001";
        readReg2_tb <= "010";
        --soma registrador 1 (valor 4) com registrador 2 (valor 0) e armazena no reg 2

        wait for 100 ns;
        ULASrc1_tb <= "01";
        ULASrc2_tb <= "00";
        memToReg_tb <= "00";
        ULAControl_tb <= "00";
        writeEnable_tb <= '1';
        writeReg_tb <= "011";
        readReg1_tb <= "001";
        readReg2_tb <= "010";

        --soma reg 1 e reg 2 e armazena no reg 3

        wait for 100 ns;
        ULASrc1_tb <= "01";
        ULASrc2_tb <= "00";
        memToReg_tb <= "00";
        ULAControl_tb <= "00";
        writeEnable_tb <= '0';
        writeReg_tb <= "011";
        readReg1_tb <= "001";
        readReg2_tb <= "000";

        wait for 100 ns;
        ULASrc1_tb <= "01";
        ULASrc2_tb <= "00";
        memToReg_tb <= "00";
        ULAControl_tb <= "00";
        writeEnable_tb <= '0';
        writeReg_tb <= "011";
        readReg1_tb <= "010";
        readReg2_tb <= "000";

        wait for 100 ns;
        ULASrc1_tb <= "01";
        ULASrc2_tb <= "00";
        memToReg_tb <= "00";
        ULAControl_tb <= "00";
        writeEnable_tb <= '0';
        writeReg_tb <= "011";
        readReg1_tb <= "011";
        readReg2_tb <= "000";

        wait for 100 ns;
        ULASrc1_tb <= "01";
        ULASrc2_tb <= "00";
        memToReg_tb <= "00";
        ULAControl_tb <= "00";
        writeEnable_tb <= '0';
        writeReg_tb <= "011";
        readReg1_tb <= "100";
        readReg2_tb <= "000";
        wait;
   end process;


    

end architecture;