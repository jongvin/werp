Create Or Replace Type fOConcatString As Object
(
	LastString				Varchar2(4000),
	Static Function ODCIAggregateInitialize(sctx In Out fOConcatString)
	Return Number,
	Member Function ODCIAggregateIterate(self In Out fOConcatString,value In Varchar2)
	Return Number,
	Member Function ODCIAggregateTerminate(self In Out fOConcatString,
		returnValue Out Varchar2, flags In Number)
	Return Number,
	Member Function ODCIAggregateMerge(self In Out fOConcatString,ctx2 In fOConcatString)
	Return Number
)
/
Create Or Replace Type Body fOConcatString As
	Static Function ODCIAggregateInitialize(sctx In Out fOConcatString)
	Return Number
	Is
	Begin
		sctx := fOConcatString('');
		Return ODCIConst.Success;
	End;
	Member Function ODCIAggregateIterate(self In Out fOConcatString,value In Varchar2)
	Return Number
	Is
	Begin
		If Nvl(Lengthb(self.LastString),0) + Nvl(Lengthb(value),0) <= 4000 Then
			self.LastString := self.LastString || value;
		End If;
		Return ODCIConst.Success;
	End;
	Member Function ODCIAggregateTerminate(self In Out fOConcatString,
		returnValue Out Varchar2, flags In Number)
	Return Number
	Is
	Begin
		returnValue := self.LastString;
		Return ODCIConst.Success;
	End;
	Member Function ODCIAggregateMerge(self In Out fOConcatString,ctx2 In fOConcatString)
	Return Number
	Is
	Begin
		self.LastString := self.LastString || ctx2.LastString;
		Return ODCIConst.Success;
	End;
End;
/
Create Or Replace Function F_T_ConcatString(input Varchar2)
Return Varchar2
Aggregate Using fOConcatString;
/
