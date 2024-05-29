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
      0  => B"0011_011_000_000000",--ld r3, 0       a:
      1  => B"0011_100_000_001000",--ld r4, 8       b:
      2  => B"1000_000_011_000000",--movr a, r3     c:
      3  => B"0001_000_100_000000",--add a, r4
      4  => B"0111_100_000_000000",--mova r4, a
      5  => B"1000_000_011_000000",--movr a, r3     d:
      6  => B"0010_000_000_000001",--addi a, 1
      7  => B"0111_011_000_000000",--mova r3, a
      8  => B"1000_000_011_000000",--movr a, r3     e:
      9  => B"0101_000_000_011110",--subi a, 30  
      10 => B"1011_111_111_111000",--jc -8
      11 => B"1000_000_100_000000",--movr a, r4     f:
      12 => B"0111_101_000_000000",--mova r5, a
      13 => B"0000_000_000_000000",
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