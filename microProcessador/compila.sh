ghdl -a *.vhd
ghdl -e ctrlUePCeROM
ghdl -e ctrlUePCeROM_tb
ghdl -r ctrlUePCeROM_tb --wave=ctrlUePCeROM_tb.ghw
gtkwave ctrlUePCeROM_tb.ghw