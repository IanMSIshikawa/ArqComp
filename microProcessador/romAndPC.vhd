library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity romAndPC is
    port (
        clk, reset: in std_logic;
        dataOut: out unsigned (11 downto 0)
    );
end entity romAndPC;

architecture a_romAndPC of romAndPC is

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

    signal pc_out : unsigned (15 downto 0) := "0000000000000000";

    

begin

    progCont: PC port map (
        clk => clk,
        reset => reset,
        writeEnable => '1',
        data_in => "0000000000000000",
        data_out => pc_out

    );

    rom: rom128x12 port map (
        clk => clk,
        dado => dataOut,
        endereco => pc_out (6 downto 0)
    );

    

end architecture;