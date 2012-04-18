
uses crt, graph;

const LEVEL = 8;

const POLEDX = 0;
const POLEDY = 500;
const POLEUX = 500;
const POLEUY = 0;

type triangle = record
	x1,y1,x2,y2,x3,y3:integer;
	end;

var
trngl:triangle;
gd,gm:integer;

procedure drawLine(x1,y1,x2,y2:integer);
	begin
	line(x1,POLEDY-y1,x2,POLEDY-y2);
        //line(x1,y1,x2,y2);
	end;

function getCentralPoints(var a:triangle):triangle;
	var res:triangle;
	begin
	res.x1:=abs(a.x1+a.x2) div 2;
	res.x2:=abs(a.x2+a.x3) div 2;
	res.x3:=abs(a.x3+a.x1) div 2;

	res.y1:=abs(a.y1+a.y2) div 2;
	res.y2:=abs(a.y2+a.y3) div 2;
	res.y3:=abs(a.y3+a.y1) div 2;
        getCentralPoints:=res;
	end;

procedure drawAll(var a:triangle; level:integer);
	var tr,tr2:triangle;
	begin
        setcolor(random(14)+1);
	drawLine(a.x1,a.y1,a.x2,a.y2);
	drawLine(a.x2,a.y2,a.x3,a.y3);
	drawLine(a.x3,a.y3,a.x1,a.y1);

	tr:=getCentralPoints(a);
	if(level>1) then
		begin
		//drawAll(tr,level-1);
                tr2:=tr;
                tr2.x3:=a.x2; tr2.y3:=a.y2;
                drawAll(tr2,level-1);
                tr2:=tr;
                tr2.x1:=a.x3; tr2.y1:=a.y3;
                drawAll(tr2,level-1);
                tr2:=tr;
                tr2.x2:=a.x1; tr2.y2:=a.y1;
                drawAll(tr2,level-1);
                //drawAll(tr,level-1);
                //drawAll(tr,level-1);
		end;


	end;

begin
randomize;
gd:=Detect;
InitGraph(gd,gm,'');
trngl.x1:=0;
trngl.x2:=250;
trngl.x3:=500;

trngl.y1:=0;
trngl.y2:=500;
trngl.y3:=0;


drawAll(trngl,LEVEL);
readln;

end.
