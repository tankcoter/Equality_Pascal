program Equality;
uses sysutils;
const  fi='EQ.INP.txt';
       fo='EQ.OUT.txt';
       inf=1000000000;
var n,s,i,j:longint;
    ch:char;
    CS:string;
    A:array[1..1000] of longint;
    B:array[1..1000] of longint;
    memo:array[1..1000,0..5000] of longint;
(* Read input text file *)
procedure read;
var f:text;
begin
        assign(f, fi);
        reset(f);
        n:=0;
        read(f, ch);
        repeat
                Inc(n);
                a[n]:=ord(ch) - 48;
                read(f, ch);
        until ch='=';
        readln(f, s);
        close(f);
        b[n]:=n;
        for i:=n-1 downto 1 do
                if a[i]=0 then b[i]:=b[i+1] else b[i]:=i;
                for i:=1 to n do
                        for j:=0 to s do
                                memo[i,j]:=-1;
        CS:='';
end;

(* Write into output text file *)
procedure write;
var f:text;
begin
        assign(f, fo);
        rewrite(f);
        write(f,CS);
        close(f);
end;

function opt(i, sum: longint): longint;
var j,broj:longint;
begin
        if i>n then
                begin
                if sum=0 then opt:=0 else opt:=inf;
                end
        else
                begin
                        if memo[i,sum] = -1 then begin
                                memo[i,sum]:=inf;
                                broj:=0;
                                for j:=b[i] to n do
                                        begin
                                        broj:=broj*10 + a[j];
                                        if broj>sum then break;
                                        if 1 + opt(j+1, sum - broj) < memo [i,sum] then
                                                memo[i,sum]:=1 + opt(j+1, sum - broj);
                                        end;
                                end;
                                opt:=memo[i,sum];
                        end;
                end;

(* Process the input string *)
procedure Process (i,sum: longint);
var f:text;
    j, broj:longint;
    st:string;
begin
        Str(s,st);
        if i > n then
                begin
                CS:=CS + '=' + st;
                end
        else
        begin
        if i > 1 then CS:=CS + '+';
        broj:=0;
        for j:=i to n do
                begin
                        CS:=CS + Chr(a[j] + 48);
                        broj:=broj * 10 + a[j];
                        if opt(i,sum) = 1 + opt(j + 1, sum - broj) then
                                begin
                                Process(j+1, sum - broj);
                                break;
                        end;
                end;
        end;
end;

(* Main program *)
begin
        read;
        Process(1,s);
        write;
end.
