// femtorv32, a minimalistic RISC-V RV32I core
//
//       Bruno Levy, 2020-2021
//
// This file: driver for UART (serial over USB)

`define CLKFREQ   (`NRV_FREQ*1000000) // Used by uart_impl.v (clk freq in Hz, NRV_FREQ is in MHz).
`include "uart_impl.v"                // (uart_impl is borrowed from J1 swapforth)

module UART(
    input wire 	       clk,   // system clock
    input wire 	       rstrb, // read strobe		
    input wire 	       wstrb, // write strobe
    input wire 	       sel,   // select data (rw) 	       
    input wire [31:0]  wdata, // data to be written
    output wire [31:0] rdata, // data read

    input wire 	       RXD, // UART pins
    output wire        TXD	    
);

/******************** UART Receiver ****************************/

   reg serial_valid_latched = 1'b0;
   wire serial_valid;
   wire [7:0] serial_rx_data;
   reg  [7:0] serial_rx_data_latched;
   rxuart rxUART( 
       .clk(clk),
       .resetq(1'b1),       
       .uart_rx(RXD),
       .rd(1'b1),
       .valid(serial_valid),
       .data(serial_rx_data) 
   );

   always @(posedge clk) begin
      if(serial_valid) begin
         serial_rx_data_latched <= serial_rx_data;
	 serial_valid_latched <= 1'b1;
      end
      if(rstrb && sel) begin
         serial_valid_latched <= 1'b0;
      end
   end

/******************** UART transmitter ****************************/

   wire       serial_tx_busy;
   wire       serial_tx_wr;
   uart txUART(
       .clk(clk),
       .uart_tx(TXD),	       
       .resetq(1'b1),
       .uart_busy(serial_tx_busy),
       .uart_wr_i(serial_tx_wr),
       .uart_dat_i(wdata[7:0])		 
   );

   assign rdata = sel ? {22'b0, serial_tx_busy, serial_valid_latched, serial_rx_data_latched} : 32'b0;
   assign serial_tx_wr = wstrb && sel;

endmodule
