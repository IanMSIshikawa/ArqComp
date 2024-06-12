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
      0  => B"0011_011_000_000101",--ld r3, 5       a:carrega registrador 3 com 5
      1  => B"0011_100_000_001000",--ld r4, 8       b:carrega registrador 4 com 8 
      2  => B"1000_000_011_000000",--movr a, r3     c:armazena r3 no endereco r4 da ram
      3  => B"1101_000_100_000000",--sw r4
      4  => B"1100_101_100_000000",--lw r5, r4      d:carrega registrador 5 com o valor armazenado no endereco r4 da ram
      5  => B"0000_000_000_000000",
      6  => B"0000_000_000_000000",
      7  => B"0000_000_000_000000",
      8  => B"0000_000_000_000000",
      9  => B"0000_000_000_000000",
      10 => B"0000_000_000_000000",
      11 => B"0000_000_000_000000",
      12 => B"0000_000_000_000000",
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