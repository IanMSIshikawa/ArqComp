library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity microProcessor is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        memToReg, ULASrc1: in unsigned (1 downto 0);
        memoryData, PC: in unsigned (15 downto 0);
        carry, overflow: out std_logic;
        ULAFinal: out unsigned (15 downto 0) 
        
    );
end entity microProcessor;

architecture a_microProcessor of microProcessor is

    component ctrlUePCeROM is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            exe_clk : out std_logic;
            ulaOP : out unsigned(1 downto 0);
            imm_enable : out std_logic;
            writeEnable :  out std_logic;     
            reg_src : out unsigned (2 downto 0);
            reg_dst1 : out unsigned (2 downto 0);
            reg_dst2 : out unsigned (2 downto 0);
            imm: out unsigned (5 downto 0)     
            );     
    end component;

    
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
    
    component reg16bits is
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
        );
    end component;

    signal writeDataFinal, ULAout, ULAinput1, ULAinput2, acumuladorFinal : unsigned (15 downto 0) := "0000000000000000";
    signal muxSrc1op1 : unsigned (15 downto 0) := "0000000000000000";
    signal muxSrc2op0 : unsigned (15 downto 0) := "0000000000000000";
    signal instructionOut_s, imm_m : unsigned (15 downto 0) := "0000000000000000";
    signal exe_clk_s, writeEnable_s, imm_enable_s : std_logic := '0';
    signal opcode : unsigned(3 downto 0 ) := "0000";
    signal reg_dst1_s, reg_dst2_s, reg_src_s : unsigned (2 downto 0) := "000";
    signal ulaOP_s, selector_s : unsigned (1 downto 0) := "00";
    signal imm_s : unsigned (5 downto 0) := "000000";
    
    
    
    
    begin

    ctrluPcRom: ctrlUePCeROM port map (
        clk => clk,
        reset => reset,
        exe_clk => exe_clk_s,
        ulaOP => ulaOP_s,
        imm_enable => imm_enable_s,
        writeEnable => writeEnable_s,
        reg_src => reg_src_s,
        reg_dst1 => reg_dst1_s,
        reg_dst2 => reg_dst2_s,
        imm => imm_s
    );
    --OK

                
    br: bankReg port map (
            clk   => exe_clk_s,
            reset => reset,
            writeEnable => writeEnable_s, 
            readReg1 => reg_dst1_s,
            readReg2 => reg_dst2_s,
            writeReg => reg_src_s,
            writeData => writeDataFinal,
            dataReg1 => muxSrc1op1,
            dataReg2 => muxSrc2op0  
    );
    --OK

    acumulador: reg16bits port map (
        clk => exe_clk_s,
        rst => reset,
        wr_en => '1',
        data_in => ULAout,
        data_out => acumuladorFinal
    );
    --OK

    muxMemToReg: mux3x16bits port map (
        selector => memToReg,
        op0 => ULAout,
        op1 => memoryData,
        op2 => "0000000000000000",
        result => writeDataFinal
    );
    --OK

    muxSrc1: mux3x16bits port map (
        selector => ULASrc1,
        op0 => PC,
        op1 => muxSrc1op1,
        op2 => "0000000000000000",
        result => ULAinput1
    );
    --OK

    --alterar depois para usar acumulador 
    selector_s <=   "10" when imm_enable_s = '1' else 
                    "00";
    
    imm_m <= "0000000000" & imm_s;

    muxSrc2: mux3x16bits port map (
        selector => selector_s,
        op0 => muxSrc2op0,
        op1 => acumuladorFinal,
        op2 => imm_m,
        result => ULAinput2
    );
    


    alu: ULA port map (
        selector => ulaOP_s,
        inputA => ULAinput1,
        inputB => ULAinput2,
        result => ULAout, 
        carry => carry,
        overflow => overflow
    );
    --OK
    ULAFinal <= ULAout;
    
    
    
end architecture;