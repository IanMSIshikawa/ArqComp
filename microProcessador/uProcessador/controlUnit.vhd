library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity controlUnit is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        instruction: in unsigned (15 downto 0);
        clk1 : out std_logic;
        clk2 : out std_logic;
        clk3 : out std_logic;
        jump_en : out std_logic;
        imm_enable : out std_logic;
        writeEnable :  out std_logic;
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
end entity controlUnit;

architecture a_controlUnit of controlUnit is

    component stateMachine is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            state : out unsigned (1 downto 0)
        );
    end component;

    signal state_s : unsigned (1 downto 0) := "00";
    signal opcode : unsigned (3 downto 0) := "0000";
    signal reg_read_s, reg_dst2_s, reg_write_s : unsigned (2 downto 0) := "000";
    signal imm_enable_s, writeEnable_s : std_logic := '0';
    signal imm_s : unsigned (5 downto 0) := "000000";
    
    
    
begin

    opcode <= instruction (15 downto 12);

    jump_en <=  '1' when opcode = "0110" else 
                '0';

    jump_adress <= instruction(11 downto 0);

    writeEnable_s <=    '1' when opcode = "0011" or opcode = "0111"
                            else 
                        '0';

    writeEnable <= writeEnable_s;
                        
    
    imm_enable_s <=     '1' when    opcode = "0010" or opcode = "0101" or opcode = "0011" else 
                        '0';

    selectorAcc <=  '1' when opcode = "0011" else 
                    '0';

    acc_write_en <= '0' when opcode = "0111" else 
                    '1';
                        
    imm_enable <= imm_enable_s;

    selectorInputA <=   '1' when opcode = "0010" or opcode = "0101" else 
                        '0';

    imm_s <= instruction(5 downto 0);

    selectorWriteData <= "01" when opcode = "0011" else 
                         "00";

    ulaOP <=    "00" when opcode = "0001" or opcode = "0010" else 
                "01" when opcode = "0100" or opcode = "0101" else 
                "11" when opcode = "1000"                    else--operacao nao faz nada, somente passa o operando a
                "00";

    reg_write <= instruction(11 downto 9);
    reg_read <= instruction(8 downto 6);


    imm <=  instruction(5 downto 0);

    -- nop 0000
    -- add 0001
    -- addi 0010
    -- ld 0011
    -- sub 0100
    -- subi 0101
    -- salto 0110


    sm: stateMachine port map (
        clk => clk,
        reset => reset,
        state => state_s
    );

    clk1 <= not state_s(0) and not state_s(1) and not reset;
    clk2 <=  state_s(0) and not state_s(1) and not reset;
    clk3 <= not state_s(0) and state_s(1) and not reset;

    
    




    

end architecture;