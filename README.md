# learn-fpga 
_Learning FPGA, yosys, nextpnr, and RISC-V_ 

Mission statement: create teaching material for FPGAs, processor design and RISC-V, using around $40 per students.

![](FemtoRV/TUTORIALS/Images/IceStick_hello.gif)

FemtoRV: a minimalistic RISC-V CPU
----------------------------------- 
FemtoRV is a minimalistic RISC-V design, with easy-to-read Verilog sources (less than 1000 lines), directly written
from the RISC-V specification. It includes a companion SOC, with drivers for an UART, a led matrix, a small OLED display,
SPI RAM and SDCard. Its most basic configuration fits on the Lattice IceStick (< 1280 LUTs). It can be used for teaching
processor design and RISC-V programming.

Quick links:
  - [FemtoRV](FemtoRV/README.md)
  - [IceStick tutorial](FemtoRV/TUTORIALS/IceStick.md)
  - [iCE40 Feather tutorial](FemtoRV/TUTORIALS/iCE_40_Feather.md) _WIP_
  - [ULX3S tutorial](FemtoRV/TUTORIALS/ULX3S.md)
  - [ECP5 eval board tutorial](FemtoRV/TUTORIALS/ECP5_EVN.md)
  - [FOMU tutorial](FemtoRV/TUTORIALS/FOMU.md)  
  - [Designing a RISC-V processor - the FemtoRV32](FemtoRV/TUTORIALS/DESIGN/FemtoRV32.md)      
  - [Notes on RISC-V software compilation](FemtoRV/TUTORIALS/software.md)

Basic: more basic things I wrote during May 2020 - June 2020  
------------------------------------------------------------
- Blinker: the "hello world" program
- LedMatrix: play with a 8x8 let matrix, driven by a MAX7219 IC. 
- OLed: play with a SSD1351 OLed display, driven by a 4-wire SPI protocol.
- Serial: access the included USB-virtual UART pins
- LedTerminal: display scrolling messages on the LED matrix, obtained from the USB virtual UART
