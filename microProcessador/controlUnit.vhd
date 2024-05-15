library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity controlUnit is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        instruction: in unsigned (15 downto 0);
        rom_clk : out std_logic;
        pc_clk : out std_logic;
        exe_clk : out std_logic;
        jump_en : out std_logic;
        imm_enable : out std_logic;
        writeEnable :  out std_logic;
        jump_adress : out unsigned (11 downto 0);
        reg_src : out unsigned (2 downto 0);
        reg_dst1 : out unsigned (2 downto 0);
        reg_dst2 : out unsigned (2 downto 0);
        ulaOP: out unsigned (1 downto 0);
        imm: out unsigned (5 downto 0)
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
    signal reg_dst1_s, reg_dst2_s, reg_src_s : unsigned (2 downto 0) := "000";
    signal imm_enable_s, writeEnable_s : std_logic := '0';
    
    
begin

    opcode <= instruction (15 downto 12);

    jump_en <= not opcode(0) and opcode(1) and opcode(2) and not opcode(3);
    jump_adress <= instruction(11 downto 0);

    writeEnable_s <=    '1' when opcode = "0001" or opcode = "0010" or 
                                 opcode = "0011" or opcode = "0100" or 
                                 opcode = "0101" else 
                        '0';

    writeEnable <= writeEnable_s;
                        
    
    imm_enable_s <=     '1' when    opcode = "0010" or opcode = "0101" or opcode = "0011" else 
                        '0';
    
    imm_enable <= imm_enable_s;

    ulaOP <=    "00" when opcode = "0001" or opcode = "0010" or opcode = "0011" else 
                "01" when opcode = "0100" or opcode = "0101" else 
                "00";

    reg_src_s <= instruction(11 downto 9);
    reg_dst1_s <= instruction(8 downto 6);
    reg_dst2_s <= instruction(5 downto 3);

    reg_src <= reg_src_s;

    -- reg_dst1 <= reg_dst1_s  when opcode = "0010" or opcode = "0101" else 
    --             "000000";

    reg_dst1 <= "000" when opcode = "0011" else 
                reg_dst1_s;

    reg_dst2 <= reg_dst2_s;

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

    rom_clk <= not state_s(0) and not state_s(1) and not reset;
    pc_clk <=  state_s(0) and not state_s(1) and not reset;
    exe_clk <= not state_s(0) and state_s(1) and not reset;

    
    




    

end architecture;