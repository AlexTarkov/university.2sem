

const POLENULLX = 30;
const POLENULLY = 300;
const POLEENDX = 330;
const POLEENDY = 0;

const DEL = 2;

var
i:integer;
from,too,y1,y2,e:real;
n:integer;


procedure importFromFile(var from,too,y1,y2,e:real; var n:integer; name:string);
	var f:text;
	i,n,l:integer;
	begin
	assign(f,name);
	reset(f);
	readln(f,from);
	readln(f,too);
	readln(f,y1);
	readln(f,y2);
	readln(f,e);
	readln(f,n);
	close(f);
	end;




//-------------------------------------------------- WORK FUNCTION
function work_func(a:real):real;
	begin
	work_func:=a*sin(a);
	end;
//------------------------------------------------

function getIntegralSum(lastSum:real; from,too:real; n:integer):real;
	var i:integer; h,res:real;
	begin
	h:=(too-from)/n;
	res:=lastSum/DEL;
	i:=1;
	while (i<=n-1) do//for i:=1 to n-1 do
		begin
		res:=res+work_func(from+h*i)*h;
		i:=i+2;
		end;
	getIntegralSum:=res;
	end;

//------------------------------------------------ GRAPHIC FUNCTION
	
procedure plotLine(x1,y1,x2,y2: real);
	begin line(trunc(x1),trunc(y1),trunc(x2),trunc(y2)); end;

procedure plotPole(from,too,y1,y2:real);
	begin
	from:=abs(from);
	too:=abs(too);
	from:=
	from:=abs(from);
	from:=abs(from);
	end;
	
//------------------------------------------------- GRAPHIC FUNCTION

begin

importFromFile(from,too,y1,y2,e,n,'input.txt');



end.
