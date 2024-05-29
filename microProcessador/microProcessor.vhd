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
            pc_clk :out std_logic;
            ulaOP : out unsigned(1 downto 0);
            imm_enable : out std_logic;
            writeEnable :  out std_logic;   
            acc_write_en : out std_logic;
            selectorWriteData : out std_logic;  
            reg_src : out unsigned (2 downto 0);
            reg_dst1 : out unsigned (2 downto 0);
            reg_dst2 : out unsigned (2 downto 0);
            imm: out unsigned (5 downto 0);
            selectorAcc : out std_logic;
            selectorInputA : out std_logic
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
            carry, overflow, zero: out std_logic
        
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

    signal writeDataFinal, ULAout, ULAinput1, ULAinput2, acumuladorFinal, ULAinput1_final, acc_in : unsigned (15 downto 0) := "0000000000000000";
    signal ULAinput1_s : unsigned (15 downto 0) := "0000000000000000";
    signal muxSrc2op0 : unsigned (15 downto 0) := "0000000000000000";
    signal instructionOut_s, imm_m, imm_final : unsigned (15 downto 0) := "0000000000000000";
    signal exe_clk_s, writeEnable_s, imm_enable_s, pc_clk_s, rom_clk_s, selectorWriteData_s,
           selectorAcc_s, acc_reset, acc_write_en_s, selectorInputA_s, zero_s : std_logic := '0';
    signal opcode : unsigned(3 downto 0 ) := "0000";
    signal reg_dst1_s, reg_dst2_s, reg_src_s : unsigned (2 downto 0) := "000";
    signal ulaOP_s, selector_s, selectorWriteData_final : unsigned (1 downto 0) := "00";
    signal imm_s : unsigned (5 downto 0) := "000000";
    
    
    
    
    begin

    ctrluPcRom: ctrlUePCeROM port map (
        clk => clk,
        reset => reset,
        exe_clk => exe_clk_s,
        pc_clk => pc_clk_s,
        ulaOP => ulaOP_s,
        imm_enable => imm_enable_s,
        writeEnable => writeEnable_s,
        acc_write_en => acc_write_en_s,
        selectorWriteData => selectorWriteData_s, 
        reg_src => reg_src_s,
        reg_dst1 => reg_dst1_s,
        reg_dst2 => reg_dst2_s,
        imm => imm_s,
        selectorAcc => selectorAcc_s,
        selectorInputA => selectorInputA_s
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
            dataReg1 => ULAinput1_s,
            dataReg2 => muxSrc2op0  
    );
    

    

    acumulador: reg16bits port map (
        clk => pc_clk_s,
        rst => reset,
        wr_en => acc_write_en_s,
        data_in => acc_in,
        data_out => acumuladorFinal
    );
    --OK

    acc_in <=   ULAout when selectorAcc_s = '0' else 
                imm_final;

    ULAinput1_final <= ULAinput1_s when selectorInputA_s = '0' else 
                    imm_final;

    selectorWriteData_final <= '0' & selectorWriteData_s;
    imm_final <= "0000000000" & imm_s;

    muxMemToReg: mux3x16bits port map (
        selector => selectorWriteData_final,
        op0 => acumuladorFinal,
        op1 => imm_final,
        op2 => memoryData,
        result => writeDataFinal
    );
    --OK

  
    --OK
    
    imm_m <= "0000000000" & imm_s;

    
    
    alu: ULA port map (
        selector => ulaOP_s,
        inputA => ULAinput1_final,
        inputB => acumuladorFinal,
        result => ULAout, 
        carry => carry,
        overflow => overflow,
        zero => zero_s
    );
    --OK
    ULAFinal <= ULAout;
    
    
    
end architecture;