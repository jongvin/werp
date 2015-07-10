SELECT
	MAX(B.LONG_NAME) 현장,
	MAX(A.품명) 품명,
	MAX(A.납기일자) 납기일자,
	MAX(A.인도조건) 인도조건,
	MAX(A.지불조건) 지불조건,
	MAX(A.변경사유) 변경사유,
	
	Max(A.업체1) 업체1,
	Max(A.업체2) 업체2,
	Max(A.업체3) 업체3,

	SUM(nvl(A.종전실행수량,0)) 종전실행수량,
	SUM(nvl(A.종전실행단가,0)) 종전실행단가,
	SUM(nvl(A.종전실행금액,0)) 종전실행금액,
	SUM(nvl(A.종전수량실시안,0)) 종전수량실시안,
	SUM(nvl(A.종전수량실시안,0) * nvl(A.종전실행단가,0)) 종전금액실시안,
	SUM(nvl(A.종전수량,0)) 종전수량,
	SUM(nvl(A.종전단가,0)) 종전단가,
	SUM(nvl(A.종전금액,0)) 종전금액,

	SUM(nvl(A.변경실행수량,0)) 변경실행수량,
	SUM(nvl(A.변경실행단가,0)) 변경실행단가,
	SUM(nvl(A.변경실행금액,0)) 변경실행금액,
	SUM(nvl(A.변경수량실시안,0)) 변경수량실시안,
	SUM(nvl(A.변경수량실시안,0) * nvl(A.변경실행단가,0)) 변경금액실시안,
	SUM(nvl(A.변경수량,0)) 변경수량,
	SUM(nvl(A.변경단가,0)) 변경단가,
	SUM(nvl(A.변경금액,0)) 변경금액
FROM
    (
    SELECT
    	A.DEPT_CODE,A.APPROYM,A.APPROSEQ,A.APPROVAL_UNQ_NUM,
		B.수량실시안 종전수량실시안,
    	B.BUD_QTY 종전실행수량,
    	B.BUD_PRICE 종전실행단가,
    	B.BUD_AMT 종전실행금액,
    	B.QTY 종전수량,
    	B.UNITPRICE 종전단가,
    	B.AMT 종전금액,
		C.수량실시안 변경수량실시안,
    	C.BUD_QTY 변경실행수량,
    	C.BUD_PRICE 변경실행단가,
    	C.BUD_AMT 변경실행금액,
    	C.QTY 변경수량,
    	C.UNITPRICE 변경단가,
    	C.AMT 변경금액,
		D.업체1,
		D.업체2,
		D.업체3,
		E.APPROTITLE 품명,
		E.DELIVERYLIMITDATE 납기일자,
		E.DELIVERYMETHOD 인도조건,
		E.PAYMENTMETHOD 지불조건,
		E.REMARK1 변경사유
    FROM
    	(
    	SELECT
    		A.DEPT_CODE,A.APPROYM,A.APPROSEQ,A.APPROVAL_UNQ_NUM
    	FROM
    		M_APPROVAL_DETAIL A,
    		M_REQUEST_DETAIL B
    	WHERE
    		A.DEPT_CODE = B.DEPT_CODE(+) AND A.REQUEST_UNQ_NUM = B.REQUEST_UNQ_NUM(+) AND A.REQUEST_CHG_CNT = B.CHG_CNT(+)
    	AND	A.DEPT_CODE = '{?a_dept_code}'
        AND	A.APPROYM = '{?b_date}'
        AND	A.APPROSEQ = {?c_seq}
    	GROUP BY
    		A.DEPT_CODE,A.APPROYM,A.APPROSEQ,A.APPROVAL_UNQ_NUM
    	) A,
    	(
    	SELECT
    		A.DEPT_CODE,A.APPROYM,A.APPROSEQ,A.APPROVAL_UNQ_NUM,A.APPRODETAILSEQ,
    		A.NAME,
    		A.SSIZE,
        	A.QTY,
    		A.UNITPRICE,
    		A.AMT,
         A.QTY 수량실시안,
	      DECODE(Y.SPEC_UNQ_NUM,0,B.BUD_QTY,DECODE(Y.RK_1,1,B.BUD_QTY,0)) BUD_QTY,
    		B.BUD_PRICE,
	      DECODE(Y.SPEC_UNQ_NUM,0,B.BUD_AMT,DECODE(Y.RK_1,1,B.BUD_AMT,0)) BUD_AMT
        FROM
        	M_APPROVAL_DETAIL A,
    		M_REQUEST_DETAIL B,
    		(SELECT b.DEPT_CODE,b.spec_unq_num,b.REQUEST_UNQ_NUM, RANK() OVER 
         		(PARTITION by b.spec_unq_num
         			ORDER BY b.spec_unq_num,b.REQUEST_UNQ_NUM desc ) rk_1
         		from M_approval_DETAIL a,
         		     m_request_detail b
               where a.DEPT_CODE = B.DEPT_CODE(+) 
    	           AND A.REQUEST_UNQ_NUM = B.REQUEST_UNQ_NUM(+) 
    	           AND A.REQUEST_CHG_CNT = B.CHG_CNT(+)
                 AND	A.DEPT_CODE = '{?a_dept_code}'
                 AND	A.APPROYM = '{?b_date}'
                 AND	A.APPROSEQ = {?c_seq}
                 AND	A.CHG_CNT = {?e_chg2} ) Y
        WHERE
    		   A.DEPT_CODE = B.DEPT_CODE(+) 
    	  AND A.REQUEST_UNQ_NUM = B.REQUEST_UNQ_NUM(+) 
    	  AND A.REQUEST_CHG_CNT = B.CHG_CNT(+)
        AND	A.DEPT_CODE = '{?a_dept_code}'
        AND	A.APPROYM = '{?b_date}'
        AND	A.APPROSEQ = {?c_seq}
        AND	A.CHG_CNT = {?e_chg2}
        AND	B.DEPT_CODE = Y.DEPT_CODE
        AND	B.REQUEST_UNQ_NUM = Y.REQUEST_UNQ_NUM 
    	) B,
    	(
    	SELECT
    		A.DEPT_CODE,A.APPROYM,A.APPROSEQ,A.APPROVAL_UNQ_NUM,A.APPRODETAILSEQ,A.CHG_CNT,
    		A.NAME,
    		A.SSIZE,
        	A.QTY,
    		A.UNITPRICE,
    		A.AMT,
         A.QTY 수량실시안,
	      DECODE(Z.SPEC_UNQ_NUM,0,B.BUD_QTY,DECODE(Z.RK_1,1,B.BUD_QTY,0)) BUD_QTY,
    		B.BUD_PRICE,
	      DECODE(Z.SPEC_UNQ_NUM,0,B.BUD_AMT,DECODE(Z.RK_1,1,B.BUD_AMT,0)) BUD_AMT
        FROM
        	M_APPROVAL_DETAIL A,
    		M_REQUEST_DETAIL B,
    		(SELECT b.DEPT_CODE,b.spec_unq_num,b.REQUEST_UNQ_NUM, RANK() OVER 
         		(PARTITION by b.spec_unq_num
         			ORDER BY b.spec_unq_num,b.REQUEST_UNQ_NUM desc ) rk_1
         		from M_approval_DETAIL a,
         		     m_request_detail b
               where a.DEPT_CODE = B.DEPT_CODE(+) 
    	           AND A.REQUEST_UNQ_NUM = B.REQUEST_UNQ_NUM(+) 
    	           AND A.REQUEST_CHG_CNT = B.CHG_CNT(+)
                 AND	A.DEPT_CODE = '{?a_dept_code}'
                 AND	A.APPROYM = '{?b_date}'
                 AND	A.APPROSEQ = {?c_seq}
                 AND	A.CHG_CNT = {?d_chg} ) Z
        WHERE
    		A.DEPT_CODE = B.DEPT_CODE(+) 
    	  AND A.REQUEST_UNQ_NUM = B.REQUEST_UNQ_NUM(+) 
    	  AND A.REQUEST_CHG_CNT = B.CHG_CNT(+)
    	  AND	A.DEPT_CODE = '{?a_dept_code}'
        AND	A.APPROYM = '{?b_date}'
        AND	A.APPROSEQ = {?c_seq}
        AND	A.CHG_CNT = {?d_chg}
        AND	B.DEPT_CODE = Z.DEPT_CODE
        AND	B.REQUEST_UNQ_NUM = Z.REQUEST_UNQ_NUM 
    	) C,
		(
    	SELECT
    		max(CASE WHEN ROWNUM = 1 THEN F.SBCR_NAME END) 업체1,
    		max(CASE WHEN ROWNUM = 2 THEN F.SBCR_NAME END) 업체2,
    		max(CASE WHEN ROWNUM = 3 THEN F.SBCR_NAME END) 업체3
    	FROM
    		M_APPROVAL_SBCR E,
    		S_SBCR F
    	WHERE
    			E.SBCR_CODE = F.SBCR_CODE(+)
    		AND	E.DEPT_CODE = '{?a_dept_code}'
    	    AND	E.APPROYM = '{?b_date}'
        	AND	E.APPROSEQ = {?c_seq}
    	    AND	E.CHG_CNT = {?d_chg}
    		AND ROWNUM <= 3
    	) D,
		M_APPROVAL E
		
    WHERE
    	A.DEPT_CODE = B.DEPT_CODE(+) 
    AND A.APPROYM = B.APPROYM(+) AND A.APPROSEQ = B.APPROSEQ(+) AND A.APPROVAL_UNQ_NUM = B.APPROVAL_UNQ_NUM(+)
    AND A.DEPT_CODE = C.DEPT_CODE(+) AND A.APPROYM = C.APPROYM(+) AND A.APPROSEQ = C.APPROSEQ(+) AND A.APPROVAL_UNQ_NUM = C.APPROVAL_UNQ_NUM(+)
    AND C.DEPT_CODE = E.DEPT_CODE(+) AND C.APPROYM = E.APPROYM(+) AND C.APPROSEQ = E.APPROSEQ(+) AND C.CHG_CNT = E.CHG_CNT(+)
    ) A,
	Z_CODE_DEPT B


WHERE
	B.DEPT_CODE = A.DEPT_CODE
