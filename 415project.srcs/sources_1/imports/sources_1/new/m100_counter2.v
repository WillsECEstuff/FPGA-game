`timescale 1ns / 1ps


module m100_counter2(
    input wire clk, reset,
    input wire [9:0] posx1, posx2,
    input wire d_inc, add10,
    input wire [9:0] pix_x, pix_y,
    output wire isOn, add100
    );
    
    localparam posy1 = 36;
    localparam posy2 = 43;
    //signal declaration
    reg add100reg;
    reg [3:0] dig0_reg, dig1_reg, dig0_next, dig1_next;
    //reg [3:0] dig0_reg, dig0_next;
    wire [2:0] rom_addr1, rom_col1, rom_addr2, rom_col2;
    reg [7:0] rom_data1, rom_data2;
    wire rom_bit1, rom_bit2;
    
    //registers
    always @(posedge clk, posedge reset)
        if (reset)
            begin
                dig1_reg <= 0;
                dig0_reg <= 0;
                
            end
        else
            begin
                dig1_reg <= dig1_next;
                dig0_reg <= dig0_next;
            end
 
    //next state logic
    always @*
    begin
        dig0_next = dig0_reg;
        dig1_next = dig1_reg;
        if (d_inc)
            if (dig0_reg == 9 && add10 == 1)
                begin
                    dig0_next = 0;
                    add100reg = 1;
                    /*
                        if (dig1_reg == 9)
                            dig1_next = 0;
                        else
                            dig1_next = dig1_reg + 1; */
                end
            else if (add10 == 1) begin
                dig0_next = dig0_reg + 1;
                add100reg = 0;
            end
     end
     
     always @*
     begin
     case (dig0_reg)
        0: case (rom_addr1)
            3'h0: rom_data1 = 8'b00111100; //   ****
            3'h1: rom_data1 = 8'b01100110; //  **  **
            3'h2: rom_data1 = 8'b11000011; // **   ***
            3'h3: rom_data1 = 8'b11000011; // **  * **
            3'h4: rom_data1 = 8'b11000011; // ** *  **
            3'h5: rom_data1 = 8'b11000011; // ***   **
            3'h6: rom_data1 = 8'b01100110; //  **  **
            3'h7: rom_data1 = 8'b00111100; //   ****
           endcase
        1: case (rom_addr1)
            3'h0: rom_data1 = 8'b00011100; //   ****
            3'h1: rom_data1 = 8'b00011110; //  **  **
            3'h2: rom_data1 = 8'b00011011; // **   ***
            3'h3: rom_data1 = 8'b00011000; // **  * **
            3'h4: rom_data1 = 8'b00011000; // ** *  **
            3'h5: rom_data1 = 8'b00011000; // ***   **
            3'h6: rom_data1 = 8'b00011000; //  **  **
            3'h7: rom_data1 = 8'b01111110; //   ****
           endcase 
       2: case (rom_addr1)
            3'h0: rom_data1 = 8'b00111100; //   ****
            3'h1: rom_data1 = 8'b01100110; //  **  **
            3'h2: rom_data1 = 8'b11000011; // **   ***
            3'h3: rom_data1 = 8'b01100001; // **  * **
            3'h4: rom_data1 = 8'b00110000; // ** *  **
            3'h5: rom_data1 = 8'b00001100; // ***   **
            3'h6: rom_data1 = 8'b00000110; //  **  **
            3'h7: rom_data1 = 8'b01111111; //   ****
           endcase
       3: case (rom_addr1)
            3'h0: rom_data1 = 8'b00111100; //   ****
            3'h1: rom_data1 = 8'b01100110; //  **  **
            3'h2: rom_data1 = 8'b11000011; // **   ***
            3'h3: rom_data1 = 8'b01111000; // **  * **
            3'h4: rom_data1 = 8'b01111000; // ** *  **
            3'h5: rom_data1 = 8'b11000011; // ***   **
            3'h6: rom_data1 = 8'b01100110; //  **  **
            3'h7: rom_data1 = 8'b00111100; //   ****
           endcase
       4: case (rom_addr1)
            3'h0: rom_data1 = 8'b01111000; //   ****
            3'h1: rom_data1 = 8'b01101100; //  **  **
            3'h2: rom_data1 = 8'b01100110; // **   ***
            3'h3: rom_data1 = 8'b01111111; // **  * **
            3'h4: rom_data1 = 8'b01100000; // ** *  **
            3'h5: rom_data1 = 8'b01100000; // ***   **
            3'h6: rom_data1 = 8'b01100000; //  **  **
            3'h7: rom_data1 = 8'b01100000; //   ****
          endcase
      5: case (rom_addr1)
            3'h0: rom_data1 = 8'b11111111; //   ****
            3'h1: rom_data1 = 8'b00000011; //  **  **
            3'h2: rom_data1 = 8'b00000011; // **   ***
            3'h3: rom_data1 = 8'b11111111; // **  * **
            3'h4: rom_data1 = 8'b11000000; // ** *  **
            3'h5: rom_data1 = 8'b11000011; // ***   **
            3'h6: rom_data1 = 8'b01100110; //  **  **
            3'h7: rom_data1 = 8'b00111100; //   ****
          endcase
      6: case (rom_addr1)
            3'h0: rom_data1 = 8'b00111100; //   ****
            3'h1: rom_data1 = 8'b01100110; //  **  **
            3'h2: rom_data1 = 8'b00000011; // **   ***
            3'h3: rom_data1 = 8'b00111111; // **  * **
            3'h4: rom_data1 = 8'b11000011; // ** *  **
            3'h5: rom_data1 = 8'b11000011; // ***   **
            3'h6: rom_data1 = 8'b01100110; //  **  **
            3'h7: rom_data1 = 8'b00111100; //   ****
         endcase
      7: case (rom_addr1)
            3'h0: rom_data1 = 8'b11111111; //   ****
            3'h1: rom_data1 = 8'b11000000; //  **  **
            3'h2: rom_data1 = 8'b01100000; // **   ***
            3'h3: rom_data1 = 8'b00110000; // **  * **
            3'h4: rom_data1 = 8'b00011000; // ** *  **
            3'h5: rom_data1 = 8'b00001100; // ***   **
            3'h6: rom_data1 = 8'b00000110; //  **  **
            3'h7: rom_data1 = 8'b00000011; //   ****
         endcase
      8: case (rom_addr1)
            3'h0: rom_data1 = 8'b00111100; //   ****
            3'h1: rom_data1 = 8'b01100110; //  **  **
            3'h2: rom_data1 = 8'b01100110; // **   ***
            3'h3: rom_data1 = 8'b01100110; // **  * **
            3'h4: rom_data1 = 8'b00111100; // ** *  **
            3'h5: rom_data1 = 8'b01100110; // ***   **
            3'h6: rom_data1 = 8'b01100110; //  **  **
            3'h7: rom_data1 = 8'b00111100; //   ****
         endcase
      9: case (rom_addr1)
            3'h0: rom_data1 = 8'b11110000; //   ****
            3'h1: rom_data1 = 8'b11001100; //  **  **
            3'h2: rom_data1 = 8'b11000100; // **   ***
            3'h3: rom_data1 = 8'b11001100; // **  * **
            3'h4: rom_data1 = 8'b11110000; // ** *  **
            3'h5: rom_data1 = 8'b11000000; // ***   **
            3'h6: rom_data1 = 8'b11000000; //  **  **
            3'h7: rom_data1 = 8'b11000000; //   ****
         endcase
      endcase
     end
      
      
      always @*
           case (dig1_reg)
              0: case (rom_addr2)
                       3'h0: rom_data2 = 8'b00111100; //   ****
                       3'h1: rom_data2 = 8'b01100110; //  **  **
                       3'h2: rom_data2 = 8'b11000011; // **   ***
                       3'h3: rom_data2 = 8'b11000011; // **  * **
                       3'h4: rom_data2 = 8'b11000011; // ** *  **
                       3'h5: rom_data2 = 8'b11000011; // ***   **
                       3'h6: rom_data2 = 8'b01100110; //  **  **
                       3'h7: rom_data2 = 8'b00111100; //   ****
                      endcase
                   1: case (rom_addr2)
                       3'h0: rom_data2 = 8'b00011100; //   ****
                       3'h1: rom_data2 = 8'b00011110; //  **  **
                       3'h2: rom_data2 = 8'b00011011; // **   ***
                       3'h3: rom_data2 = 8'b00011000; // **  * **
                       3'h4: rom_data2 = 8'b00011000; // ** *  **
                       3'h5: rom_data2 = 8'b00011000; // ***   **
                       3'h6: rom_data2 = 8'b00011000; //  **  **
                       3'h7: rom_data2 = 8'b01111110; //   ****
                      endcase 
                  2: case (rom_addr2)
                       3'h0: rom_data2 = 8'b00111100; //   ****
                       3'h1: rom_data2 = 8'b01100110; //  **  **
                       3'h2: rom_data2 = 8'b11000011; // **   ***
                       3'h3: rom_data2 = 8'b01100001; // **  * **
                       3'h4: rom_data2 = 8'b00110000; // ** *  **
                       3'h5: rom_data2 = 8'b00001100; // ***   **
                       3'h6: rom_data2 = 8'b00000110; //  **  **
                       3'h7: rom_data2 = 8'b01111111; //   ****
                      endcase
                  3: case (rom_addr2)
                       3'h0: rom_data2 = 8'b00111100; //   ****
                       3'h1: rom_data2 = 8'b01100110; //  **  **
                       3'h2: rom_data2 = 8'b11000011; // **   ***
                       3'h3: rom_data2 = 8'b01111000; // **  * **
                       3'h4: rom_data2 = 8'b01111000; // ** *  **
                       3'h5: rom_data2 = 8'b11000011; // ***   **
                       3'h6: rom_data2 = 8'b01100110; //  **  **
                       3'h7: rom_data2 = 8'b00111100; //   ****
                      endcase
                  4: case (rom_addr2)
                       3'h0: rom_data2 = 8'b01111000; //   ****
                       3'h1: rom_data2 = 8'b01101100; //  **  **
                       3'h2: rom_data2 = 8'b01100110; // **   ***
                       3'h3: rom_data2 = 8'b01111111; // **  * **
                       3'h4: rom_data2 = 8'b01100000; // ** *  **
                       3'h5: rom_data2 = 8'b01100000; // ***   **
                       3'h6: rom_data2 = 8'b01100000; //  **  **
                       3'h7: rom_data2 = 8'b01100000; //   ****
                     endcase
                 5: case (rom_addr2)
                       3'h0: rom_data2 = 8'b11111111; //   ****
                       3'h1: rom_data2 = 8'b00000011; //  **  **
                       3'h2: rom_data2 = 8'b00000011; // **   ***
                       3'h3: rom_data2 = 8'b11111111; // **  * **
                       3'h4: rom_data2 = 8'b11000000; // ** *  **
                       3'h5: rom_data2 = 8'b11000011; // ***   **
                       3'h6: rom_data2 = 8'b01100110; //  **  **
                       3'h7: rom_data2 = 8'b00111100; //   ****
                     endcase
                 6: case (rom_addr2)
                       3'h0: rom_data2 = 8'b00111100; //   ****
                       3'h1: rom_data2 = 8'b01100110; //  **  **
                       3'h2: rom_data2 = 8'b00000011; // **   ***
                       3'h3: rom_data2 = 8'b00111111; // **  * **
                       3'h4: rom_data2 = 8'b11000011; // ** *  **
                       3'h5: rom_data2 = 8'b11000011; // ***   **
                       3'h6: rom_data2 = 8'b01100110; //  **  **
                       3'h7: rom_data2 = 8'b00111100; //   ****
                    endcase
                 7: case (rom_addr2)
                       3'h0: rom_data2 = 8'b11111111; //   ****
                       3'h1: rom_data2 = 8'b11000000; //  **  **
                       3'h2: rom_data2 = 8'b01100000; // **   ***
                       3'h3: rom_data2 = 8'b00110000; // **  * **
                       3'h4: rom_data2 = 8'b00011000; // ** *  **
                       3'h5: rom_data2 = 8'b00001100; // ***   **
                       3'h6: rom_data2 = 8'b00000110; //  **  **
                       3'h7: rom_data2 = 8'b00000011; //   ****
                    endcase
                 8: case (rom_addr2)
                       3'h0: rom_data2 = 8'b00111100; //   ****
                       3'h1: rom_data2 = 8'b01100110; //  **  **
                       3'h2: rom_data2 = 8'b01100110; // **   ***
                       3'h3: rom_data2 = 8'b01100110; // **  * **
                       3'h4: rom_data2 = 8'b00111100; // ** *  **
                       3'h5: rom_data2 = 8'b01100110; // ***   **
                       3'h6: rom_data2 = 8'b01100110; //  **  **
                       3'h7: rom_data2 = 8'b00111100; //   ****
                    endcase
                 9: case (rom_addr2)
                       3'h0: rom_data2 = 8'b11110000; //   ****
                       3'h1: rom_data2 = 8'b11001100; //  **  **
                       3'h2: rom_data2 = 8'b11000100; // **   ***
                       3'h3: rom_data2 = 8'b11001100; // **  * **
                       3'h4: rom_data2 = 8'b11110000; // ** *  **
                       3'h5: rom_data2 = 8'b11000000; // ***   **
                       3'h6: rom_data2 = 8'b11000000; //  **  **
                       3'h7: rom_data2 = 8'b11000000; //   ****
                    endcase
            endcase
            
     //output
      assign rom_addr1 = pix_y[2:0] - posy1[2:0];
      assign rom_addr2 = pix_y[2:0] - posy1[2:0];
      assign rom_bit1 = rom_data1[rom_col1];
      assign rom_bit2 = rom_data2[rom_col2];
      assign rom_col1 = pix_x[2:0] - posx1[2:0];
      assign rom_col2 = posx2[2:0] - pix_x[2:0];
      assign isOn = (posy1<=pix_y) && (pix_y<=posy2) && (posx1<=pix_x) && (pix_x<=posx2) && rom_bit1;
      assign add100 = add100reg;
endmodule