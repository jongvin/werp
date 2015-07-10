Create Or Replace Procedure SP_T_Sum_Daily_From_To
(
	Ar_Slip_Ymd			T_ACC_SLIP_HEAD.MAKE_DT_TRANS%Type,
	Ar_Slip_Ymd2		T_ACC_SLIP_HEAD.MAKE_DT_TRANS%Type,
	Ar_CRTUSERNO		T_ACC_TRANS_DAILY_SUM.CRTUSERNO%Type
)
Is
/***************************************************/
/* 최초작성자 : 김흥수
/* 최초작성일 : 2006-02-03
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
-- 이프로그램은 특정 일자 기준의 전표 일집계 프로그램입니다.
Begin
	--먼저 해당 전표의 일자,귀속부서,계정에 따라 집계테이블을 삭제한다.
	If SubStrb(Ar_Slip_Ymd,5,4) = '0101' Then
		Delete	T_ACC_TRANS_DAILY_SUM x
		Where	x.CONF_YMD Between SubStrb(Ar_Slip_Ymd,1,6)||'00' And Ar_Slip_Ymd2;
	Else
		Delete	T_ACC_TRANS_DAILY_SUM x
		Where	x.CONF_YMD Between Ar_Slip_Ymd And Ar_Slip_Ymd2;
	End If;
	Insert Into T_ACC_TRANS_DAILY_SUM
	(
		CONF_YMD,
		COMP_CODE,
		DEPT_CODE,
		CLASS_CODE,
		ACC_CODE,
		CRTUSERNO,
		CRTDATE,
		DR_SUM,
		CR_SUM
	)
	Select
		b.CONF_YMD,
		b.COMP_CODE,
		b.DEPT_CODE,
		b.CLASS_CODE,
		c.PARENT_ACC_CODE ACC_CODE,
		Ar_CRTUSERNO,
		SYSDATE,
		Sum(b.DR_SUM) DR_SUM,
		Sum(b.CR_SUM) CR_SUM
	From	(
				Select
					Decode(b.TRANSFER_TAG , 'F', To_Char(b.MAKE_DT,'YYYYMMDD'),SubStrb(To_Char(b.MAKE_DT,'YYYYMMDD'),1,6) || '00') CONF_YMD,
					b.COMP_CODE,
					b.DEPT_CODE,
					b.CLASS_CODE,
					b.ACC_CODE,
					Sum(b.DB_AMT) DR_SUM,
					Sum(b.CR_AMT) CR_SUM
				From	T_ACC_SLIP_BODY1 b
				Where	b.MAKE_DT Between To_Date(Ar_Slip_Ymd,'YYYYMMDD') And To_Date(Ar_Slip_Ymd2,'YYYYMMDD')
				And		b.KEEP_DT Is Not Null
				Group By
					Decode(b.TRANSFER_TAG , 'F', To_Char(b.MAKE_DT,'YYYYMMDD'),SubStrb(To_Char(b.MAKE_DT,'YYYYMMDD'),1,6) || '00'),
					b.COMP_CODE,
					b.DEPT_CODE,
					b.CLASS_CODE,
					b.ACC_CODE
			) b,
			T_ACC_CODE_CHILD2 c
	Where	b.ACC_CODE = c.CHILD_ACC_CODE
	Group By
		b.CONF_YMD,
		b.COMP_CODE,
		b.DEPT_CODE,
		b.CLASS_CODE,
		c.PARENT_ACC_CODE;
End;
/
