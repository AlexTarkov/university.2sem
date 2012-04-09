const MAXVAL = 100;

type ourtype = integer;

type vector = array[0..MAXVAL] of ourtype;

type matrix = array[0..MAXVAL] of vector;


function getNorm(var a:matrix):ourtype; // IT NOT GET TRUE, BUT IT WORK THEM.( <-10000 )
	var i,l,sum:integer;
	res:ourtype;
	begin
	res:=-10000; //!!!
	for i:=1 to trunc(a[0][0]) do
		begin 
		sum:=1; 
		for l:=1 to trunc(a[0][0]) do sum:=sum+a[i][l];
		if sum>res then res:=sum;
		end;
	getNorm:=res;
	end;
	
function multiplyVectors(var a,b:vector):ourtype;
	var i:integer; res:ourtype;
	begin
	for i:=1 to trunc(a[0]) do
		begin
		res:=res+a[i]*b[i];
		end;
	multiplyVectors:=res;
	end;

function addVectors(a,b:vector):vector;
	var i:integer; res:vector;
	begin
	for i:=1 to trunc(a[0]) do
		res[i]:=a[i]+b[i];
	addVectors:=res;
	end;
	
function subVectors(var a,b:vector):vector;
	var i:integer; res:vector;
	begin
	for i:=1 to trunc(a[0]) do
		res[i]:=a[i]-b[i];
	subVectors:=res;
	end;
	
function multiplyMatrixVector(var a:matrix; var x:vector):vector;
	var
	i:integer;
	res:vector;
	begin
	for i:=1 to trunc(a[0][0]) do
		res[i]:=multiplyVectors(a[i],x);
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
	writeln('ololo');
	for i:=1 to n do
		begin
		a[i][0]:=n;
		for l:=1 to n do read(f,a[i][l]);
		writeln(a[i][l]);
		//readln(f);
		end;
	b[0]:=n;
	for i:=1 to n do read(f,b[i]);
	readln(f);
	//readln(f,e);
	close(f);
	end;	

procedure initX(var v:vector;n:integer);
	var i:integer;
	begin v[0]:=n; for i:=1 to n do v[i]:=1; end;


function getNextX(var a:matrix; var b:vector; x:vector):vector;
	var res:vector;
	begin
	res:=multiplyMatrixVector(a,x);
	writeln('olologetNextX');
	res:=addVectors(res,b);
	writeln('olologetNextX');
	getNextX:=res;
	end;
	
function getVectorNorm(a:vector):ourtype;
	var i:integer; res:ourtype;
	begin
	res:=0;
	for i:=1 to trunc(a[0]) do
		res:=res+a[i];
	getVectorNorm:=res;
	end;

function isEnd(var x1,x2:vector; e:real):boolean;
	begin
	isEnd:=(getVectorNorm( subVectors(x1,x2) )/getVectorNorm(x2))<e;
	end;
	
var

a:matrix;
b,x1,x2:vector;
i:integer;
e:real;

begin

importFromFile(a,b,e,'input.txt');
writeln('ololo');
initX(x1,trunc(b[0]));

x2:=getNextX(a,b,x1);

i:=10000;
writeln('ololo!!!');
while ( not(isEnd(x1,x2,e)) and (i>0) ) do
	begin
	i:=i-1;
	x1:=x2;
	x2:=getNextX(a,b,x2);
	end;
write('result: ');
for i:=1 to trunc(x2[0]) do write(x2[i],' ');

end.
