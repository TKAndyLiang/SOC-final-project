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

`default_nettype wire
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

module fir 
#(  parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32,
    parameter Tape_Num    = 11
)
(
	// AXI-Lite write channel
    output  wire                     awready,
    output  wire                     wready,
    input   wire                     awvalid,
    input   wire [(pADDR_WIDTH-1):0] awaddr,
    input   wire                     wvalid,
    input   wire [(pDATA_WIDTH-1):0] wdata,
    
	// AXI-Lite read channel
    output  wire                     arready,
    input   wire                     rready,
    input   wire                     arvalid,
    input   wire [(pADDR_WIDTH-1):0] araddr,
    output  wire                     rvalid,
    output  reg  [(pDATA_WIDTH-1):0] rdata,    
	
	// DMA config
    output  reg                      dma_en,
	output  reg  [(pDATA_WIDTH-1):0] r_start_addr,
	output  reg  [(pDATA_WIDTH-1):0] w_start_addr,
	output  reg  [(pDATA_WIDTH-1):0] read_len,
	input	wire					 dma_busy,
	// output  reg						 dma_write_en,
	
	// AXI-Stream from DMA
    input   wire                     ss_tvalid, 
    input   wire [(pDATA_WIDTH-1):0] ss_tdata, 
    input   wire                     ss_tlast, 
    output  reg                      ss_tready, 
	
	// AXI-Stream to DMA
    input   wire                     sm_tready, 
    output  reg                      sm_tvalid, 
    output  wire [(pDATA_WIDTH-1):0] sm_tdata, 
    output  reg                      sm_tlast, 
    
    // bram for tap RAM
    output  wire [3:0]               tap_WE,
    output  wire                     tap_EN,
    output  wire [(pDATA_WIDTH-1):0] tap_Di,
    output  reg  [(pADDR_WIDTH-1):0] tap_A,
    input   wire [(pDATA_WIDTH-1):0] tap_Do,

    // bram for data RAM
    output  wire [3:0]               data_WE,
    output  wire                     data_EN,
    output  wire [(pDATA_WIDTH-1):0] data_Di,
    output  wire [(pADDR_WIDTH-1):0] data_A,
    input   wire [(pDATA_WIDTH-1):0] data_Do,
	
	// system signals
    input   wire                     axis_clk,
    input   wire                     axis_rst_n
);


    // write your code here!
    parameter   IDLE            = 2'b00, 
                WAIT_FOR_DATA   = 2'b01, 
                COMPUTE         = 2'b10,  
                RESET           = 2'b11;

    reg [1:0] current_state, next_state;

    reg [(pDATA_WIDTH-1):0] configuration;
    reg [(pDATA_WIDTH-1):0] data_length;
	reg [(pDATA_WIDTH-1):0] dma_r_start_addr;
	reg [(pDATA_WIDTH-1):0] dma_w_start_addr;

    reg [(pADDR_WIDTH-1):0] axilite_write_addr;
    reg [(pDATA_WIDTH-1):0] axilite_write_data;
    reg axilite_wdata_received;
    reg axilite_waddr_received;
    reg axilite_write_en;

    //reg [(pADDR_WIDTH-1):0] axilite_reg_raddr;
    reg [(pDATA_WIDTH-1):0] axilite_read_reg;
    reg axilite_out_valid;
    reg wait_tapram_data;
    reg axilite_raddr_received;
    reg [(pADDR_WIDTH-1):0] axilite_read_addr;
    reg read_data_length;
    reg read_configuration;
    
    reg first_data;
    reg [5:0] shift_counter;
    wire data_write_en;
    reg [3:0] data_read_stage;
    reg computing, outputing;
    reg last_data;
    reg signed [(pDATA_WIDTH-1):0] data_received;
    reg [9:0] data_counter;

    reg signed [(pDATA_WIDTH-1):0] accumulated_result;
    wire signed [(pDATA_WIDTH-1):0] mult_result;
    reg signed [(pDATA_WIDTH-1):0] mult1;
    wire signed [(pDATA_WIDTH-1):0] mult2;
    reg signed [(pDATA_WIDTH-1):0] current_data;

    always@(*) begin
        case(current_state)
            IDLE: begin
                if(configuration[0] == 1)   next_state = WAIT_FOR_DATA;
                else                        next_state = IDLE;
            end
            WAIT_FOR_DATA: begin
                if(ss_tvalid)   next_state = COMPUTE;
                else            next_state = WAIT_FOR_DATA;
            end
            COMPUTE: begin
                if(sm_tlast && sm_tready && sm_tvalid)  next_state = IDLE;
                else                                    next_state = COMPUTE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) current_state <= IDLE;
        else            current_state <= next_state;
    end

    //-------------------------------------tap sram----------------------------------------------------
    assign tap_EN = 1;

    // axi lite write
    assign awready = !axilite_waddr_received;
    assign wready = !axilite_wdata_received;
    assign tap_WE = {4{axilite_write_en && axilite_write_addr != 12'h00 && axilite_write_addr != 12'h10}};
    assign tap_Di = axilite_write_data;

    always@(*) begin
        axilite_write_en = (axilite_waddr_received && axilite_wdata_received);
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            axilite_write_addr <= 0;
        end
        else begin
            if(awvalid && awready)  axilite_write_addr <= awaddr;
            else                    axilite_write_addr <= axilite_write_addr;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            axilite_write_data <= 0;
        end
        else begin
            if(wvalid && wready) axilite_write_data <= wdata;
            else axilite_write_data <= axilite_write_data;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            axilite_waddr_received <= 0;
        end
        else begin
            if(awvalid && awready)      axilite_waddr_received <= 1;
            else if(axilite_write_en)   axilite_waddr_received <= 0;
            else                        axilite_waddr_received <= axilite_waddr_received;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            axilite_wdata_received <= 0;
        end
        else begin
            if(wvalid && wready)        axilite_wdata_received <= 1;
            else if(axilite_write_en)   axilite_wdata_received <= 0;
            else                        axilite_wdata_received <= axilite_wdata_received;
        end
    end

    // axi lite read
    assign arready = !rvalid && !axilite_write_en;
    assign rvalid = axilite_out_valid;

    always@(*) begin
        if(read_configuration)      rdata = {configuration[31:5], ss_tready, configuration[3:0]};
        else if(read_data_length)   rdata = data_length;
        else                        rdata = axilite_read_reg;
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            axilite_raddr_received <= 0;
        end
        else begin
            if(arvalid && arready)  axilite_raddr_received <= 1;
            else                    axilite_raddr_received <= 0;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            axilite_read_addr <= 0;
        end
        else begin
            if(arvalid && arready)  axilite_read_addr <= araddr;
            else                    axilite_read_addr <= axilite_read_addr;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            read_data_length <= 0;
        end
        else begin
            if(arvalid && arready && araddr == 12'h10)  read_data_length <= 1;
            else if(rvalid && rready)                   read_data_length <= 0;
            else                                        read_data_length <= read_data_length;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            read_configuration <= 0;
        end
        else begin 
            if(arvalid && arready && araddr == 12'h00)  read_configuration <= 1;
            else if(rvalid && rready)                   read_configuration <= 0;
            else                                        read_configuration <= read_configuration;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            wait_tapram_data <= 0;
        end
        else begin
            if(axilite_raddr_received)  wait_tapram_data <= 1;
            else                        wait_tapram_data <= 0;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            axilite_read_reg <= 0;
        end
        else begin 
            if(wait_tapram_data)    axilite_read_reg <= tap_Do;
            else                    axilite_read_reg <= axilite_read_reg;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            axilite_out_valid <= 0;
        end
        else begin
            if(rvalid && rready)        axilite_out_valid <= 0;
            else if(wait_tapram_data)   axilite_out_valid <= 1;
            else                        axilite_out_valid <= axilite_out_valid;
        end
    end

    // axi lite address control
    always@(*) begin
        if(axilite_raddr_received && (axilite_read_addr != 12'h00 && axilite_read_addr != 12'h10)) 
                                    tap_A = axilite_read_addr - 12'h40;
        else if(axilite_write_en)   tap_A = axilite_write_addr - 12'h40;
        else                        tap_A = computing ? data_read_stage * 4 : 0;
    end

    reg sm_done;
    wire task_done;
    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) sm_done <= 0;
        else begin
            if(configuration[0] == 1)                   sm_done <= 0;
            else if(sm_tready && sm_tvalid && sm_tlast) sm_done <= 1;
            else                                        sm_done <= sm_done;
        end
    end

    assign task_done = (sm_done && !dma_busy);
    // configuration and data length storage
    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            configuration <= 32'h0000_0004;
        end
        else begin 
            if(axilite_write_en && axilite_write_addr == 12'h00)    configuration <= axilite_write_data;
            else if(ss_tvalid && current_state == WAIT_FOR_DATA)    configuration <= configuration & 32'hFFFF_FFFE;
            else if(data_read_stage == 0)                           configuration <= configuration | 32'h0000_0020;
            else if(task_done)                                      configuration <= 32'h0000_0006;
            else if(rready && rvalid && read_configuration)         configuration <= configuration & 32'hFFFF_FFDD;
            else                                                    configuration <= configuration;
        end
    end

	// axilite get datalength
    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            data_length <= 0;
        end
        else begin
            if(axilite_write_en && axilite_write_addr == 12'h10)    data_length <= axilite_write_data;
            else                                                    data_length <= data_length;
        end
    end
	
	// axilite get dma_r_start_addr
    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            dma_r_start_addr <= 0;
        end
        else begin
            if(axilite_write_en && axilite_write_addr == 12'h14)    dma_r_start_addr <= axilite_write_data;
            else                                                    dma_r_start_addr <= dma_r_start_addr;
        end
    end

	// axilite get dma_w_start_addr
    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            dma_w_start_addr <= 0;
        end
        else begin
            if(axilite_write_en && axilite_write_addr == 12'h18)    dma_w_start_addr <= axilite_write_data;
            else                                                    dma_w_start_addr <= dma_w_start_addr;
        end
    end
	
	// fir config dma
	always@(posedge axis_clk or negedge axis_rst_n) begin
		if(!axis_rst_n) begin
			read_len <= 0;
			r_start_addr <= 0;
			w_start_addr <= 0;
            dma_en <= 0;
		end
		else begin
			if(configuration[0] == 1 && !dma_busy) begin
				read_len <= data_length;
				r_start_addr <= dma_r_start_addr;
				w_start_addr <= dma_w_start_addr;
                dma_en <= 1;
			end
			else begin
				read_len <= read_len;
				r_start_addr <= r_start_addr;
				w_start_addr <= w_start_addr;
                dma_en <= 0;
			end
		end
	end

    //------------------------------------COMPUTE state logic-----------------------------------------------------------
    // data sram control
    assign data_EN = (current_state == COMPUTE);
    assign data_write_en = (data_read_stage == 0 || first_data);
    assign data_WE = {4{data_write_en}};
    assign data_A = (computing) ? ((shift_counter==0) ? 'd40 : shift_counter - 4) : shift_counter;
    assign mult2 = tap_Do;
    assign data_Di = first_data ? ((data_read_stage == 0) ? data_received : 0) : data_received;
    assign mult_result = mult1 * mult2;
    assign sm_tdata = accumulated_result;

    always@(*) begin
        if(data_read_stage == 10) begin
            if(data_counter >= data_length) mult1 = 0;
            else                            mult1 = data_received;
        end
        else begin
            if(first_data)  mult1 = 0;
            else            mult1 = data_Do;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            data_counter <= 0;
        end
        else begin
            if(next_state == IDLE)          data_counter <= 0;
            else if(sm_tready && sm_tvalid) data_counter <= data_counter + 1;
            else                            data_counter <= data_counter;
        end
    end
    
    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            data_received <= 0;
        end
        else begin
            if(ss_tready && ss_tvalid)  data_received <= ss_tdata;
            else                        data_received <= data_received;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            last_data <= 0;
        end
        else begin
            if(next_state == IDLE)          last_data <= 0;
            else if(ss_tready && ss_tvalid) last_data <= ss_tlast;
            else                            last_data <= last_data;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            computing <= 0;
        end
        else begin
            if(ss_tready && ss_tvalid)      computing <= 1;
            else if(data_read_stage == 0)   computing <= 0;
            else                            computing <= computing;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            outputing <= 0;
        end
        else begin
            if(data_read_stage == 0)        outputing <= 1;
            else if(sm_tready && sm_tvalid) outputing <= 0;
            else                            outputing <= outputing;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            data_read_stage <= 10;
        end
        else begin
            if(current_state ==COMPUTE) begin
                if(sm_tready && sm_tvalid)      data_read_stage <= 10;
                else if(computing) begin
                    if(data_read_stage == 0)    data_read_stage <= 10;
                    else                        data_read_stage <= data_read_stage - 1;
                end
                else                            data_read_stage <= data_read_stage;
            end
            else                                data_read_stage <= data_read_stage;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            current_data <= 0;
        end
        else begin
            if(data_read_stage == 1)    current_data <= data_Do;
            else                        current_data <= current_data;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            first_data <= 0;
        end
        else begin
            if(current_state == WAIT_FOR_DATA && next_state == COMPUTE) first_data <= 1;
            else if(data_read_stage == 0)                               first_data <= 0;
            else                                                        first_data <= first_data;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            shift_counter <= 40;
        end
        else begin
            if(next_state == IDLE)      shift_counter <= 40;
            else if(computing || (sm_tready && sm_tvalid)) begin
                if(shift_counter == 0)  shift_counter <= 40;
                else                    shift_counter <= shift_counter - 4;
            end
            else                        shift_counter <= shift_counter;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            accumulated_result <= 0;
        end
        else begin
            if(sm_tready && sm_tvalid)  accumulated_result <= 0;
            else if(computing)          accumulated_result <= accumulated_result + mult_result;
            else                        accumulated_result <= accumulated_result;
        end
    end


    // ss control
    always@(*) begin
        ss_tready = (!computing && !outputing && current_state == COMPUTE);
    end

    // sm control
    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            sm_tvalid <= 0;
        end
        else begin
            if(sm_tready && sm_tvalid)      sm_tvalid <= 0;
            else if(data_read_stage == 0)   sm_tvalid <= 1;
            else                            sm_tvalid <= sm_tvalid;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin
            sm_tlast <= 0;
        end
        else begin
            if(sm_tvalid && sm_tready)      sm_tlast <= 0;
            else if(data_read_stage == 0)   sm_tlast <= (data_counter == data_length - 1);
            else                            sm_tlast <= sm_tlast;
        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin

        end
        else begin

        end
    end

    always@(posedge axis_clk or negedge axis_rst_n) begin
        if(!axis_rst_n) begin

        end
        else begin

        end
    end


endmodule

module bram11 (clk, we, re, waddr, raddr, wdi, rdo);
    // `define RAMinitFile "./init.dat"
    parameter ADDR_WIDTH = 12;
    parameter SIZE = 11;
    parameter BIT_WIDTH = 32;
    input                          clk;
    input                          we, re;
    input [ADDR_WIDTH-1:0]         waddr, raddr;
    input [BIT_WIDTH-1:0]          wdi;
    output reg [BIT_WIDTH-1:0]     rdo;
    reg [BIT_WIDTH-1:0] RAM [SIZE-1:0];
    // initial $readmemh(`RAMinitFile, RAM);
    
    always @(posedge clk)begin
        if(re) rdo <= RAM[raddr>>2];
    end
    
    always @(posedge clk)begin
        if(we) RAM[waddr>>2] <= wdi;
    end
    
endmodule

module DMA #(
    parameter pADDR_WIDTH = 12,
    parameter pDATA_WIDTH = 32
)
(
	// system signals
	input wire 						clk,
	input wire 						rst_n,
	
    // input config for telling where and how many to fetch
	// these signals are from fir.v
    input wire                      dma_valid,
    input wire                      dma_en,
    input wire [(pDATA_WIDTH-1):0]  r_start_addr, // 0x38000200
    input wire [(pDATA_WIDTH-1):0]  w_start_addr, // 0x38000404
    input wire [(pDATA_WIDTH-1):0]  read_len,
	
    // 1 for write to user_bram, 0 for read from user_bram
    // input wire                      dma_write_en, 
	
	// DMA status
	output reg 						dma_busy,

    // Memory -> DMA buffer
    output reg                      sm_tready, 
    input  wire                     sm_tvalid, 
    input  wire [(pDATA_WIDTH-1):0] sm_tdata, 
    input  wire                     sm_tlast, 

    // DMA buffer -> output interface 
    output reg                      ss_tlast,
    output reg  [(pDATA_WIDTH-1):0] ss_tdata,
    output reg                      ss_tvalid,
    input  wire                     ss_tready,
	
	// user_bram interface
	output reg  [(pDATA_WIDTH-1):0] A0,
	output reg  [(pDATA_WIDTH-1):0] Di0,
	output reg  [3:0] 			   	WE0,
	input  wire [(pDATA_WIDTH-1):0] Do0 // read data from user_bram and pass to fir

);

reg [6:0] ans_cnt;
reg [3:0] cal_cnt; // for 12T fir calculation
reg [3:0] delay_cnt; // user_bram 10T delay
reg [6:0] read_cnt; // count to read_data_len
reg [6:0] write_cnt;
reg [6:0] buf_cnt;
reg [31:0] read_buffer [0:63];
reg [31:0] write_buffer [0:63];
reg [31:0] addr;
reg read_flag;
reg write_flag;

always@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        delay_cnt <= 0;
    end else begin
        if(dma_valid) begin
            if(delay_cnt < 9)   delay_cnt <= delay_cnt + 1;
            else                delay_cnt <= delay_cnt;
        end
        else begin
            delay_cnt <= 0;
        end
    end
end

always@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        read_cnt <= 0;
    end else begin
        if(dma_valid) begin
            if(read_cnt < read_len) read_cnt <= read_cnt + 1;
            else                    read_cnt <= read_cnt;
        end
        else begin
            read_cnt <= 0;
        end
    end
end

always@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        buf_cnt <= 0;
    end else begin
        if(dma_valid) begin
            if(buf_cnt < read_len && read_cnt >= 11)buf_cnt <= buf_cnt + 1;
            else                                    buf_cnt <= buf_cnt;
        end
        else begin
            buf_cnt <= 0;
        end
    end
end

always@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        read_flag <= 0;
        write_flag <= 0;
    end
    else begin
        if(dma_valid) begin
            // read_flag
            if(buf_cnt < read_len - 1)  read_flag <= 1;
            else                        read_flag <= 0;

            // write flag
            if(sm_tlast)                    write_flag <= 1;
            else if(write_cnt < read_len -1)write_flag <= write_flag;
            else                            write_flag <= 0;
        end
    end
end

genvar i;
generate
    for(i=0; i<64; i=i+1) begin :READ_BUFFER
        always@(posedge clk, negedge rst_n) begin
            if(!rst_n) begin
                read_buffer[i] <= 0;
            end else begin
                if(i == buf_cnt && read_flag) begin
                    read_buffer[i] <= Do0;
                end
            end
        end
    end
endgenerate

always@(*) begin
    if(write_flag == 0) addr = (r_start_addr - 32'h38000000 + (read_cnt << 2)) >> 2;
    else                addr = (w_start_addr - 32'h38000000 + (write_cnt << 2)) >> 2;
end

always@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        cal_cnt <= 13;
    end else begin
        if(dma_valid && delay_cnt == 9) begin
            if(cal_cnt < 13)        cal_cnt <= cal_cnt + 1;
            else if(cal_cnt == 13)  cal_cnt <= 1;
        end
        else begin
            cal_cnt <= 13;
        end
    end
end

always@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        ans_cnt <= 0;
    end else begin
        if(dma_valid) begin
            if(cal_cnt == 2)        ans_cnt <= ans_cnt + 1;
            else                    ans_cnt <= ans_cnt;
        end
        else begin
            ans_cnt <= 0;
        end
    end
end

// ss part
always@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        ss_tlast <= 0;
        ss_tvalid <= 0;
        ss_tdata <= 0;
    end else begin
        if(dma_valid) begin
            if(delay_cnt == 9) begin
                ss_tvalid <= (cal_cnt == 13 || cal_cnt == 1);
                ss_tlast <= (cal_cnt == 13 || cal_cnt == 1);
                ss_tdata <= read_buffer[ans_cnt];
            end
        end
    end
end

// sm part
always@(posedge clk, negedge rst_n) begin
    if(!rst_n) begin
        sm_tready <= 0;
    end else begin
        sm_tready <= (dma_busy) ? 1 : 0;
    end
end

genvar j;
generate
    for(j=0; j<64; j=j+1) begin :WRITE_BUFFER
        always@(posedge clk, negedge rst_n) begin
            if(!rst_n) begin
                write_buffer[j] <= 0;
            end else begin
                if(j == ans_cnt - 1 && (sm_tready && sm_tvalid)) begin
                    write_buffer[j] <= sm_tdata;
                end
            end
        end
    end
endgenerate

always@(posedge clk, negedge rst_n) begin
    if(!rst_n)  write_cnt <= 0;
    else begin
        if(dma_valid) begin
            if(write_flag) begin
                if(write_cnt < read_len)    write_cnt <= write_cnt + 1;
                else                        write_cnt <= write_cnt;
            end
        end
        else begin
            write_cnt <= 0;
        end
    end
end

// user bram interface
always@(*) begin
    A0 = 0;
    Di0 = 0;
    WE0 = 0;
    if(dma_valid) begin
        A0 = addr;
        Di0 = (write_flag) ? write_buffer[write_cnt] : 0;
        WE0 = {4{write_flag}};
    end
end

always@(posedge clk, negedge rst_n) begin
	if(!rst_n)	dma_busy <= 0;
	else begin
        if(dma_en)                      dma_busy <= 1;
        else if(write_cnt == read_len)  dma_busy <= 0;
        else                            dma_busy <= dma_busy;
	end
end

endmodule

`default_nettype wire
