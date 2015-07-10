--해당월의 일자수 반환 
CREATE OR REPLACE Function F_T_Get_Last_Days
(
	Ar_Month			Number
)
Return Varchar2
Is
	ln_Month			Number;
	ln_day				Number;
Begin
	ln_Month := Ar_Month;
	IF ln_Month = 1 Then 
	   Return '31';
	ElsIF ln_Month = 2 Then 
	   Return '28';
	ElsIF ln_Month = 3 Then 
	   Return '31';
	ElsIF ln_Month = 4 Then 
	   Return '30';
	ElsIF ln_Month = 5 Then 
	   Return '31';
	ElsIF ln_Month = 6 Then 
	   Return '30';
	ElsIF ln_Month = 7 Then 
	   Return '31';
	ElsIF ln_Month = 8 Then 
	   Return '31';
	ElsIF ln_Month = 9 Then 
	   Return '31';
	ElsIF ln_Month = 10 Then 
	   Return '31';
	ElsIF ln_Month = 11 Then 
	   Return '30';
	ElsIF ln_Month = 12 Then 
	   Return '31';
	End If;      
	
End;