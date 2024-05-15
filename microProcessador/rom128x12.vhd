library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
entity rom128x12 is
   port( clk      : in std_logic;
         endereco : in unsigned(11 downto 0);
         dado     : out unsigned(15 downto 0) 
   );
end entity;
architecture a_rom128x12 of rom128x12 is
   type mem is array (0 to 127) of unsigned(15 downto 0);
   constant conteudo_rom : mem := (
      -- caso endereco => conteudo
      0  => "0010011011000101",--addi r3, r3, 5
      1  => "0010100100001000",--addi r4, r4, 8
      2  => "0001101011100000",--add  r5, r3, r4
      3  => "0101101101000001",--subi r5, r5, 1
      4  => "0110000000010100",--j 20
      5  => "0011101010000000",--ld r5, 0
      6  => "0000000000000000",
      7  => "0000000000000000",
      8  => "0000000000000000",
      9  => "0000000000000000",
      10 => "0000000000000000",
      20 => "0010011101000000",--addi r3, r5, 0
      21 => "0110000000000010",--j 2  
      22 => "0011011010000000",-- ld r3 0
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