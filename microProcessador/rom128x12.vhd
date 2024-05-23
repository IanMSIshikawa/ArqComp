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
      0  => "0011011000000101",--ld r3, 5       a:
      1  => "0011100000001000",--ld r4, 8       b:
      2  => "1000111011101001",--movr a, r3     c:
      3  => "0001101100000001",--add a, r4
      4  => "0111101010010100",--mova r5, a
      5  => "0101101010000001",--subi a, 1      d:
      6  => "0111101000000000",--mova r5, a
      7  => "0110000000010100",--jump 20        e:--mudar para testar nop
      8  => "0011101010000000",--ld r5, 0       f:
      9  => "0000000000000000",
      10 => "0000000000000000",
      20 => "1000111101101001",--movr a, r5     g:
      21 => "0111011010000010",--mova r3, a
      22 => "0110000100000010",--jump 2         h:

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