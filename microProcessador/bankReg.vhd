library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity bankReg is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        writeEnable: in std_logic;
        readReg1, readReg2, writeReg: in unsigned (2 downto 0);
        writeData: in unsigned (15 downto 0);
        dataReg1, dataReg2: out unsigned (15 downto 0)       
    );
end entity bankReg;

architecture a_bankReg of bankReg is

    component reg16bits is
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    signal selectWriteEnable, selectWriteEnableIntermediate : unsigned (7 downto 0):= "00000000";
    signal outReg0, outReg1, outReg2, outReg3, outReg4, outReg5, outReg6, outReg7 : unsigned (15 downto 0) := "0000000000000000";
    
begin

    selectWriteEnable <=    selectWriteEnableIntermediate and "11111111" when writeEnable = '1' else
                            "00000000";
                            
 
    reg0: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => '0',
        data_in => "0000000000000000",
        data_out => outReg0
    );


    reg1: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => selectWriteEnable(1),
        data_in => writeData,
        data_out => outReg1
    );

    reg2: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => selectWriteEnable(2),
        data_in => writeData,
        data_out => outReg2
    );
    reg3: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => selectWriteEnable(3),
        data_in => writeData,
        data_out => outReg3
    );
    reg4: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => selectWriteEnable(4),
        data_in => writeData,
        data_out => outReg4
    );
    reg5: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => selectWriteEnable(5),
        data_in => writeData,
        data_out => outReg5
    );
    reg6: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => selectWriteEnable(6),
        data_in => writeData,
        data_out => outReg6
    );
    reg7: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => selectWriteEnable(7),
        data_in => writeData,
        data_out => outReg7
    );

    selectWriteEnableIntermediate <=    "00000010" when writeReg = "001" else
                                        "00000100" when writeReg = "010" else
                                        "00001000" when writeReg = "011" else
                                        "00010000" when writeReg = "100" else
                                        "00100000" when writeReg = "101" else
                                        "01000000" when writeReg = "110" else
                                        "10000000" when writeReg = "111" else
                                        "00000000";

    dataReg1 <= outReg0 when readReg1 = "000" else
                outReg1 when readReg1 = "001" else
                outReg2 when readReg1 = "010" else
                outReg3 when readReg1 = "011" else
                outReg4 when readReg1 = "100" else
                outReg5 when readReg1 = "101" else
                outReg6 when readReg1 = "110" else
                outReg7 when readReg1 = "111" else
                "0000000000000000";

    dataReg2 <= outReg0 when readReg2 = "000" else
                outReg1 when readReg2 = "001" else
                outReg2 when readReg2 = "010" else
                outReg3 when readReg2 = "011" else
                outReg4 when readReg2 = "100" else
                outReg5 when readReg2 = "101" else
                outReg6 when readReg2 = "110" else
                outReg7 when readReg2 = "111" else
                "0000000000000000";
                    
        


    

end architecture;