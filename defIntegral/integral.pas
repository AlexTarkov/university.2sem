type func = function(a:real):real;

type info = record
	sum:real;
	y:real;
	end;

type heap = array[0..1000] of info;

const POLENULLX = 30;
const POLENULLY = 300;
const POLEENDX = 330;
const POLEENDY = 0;

const DEL = 2;

var
i:integer;
//test:func;

//--------------------------------------------------

{$F+}
function test(a:real):real;
	begin
	test:=a;
	end;
{$F-}


//------------------------------------------------

function heapInsert(sum:)

//------------------------------------------------

function getFunctionValue(f:func;t:real):real;
	begin
	getFunctionValue:=f(t);
	end;

function getIntegralSum(f:func; from,en:real; col:integer):heap;
	begin
	
	end;
	
procedure plotLine(x,y: real);
	begin end;


	
//--------------------------------------------------

begin

//writeln( getFunctionValue(test,4) );

end.
