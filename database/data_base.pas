program database;

uses crt, graph;

const N = 100;

type people = record
	fio  :string;
	stage:integer;
	price:integer;
	end;

type base=array[0..N] of people;

var
	db:base;
	exbool:boolean;
	gd,gm:integer;

//-----------------------------------------------------------------------
	
procedure writeBase(var a:base);
	var i:integer;
	begin
	writeln('--------------------------------------------------------------');
	for i:=1 to a[0].stage do
		writeln( a[i].fio,' ',a[i].stage,' ',a[i].price );
	writeln('--------------------------------------------------------------');
	end;

procedure addPeople(var a:base; var p:people);
	var count:integer;
	begin
	inc(a[0].stage);
	count:=a[0].stage;
	a[count]:=p;
	end;

procedure removePeople(var a:base; number:integer);// no defence
	var i:integer;
	begin
	for i:=number to a[0].stage-1 do
		a[i]:=a[i+1];
	if(a[0].stage>0) then dec(a[0].stage);
	end;

procedure exchange(var a:base; i,l:integer);
	var p:people; begin p:=a[i]; a[i]:=a[l]; a[l]:=p; end;

//-------------------------------------------------------------------SORTS

function compare(a,b:string):boolean; begin compare:=(a>b); end;
function compare(a,b:integer):boolean; begin compare:=(a>b); end;

procedure sort(var a:base; way:integer; direction:integer);
// way: 1-fio,2-stage,3-price; direction: 1=0-5, 0=5-0
	var i,l:integer; bool:boolean;
	begin
	for i:=1 to a[0].stage-1 do
		for l:=i+1 to a[0].stage do
			begin
			if (way=1) then bool:=compare(a[i].fio,a[l].fio);
			if (way=2) then bool:=compare(a[i].stage,a[l].stage);
			if (way=3) then bool:=compare(a[i].price,a[l].price);
			if ( (bool and (direction=1) ) or (not(bool) and (direction=0) ) ) then exchange(a,i,l);
			end;
	end;

//-------------------------------------------------------------------SORTS

procedure importFromFile(var a:base; name:string);
	var f:text;
	i,n:integer;
	begin
	assign(f,name);
	reset(f);
	n:=0;
	while (not EOF(f)) do
		begin
		inc(n);
		readln(f,a[n].fio);
		readln(f,a[n].stage);
		readln(f,a[n].price);
		end;
	a[0].stage:=n;
	close(f);
	end;

procedure exportToFile(var a:base; name:string);
	var f:text;
	i,n:integer;
	begin
	assign(f,name);
	rewrite(f);
	for i:=1 to a[0].stage do
		begin
		writeln(f,a[i].fio);
		writeln(f,a[i].stage);
		writeln(f,a[i].price);
		end;
	close(f);
	end;

procedure drawCircleDiagram;
	begin
	clrscr;
	Setfillstyle(1,1);
	PieSlice (200,200,0,30,100);
	end;

procedure menu(var a:base);
	var
		i:integer;
		fio:string;
		stage:integer;
		price:integer;
		p:people;
		name:string;
	begin
	writeln('0.write list');
	writeln('1.sort list');
	writeln('2.add people');
	writeln('3.remove people');
	writeln('4.import from file');
	writeln('5.export to file');
	writeln('6.draw diagramm');
	writeln('7.exit');
	readln(i);
	case i of
		7: exbool:=false;
		0: writeBase(a);
		2: begin writeln('enter fio, stage, price:'); readln(p.fio,p.stage,p.price); addPeople(a,p); end;
		3: begin writeln('enter number:'); readln(i); removePeople(a,i); end;
		4: begin writeln('enter filename:'); readln(name); importFromFile(a,name); end;
		5: begin writeln('enter filename:'); readln(name); exportToFile(a,name); end;
		1:
			begin
			writeln('0.by fio \/');
			writeln('1.by fio /\');
			writeln('2.by stage \/');
			writeln('3.by stage /\');
			writeln('4.by price \/');
			writeln('5.by price /\');
			readln(i);
			sort(a , (i div 2) + 1 , (i mod 2) )
			end;
		6:
			begin
			writeln('0.by stage circle');
			writeln('1.by stage columns');
			writeln('2.by price circle');
			writeln('3.by price columns');
			readln(i);
			end;
	end;
	end;

begin
exbool:=true;
gd:=Detect;
InitGraph(gd,gm,'');
//while exbool do menu(db);
drawCircleDiagram;
readln(gm);
end.


