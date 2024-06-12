library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity uProcessador is
    port (
        clk   : in std_logic;
        reset : in std_logic 
    );
end entity uProcessador;

architecture a_uProcessador of uProcessador is

    component controlUnit is
        port(
            clk   : in std_logic;
            reset : in std_logic;
            instruction: in unsigned (15 downto 0);
            PC: in unsigned (15 downto 0);
            flagCarry: in std_logic;
            flagZero: in std_logic;
            clk1 : out std_logic;
            clk2 : out std_logic;
            clk3 : out std_logic;
            clkFlags : out std_logic;
            jump_en : out std_logic;
            imm_enable : out std_logic;
            writeEnable :  out std_logic;
            writeEnableRam : out std_logic;
            selectorWriteData : out unsigned (1 downto 0);
            acc_write_en : out std_logic;
            jump_adress : out unsigned (11 downto 0);
            reg_write : out unsigned (2 downto 0);
            reg_read : out unsigned (2 downto 0);
            ulaOP: out unsigned (1 downto 0);
            imm: out unsigned (5 downto 0);
            selectorAcc : out std_logic;
            selectorInputA : out std_logic
        );
        end component;

    component PC is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            writeEnable : in std_logic;
            data_in : in unsigned (15 downto 0);
            data_out : out unsigned (15 downto 0) 
        );
    end component;

    component rom128x12 is
        port (
            clk      : in std_logic;
            endereco : in unsigned(11 downto 0);
            dado     : out unsigned(15 downto 0)       
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

    component reg1bit is
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in std_logic;
            data_out : out std_logic
        );
    end component;

    component ram is
        port (
            clk      : in std_logic;
            endereco : in unsigned(6 downto 0);
            wr_en    : in std_logic;
            dado_in  : in unsigned(15 downto 0);
            dado_out : out unsigned(15 downto 0)    
        );
    end component;


    --SIGNAL CONTROL UNIT--
    signal clk1_s, clk2_s, clk3_s, clkFlags_s :                     std_logic := '0'; 
    signal jump_en_s, imm_enable_s, writeEnable_s, acc_write_en_s : std_logic := '0'; 
    signal jump_adress_s :                                          unsigned (11 downto 0) := "000000000000"; 
    signal reg_write_s, reg_read_s :                                unsigned (2 downto 0) := "000";
    signal selectorWriteData_s, ulaOP_s :                           unsigned (1 downto 0) := "00";
    signal imm_s :                                                  unsigned (5 downto 0) := "000000";
    signal selectorAcc_s, selectorInputA_s  :                       std_logic := '0'; 
    ---------------------------

    --SIGNAL ROM --
    signal rom_out : unsigned (15 downto 0) := "0000000000000000";
    ---------------------------

    --SIGNAL PC --
    signal pc_out, jump_adress_final : unsigned (15 downto 0) := "0000000000000000";
    ---------------------------

    --SIGNAL REGISTER BANK--
    signal reg1_s : unsigned (15 downto 0) := "0000000000000000";
    ---------------------------

    --SIGNAL ACUMULADOR--
    signal acumuladorFinal, acc_in : unsigned (15 downto 0) := "0000000000000000";
    ---------------------------

    --SIGNAL ULA--
    signal ULAout : unsigned (15 downto 0) := "0000000000000000";
    ---------------------------

    -- SIGNAL RAM--
    signal writeEnableRam_s : std_logic := '0';
    signal ramOut: unsigned (15 downto 0) := "0000000000000000";
    

    --SIGNAL--
    signal  ULAinput1_s, imm_final, writeDataFinal: unsigned (15 downto 0):= "0000000000000000";
    signal carry_s, zero_s, flagZero, flagCarry, cmp : std_logic := '0';
    ---------------------------


begin

    ctrlUnit: controlUnit port map (
        clk => clk,
        reset => reset,
        instruction => rom_out,
        PC => pc_out,
        flagCarry => flagCarry,
        flagZero => flagZero,
        clk1 => clk1_s,
        clk2 => clk2_s,
        clk3 => clk3_s,
        clkFlags => clkFlags_s,
        jump_en => jump_en_s,
        imm_enable => imm_enable_s,
        writeEnable => writeEnable_s,
        writeEnableRam => writeEnableRam_s,
        acc_write_en =>acc_write_en_s,
        jump_adress => jump_adress_s,
        selectorWriteData => selectorWriteData_s,
        reg_write => reg_write_s,
        reg_read => reg_read_s,
        ulaOP => ulaOP_s,
        imm => imm_s,
        selectorAcc => selectorAcc_s,
        selectorInputA => selectorInputA_s
    );

    jump_adress_final <= "0000" & jump_adress_s;

    programCounter: PC port map (
        clk => clk3_s,
        reset => reset,
        writeEnable => jump_en_s,
        data_in => jump_adress_final,
        data_out => pc_out

    );

    rom: rom128x12 port map (
        clk => clk1_s,
        endereco => pc_out (11 downto 0),
        dado => rom_out
    );
    
    ramComponent: ram port map (
        clk => clk3_s,
        endereco => reg1_s(6 downto 0),
        wr_en    => writeEnableRam_s,
        dado_in  => acumuladorFinal,
        dado_out => ramOut
    );
    --ler REG_READ, passar valor para ENDERECO na ram
    --

    br: bankReg port map (
        clk   => clk3_s,
        reset => reset,
        writeEnable => writeEnable_s, 
        readReg1 => reg_read_s,
        readReg2 => "000",
        writeReg => reg_write_s,
        writeData => writeDataFinal,
        dataReg1 => reg1_s
    );

    
    muxWriteData: mux3x16bits port map (
        selector => selectorWriteData_s,
        op0 => acumuladorFinal,
        op1 => imm_final,
        op2 => ramOut,
        result => writeDataFinal
    );
    
    imm_final <= "0000000000" & imm_s;

    ULAinput1_s <=  reg1_s when selectorInputA_s = '0' else 
                    imm_final;

    alu: ULA port map (
        selector => ulaOP_s,
        inputA => ULAinput1_s,
        inputB => acumuladorFinal,
        result => ULAout, 
        carry => carry_s,
        zero => zero_s
    );

    cmp <= carry_s;
    -- OBS: ULA possui uma gambiarra para carregar registradores no acumulador. Dessa forma, existe uma operação nothing que
    -- simplesmente passa o sinal do registrador sem nenhuma operação 

    acc_in <=   ULAout when selectorAcc_s = '0' else 
                imm_final;

    acumulador: reg16bits port map (
        clk => clk2_s,
        rst => reset,
        wr_en => acc_write_en_s,
        data_in => acc_in,
        data_out => acumuladorFinal
    );         
        
    
    regFlagZero: reg1bit port map (
        clk => clk3_s,
        rst => reset,
        wr_en => '1',--wr enable somente em operações de ula 
        data_in => zero_s,
        data_out => flagZero
    );    
    
    regFlagCarry: reg1bit port map (
        clk => clk3_s,
        rst => reset,
        wr_en => '1',
        data_in => carry_s,
        data_out => flagCarry
    );   


    

end architecture;