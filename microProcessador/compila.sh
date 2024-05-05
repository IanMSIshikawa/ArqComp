ghdl -a rom128x12.vhd 
ghdl -e rom128x12
ghdl -a rom128x12_tb.vhd
ghdl -e rom128x12_tb
ghdl -r rom128x12_tb --wave=rom128x12_tb.ghw