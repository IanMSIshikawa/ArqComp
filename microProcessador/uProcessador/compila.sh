ghdl -a *.vhd
ghdl -e uProcessador
ghdl -e uProcessador_tb
ghdl -r uProcessador_tb --wave=uProcessador_tb.ghw
gtkwave uProcessador_tb.gtkw