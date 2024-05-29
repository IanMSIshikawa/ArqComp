ghdl -a *.vhd
ghdl -e uProcessador
ghdl -e uUrocessador_tb
ghdl -r uProcessador_tb --wave=uProcessador_tb.ghw
gtkwave uProcessador.gtkw