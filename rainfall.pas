program rainfall;
uses crt;
var
x : integer;
rain_height : Array[1..80] of Integer;
rain_speed: Array[1..80] of Integer;
begin
	cursoroff; { doesn't work in linux }
	{ initialize arrays }
	for x := 1 to 80 do
	begin
		rain_height[x] := 0;
		rain_speed[x] := 0
	end;
	
	if(keypressed) then readkey; { Clear any keypress still in the buffer }
	
	{ Make the program run until any key is pressed }
	while(keypressed <> true) do
	begin
		delay(100);
		clrscr;
		{ 
			* The rain_height array stores the height of the raindrops in each column of the screen
			* i.e. if rain_height[10] = 7 then the raindrop in the 10th column is now in the 7th row.
			* Any raindrop with a height of 0 does not yet exist so randomly decide if to
			* create one with a height of 1. Also generate a random rain speed for each 
			* created raindrop.
	    }
		for x := 1 to 80 do
		begin
			if rain_height[x] = 0 then
			begin
			    if random < 0.1 then {10% chance to create a raindrop in the x'th column}
					rain_height[x] := 1;
					rain_speed[x] := 1 + random(2);
			end;
		end;
		
		{
			* For a given column x, rain_height[x] represents the row of the raindrop
			* Using this we can draw the raindrop at (x, rain_height[x])
		}
		for x := 1 to 80 do
		begin
			if rain_height[x] > 0 then
			begin
				gotoxy(x, rain_height[x]);
				write('.');
				rain_height[x] := rain_height[x] + rain_speed[x]; { increment the height of the raindrop } 
				
				{ destroy raindrops when it exits the screen }
				if rain_height[x] > 24 then rain_height[x] := 0;
			end;
		end;
	end;
end.
