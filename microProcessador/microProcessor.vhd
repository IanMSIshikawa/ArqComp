library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity microProcessor is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        writeEnable: in std_logic;
        memToReg, ULASrc1, ULASrc2, ULAControl: in unsigned (1 downto 0);
        memoryData, PC, imm: in unsigned (15 downto 0);
        readReg1, readReg2, writeReg: in unsigned (2 downto 0);
        carry, overflow: out std_logic;
        ULAFinal: out unsigned (15 downto 0) 
        
    );
end entity microProcessor;

architecture a_microProcessor of microProcessor is

    
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
        
        component ULA is
            port (
                selector: in unsigned (1 downto 0);
                inputA: in unsigned (15 downto 0);
                inputB: in unsigned (15 downto 0);
                result: out unsigned (15 downto 0);
                carry, overflow: out std_logic
            
        );
    end component;
    
    component mux3x16bits is
        port (
            selector: in unsigned (1 downto 0);
            op0: in unsigned (15 downto 0);
            op1: in unsigned (15 downto 0);
            op2: in unsigned (15 downto 0);
            result: out unsigned (15 downto 0)
            
            );
        end component;

    signal writeDataFinal, ULAout, ULAinput1, ULAinput2 : unsigned (15 downto 0) := "0000000000000000";
    signal muxSrc1op1 : unsigned (15 downto 0) := "0000000000000000";
    signal muxSrc2op0 : unsigned (15 downto 0) := "0000000000000000";

    
    
    
    begin

    br: bankReg port map (
            clk   => clk,
            reset => reset,
            writeEnable => writeEnable, 
            readReg1 => readReg1,
            readReg2 => readReg2,
            writeReg => writeReg,
            writeData => writeDataFinal,
            dataReg1 => muxSrc1op1,
            dataReg2 => muxSrc2op0  
    );

    muxMemToReg: mux3x16bits port map (
        selector => memToReg,
        op0 => ULAout,
        op1 => memoryData,
        op2 => "0000000000000000",
        result => writeDataFinal
    );

    muxSrc1: mux3x16bits port map (
        selector => ULASrc1,
        op0 => PC,
        op1 => muxSrc1op1,
        op2 => "0000000000000000",
        result => ULAinput1
    );

    muxSrc2: mux3x16bits port map (
        selector => ULASrc2,
        op0 => muxSrc2op0,
        op1 => "0000000000000100",
        op2 => imm,
        result => ULAinput2
    );

    alu: ULA port map (
        selector => ULAControl,
        inputA => ULAinput1,
        inputB => ULAinput2,
        result => ULAout, 
        carry => carry,
        overflow => overflow
    );
    ULAFinal <= ULAout;
    
    
    
end architecture;