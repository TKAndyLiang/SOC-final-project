module exmem #(
    parameter BITS = 32,
    parameter DELAYS=0
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
    output wbs_ack_o,
    output [31:0] wbs_dat_o

);
    wire clk;
    wire rst;
	
    reg [3:0] counter;
    reg valid;
    wire [31:0] data_out;
    reg [31:0] wbs_dat_o;
    reg ack;
    wire [3:0] write_en;
    wire [31:0] address;
    wire [31:0] data_in;
    wire to_user_bram;

    assign clk = wb_clk_i;
    assign rst = wb_rst_i;
    assign to_user_bram = (wbs_cyc_i && wbs_stb_i && wbs_adr_i[31:24] == 8'h38);
    assign write_en = to_user_bram ? {4{wbs_we_i}} & wbs_sel_i : 4'b0000;
    assign address = to_user_bram ? (wbs_adr_i-32'h38000000)>>2 : 32'h0;
    assign data_in = to_user_bram ? wbs_dat_i : 32'h0;
    assign wbs_ack_o = ack;

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            counter <= 0;
        end
        else begin
            if(wbs_ack_o) counter <= 0;
            else if(wbs_cyc_i && wbs_stb_i) counter <= counter + 1;
            else counter <= 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            ack <= 0;
        end
        else begin
            if(counter == DELAYS + 1) ack <= 1;
            else ack <= 0;
        end
    end

    always @(posedge clk or posedge rst) begin
        if(rst) begin
            wbs_dat_o <= 0;
        end
        else begin
            if(counter == DELAYS + 1) wbs_dat_o <= data_out;
            else wbs_dat_o <= 0;
        end
    end

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