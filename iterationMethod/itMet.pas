const MAXVAL = 100;

type ourtype = real;

type vector = array[0..MAXVAL] of ourtype;

type matrix = array[0..MAXVAL] of vector;


//------------------------------------------------------------------------TESTER FUNCTION

procedure pV(a:vector); var i:integer; begin write('vector: '); for i:=1 to trunc(a[0]) do write(a[i]:0:10,'|'); writeln; end;

//------------------------------------------------------------------------TESTER FUNCTION

function getNorm(var a:matrix):ourtype; // IT NOT GET TRUE, BUT IT WORK THEM.( <-10000 )
	var i,l:integer; sum:ourtype;
	res:ourtype;
	begin
	res:=-10000; //!!!
	for i:=1 to trunc(a[0][0]) do
		begin
		sum:=0;
		for l:=1 to trunc(a[0][0]) do sum:=sum+abs(a[i][l]);
		if sum>res then res:=sum;
		end;
	getNorm:=res;
	end;
	
function multiplyVectors(var a,b:vector):ourtype;
	var i:integer; res:ourtype;
	begin
	//writeln('multiply'); pv(a); pv(b);
	res:=0;
	for i:=1 to trunc(a[0]) do
		begin
		res:=res+a[i]*b[i];
		end;
	multiplyVectors:=res;
	end;

function addVectors(a,b:vector):vector;
	var i:integer; res:vector;
	begin
	//writeln('chop',trunc(a[0]));
	for i:=1 to trunc(a[0]) do
		begin res[i]:=a[i]+b[i]; {writeln('chop');} end;
	res[0]:=trunc(a[0]);
	addVectors:=res;
	end;
	
function subVectors(a,b:vector):vector;
	var i:integer; res:vector;
	begin
	for i:=1 to trunc(a[0]) do
		res[i]:=a[i]-b[i];
	res[0]:=trunc(a[0]);
	//writeln(res[0]);
	subVectors:=res;
	//writeln('subVectors:end');
	end;
	
function multiplyMatrixVector(var a:matrix; var x:vector):vector;
	var
	i:integer;
	res:vector;
	begin
	for i:=1 to trunc(a[0][0]) do
		res[i]:=multiplyVectors(a[i],x);
	res[0]:=x[0];
	multiplyMatrixVector:=res;
	end;

	
procedure importFromFile(var a:matrix; var b:vector; var e:real; name:string);
	var f:text;
	i,n,l:integer;
	begin
	assign(f,name);
	reset(f);
	readln(f,n);
	a[0][0]:=n;
	//writeln('ololo');
	for i:=1 to n do
		begin
		a[i][0]:=n;
		for l:=1 to n do read(f,a[i][l]);
		//writeln(a[i][l]);
		//readln(f);
		end;
	b[0]:=n;
	for i:=1 to n do read(f,b[i]);
	//readln(f);
	readln(f,e);
	close(f);
	end;	

procedure initX(var v:vector;n:integer);
	var i:integer;
	begin v[0]:=n; for i:=1 to n do v[i]:=1; end;


function getNextX( a:matrix; b:vector; x:vector):vector;
	var res:vector;
	begin
	res:=multiplyMatrixVector(a,x);
	//pv(res);
	//writeln('olologetNextX');
	res:=addVectors(res,b);
	//pv(res);
	//writeln('olologetNextX');
	getNextX:=res;
	end;
	
function getVectorNorm(a:vector):ourtype;
	var i:integer; res:ourtype;
	begin
	res:=0;
	//writeln(trunc(a[0]));
	for i:=1 to trunc(a[0]) do
		begin res:=res+a[i]; {writeln(res);} end;
	getVectorNorm:=res;
	//writeln('getVectorNorm:end');
	end;

function isEnd(var x1,x2:vector; e:real):boolean;
	var k:ourtype;
	begin
	//pv(x1); pv(x2);
	//writeln('1:',getVectorNorm( subVectors(x1,x2) ));
	//writeln('2:',getVectorNorm( x2 ));
	//writeln(e:0:5);
	//isEnd:=false;
	k:=(getVectorNorm( subVectors(x1,x2) )/getVectorNorm(x2));
	writeln('/~e:',k:0:5);
	isEnd:=abs(k)<e;
	end;
	
var

a:matrix;
b,x1,x2:vector;
i:integer;
e:real;

begin

importFromFile(a,b,e,'input.txt');
//writeln('Norm: ',getNorm(a):0:4);
if( getNorm(a) >= 1 ) then
	begin writeln('Norm is bad: ' , getNorm(a):0:4); exit; end;
//readln;
//exit;
//writeln('BEGIN');
initX(x1,trunc(b[0]));

//pv(b); pv(x1);

x2:=getNextX(a,b,x1);

i:=10000;
//writeln('BEGIN:end');
while ( not(isEnd(x1,x2,e)) and (i>0) ) do
	begin
	//writeln('[+++++++++]i= ',i);
	i:=i-1;
	x1:=x2;
	x2:=getNextX(a,b,x2);
	pv(x2);
	end;
write('result: ');
pv(x2);

end.
