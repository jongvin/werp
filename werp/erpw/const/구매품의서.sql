SELECT
	MAX(B.LONG_NAME) 현장,
	MAX(A.품명) 품명,
	MAX(A.납기일자) 납기일자,
	MAX(A.인도조건) 인도조건,
	MAX(A.지불조건) 지불조건,
	
	Max(A.업체1) 업체1,
	Max(A.업체2) 업체2,
	Max(A.업체3) 업체3,

	SUM(nvl(A.실행금액,0)) 실행금액,
	SUM(nvl(A.수량실시안,0) * nvl(A.실행단가,0)) 금액실시안,
	SUM(nvl(A.금액,0)) 금액,
	SUM(nvl(A.금액,0))*0.1 부가세,
	SUM(nvl(A.금액,0)) + (SUM(nvl(A.금액,0))*0.1) 실시금액,

	MAX(A.특기사항) 특기사항
FROM
    (
    SELECT
    	B.DEPT_CODE,B.APPROYM,B.APPROSEQ,B.APPROVAL_UNQ_NUM,
		B.수량실시안 수량실시안,
    	B.BUD_PRICE 실행단가,
    	B.BUD_AMT 실행금액,
    	B.AMT 금액,
		D.업체1,
		D.업체2,
		D.업체3,
		E.APPROTITLE 품명,
		E.DELIVERYLIMITDATE 납기일자,
		E.DELIVERYMETHOD 인도조건,
		E.PAYMENTMETHOD 지불조건,
		E.REMARK1 특기사항
    FROM
    	(
    	SELECT
    		A.DEPT_CODE,A.APPROYM,A.APPROSEQ,A.APPROVAL_UNQ_NUM,A.APPRODETAILSEQ,A.CHG_CNT,
    		A.NAME,
    		A.SSIZE,
        	A.QTY,
    		A.UNITPRICE,
    		A.AMT,
			B.QTY 수량실시안,
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
                 AND	A.CHG_CNT = {?d_chg} ) z
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
        
    	) B,
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
    WHERE B.DEPT_CODE = E.DEPT_CODE(+) 
      AND B.APPROYM = E.APPROYM(+) 
      AND B.APPROSEQ = E.APPROSEQ(+) 
      AND B.CHG_CNT = E.CHG_CNT(+)
    ) A,
	Z_CODE_DEPT B
WHERE
	B.DEPT_CODE = A.DEPT_CODE