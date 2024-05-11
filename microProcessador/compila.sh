ghdl -a stateMachine.vhd
ghdl -e stateMachine
ghdl -a stateMachine_tb.vhd
ghdl -e stateMachine_tb

ghdl -a rom128x12.vhd 
ghdl -e rom128x12
ghdl -a rom128x12_tb.vhd
ghdl -e rom128x12_tb

ghdl -a sum2x16.vhd
ghdl -e sum2x16
ghdl -a sum2x16_tb.vhd
ghdl -e sum2x16_tb

ghdl -a reg16bits.vhd
ghdl -e reg16bits       
ghdl -a reg16bits_tb.vhd
ghdl -e reg16bits_tb  

ghdl -a bankReg.vhd
ghdl -e bankReg                         
ghdl -a bankReg_tb.vhd
ghdl -e bankReg_tb

ghdl -a mux3x16bits.vhd
ghdl -e mux3x16bits    

ghdl -a ULA.vhd
ghdl -e ULA
ghdl -a ULA_tb.vhd
ghdl -e ULA_tb    

ghdl -a microProcessor.vhd
ghdl -e microProcessor  
ghdl -a microProcessor_tb.vhd
ghdl -e microProcessor_tb  

ghdl -a PC.vhd
ghdl -e PC
ghdl -a PC_tb.vhd
ghdl -e PC_tb

ghdl -a romAndPC.vhd
ghdl -e romAndPC
ghdl -a romAndPC_tb.vhd
ghdl -e romAndPC_tb

ghdl -a controlUnit.vhd
ghdl -e controlUnit

ghdl -a topLevel.vhd
ghdl -e topLevel
ghdl -a topLevel_tb.vhd
ghdl -e topLevel_tb

ghdl -r microProcessor_tb --wave=microProcessor_tb.ghw
gtkwave microProcessor_tb.ghw
