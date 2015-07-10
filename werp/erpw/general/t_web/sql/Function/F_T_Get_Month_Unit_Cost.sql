--단가계산
CREATE OR REPLACE Function F_T_Get_Month_Unit_Cost
(
	Ar_Day_Calc_Tag			Varchar2,
	Ar_Unit_Tag				Varchar2,
	Ar_Unit_Cost			Number,
	Ar_Month_Days			Number
)
Return Varchar2
Is
	
	ln_Month_Unit_Cost	Number;
Begin
	
	IF Ar_Day_Calc_Tag = 'D' Then 
	   
	   IF Ar_Unit_Tag = 'D' Then 
	   	  ln_Month_Unit_Cost := Ar_Month_Days * Ar_Unit_Cost;
	   ElsIF Ar_Unit_Tag = 'M' Then 
	   	  ln_Month_Unit_Cost := Ar_Unit_Cost;
	   ElsIF Ar_Unit_Tag = 'Y' Then 
	   	  ln_Month_Unit_Cost := Ar_Month_Days * ( Ar_Unit_Cost/365) ;
	   End If;  
	   
	ElsIF Ar_Day_Calc_Tag = 'M' Then 
	   
	   IF Ar_Unit_Tag = 'D' Then 
	   	  ln_Month_Unit_Cost := 30* Ar_Unit_Cost;
	   ElsIF Ar_Unit_Tag = 'M' Then 
	   	  ln_Month_Unit_Cost := Ar_Unit_Cost;
	   ElsIF Ar_Unit_Tag = 'Y' Then 
	   	  ln_Month_Unit_Cost := Ar_Unit_Cost / 12;
	   End If;
	     
	End If;      
	Return ln_Month_Unit_Cost;
End;
/
