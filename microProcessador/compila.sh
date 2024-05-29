ghdl -a 
ghdl -e microProcessor
ghdl -e processador_tb
ghdl -r processador_tb --wave=processador_tb.ghw
gtkwave processador.gtkw