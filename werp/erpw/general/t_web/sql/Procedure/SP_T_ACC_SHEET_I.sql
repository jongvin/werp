CREATE OR REPLACE PROCEDURE Sp_T_Acc_Sheet_I
(
	AR_PROGRAM_ID      VARCHAR2, 
	AR_USER_NO         VARCHAR2,
	AR_COMP_CODE  	   VARCHAR2,
	AR_DEPT_CODE       VARCHAR2 , 
	AR_CUST_CODE       VARCHAR2,
	AR_ACC_CODE        VARCHAR2,
	AR_DT_F            VARCHAR2,
	AR_DT_T            VARCHAR2
)
IS
	--lnCnt1						Number;
	--lsMsg						Varchar2(4000);
/**************************************************************************/
/* 1. �� �� �� �� id : SP_T_ACC_SHEET_I
/* 2. ����(�ó�����) : Procedure
/* 3. ��  ��  ��  �� : ���������� ����
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-12-07)
/* 5. ����  ���α׷� :
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
BEGIN

DELETE FROM T_ACC_PRINT_EXT
WHERE
	PROGRAM_ID = AR_PROGRAM_ID
	AND USER_NO = AR_USER_NO;	

INSERT INTO T_ACC_PRINT_EXT
(
	PROGRAM_ID, 
	USER_NO, 
	SEQ,
	ACC_CODE1, 
	ACC_CODE2, 
	ACC_CODE3, 
	ACC_CODE4, 
	ACC_CODE5, 
	ACC_CODE6, 
	ACC_CODE,
	TG,
	SLIP_ID,
	SLIP_IDSEQ,
	DB_AMT,
	CR_AMT,
	REMAIN_DETAIL,
	RUNNING_TOTAL
)
SELECT
	AR_PROGRAM_ID PROGRAM_ID, 
	AR_USER_NO USER_NO, 
	(
	 	SELECT NVL(MAX(SEQ),0)
		FROM T_ACC_PRINT_EXT
		WHERE
			PROGRAM_ID = AR_PROGRAM_ID
			AND USER_NO = AR_USER_NO
	) + ROWNUM SEQ,
	ACC_CODE1, 
	ACC_CODE2, 
	ACC_CODE3, 
	ACC_CODE4, 
	ACC_CODE5, 
	ACC_CODE6, 
	ACC_CODE,
	TG,
	SLIP_ID,
	SLIP_IDSEQ,
	0 DB_AMT,
	0 CR_AMT,
	REMAIN_DETAIL,
	RUNNING_TOTAL
FROM
(
	SELECT
		NVL(a.ACC_CODE1,'000000000') ACC_CODE1, 
		NVL(a.ACC_CODE2,'000000000') ACC_CODE2, 
		NVL(a.ACC_CODE3,'000000000') ACC_CODE3, 
		NVL(a.ACC_CODE4,'000000000') ACC_CODE4, 
		NULL ACC_CODE5, 
		NULL ACC_CODE6, 
		'000000000' ACC_CODE, 
		'A' TG, 
		0  SLIP_ID, 
		0  SLIP_IDSEQ, 
		SUM(B.REMAIN_DETAIL) REMAIN_DETAIL,
		SUM(B.REMAIN_DETAIL) Running_Total
	FROM
	(
		SELECT 
			NVL(MAX(DECODE(b.ACC_LVL,1,a.PARENT_ACC_CODE)),'000000000') ACC_CODE1, 
			NVL(MAX(DECODE(b.ACC_LVL,2,a.PARENT_ACC_CODE)),'000000000') ACC_CODE2, 
			NVL(MAX(DECODE(b.ACC_LVL,3,a.PARENT_ACC_CODE)),'000000000') ACC_CODE3, 
			NVL(MAX(DECODE(b.ACC_LVL,4,a.PARENT_ACC_CODE)),'000000000') ACC_CODE4, 
			NVL(MAX(DECODE(b.ACC_LVL,5,a.PARENT_ACC_CODE)),'000000000') ACC_CODE5,
			NVL(MAX(DECODE(b.ACC_LVL,6,a.PARENT_ACC_CODE)),'000000000') ACC_CODE6,
			A.ACC_CODE
		FROM
		(
			SELECT 
				B.PARENT_ACC_CODE, A.ACC_CODE
			FROM 
				T_ACC_SLIP_S_VIEW A, 
				T_ACC_CODE_CHILD B
			WHERE 
				A.ACC_CODE = B.CHILD_ACC_CODE 
				AND A.COMP_CODE = AR_COMP_CODE 
				AND A.DEPT_CODE LIKE AR_DEPT_CODE || '%' 
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%' 
				AND A.ACC_CODE LIKE AR_ACC_CODE || '%' 
				AND A.MAKE_DT_TRANS BETWEEN F_T_Stringtodate(AR_DT_F) AND F_T_Stringtodate(AR_DT_T) 
				AND A.TRANSFER_TAG = 'F' 
				AND A.KEEP_DT IS NOT NULL 
				AND A.SLIP_KIND_TAG <> 'D'
			UNION ALL		
			SELECT 
				DISTINCT A.ACC_CODE PARENT_ACC_CODE, A.ACC_CODE
			FROM 
				T_ACC_SLIP_S_VIEW A
			WHERE 
				A.COMP_CODE = AR_COMP_CODE 
				AND A.DEPT_CODE LIKE AR_DEPT_CODE || '%' 
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%' 
				AND A.ACC_CODE LIKE AR_ACC_CODE || '%' 
				AND A.MAKE_DT_TRANS BETWEEN F_T_Stringtodate(AR_DT_F) AND F_T_Stringtodate(AR_DT_T) 
				AND A.TRANSFER_TAG = 'F' 
				AND A.KEEP_DT IS NOT NULL 
				AND A.SLIP_KIND_TAG <> 'D'
		) A,
		T_ACC_CODE B
		WHERE
			A.PARENT_ACC_CODE = B.ACC_CODE
		GROUP BY 
			A.ACC_CODE 
	) A,
	(
		SELECT 
			A.COMP_CODE, 
			'A' TG, 
			A.ACC_CODE, 
			A.ACC_NAME, 
			A.REMAIN_DETAIL 
		FROM 
		( 
			SELECT 
				A.COMP_CODE, 
				a.ACC_CODE, 
				Z.ACC_NAME, 
				SUM(
					CASE 
					WHEN	A.MAKE_DT_TRANS < AR_DT_F THEN 
						DECODE(a.ACC_REMAIN_POSITION,'D',NVL(a.DB_AMT,0)-NVL(a.CR_AMT,0),NVL(a.CR_AMT,0)-NVL(a.DB_AMT,0)) 
					ELSE 
						0 
					END
				) REMAIN_DETAIL 
			FROM
				T_ACC_SLIP_S_VIEW A,
				(
				SELECT 
					DISTINCT ACC_CODE
				FROM
					T_ACC_SLIP_S_VIEW
				WHERE
					COMP_CODE = AR_COMP_CODE
					AND DEPT_CODE LIKE AR_DEPT_CODE || '%'
					AND NVL(CUST_CODE, ' ') LIKE AR_CUST_CODE || '%'  
					AND ACC_CODE LIKE AR_ACC_CODE || '%'  
					AND MAKE_DT_TRANS BETWEEN F_T_Stringtodate(AR_DT_F) AND F_T_Stringtodate(AR_DT_T)
					AND TRANSFER_TAG = 'F'
					AND KEEP_DT IS NOT NULL
					AND SLIP_KIND_TAG <> 'D'
				) B,
				T_ACC_CODE Z
			WHERE
				A.ACC_CODE = B.ACC_CODE
				AND a.ACC_CODE = Z.ACC_CODE
				AND A.COMP_CODE = AR_COMP_CODE
				AND a.DEPT_CODE LIKE AR_DEPT_CODE || '%' 
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%'
				AND a.ACC_CODE LIKE AR_ACC_CODE || '%'
				AND
				(
					(
					 	( A.MAKE_DT_TRANS < AR_DT_F )
						AND
						( A.MAKE_DT_TRANS LIKE SUBSTR(AR_DT_T , 1, 4) ||'%' )
					)
					OR
					( 
					  	( A.MAKE_DT_TRANS BETWEEN AR_DT_F AND AR_DT_T )
					  	AND
						( A.TRANSFER_TAG = 'F' )
					)
				)
				AND A.KEEP_DT_TRANS IS NOT NULL
				AND A.SLIP_KIND_TAG <> 'D'
			GROUP BY
				A.COMP_CODE, 
				a.ACC_CODE,
				Z.ACC_NAME
		) A
	) B
	WHERE                                                       
		a.ACC_CODE = b.ACC_CODE 
	GROUP BY GROUPING SETS
	(
		(
			B.COMP_CODE, 
			a.ACC_CODE1, 
			A.ACC_CODE2, 
			A.ACC_CODE3, 
			A.ACC_CODE4
		),
		(
			B.COMP_CODE, 
			a.ACC_CODE1, 
			A.ACC_CODE2, 
			A.ACC_CODE3
		),
		(
			B.COMP_CODE, 
			a.ACC_CODE1, 
			A.ACC_CODE2
		),
		(
			B.COMP_CODE, 
			a.ACC_CODE1
		)
	)
);

INSERT INTO T_ACC_PRINT_EXT
(
	PROGRAM_ID, 
	USER_NO, 
	SEQ,
	ACC_CODE1, 
	ACC_CODE2, 
	ACC_CODE3, 
	ACC_CODE4, 
	ACC_CODE5, 
	ACC_CODE6, 
	ACC_CODE,
	TG,
	SLIP_ID,
	SLIP_IDSEQ,
	DB_AMT,
	CR_AMT,
	REMAIN_DETAIL,
	RUNNING_TOTAL
)
SELECT
	AR_PROGRAM_ID PROGRAM_ID, 
	AR_USER_NO USER_NO, 
	(
	 	SELECT NVL(MAX(SEQ),0)
		FROM T_ACC_PRINT_EXT
		WHERE
			PROGRAM_ID = AR_PROGRAM_ID
			AND USER_NO = AR_USER_NO
	) + ROWNUM SEQ,
	ACC_CODE1, 
	ACC_CODE2, 
	ACC_CODE3, 
	ACC_CODE4, 
	ACC_CODE5, 
	ACC_CODE6, 
	ACC_CODE,
	TG,
	SLIP_ID,
	SLIP_IDSEQ,
	DB_AMT,
	CR_AMT,
	REMAIN_DETAIL,
	RUNNING_TOTAL
FROM
(
	SELECT 
		S.COMP_CODE, 
		NVL(a.ACC_CODE1,'000000000') ACC_CODE1, 
		NVL(a.ACC_CODE2,'000000000') ACC_CODE2, 
		NVL(a.ACC_CODE3,'000000000') ACC_CODE3, 
		NVL(a.ACC_CODE4,'000000000') ACC_CODE4, 
		NULL ACC_CODE5, 
		NULL ACC_CODE6, 
		NVL(S.ACC_CODE, '000000000') ACC_CODE, 
		S.TG, 
		S.ACC_NAME, 
		S.ACC_REMAIN_POSITION, 
		S.ACC_REMAIN_POSITION_NM, 
		F_T_Datetostring(S.KEEP_DT) KEEP_DT, 
		--S.KEEP_SEQ, 
		--S.KEEP_SLIPNO, 
		S.MAKE_SLIPNO, 
		S.SLIP_ID, 
		S.SLIP_IDSEQ, 
		--S.SUMMARY1, 
		S.DEPT_CODE, 
		S.PROJ_NAME, 
		F_T_Cust_Mask(S.CUST_CODE) CUST_CODE, 
		--S.CUST_NAME, 
		--S.BANK_CODE, 
		--S.BANK_NAME, 
		S.DB_AMT, 
		S.CR_AMT, 
		S.ACC_NAME_T, 
		S.MAKE_DEPT, 
		S.MAKE_DT, 
		--S.MAKE_SEQ, 
		S.REMAIN_DETAIL  , 
		SUM(S.REMAIN_DETAIL) Over (
			PARTITION BY
				S.COMP_CODE,
				a.ACC_CODE1, 
				A.ACC_CODE2, 
				A.ACC_CODE3, 
				A.ACC_CODE4,
				S.ACC_CODE
			ORDER BY 
				S.COMP_CODE, 
				a.ACC_CODE1, 
				A.ACC_CODE2, 
				A.ACC_CODE3, 
				A.ACC_CODE4,
				S.ACC_CODE, 
				S.TG, 
				S.MAKE_DT, 
				S.SLIP_IDSEQ 
			--Range 	Between 	Unbounded Preceding And	Current Row
		) Running_Total 
	FROM
	(
		SELECT 
			NVL(MAX(DECODE(b.ACC_LVL,1,a.PARENT_ACC_CODE)),'000000000') ACC_CODE1, 
			NVL(MAX(DECODE(b.ACC_LVL,2,a.PARENT_ACC_CODE)),'000000000') ACC_CODE2, 
			NVL(MAX(DECODE(b.ACC_LVL,3,a.PARENT_ACC_CODE)),'000000000') ACC_CODE3, 
			NVL(MAX(DECODE(b.ACC_LVL,4,a.PARENT_ACC_CODE)),'000000000') ACC_CODE4, 
			NVL(MAX(DECODE(b.ACC_LVL,5,a.PARENT_ACC_CODE)),'000000000') ACC_CODE5,
			NVL(MAX(DECODE(b.ACC_LVL,6,a.PARENT_ACC_CODE)),'000000000') ACC_CODE6,
			A.ACC_CODE
		FROM
		(
			SELECT 
				B.PARENT_ACC_CODE, A.ACC_CODE
			FROM 
				T_ACC_SLIP_S_VIEW A, 
				T_ACC_CODE_CHILD B
			WHERE 
				A.ACC_CODE = B.CHILD_ACC_CODE 
				AND A.COMP_CODE = AR_COMP_CODE 
				AND A.DEPT_CODE LIKE AR_DEPT_CODE || '%' 
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%' 
				AND A.ACC_CODE LIKE AR_ACC_CODE || '%' 
				AND A.MAKE_DT_TRANS BETWEEN F_T_Stringtodate(AR_DT_F) AND F_T_Stringtodate(AR_DT_T) 
				AND A.TRANSFER_TAG = 'F' 
				AND A.KEEP_DT IS NOT NULL
				AND A.SLIP_KIND_TAG <> 'D'
			UNION ALL		
			SELECT 
				DISTINCT A.ACC_CODE PARENT_ACC_CODE, A.ACC_CODE
			FROM 
				T_ACC_SLIP_S_VIEW A
			WHERE 
				A.COMP_CODE = AR_COMP_CODE 
				AND A.DEPT_CODE LIKE AR_DEPT_CODE || '%' 
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%' 
				AND A.ACC_CODE LIKE AR_ACC_CODE || '%' 
				AND A.MAKE_DT_TRANS BETWEEN F_T_Stringtodate(AR_DT_F) AND F_T_Stringtodate(AR_DT_T) 
				AND A.TRANSFER_TAG = 'F' 
				AND A.KEEP_DT IS NOT NULL 
				AND A.SLIP_KIND_TAG <> 'D'
		) A,
		T_ACC_CODE B
		WHERE
			A.PARENT_ACC_CODE = B.ACC_CODE
		GROUP BY 
			A.ACC_CODE 
	) A,
	( 
		SELECT 
			A.COMP_CODE, 
			'A' TG, 
			A.ACC_CODE, 
			A.ACC_NAME, 
			'' ACC_REMAIN_POSITION, 
			'' ACC_REMAIN_POSITION_NM, 
			NULL KEEP_DT, 
			--0 KEEP_SEQ, 
			--'' KEEP_SLIPNO, 
			'' MAKE_SLIPNO, 
			0  SLIP_ID, 
			0  SLIP_IDSEQ, 
			--'' SUMMARY1, 
			'' DEPT_CODE, 
			'<����  �ܾ�>' PROJ_NAME, 
			'' CUST_CODE, 
			--'' CUST_NAME, 
			--'' BANK_CODE, 
			'' BANK_NAME, 
			0 DB_AMT, 
			0 CR_AMT, 
			'' ACC_NAME_T, 
			'' MAKE_DEPT, 
			NULL MAKE_DT, 
			--0  MAKE_SEQ, 
			A.REMAIN_DETAIL 
		FROM 
		( 
			SELECT 
				A.COMP_CODE, 
				a.ACC_CODE, 
				LPAD(' ',(z.ACC_LVL-1))||z.ACC_NAME ACC_NAME,
				SUM(
					CASE 
					WHEN	A.MAKE_DT_TRANS < AR_DT_F THEN 
						DECODE(a.ACC_REMAIN_POSITION,'D',NVL(a.DB_AMT,0)-NVL(a.CR_AMT,0),NVL(a.CR_AMT,0)-NVL(a.DB_AMT,0)) 
					ELSE 
						0 
					END
				) REMAIN_DETAIL 
			FROM
				T_ACC_SLIP_S_VIEW A,
				(
				SELECT 
					DISTINCT ACC_CODE
				FROM
					T_ACC_SLIP_S_VIEW
				WHERE
					COMP_CODE = AR_COMP_CODE
					AND DEPT_CODE LIKE AR_DEPT_CODE || '%'
					AND NVL(CUST_CODE, ' ') LIKE AR_CUST_CODE || '%'  
					AND ACC_CODE LIKE AR_ACC_CODE || '%'  
					AND MAKE_DT_TRANS BETWEEN F_T_Stringtodate(AR_DT_F) AND F_T_Stringtodate(AR_DT_T)
					AND TRANSFER_TAG = 'F'
					AND KEEP_DT IS NOT NULL
					AND SLIP_KIND_TAG <> 'D'
				) B,
				T_ACC_CODE Z
			WHERE
				A.ACC_CODE = B.ACC_CODE
				AND a.ACC_CODE = Z.ACC_CODE
				AND A.COMP_CODE = AR_COMP_CODE
				AND a.DEPT_CODE LIKE AR_DEPT_CODE || '%' 
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%'
				AND a.ACC_CODE LIKE AR_ACC_CODE || '%'
				AND
				(
					(
					 	( A.MAKE_DT_TRANS < AR_DT_F )
						AND
						( A.MAKE_DT_TRANS LIKE SUBSTR(AR_DT_T , 1, 4) ||'%' )
					)
					OR
					( 
					  	( A.MAKE_DT_TRANS BETWEEN AR_DT_F AND AR_DT_T )
					  	AND
						( A.TRANSFER_TAG = 'F' )
					)
				)
				AND A.KEEP_DT_TRANS IS NOT NULL
				AND A.SLIP_KIND_TAG <> 'D'
			GROUP BY
				A.COMP_CODE, 
				a.ACC_CODE,
				Z.ACC_NAME,
				z.ACC_LVL
		) A
		UNION ALL 
		SELECT 
			A.COMP_CODE, 
			'B' TG, 
			a.ACC_CODE, 
			LPAD(' ',(z.ACC_LVL-1))||z.ACC_NAME ACC_NAME, 
			a.ACC_REMAIN_POSITION, 
			F.CODE_LIST_NAME  ACC_REMAIN_POSITION_NM, 
			A.KEEP_DT, 
			--A.KEEP_SEQ, 
			--A.KEEP_SLIPNO, 
			A.MAKE_SLIPNO, 
			A.SLIP_ID, 
			a.SLIP_IDSEQ, 
			--a.SUMMARY1, 
			a.DEPT_CODE, 
			a.DEPT_NAME, 
			a.CUST_CODE, 
			a.CUST_NAME, 
			--a.BANK_CODE, 
			--a.BANK_NAME, 
			a.DB_AMT, 
			a.CR_AMT, 
			a.ACC_NAME ACC_NAME_T, 
			A.MAKE_DEPT_CODE, 
			A.MAKE_DT, 
			--A.MAKE_SEQ, 
			DECODE(a.ACC_REMAIN_POSITION,'D',NVL(a.DB_AMT,0)-NVL(a.CR_AMT,0),NVL(a.CR_AMT,0)-NVL(a.DB_AMT,0)) REMAIN_DETAIL 
		FROM
			T_ACC_SLIP_S_VIEW A,
			( 
				SELECT 
					F.CODE_LIST_ID , 
					F.CODE_LIST_NAME 
				FROM	V_T_CODE_LIST F 
				WHERE	F.CODE_GROUP_ID = 'ACC_REMAIN_POSITION' 
			) F ,
			T_ACC_CODE Z
		WHERE
			A.ACC_REMAIN_POSITION = F.CODE_LIST_ID(+) 
			AND a.ACC_CODE = Z.ACC_CODE
			AND A.COMP_CODE = AR_COMP_CODE
			AND A.DEPT_CODE LIKE AR_DEPT_CODE || '%'  
			AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%'
			AND a.ACC_CODE LIKE AR_ACC_CODE || '%'
			AND A.MAKE_DT_TRANS BETWEEN AR_DT_F AND AR_DT_T
			AND TRANSFER_TAG = 'F'
			AND A.KEEP_DT_TRANS IS NOT NULL	
			AND A.SLIP_KIND_TAG <> 'D'
	) S
	WHERE                                                       
		a.ACC_CODE = S.ACC_CODE
);

INSERT INTO T_ACC_PRINT_EXT
(
	PROGRAM_ID, 
	USER_NO, 
	SEQ,
	ACC_CODE1, 
	ACC_CODE2, 
	ACC_CODE3, 
	ACC_CODE4, 
	ACC_CODE5, 
	ACC_CODE6, 
	ACC_CODE,
	TG,
	SLIP_ID,
	SLIP_IDSEQ,
	DB_AMT,
	CR_AMT,
	REMAIN_DETAIL,
	RUNNING_TOTAL
)
SELECT
	AR_PROGRAM_ID PROGRAM_ID, 
	AR_USER_NO USER_NO, 
	(
	 	SELECT NVL(MAX(SEQ),0)
		FROM T_ACC_PRINT_EXT
		WHERE
			PROGRAM_ID = AR_PROGRAM_ID
			AND USER_NO = AR_USER_NO
	) + ROWNUM SEQ,
	ACC_CODE1, 
	ACC_CODE2, 
	ACC_CODE3, 
	ACC_CODE4, 
	ACC_CODE5, 
	ACC_CODE6, 
	ACC_CODE,
	TG,
	SLIP_ID,
	SLIP_IDSEQ,
	DB_AMT,
	CR_AMT,
	REMAIN_DETAIL,
	RUNNING_TOTAL
FROM
(
	SELECT
		B.COMP_CODE, 
		NVL(a.ACC_CODE1,'999999999') ACC_CODE1, 
		NVL(a.ACC_CODE2,'999999999') ACC_CODE2, 
		NVL(a.ACC_CODE3,'999999999') ACC_CODE3, 
		NVL(a.ACC_CODE4,'999999999') ACC_CODE4, 
		NULL ACC_CODE5, 
		NULL ACC_CODE6, 
		NVL(a.ACC_CODE, '999999999') ACC_CODE, 
		'C' TG, 
		'' ACC_NAME, 
		'' ACC_REMAIN_POSITION, 
		'' ACC_REMAIN_POSITION_NM, 
		NULL KEEP_DT, 
		0 KEEP_SEQ, 
		'' KEEP_SLIPNO, 
		'' MAKE_SLIPNO, 
		0  SLIP_ID, 
		0  SLIP_IDSEQ, 
		'' SUMMARY1, 
		'' DEPT_CODE, 
		'<'||'a.ACC_NAME'||'  ��>' PROJ_NAME, 
		'' CUST_CODE, 
		'' CUST_NAME, 
		'' BANK_CODE, 
		'' BANK_NAME, 
		SUM(B.DB_AMT) DB_AMT, 
		SUM(B.CR_AMT) CR_AMT, 
		'' ACC_NAME_T, 
		'' MAKE_DEPT, 
		NULL MAKE_DT, 
		0  MAKE_SEQ, 
		SUM(B.REMAIN_DETAIL) REMAIN_DETAIL,
		SUM(B.REMAIN_DETAIL) Running_Total
	FROM
	(
		SELECT 
			NVL(MAX(DECODE(b.ACC_LVL,1,a.PARENT_ACC_CODE)),'000000000') ACC_CODE1, 
			NVL(MAX(DECODE(b.ACC_LVL,2,a.PARENT_ACC_CODE)),'000000000') ACC_CODE2, 
			NVL(MAX(DECODE(b.ACC_LVL,3,a.PARENT_ACC_CODE)),'000000000') ACC_CODE3, 
			NVL(MAX(DECODE(b.ACC_LVL,4,a.PARENT_ACC_CODE)),'000000000') ACC_CODE4, 
			NVL(MAX(DECODE(b.ACC_LVL,5,a.PARENT_ACC_CODE)),'000000000') ACC_CODE5,
			NVL(MAX(DECODE(b.ACC_LVL,6,a.PARENT_ACC_CODE)),'000000000') ACC_CODE6,
			A.ACC_CODE
		FROM
		(
			SELECT 
				B.PARENT_ACC_CODE, A.ACC_CODE
			FROM 
				T_ACC_SLIP_S_VIEW A, 
				T_ACC_CODE_CHILD B
			WHERE 
				A.ACC_CODE = B.CHILD_ACC_CODE 
				AND A.COMP_CODE = AR_COMP_CODE 
				AND A.DEPT_CODE LIKE AR_DEPT_CODE || '%' 
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%' 
				AND A.ACC_CODE LIKE AR_ACC_CODE || '%' 
				AND A.MAKE_DT_TRANS BETWEEN F_T_Stringtodate(AR_DT_F) AND F_T_Stringtodate(AR_DT_T) 
				AND A.TRANSFER_TAG = 'F' 
				AND A.KEEP_DT IS NOT NULL 
				AND A.SLIP_KIND_TAG <> 'D'
			UNION ALL		
			SELECT 
				DISTINCT A.ACC_CODE PARENT_ACC_CODE, A.ACC_CODE
			FROM 
				T_ACC_SLIP_S_VIEW A
			WHERE 
				A.COMP_CODE = AR_COMP_CODE 
				AND A.DEPT_CODE LIKE AR_DEPT_CODE || '%' 
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%' 
				AND A.ACC_CODE LIKE AR_ACC_CODE || '%' 
				AND A.MAKE_DT_TRANS BETWEEN F_T_Stringtodate(AR_DT_F) AND F_T_Stringtodate(AR_DT_T) 
				AND A.TRANSFER_TAG = 'F' 
				AND A.KEEP_DT IS NOT NULL 
				AND A.SLIP_KIND_TAG <> 'D'
		) A,
		T_ACC_CODE B
		WHERE
			A.PARENT_ACC_CODE = B.ACC_CODE
		GROUP BY 
			A.ACC_CODE 
	) A,
	(
		SELECT 
			A.COMP_CODE, 
			'C' TG, 
			A.ACC_CODE, 
			A.ACC_NAME, 
			a.DB_AMT, 
			a.CR_AMT, 
			(a.REMAIN_DETAIL_PRE + a.REMAIN_DETAIL_T) REMAIN_DETAIL , 
			(a.REMAIN_DETAIL_PRE + a.REMAIN_DETAIL_T) Running_Total 
		FROM 
		( 
			SELECT 
				A.COMP_CODE, 
				a.ACC_CODE, 
				LPAD(' ',(z.ACC_LVL-1))||z.ACC_NAME ACC_NAME, 
				SUM(CASE 
						WHEN	A.MAKE_DT_TRANS BETWEEN AR_DT_F AND AR_DT_T THEN 
							NVL(a.DB_AMT,0) 
						ELSE 
							0 
						END) DB_AMT, 
				SUM(CASE 
						WHEN	A.MAKE_DT_TRANS BETWEEN AR_DT_F AND AR_DT_T THEN 
							NVL(a.CR_AMT,0) 
						ELSE 
							0 
						END) CR_AMT, 
				SUM(CASE 
						WHEN	A.MAKE_DT_TRANS < AR_DT_F THEN 
							DECODE(a.ACC_REMAIN_POSITION,'D',NVL(a.DB_AMT,0)-NVL(a.CR_AMT,0),NVL(a.CR_AMT,0)-NVL(a.DB_AMT,0)) 
						ELSE 
							0 
						END) REMAIN_DETAIL_PRE, 
				SUM(CASE 
						WHEN	A.MAKE_DT_TRANS BETWEEN AR_DT_F AND AR_DT_T THEN 
							DECODE(a.ACC_REMAIN_POSITION,'D',NVL(a.DB_AMT,0)-NVL(a.CR_AMT,0),NVL(a.CR_AMT,0)-NVL(a.DB_AMT,0)) 
						ELSE 
							0 
						END) REMAIN_DETAIL_T 
			FROM
				T_ACC_SLIP_S_VIEW A,
				(
					SELECT 
						DISTINCT ACC_CODE
					FROM
						T_ACC_SLIP_S_VIEW
					WHERE
						COMP_CODE = AR_COMP_CODE
						AND DEPT_CODE LIKE AR_DEPT_CODE || '%'  
						AND NVL(CUST_CODE, ' ') LIKE AR_CUST_CODE || '%'
						AND ACC_CODE LIKE AR_ACC_CODE || '%'  
						AND MAKE_DT_TRANS BETWEEN AR_DT_F AND AR_DT_T
						AND TRANSFER_TAG = 'F'
						AND KEEP_DT IS NOT NULL	
						AND SLIP_KIND_TAG <> 'D'
				) B,
				T_ACC_CODE Z
			WHERE
				A.ACC_CODE = B.ACC_CODE
				AND a.ACC_CODE = Z.ACC_CODE
				AND A.COMP_CODE = AR_COMP_CODE
				AND a.DEPT_CODE LIKE AR_DEPT_CODE || '%'
				AND NVL(A.CUST_CODE, ' ') LIKE AR_CUST_CODE || '%' 
				AND a.ACC_CODE LIKE AR_ACC_CODE || '%'
				AND 
				(
					(
					 	( A.MAKE_DT_TRANS < AR_DT_F )
						AND
						( A.MAKE_DT_TRANS LIKE SUBSTR(AR_DT_T , 1, 4) ||'%' )
					)
					OR
					( 
					  	( A.MAKE_DT_TRANS BETWEEN AR_DT_F AND AR_DT_T )
					  	AND
						( A.TRANSFER_TAG = 'F' )
					)
				)
				AND A.KEEP_DT_TRANS IS NOT NULL
				AND A.SLIP_KIND_TAG <> 'D'
			GROUP BY
				A.COMP_CODE, 
				a.ACC_CODE,
				Z.ACC_NAME,
				z.ACC_LVL
		) A
	) B
	WHERE                                                       
		a.ACC_CODE = b.ACC_CODE 
	GROUP BY GROUPING SETS
	(
		(
			B.COMP_CODE, 
			a.ACC_CODE1, 
			A.ACC_CODE2, 
			A.ACC_CODE3, 
			A.ACC_CODE4,
			A.ACC_CODE
		),
		(
			B.COMP_CODE, 
			a.ACC_CODE1, 
			A.ACC_CODE2, 
			A.ACC_CODE3, 
			A.ACC_CODE4
		),
		(
			B.COMP_CODE, 
			a.ACC_CODE1, 
			A.ACC_CODE2, 
			A.ACC_CODE3
		),
		(
			B.COMP_CODE, 
			a.ACC_CODE1, 
			A.ACC_CODE2
		),
		(
			B.COMP_CODE, 
			a.ACC_CODE1
		)
	)
);

END;
/