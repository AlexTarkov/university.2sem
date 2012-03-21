program database;

uses crt, graph, sysutils;

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

//=======================================================================================================	
	
	
procedure drawText(str:string; x,y:integer);
	var
		w:integer;
	begin
	w:=20;
	Bar(x,y-10,x+w,y+w);
	OutTextXY(x+30,y,str);
	end;
	
{procedure drawText2(str:integer; x,y:integer);
	begin
	OutTextXY(x,y,str);
	end;
}	
procedure drawCircleDiagram(var a:base; m:integer);
	var
		sum,i,buf:integer;
		xc,yc,rad,sect:word;
		b1,b2:word;
	begin
	ClearDevice;
	sum:=0;
	xc:=500; yc:=500; rad:=300;
	if m=0 then for i:=1 to a[0].stage do sum:=sum+a[i].stage else for i:=1 to a[0].stage do sum:=sum+a[i].price;
	//writeln('sum=',sum);
	b1:=0;
	for i:=1 to a[0].stage-1 do
		begin
		if(m=0) then buf:=a[i].stage else buf:=a[i].price;
		//WRITELN(buf);
		b2:=b1+Word(trunc(360*(buf/sum)));
		Setfillstyle(1,i);
		PieSlice(xc,yc,b1,b2,rad);
		b1:=b2;
		drawText(a[i].fio+'('+intToStr(buf)+')',10,yc+40*(i-1));
		end;
	i:=a[0].stage;
	if(m=0) then buf:=a[i].stage else buf:=a[i].price;
	Setfillstyle(1,a[0].stage);
	PieSlice(xc,yc,b2,360,rad);
	drawText(a[i].fio+'('+intToStr(buf)+')',10,yc+40*(a[0].stage-1));
	end;
	
	
procedure drawBarDiagram(var a:base; m:integer);
	var
		sum,i,buf:integer;
		xd,yd,max,xw,xn:integer;
		y:integer;
		str:string;
	begin
	ClearDevice;
	sum:=-1;
	xn:=30; xd:=200; yd:=500; max:=300; xw:=30;
	if m=0 then 
		begin for i:=1 to a[0].stage do if(a[i].stage>sum) then sum:=a[i].stage; end 
	else 
		begin for i:=1 to a[0].stage do if(a[i].price>sum) then sum:=a[i].price; end;
	for i:=1 to a[0].stage do
		begin
		if(m=0) then buf:=a[i].stage else buf:=a[i].price;
		y:=(trunc(max*(buf/sum)));
		Setfillstyle(1,i);
		Bar(xd,yd,xd+xw,yd-y);
		//Str(buf,str);
		outTextXY(xd,yd+20,intToStr(buf));
		xd:=xd+xw+xn;
		drawText(a[i].fio,10,250+40*(i-1));
		end;
	end;

	

//=======================================================================================================	
	
procedure menu(var a:base);
	var
		i,l:integer;
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
			readln(l);
			sort(a , (l div 2) + 1 , (l mod 2) )
			end;
		6:
			begin
			writeln('0.by stage - circle');
			writeln('1.by stage - columns');
			writeln('2.by price circle');
			writeln('3.by price columns');
			readln(l);
			case l of
				0: drawCircleDiagram(a,0);
				1: drawBarDiagram(a,0);
				2: drawCircleDiagram(a,1);
				3: drawBarDiagram(a,1);
				end;
			end;
	end;
	end;

begin
exbool:=true;
gd:=Detect;
InitGraph(gd,gm,'');
while exbool do menu(db);
//drawCircleDiagram;
//readln(gm);
end.


