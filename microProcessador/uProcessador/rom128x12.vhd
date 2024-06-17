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
      0  => B"0011_001_000_000001",--ld r1, 1       
      1  => B"0011_010_000_000010",--ld r2, 2       
      2  => B"0011_101_000_000110",--ld r5, 6     
      3  => B"0011_011_111_111111",--ld r3, 32 
      4  => B"1000_000_010_000000",--movr a, r2       
      5  => B"1101_000_010_000000",--sw r2    
      6  => B"1000_000_001_000000",--movr a, r1
      7  => B"0001_000_010_000000",--add r2     
      8  => B"0111_010_000_000000",--mova r2, a
      9  => B"0100_000_011_000000",--sub r3    
      10 => B"1011_111_111_111010",--jc -6
      11 => B"0011_010_000_000010",--ld r2, 2
      12 => B"1000_000_010_000000",--movr a, r2
      13 => B"0001_000_010_000000",--add r2
      14 => B"0111_100_000_000000",--mova r4, a
      15 => B"1000_000_000_000000",--movr a, r0
      16 => B"1101_000_100_000000",--sw r4
      17 => B"1000_000_100_000000",--movr a, r4
      18 => B"0001_000_010_000000",--add r2
      19 => B"0111_100_000_000000",--mova r4, a
      20 => B"0100_000_011_000000",--sub r3
      21 => B"1011_111_111_111010",--jc -6
      22 => B"1000_000_010_000000",--movr a, r2
      23 => B"0001_000_001_000000",--add r1
      24 => B"0111_010_000_000000",--mova r2
      25 => B"1000_000_010_000000",--movr a, r2
      26 => B"0100_000_101_000000",--sub r5
      27 => B"1011_111_111_110001",--jc -15
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