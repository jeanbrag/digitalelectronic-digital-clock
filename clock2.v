module Digital_Clock(
    input Clk_1sec,reset,Clk_10sec,   
    output reg [5:0]hora_minuto,
	 output reg [5:0]minuto_segundo);

   

//Variáveis internas
    reg [5:0] segundos;
    reg [5:0] minutos;
    reg [4:0] horas; 

	
	 always @(posedge(Clk_1sec) or posedge(reset))
    begin
        if(reset == 1'b1) begin 
            segundos <= 0;
            minutos <= 0;
            horas <= 0;  end
        else if(Clk_1sec == 1'b1) begin 
            segundos <= segundos + 1;
            if(segundos == 60) begin
                segundos <= 0;
                minutos <= minutos + 1;
                if(minutos == 60) begin
                    minutos <= 0;
                    horas <= horas + 1; 
                   if(horas ==  24) begin 
                        horas <= 0; 
                    end 
                end
            end     
        end
    end     

	 reg tmp=1'b0;
	 
	 always @(posedge (Clk_10sec)) begin
			tmp=~tmp;
			if(tmp==1'b1) begin
				hora_minuto=horas;
				minuto_segundo=minutos;
			end
			else begin
				hora_minuto<=minutos;
				minuto_segundo<=segundos;
			end
	 end
		
endmodule

//DIVISOR DE FREQUENCIA 50MHz PARA 1Hz

module clock_1hz (input clkin,
							output reg clkout);

reg [24:0] counter;

	initial begin
    counter = 0;
    clkout = 0;
	end
	always @(posedge clkin) begin
		if (counter == 0) begin
			counter <= 25'd24999999;
			clkout <= ~clkout;
		end else begin
			counter <= counter - 25'd1;
		end
		end
endmodule 