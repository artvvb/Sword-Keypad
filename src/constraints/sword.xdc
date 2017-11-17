set_property -dict { PACKAGE_PIN AD12   IOSTANDARD LVDS } [get_ports { clk_p }];#sch=FPGA_SYSCLK_P
set_property -dict { PACKAGE_PIN AD11   IOSTANDARD LVDS } [get_ports { clk_n }];#sch=FPGA_SYSCLK_N

set_property -dict { PACKAGE_PIN A11   IOSTANDARD LVCMOS33 } [get_ports { ss_clk  }];#sch=7SEG_CLK
set_property -dict { PACKAGE_PIN E11   IOSTANDARD LVCMOS33 } [get_ports { ss_dout }];#sch=7SEG_SDO
set_property -dict { PACKAGE_PIN A12   IOSTANDARD LVCMOS33 } [get_ports { ss_en   }];#sch=7SEG_EN