Program INTEGRAL;
 type
    Func= function(x: Real): Real;
 var
    I,TN,TK:Real;
    N:Integer;
{$F+}
 Function Q(t: Real): Real;
   begin
     Q:=2*t/Sqrt(1-Sin(2*t));
   end;
{$F-}
 Procedure Simps(F:Func; a,b:Real; N:Integer; var INT:Real);
   var
      sum, h: Real;
      j:Integer;
   begin
     if Odd(N) then N:=N+1;
     h:=(b-a)/N;
     sum:=0.5*(F(a)+F(b));
     for j:=1 to N-1 do
       sum:=sum+(j mod 2+1)*F(a+j*h);
       INT:=2*h*sum/3
   end;
 begin
   WriteLn(' ббедх TN,TK,N');
   Read(TN,TK,N);
   Simps(Q,TN,TK,N,I);
   WriteLn('I=',I:8:3)
 end.