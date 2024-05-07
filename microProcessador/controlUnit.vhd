library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity controlUnit is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        instruction: in unsigned (11 downto 0);
        rom_clk : out std_logic;
        pc_clk : out std_logic;
        jump_en : out std_logic;
        jump_adress : out unsigned (7 downto 0)
        
    );
end entity controlUnit;

architecture a_controlUnit of controlUnit is

    component stateMachine is
        port (
            clk   : in std_logic;
            reset : in std_logic;
            state : out std_logic
        );
    end component;

    signal state_s : std_logic := '0';
    signal opcode : unsigned (3 downto 0) := "0000";
    
begin

    opcode <= instruction (11 downto 8);

    jump_en <=  '1' when opcode = "1111" else 
                '0';
    jump_adress <= instruction(7 downto 0);


    sm: stateMachine port map (
        clk => clk,
        reset => reset,
        state => state_s
    );

    rom_clk <= state_s;
    pc_clk <= not state_s;
    




    

end architecture;