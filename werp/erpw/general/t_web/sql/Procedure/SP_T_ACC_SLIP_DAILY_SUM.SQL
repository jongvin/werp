Create Or Replace PROCEDURE Sp_T_Acc_Slip_Daily_Sum
(
	Ar_Slip_Id				T_ACC_SLIP_HEAD.Slip_Id%TYPE,
	Ar_Slip_Ymd				T_ACC_SLIP_HEAD.MAKE_DT_TRANS%TYPE,
	Ar_CRTUSERNO			T_ACC_TRANS_DAILY_SUM.CRTUSERNO%TYPE
)
IS
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산이 아니라서 도용해서쓰건 니맘대로 하세요
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-12-03
/* 최종수정자 :
/* 최종수정일 :
/***************************************************/
-- 이프로그램은 전표 확정 시에 일일 집계를 하는 프로그램입니다.
-- 주의할 점은 전표를 확정할 경우는 먼저 확정을 하여 KEEP_DT(확정일자)에 값을 저장한 후
-- 이 집계프로그램을 호출하여야 한다는 점이고
-- 반대로 확정을 풀 경우는 먼저 KEEP_DT(확정일자)에 Null 값을 저장한 후
-- 이 집계프로그램을 호출하여야 한다는 점입니다.
BEGIN
	--먼저 해당 전표의 일자,귀속부서,부문코드,계정에 따라 집계테이블을 삭제한다.
	DELETE	T_ACC_TRANS_DAILY_SUM x
	WHERE	(x.CONF_YMD,x.COMP_CODE,x.DEPT_CODE,x.CLASS_CODE,x.ACC_CODE)
			IN
			(
				SELECT
					Ar_Slip_Ymd CONF_YMD ,bb.COMP_CODE,bb.DEPT_CODE,bb.CLASS_CODE,cc.PARENT_ACC_CODE
				FROM
					T_ACC_SLIP_BODY1 bb,
					T_ACC_CODE_CHILD2 cc
				WHERE	bb.SLIP_ID = Ar_Slip_Id
				AND	bb.ACC_CODE = cc.CHILD_ACC_CODE
				AND bb.KEEP_DT IS NOT NULL
			);
	Merge INTO T_ACC_TRANS_DAILY_SUM t
	USING
	(
		SELECT
			Decode(a.TRANSFER_TAG , 'F', To_Char(a.MAKE_DT,'YYYYMMDD'),SubStrb(To_Char(a.MAKE_DT,'YYYYMMDD'),1,6) || '00') CONF_YMD,
			A.COMP_CODE,
			A.DEPT_CODE,
			A.CLASS_CODE,
			B.PARENT_ACC_CODE ACC_CODE,
			--A.ACC_CODE,
			Ar_CRTUSERNO CRTUSERNO,
			SYSDATE CRTDATE,
			SUM(A.DB_AMT) DR_SUM,
			SUM(A.CR_AMT) CR_SUM
		FROM
			T_ACC_SLIP_BODY1 A,
			T_ACC_CODE_CHILD2 B
		WHERE 
			A.ACC_CODE = B.CHILD_ACC_CODE
			AND A.KEEP_DT IS NOT NULL
			AND A.MAKE_DT = F_T_Stringtodate(Ar_Slip_Ymd)
			AND Exists
			(
				SELECT Null
				FROM	T_ACC_SLIP_BODY1 aa,
						T_ACC_CODE_CHILD2 bb
				WHERE	aa.SLIP_ID = Ar_Slip_Id
				And		aa.ACC_CODE = bb.CHILD_ACC_CODE
				And		b.PARENT_ACC_CODE = bb.PARENT_ACC_CODE
				And		a.DEPT_CODE = aa.DEPT_CODE
				And		a.CLASS_CODE = aa.CLASS_CODE
			)	
		GROUP BY
			Decode(a.TRANSFER_TAG , 'F', To_Char(a.MAKE_DT,'YYYYMMDD'),SubStrb(To_Char(a.MAKE_DT,'YYYYMMDD'),1,6) || '00'),
			A.COMP_CODE,
			A.DEPT_CODE,
			A.CLASS_CODE,
			B.PARENT_ACC_CODE
	) s
	ON
	(
			t.CONF_YMD = s.CONF_YMD
		AND	t.COMP_CODE = s.COMP_CODE
		AND	t.DEPT_CODE = s.DEPT_CODE
		AND	t.CLASS_CODE = s.CLASS_CODE
		AND	t.ACC_CODE = s.ACC_CODE
	)
	WHEN Matched THEN
		UPDATE
		SET
			t.DR_SUM = s.DR_SUM,
			t.CR_SUM = s.CR_SUM,
			t.MODUSERNO = s.CRTUSERNO,
			t.MODDATE = s.CRTDATE
	WHEN NOT Matched THEN
		INSERT (t.CONF_YMD,t.COMP_CODE,t.DEPT_CODE,t.CLASS_CODE,t.ACC_CODE,t.CRTUSERNO,t.CRTDATE,t.DR_SUM,t.CR_SUM)
		VALUES (s.CONF_YMD,s.COMP_CODE,s.DEPT_CODE,s.CLASS_CODE,s.ACC_CODE,s.CRTUSERNO,s.CRTDATE,s.DR_SUM,s.CR_SUM) ;
END;
/
