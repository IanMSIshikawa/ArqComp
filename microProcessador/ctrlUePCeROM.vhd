library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity ctrlUePCeROM is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        dataOut: out unsigned (15 downto 0)
        -- instruction: in unsigned (11 downto 0)
        
    );
end entity ctrlUePCeROM;

architecture a_ctrlUePCeROM of ctrlUePCeROM is

    component controlUnit is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            instruction: in unsigned (15 downto 0);
            rom_clk : out std_logic;
            pc_clk : out std_logic;
            jump_en : out std_logic;
            jump_adress : out unsigned (11 downto 0)
            
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

    signal rom_clk_s, pc_clk_s: std_logic := '0';
    signal pc_out, jump_adress_final : unsigned (15 downto 0) := "0000000000000000";
    signal jump_en_s : std_logic := '0';
    signal jump_adress_s: unsigned (11 downto 0) := "000000000000";
    signal rom_out : unsigned (15 downto 0) := "0000000000000000";
    
    
    

begin

    ctrlUnit: controlUnit port map (
        clk => clk,
        reset => reset,
        rom_clk => rom_clk_s,
        pc_clk => pc_clk_s,
        jump_en => jump_en_s,
        jump_adress => jump_adress_s,
        instruction => rom_out

    );

    jump_adress_final <= "0000" & jump_adress_s;

    programCounter: PC port map (
        clk => pc_clk_s,
        reset => reset,
        writeEnable => jump_en_s,
        data_in => jump_adress_final,
        data_out => pc_out

    );

    rom: rom128x12 port map (
        clk => rom_clk_s,
        endereco => pc_out (11 downto 0),
        dado => rom_out
    );
    

end architecture;