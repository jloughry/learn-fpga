/*
 *  The PLL, that generates the internal clock (high freq) from the 
 * external one (lower freq).
 *  Trying to make something that is portable between different boards
 *  For now, ICEStick, ULX3S, ECP5 evaluation boards, FOMU supported.
 *  WIP: IceFeather
 */ 

`ifdef BENCH
 `define PASSTHROUGH_PLL
`endif

/**********************************************************************/

`ifdef PASSTHROUGH_PLL
module femtoPLL #(
 parameter freq = 60
) (
 input 	pclk,
 output clk	   
);
   assign clk = pclk;   
endmodule
`endif

/**********************************************************************/

`ifdef  ICE_STICK 
 `include "pll_icestick.v"
`elsif ICE_FEATHER
 `include "pll_icefeather.v"
`elsif ULX3S
 `include "pll_ulx3s.v"
`elsif ECP5_EVN
 `include "pll_ecp5_evn.v"
`elsif FOMU
 `include "pll_fomu.v"
`endif
   

