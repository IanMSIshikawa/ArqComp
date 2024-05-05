library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity PC is
    port (
        clk   : in std_logic;
        reset : in std_logic;
        writeEnable : in std_logic;
        data_in : in unsigned (15 downto 0);
        data_out : out unsigned (15 downto 0)
    );
end entity PC;

architecture a_PC of PC is

    component reg16bits is
        port (
            clk      : in std_logic;
            rst      : in std_logic;
            wr_en    : in std_logic;
            data_in  : in unsigned(15 downto 0);
            data_out : out unsigned(15 downto 0)
            
        );
    end component;
    
    signal data_in_s, data_out_s : unsigned(15 downto 0) := "0000000000000000";
    

begin

    data_in_s <= data_out_s + 1;

    reg: reg16bits port map (
        clk => clk,
        rst => reset,
        wr_en => writeEnable,
        data_in => data_in_s,
        data_out => data_out_s
    );

    data_out <=data_out_s;


    

end architecture;