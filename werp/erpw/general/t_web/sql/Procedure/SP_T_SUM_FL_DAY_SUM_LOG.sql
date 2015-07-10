Create Or Replace Procedure SP_T_SUM_FL_DAY_SUM_LOG
(
	Ar_Work_Dt					Date,
	Ar_CrtUserNo				Varchar2,
	Ar_Start_Dt					Date,
	Ar_Errm						Varchar2
)
Is
	Pragma autonomous_transaction;
	lddt_End_Dt				Date := Sysdate;
	ln_Seq					Number;
	ls_Name					Varchar2(60);
Begin
	Begin
		Select
			NAME
		Into
			ls_Name
		From	Z_AUTHORITY_USER
		Where	EMPNO = Ar_CrtUserNo;
	Exception When No_Data_Found Then
		ls_Name := '등록되지 않은 사용자';
	End;
	Update	T_FL_SUM_HISTORY
	Set		START_DT_TIME = To_Char(Ar_Start_Dt,'YYYY-MM-DD HH24:MI:SS'),
			END_DT_TIME = To_Char(lddt_End_Dt,'YYYY-MM-DD HH24:MI:SS'),
			EMP_NO = Ar_CrtUserNo,
			NAME = ls_Name,
			ERRM = Ar_Errm
	Where	WORK_DT = Ar_Work_Dt;
	Insert Into T_FL_SUM_HISTORY_DETAIL
	(
		WORK_DT,
		WORK_NO,
		START_DT_TIME,
		END_DT_TIME,
		EMP_NO,
		NAME,
		ERRM
	)
	Select
		a.WORK_DT,
		Nvl(Max(b.WORK_NO),0) + 1,
		a.START_DT_TIME,
		a.END_DT_TIME,
		a.EMP_NO,
		a.NAME,
		a.ERRM
	From	T_FL_SUM_HISTORY a,
			T_FL_SUM_HISTORY_DETAIL b
	Where	a.WORK_DT = b.WORK_DT (+)
	And		a.WORK_DT = Ar_Work_Dt
	Group By
		a.WORK_DT,
		a.START_DT_TIME,
		a.END_DT_TIME,
		a.EMP_NO,
		a.NAME,
		a.ERRM;
	Commit;
Exception When Others Then
	Rollback;
End;
/
