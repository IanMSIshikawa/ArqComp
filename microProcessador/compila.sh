ghdl -a *.vhd
ghdl -e microProcessor
ghdl -e microProcessor_tb
ghdl -r microProcessor_tb --wave=microProcessor_tb.ghw
gtkwave microProcessor.gtkw