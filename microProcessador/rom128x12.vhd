library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom128x12 is
   port( clk      : in std_logic;
         endereco : in unsigned(6 downto 0);
         dado     : out unsigned(11 downto 0) 
   );
end entity;
architecture a_rom128x12 of rom128x12 is
   type mem is array (0 to 127) of unsigned(11 downto 0);
   constant conteudo_rom : mem := (
      -- caso endereco => conteudo
      0  => "111100000010",
      1  => "100000000000",
      2  => "111100000110",
      3  => "000000000000",
      4  => "100000000000",
      5  => "000000000010",
      6  => "111100000011",
      7  => "000000000010",
      8  => "000000000010",
      9  => "000000000000",
      10 => "000000000000",
      -- abaixo: casos omissos => (zero em todos os bits)
      others => (others=>'0')
   );
begin
   process(clk)
   begin
      if(rising_edge(clk)) then
         dado <= conteudo_rom(to_integer(endereco));
      end if;
   end process;
end architecture;