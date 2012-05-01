uses graph,crt,sysutils;

const POLENULLX = 30;
const POLENULLY = 830;
const POLEENDX = 830;
const POLEENDY = 30;

const DEL = 2;

var
i:integer;
from,too,y1,y2,e,k:real;
n:integer;

lsum,sum:real;

gd,gm:integer;

x0,y0:real;

xb,yb,xe,ye:real;

ch:char;



//------------------------------------------------ GRAPHIC FUNCTION

procedure plotLine(x1,y1,x2,y2: real);
	begin line(POLENULLX+trunc(x1),POLENULLY-trunc(y1),POLENULLX+trunc(x2),POLENULLY-trunc(y2)); end;
	
procedure convertCord(x,y:real; var xx,yy:real);
	begin
	xx:=x0+x/(abs(from)+abs(too))*(POLEENDX-POLENULLX);
	yy:=y0+y/(abs(y1)+abs(y2))*(POLENULLY-POLEENDY);
	end;

procedure plotPole(from,too,y1,y2:real);
	begin
	from:=abs(from); writeln(from);
	too:=abs(too);
	y1:=abs(y1);
	y2:=abs(y2);
	plotLine( (from/(from+too))*(POLEENDX-POLENULLX),POLEENDY,(from/(from+too))*(POLEENDX-POLENULLX),POLENULLY);
	plotLine( 0,(y1/(y1+y2))*(POLENULLY-POLEENDY),POLEENDX,(y1/(y1+y2))*(POLENULLY-POLEENDY));
	x0:=(from/(from+too))*(POLEENDX-POLENULLX);
	y0:=(y1/(y1+y2))*(POLENULLY-POLEENDY);
	end;
	
procedure echoE(k:real;n:integer);
	begin
	OutTextXY(POLENULLX,POLENULLY+10*n,FloatToStr(k));
	end;

//------------------------------------------------- GRAPHIC FUNCTION


procedure importFromFile(var from,too,y1,y2,e:real; var n:integer; name:string);
	var f:text;
	i,l:integer;
	begin
	assign(f,name);
	reset(f);
	writeln('ololo');
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
	//work_func:=a*sin(a);
	work_func:=sqrt(a*(1-a));
	end;
//------------------------------------------------

function getIntegralSum(lastSum:real; from,too:real; n:integer):real;
	var i:integer; x,y,lx,ly,h,res,xx,yy:real;
	begin
	h:=(too-from)/n;
	res:=lastSum/DEL;
	lx:=xb; ly:=yb;
	i:=1;
	setColor(n mod 15);
	while (i<=n-1) do//for i:=1 to n-1 do
		begin
		x:=from+h*i;
		y:=work_func(x);
		res:=res+y*h;
		convertCord(x,y,x,y);
		//convertCord(lx,ly,lx,ly);
		//writeln(x:0:2,' ',y:0:2,' ',lx:0:2,' ',ly:0:2);
		plotLine(x,y,lx,ly);
		lx:=x; ly:=y;
		i:=i+2;
		end;
	//convertCord(x,y,x,y);
	plotLine(x,y,xe,ye);
	getIntegralSum:=res;
	end;



begin

gd:=Detect;
InitGraph(gd,gm,'');
writeln('lsum');
importFromFile(from,too,y1,y2,e,n,'input.txt');
plotPole(from,too,y1,y2);

lsum:=(too-from)*( work_func(from)+work_func(too) )/2;
writeln('lsum');
convertCord(from,work_func(from),xb,yb);
convertCord(too,work_func(too),xe,ye);
writeln(xb:0:2,' ',yb:0:2,' ',xe:0:2,' ',ye:0:2);
writeln(x0:0:2,' ',y0:0:2);

sum:=getIntegralSum(lsum,from,too,n);

k:=abs(lsum-sum);
writeln('begin Cicle');
while( k>e ) do
	begin
	//readln(e);
	//ch:=ReadKey;
	//if(ch='x') then break;
	echoE(sum,trunc(ln(n)));
	//writeln(k);
	n:=n*2;
	lsum:=sum;
	sum:=getIntegralSum(lsum,from,too,n);
	k:=abs(lsum-sum);
	readln;
	end;

readln;

end.
