
   //Constant that contains the screen filled with the Alphabet and numbers
   localparam reg [7:0] alphabet_screen[0:3][0:15] = '{
        {8'h41, 8'h42, 8'h43, 8'h44, 8'h45, 8'h46, 8'h47, 8'h48, 8'h49, 8'h4A, 8'h4B, 8'h4C, 8'h4D, 8'h4E, 8'h4F, 8'h50}, 
        {8'h51, 8'h52, 8'h53, 8'h54, 8'h55, 8'h56, 8'h57, 8'h58, 8'h59, 8'h5A, 8'h61, 8'h62, 8'h63, 8'h64, 8'h65, 8'h66}, 
        {8'h67, 8'h68, 8'h69, 8'h6A, 8'h6B, 8'h6C, 8'h6D, 8'h6E, 8'h6F, 8'h70, 8'h71, 8'h72, 8'h73, 8'h74, 8'h75, 8'h76}, 
        {8'h77, 8'h78, 8'h79, 8'h7A, 8'h30, 8'h31, 8'h32, 8'h33, 8'h34, 8'h35, 8'h36, 8'h37, 8'h38, 8'h39, 8'h7F, 8'h7F}};
   //Constant that fills the screen with blank (spaces) entries
   localparam reg [7:0]  clear_screen[0:3][0:15] = '{
        {"X", 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, "!", 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20}, 
        {8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, "!", 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20}, 
        {8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, "!", 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20}, 
        {8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, "!", 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, "Y"}};
   //Constant that holds "This is Digilent's PmodOLED"   //Constant that holds "This is Digilent's PmodOLED"
   localparam reg [7:0]  agh_screen[0:3][0:15] = '{
        {8'h54, 8'h68, 8'h69, 8'h73, 8'h20, 8'h69, 8'h73, 8'h20, "O", "L", "E", "D", 8'h20, "o", "n", 8'h20}, 
        {8'h44, 8'h69, 8'h67, 8'h69, 8'h6C, 8'h65, 8'h6E, 8'h74, 8'h27, 8'h73, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20}, 
        {"Z", "e", "d", "B", "o", "a", "r", "d", 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20, 8'h20}, 
        {"H", "D", "L", 8'h20, "W", "F", "i", "I", "S", 8'h20, "A", "G", "H", 8'h20, 8'h20, 8'h20}};
        
