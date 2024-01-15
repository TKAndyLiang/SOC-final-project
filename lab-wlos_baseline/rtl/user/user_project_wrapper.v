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
/*
 *-------------------------------------------------------------
 *
 * user_project_wrapper
 *
 * This wrapper enumerates all of the pins available to the
 * user for the user project.
 *
 * An example user project is provided in this wrapper.  The
 * example should be removed and replaced with the actual
 * user project.
 *
 *-------------------------------------------------------------
 */

module user_project_wrapper #(
    parameter BITS = 32
) (
`ifdef USE_POWER_PINS
    inout vdda1,	// User area 1 3.3V supply
    inout vdda2,	// User area 2 3.3V supply
    inout vssa1,	// User area 1 analog ground
    inout vssa2,	// User area 2 analog ground
    inout vccd1,	// User area 1 1.8V supply
    inout vccd2,	// User area 2 1.8v supply
    inout vssd1,	// User area 1 digital ground
    inout vssd2,	// User area 2 digital ground
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

    // Analog (direct connection to GPIO pad---use with caution)
    // Note that analog I/O is not available on the 7 lowest-numbered
    // GPIO pads, and so the analog_io indexing is offset from the
    // GPIO indexing by 7 (also upper 2 GPIOs do not have analog_io).
    inout [`MPRJ_IO_PADS-10:0] analog_io,

    // Independent clock (on independent integer divider)
    input   user_clock2,

    // User maskable interrupt signals
    output [2:0] user_irq
);

parameter pDATA_WIDTH = 32;
parameter pADDR_WIDTH = 12;
// WB responding signals
wire        wbs_ack_o_fir;
wire [31:0] wbs_dat_o_fir;

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
wire wbs_ack_o_user, wbs_ack_o_uart;
wire [31:0] wbs_dat_o_user, wbs_dat_o_uart;

always@(*) begin
	wbs_dat_o	= 0;
	wbs_ack_o	= 0;
	if(wbs_cyc_i && wbs_stb_i) begin
		if(wbs_adr_i[31:24] == 'h38) begin
			wbs_dat_o = wbs_dat_o_user;
			wbs_ack_o = wbs_ack_o_user;
		end
		else if(wbs_adr_i[31:24] == 'h30) begin
			wbs_dat_o = wbs_dat_o_uart;
			wbs_ack_o = wbs_ack_o_uart;
		end
		else if(wbs_adr_i[31:24] == 'h31) begin
			wbs_dat_o = wbs_dat_o_fir;
			wbs_ack_o = wbs_ack_o_fir;
		end
	end
end

/*--------------------------------------*/
/* User project is instantiated  here   */
/*--------------------------------------*/
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

uart uart (
`ifdef USE_POWER_PINS
	.vccd1(vccd1),	// User area 1 1.8V power
	.vssd1(vssd1),	// User area 1 digital ground
`endif
    .wb_clk_i(wb_clk_i),
    .wb_rst_i(wb_rst_i),

    // MGMT SoC Wishbone Slave

    .wbs_stb_i(wbs_stb_i),
    .wbs_cyc_i(wbs_cyc_i),
    .wbs_we_i(wbs_we_i),
    .wbs_sel_i(wbs_sel_i),
    .wbs_dat_i(wbs_dat_i),
    .wbs_adr_i(wbs_adr_i),
    .wbs_ack_o(wbs_ack_o_uart),
    .wbs_dat_o(wbs_dat_o_uart),

    // IO ports
    .io_in  (io_in      ),
    .io_out (io_out     ),
    .io_oeb (io_oeb     ),

    // irq
    .user_irq (user_irq)
);

endmodule	// user_project_wrapper


module WBToAXI(
    // WB
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output reg [31:0] wbs_dat_o,

    // AXI LITE
    input awready,
    input wready,
    output reg awvalid,
    output reg [11:0] awaddr,
    output reg wvalid,
    output reg [31:0] wdata,

    input arready,
    output reg rready,
    output reg arvalid,
    output reg [11:0] araddr,
    input rvalid,
    input [31:0] rdata
);

reg wbs_ack_o;
wire fir_valid;
wire fir_axil;
reg aw_handshaked;
reg w_handshaked;
reg ar_handshaked;

assign fir_valid = (wbs_stb_i == 1 && wbs_cyc_i == 1 && wbs_adr_i[31:24] == 'h31);
assign fir_axil = wbs_adr_i[7] == 0;

always@(posedge wb_clk_i or posedge wb_rst_i)begin
    if(wb_rst_i)begin
        aw_handshaked   <= 0;
        w_handshaked    <= 0;
        ar_handshaked   <= 0;
    end
    else begin
        if(wbs_ack_o)               aw_handshaked <= 0;
        else if(awvalid && awready) aw_handshaked <= 1;
        else                        aw_handshaked <= aw_handshaked;

        if(wbs_ack_o)               w_handshaked <= 0;
        else if(wvalid && wready)   w_handshaked <= 1;
        else                        w_handshaked <= w_handshaked;

        if(wbs_ack_o)               ar_handshaked <= 0;
        else if(arvalid && arready) ar_handshaked <= 1;
        else                        ar_handshaked <= ar_handshaked;
    end
end

// AXI LITE write
    // input awready,
    // input wready,
    // output awvalid,
    // output [11:0] awaddr,
    // output wvalid,
    // output [31:0] wdata,

always@(*) begin
    if(fir_valid && fir_axil) begin
        // awvalid
        awvalid = (wbs_we_i && !aw_handshaked);
        // wvalid
        wvalid = (wbs_we_i && !w_handshaked);
        // awaddr
        awaddr = wbs_adr_i[11:0];
        // wdata
        wdata = wbs_dat_i;

    end else begin
        awvalid = 0;
        awaddr  = 0;
        wvalid  = 0;
        wdata   = 0;
    end
end

// AXI LITE read
    // input arready,
    // output rready,
    // output arvalid,
    // output [11:0] araddr,
    // input rvalid,
    // input [31:0] rdata,

always@(*) begin
    if(fir_valid && fir_axil) begin
        // rready
        rready = (!wbs_we_i);
        // arvalid
        arvalid = (!wbs_we_i && !ar_handshaked);
        // araddr
        araddr = wbs_adr_i[11:0];

    end else begin
        rready  = 0;
        arvalid = 0;
        araddr  = 0;
    end
end

// ack to wb and wbs_dat_o
always@(*) begin
    wbs_dat_o = 0;

    if(fir_valid && fir_axil)
        wbs_dat_o = rdata;

    wbs_ack_o = ((w_handshaked == 1 && aw_handshaked == 1) 
              || (rready == 1 && rvalid == 1));
end

endmodule

module WB_to_User_Bram #(
    parameter BITS = 32,
    parameter DELAYS=10
)(
    // Wishbone Slave ports (WB MI A)
    input wb_clk_i,
    input wb_rst_i,
    input wbs_stb_i,
    input wbs_cyc_i,
    input wbs_we_i,
    input [3:0] wbs_sel_i,
    input [31:0] wbs_dat_i,
    input [31:0] wbs_adr_i,
    output wbs_ack_o,
    output [31:0] wbs_dat_o,
	
	// to DMA signals
    // input config for telling where and how many to fetch
    input wire dma_en,
    input wire [(BITS-1):0]  r_start_addr,
    input wire [(BITS-1):0]  w_start_addr,
    input wire [(BITS-1):0]  read_len,
    // 1 for write to user_bram, 0 for read from user_bram
    // input wire                      dma_write_en, 
	// DMA status
	output wire 					dma_busy,
    // Memory -> DMA buffer
    output wire                     sm_tready, 
    input  wire                     sm_tvalid, 
    input  wire [(BITS-1):0] sm_tdata, 
    input  wire                     sm_tlast, 
    // DMA buffer -> output interface 
    output wire                     ss_tlast,
    output wire [(BITS-1):0]        ss_tdata,
    output wire                     ss_tvalid,
    input  wire                     ss_tready
);
    wire clk;
    wire rst;

    reg [3:0] counter;
    reg valid;
    reg  [31:0] wbs_dat_o;
    reg ack;
	
	// wishbone to user_bram
    wire [3:0]  wb_write_en;
    wire [31:0] wb_address;
    wire [31:0] wb_data_in;
    wire [31:0] wb_data_out;
    wire to_user_bram;
	
	// dma to user_bram
    wire [3:0]  dma_write_en;
    wire [31:0] dma_address;
    wire [31:0] dma_data_in;
    wire [31:0] dma_data_out;
	
	// user_bram_priority arbitrator
	reg wb_or_dma; // 1 for dma, 0 for wb
    wire [3:0]  write_en;
    wire [31:0] address;
    wire [31:0] data_in;
    wire [31:0] data_out;
	
	always@(posedge clk or negedge rst) begin
		if(rst) wb_or_dma <= 0;
		else begin
			if(((wbs_cyc_i == 0) || (wbs_stb_i == 0)) && dma_busy == 1) begin
				wb_or_dma <= 1;
			end
			else if(dma_busy == 0) begin
				wb_or_dma <= 0;
			end
			else begin
				wb_or_dma <= wb_or_dma;
			end
		end
	end
	
    assign clk          = wb_clk_i;
    assign rst          = wb_rst_i;
    assign to_user_bram = (wbs_cyc_i && wbs_stb_i && wbs_adr_i[31:24] == 8'h38);
    assign wb_write_en  = to_user_bram ? {4{wbs_we_i}} & wbs_sel_i : 4'b0000;
    assign wb_address   = to_user_bram ? (wbs_adr_i - 32'h38000000) >> 2 : 32'h0;
    assign wb_data_in   = to_user_bram ? wbs_dat_i : 32'h0;
    assign wbs_ack_o    = ack;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            counter <= 0;
        end
        else begin
            if(wbs_ack_o)           counter <= 0;
            else if(to_user_bram)   counter <= counter + 1;
            else                    counter <= 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            ack <= 0;
        end
        else begin
            if(!wb_or_dma) begin
                if(counter == DELAYS - 1)   ack <= 1;
                else                        ack <= 0;
            end
            else ack <= 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            wbs_dat_o <= 0;
        end
        else begin
            if(counter == DELAYS - 1)   wbs_dat_o <= wb_data_out;
            else                        wbs_dat_o <= 0;
        end
    end
	
	DMA dma_u(
		// system signals
		.clk(clk),
		.rst_n(!rst),
		
		// DMA config
        .dma_valid(wb_or_dma),
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
		
		// dma to user_bram interfece
        .WE0(dma_write_en),
        .Di0(dma_data_in),
        .Do0(dma_data_out),
        .A0(dma_address)
	);

    reg [31:0] dma_data_out_10T [0:(DELAYS-1)];
    integer i;
    always@(posedge clk, posedge rst) begin
        if(rst) begin
            for(i=0; i<DELAYS; i=i+1) begin
                dma_data_out_10T[i] <= 0;
            end
        end else begin
            dma_data_out_10T[DELAYS-1] <= (wb_or_dma == 1) ? data_out : 0;
            for(i=0; i<(DELAYS-1); i=i+1) begin
                dma_data_out_10T[i] <= dma_data_out_10T[i+1];
            end
        end
    end
	
	assign write_en = (wb_or_dma == 1) ? dma_write_en : wb_write_en;
	assign data_in 	= (wb_or_dma == 1) ? dma_data_in : wb_data_in;
	assign address 	= (wb_or_dma == 1) ? dma_address : wb_address;
    assign wb_data_out = (wb_or_dma == 0) ? data_out : 0;
    // assign dma_data_out = (wb_or_dma == 1) ? data_out : 0;
    assign dma_data_out = dma_data_out_10T[0];
	
    bram user_bram (
        .CLK(clk),
        .WE0(write_en),
        .EN0(1'b1),
        .Di0(data_in),
        .Do0(data_out),
        .A0(address)
    );

endmodule

`default_nettype wire
