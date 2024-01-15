// SPDX-FileCopyrightText: 2020 Efabless Corporation
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
// SPDX-License-Identifier: Apache-2.0

`default_nettype none
`include "/home/ubuntu/final_project/lab-wlos_baseline/rtl/user/fir.v"
`include "/home/ubuntu/final_project/lab-wlos_baseline/rtl/user/dma.v"
`include "/home/ubuntu/final_project/lab-wlos_baseline/rtl/user/bram11.v"

/*
 *-------------------------------------------------------------
 *
 * user_proj_example
 *
 * This is an example of a (trivially simple) user project,
 * showing how the user project can connect to the logic
 * analyzer, the wishbone bus, and the I/O pads.
 *
 * This project generates an integer count, which is output
 * on the user area GPIO pads (digital output only).  The
 * wishbone connection allows the project to be controlled
 * (start and stop) from the management SoC program.
 *
 * See the testbenches in directory "mprj_counter" for the
 * example programs that drive this user project.  The three
 * testbenches are "io_ports", "la_test1", and "la_test2".
 *
 *-------------------------------------------------------------
 */

module user_proj_example #(
    parameter BITS = 32,
    parameter DELAYS=10,
    parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)(
`ifdef USE_POWER_PINS
    inout vccd1,	// User area 1 1.8V supply
    inout vssd1,	// User area 1 digital ground
`endif

    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output reg wbs_ack_o,
    output reg [31:0] wbs_dat_o,

    // Logic Analyzer Signals
    input  [127:0] la_data_in,
    output [127:0] la_data_out,
    input  [127:0] la_oenb,

    // IOs
    input  [`MPRJ_IO_PADS-1:0] io_in,
    output [`MPRJ_IO_PADS-1:0] io_out,
    output [`MPRJ_IO_PADS-1:0] io_oeb,

    // IRQ
    output [2:0] irq
);
    // wire clk;
    // wire rst;

    wire [`MPRJ_IO_PADS-1:0] io_in;
    wire [`MPRJ_IO_PADS-1:0] io_out;
    wire [`MPRJ_IO_PADS-1:0] io_oeb;

    // WB responding signals
    wire        wbs_ack_o_fir;
    wire [31:0] wbs_dat_o_fir;
    wire        wbs_ack_o_user;
    wire [31:0] wbs_dat_o_user;

    wire [3:0]               tap_WE;
    wire                     tap_EN;
    wire [(pDATA_WIDTH-1):0] tap_Di;
    wire [(pADDR_WIDTH-1):0] tap_A;
    wire [(pDATA_WIDTH-1):0] tap_Do;

    // bram for data RAM
    wire [3:0]               data_WE;
    wire                     data_EN;
    wire [(pDATA_WIDTH-1):0] data_Di;
    wire [(pADDR_WIDTH-1):0] data_A;
    wire [(pDATA_WIDTH-1):0] data_Do;

    // AXI LITE
    wire awready;
    wire wready;
    wire awvalid;
    wire [11:0] awaddr;
    wire wvalid;
    wire [31:0] wdata;

    wire arready;
    wire rready;
    wire arvalid;
    wire [11:0] araddr;
    wire rvalid;
    wire [31:0] rdata;
	
	// DMA config
    wire dma_en;
	wire [31:0] r_start_addr;
	wire [31:0] w_start_addr;
	wire [31:0] read_len;
	// wire dma_write_en;
	wire dma_busy;

    // AXI stream
    wire ss_tvalid; 
    wire [31:0] ss_tdata; 
    wire ss_tlast; 
    wire ss_tready; 

    wire sm_tready; 
    wire sm_tvalid; 
    wire [31:0] sm_tdata; 
    wire sm_tlast;

    always@(*) begin
        wbs_ack_o = 0;
        wbs_dat_o = 0;
        if(wbs_cyc_i && wbs_stb_i) begin
            if(wbs_adr_i[31:24] == 'h30) begin
                wbs_ack_o = wbs_ack_o_fir;
                wbs_dat_o = wbs_dat_o_fir;
            end
            else if(wbs_adr_i[31:24] == 'h38) begin
                wbs_ack_o = wbs_ack_o_user;
                wbs_dat_o = wbs_dat_o_user;
            end
        end
    end

    WB_to_User_Bram wb_to_userbram_u (
         .wb_clk_i(wb_clk_i),
         .wb_rst_i(wb_rst_i),
         .wbs_stb_i(wbs_stb_i),
         .wbs_cyc_i(wbs_cyc_i),
         .wbs_we_i(wbs_we_i),
         .wbs_sel_i(wbs_sel_i),
         .wbs_dat_i(wbs_dat_i),
         .wbs_adr_i(wbs_adr_i),
         .wbs_ack_o(wbs_ack_o_user),
         .wbs_dat_o(wbs_dat_o_user),
		 
		 // DMA signals
         .dma_en(dma_en),
		 .r_start_addr(r_start_addr),
		 .w_start_addr(w_start_addr),
		 .read_len(read_len),
		 // .dma_write_en(dma_write_en),
		 .dma_busy(dma_busy),
		 
		 .sm_tready(sm_tready), 
		 .sm_tvalid(sm_tvalid), 
		 .sm_tdata(sm_tdata), 
		 .sm_tlast(sm_tlast), 
		 
		 .ss_tlast(ss_tlast),
		 .ss_tdata(ss_tdata),
		 .ss_tvalid(ss_tvalid),
		 .ss_tready(ss_tready)
    );

    WBToAXI wbtoaxi_u (
        // WB
        .wb_clk_i(wb_clk_i),
        .wb_rst_i(wb_rst_i),
        .wbs_stb_i(wbs_stb_i),
        .wbs_cyc_i(wbs_cyc_i),
        .wbs_we_i(wbs_we_i),
        .wbs_sel_i(wbs_sel_i),
        .wbs_dat_i(wbs_dat_i),
        .wbs_adr_i(wbs_adr_i),
        .wbs_ack_o(wbs_ack_o_fir),
        .wbs_dat_o(wbs_dat_o_fir),

        // AXI LITE
        .awready(awready),
        .wready(wready),
        .awvalid(awvalid),
        .awaddr(awaddr),
        .wvalid(wvalid),
        .wdata(wdata),

        .arready(arready),
        .rready(rready),
        .arvalid(arvalid),
        .araddr(araddr),
        .rvalid(rvalid),
        .rdata(rdata)
    );

    fir fir_1(
        // AXI LITE
        .awready(awready),
        .wready(wready),
        .awvalid(awvalid),
        .awaddr(awaddr),
        .wvalid(wvalid),
        .wdata(wdata),

        .arready(arready),
        .rready(rready),
        .arvalid(arvalid),
        .araddr(araddr),
        .rvalid(rvalid),
        .rdata(rdata),
		
		// DMA config
        .dma_en(dma_en),
		.r_start_addr(r_start_addr),
		.w_start_addr(w_start_addr),
		.read_len(read_len),
		// .dma_write_en(dma_write_en),
		.dma_busy(dma_busy),
		
        // AXI stream
        .ss_tvalid(ss_tvalid), 
        .ss_tdata(ss_tdata), 
        .ss_tlast(ss_tlast), 
        .ss_tready(ss_tready), 

        .sm_tready(sm_tready), 
        .sm_tvalid(sm_tvalid), 
        .sm_tdata(sm_tdata), 
        .sm_tlast(sm_tlast), 
    
        // bram for tap RAM
        .tap_WE(tap_WE),
        .tap_EN(tap_EN),
        .tap_Di(tap_Di),
        .tap_A(tap_A),
        .tap_Do(tap_Do),

        // bram for data RAM
        .data_WE(data_WE),
        .data_EN(data_EN),
        .data_Di(data_Di),
        .data_A(data_A),
        .data_Do(data_Do),

        .axis_clk(wb_clk_i),
        .axis_rst_n(!wb_rst_i)
    );
	

    bram11 data_ram (
        .clk(wb_clk_i),
        .we(data_WE[0]),
        .re(data_EN),
        .waddr(data_A),
        .raddr(data_A),
        .wdi(data_Di),
        .rdo(data_Do)
    );

    bram11 tap_ram (
        .clk(wb_clk_i),
        .we(tap_WE[0]),
        .re(tap_EN),
        .waddr(tap_A),
        .raddr(tap_A),
        .wdi(tap_Di),
        .rdo(tap_Do)
    );
    
    // bram user_bram (
    //     .CLK(clk),
    //     .WE0(),
    //     .EN0(),
    //     .Di0(),
    //     .Do0(),
    //     .A0()
    // );

endmodule


`default_nettype wire
