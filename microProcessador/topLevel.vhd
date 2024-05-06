library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity topLevel is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        dataOut: out unsigned (11 downto 0)
        
    );
end entity topLevel;

architecture a_topLevel of topLevel is

    component controlUnit is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            rom_clk : out std_logic;
            pc_clk : out std_logic
            
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
            endereco : in unsigned(6 downto 0);
            dado     : out unsigned(11 downto 0) 
            
        );
    end component;

    signal rom_clk_s, pc_clk_s: std_logic := '0';
    signal pc_out : unsigned (15 downto 0) := "0000000000000000";
    
    

begin

    ctrlUnit: controlUnit port map (
        clk => clk,
        reset => reset,
        rom_clk => rom_clk_s,
        pc_clk => pc_clk_s

    );

    programCounter: PC port map (
        clk => pc_clk_s,
        reset => reset,
        writeEnable => '1',
        data_in => "0000000000000000",
        data_out => pc_out

    );

    rom: rom128x12 port map (
        clk => rom_clk_s,
        endereco => pc_out (6 downto 0),
        dado => dataOut
    );
    

end architecture;