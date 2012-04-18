//type func = function(a:real):real; //NOT WORK

type info = record
	sum:real;
	y:real;
	end;

//type heap = array[0..1000] of info;

const POLENULLX = 30;
const POLENULLY = 300;
const POLEENDX = 330;
const POLEENDY = 0;

const DEL = 2;

var
i:integer;
from,too,y1,y2:real;
n:integer;


//test:func;

procedure importFromFile(var from,too,y1,y2:real; var n:integer; name:string);
	var f:text;
	i,n,l:integer;
	begin
	assign(f,name);
	reset(f);
	readln(f,from);
//	readln(f,too); // JOHN1540M CHANGE THIS STRING
	readln(f,y1);

//DELL END OF FUNCTION. 






//-------------------------------------------------- WORK FUNCTION
function work_func(a:real):real;
	begin
	work_func:=a*sin(a);
	end;
//--------------------------------------------------


{$F+}
{function test(a:real):real; // NOT WORK
	begin
	test:=a;
	end;}
{$F-}


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

//------------------------------------------------

function getFunctionValue(f:func;t:real):real;// NOT WORK
	begin
	getFunctionValue:=f(t);
	end;

	
procedure plotLine(x,y: real);
	begin end;


	
//--------------------------------------------------

begin

importFromFile();

//==========================================================
//THIS IS WHAT I WANT TO CHANGE IN MASTER BRANCH (THINK SO)
//==========================================================
//BRANCH MASTER
//ÒÅÑÒ ÍÀ ÏÅÐÅÄÀ×Ó ÐÓÑÑÊÎÃÎ ßÇÛÊÀ ×ÅÐÅÇ ÐÅÏÎÇÈÒÎÐÈÉ
//åùå òåñò íà ïåðåäà÷ó ðóññêîãî ÿçûêà
//=========================================================
//THIS IS WHAT I WANT TO CHANGE IN MASTER BRANCH (THINK SO)
//==========================================================

end.
