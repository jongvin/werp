SELECT
	MAX(B.LONG_NAME) ����,
	MAX(A.ǰ��) ǰ��,
	MAX(A.��������) ��������,
	MAX(A.�ε�����) �ε�����,
	MAX(A.��������) ��������,
	
	Max(A.��ü1) ��ü1,
	Max(A.��ü2) ��ü2,
	Max(A.��ü3) ��ü3,

	SUM(nvl(A.����ݾ�,0)) ����ݾ�,
	SUM(nvl(A.�����ǽþ�,0) * nvl(A.����ܰ�,0)) �ݾ׽ǽþ�,
	SUM(nvl(A.�ݾ�,0)) �ݾ�,
	SUM(nvl(A.�ݾ�,0))*0.1 �ΰ���,
	SUM(nvl(A.�ݾ�,0)) + (SUM(nvl(A.�ݾ�,0))*0.1) �ǽñݾ�,

	MAX(A.Ư�����) Ư�����
FROM
    (
    SELECT
    	B.DEPT_CODE,B.APPROYM,B.APPROSEQ,B.APPROVAL_UNQ_NUM,
		B.�����ǽþ� �����ǽþ�,
    	B.BUD_PRICE ����ܰ�,
    	B.BUD_AMT ����ݾ�,
    	B.AMT �ݾ�,
		D.��ü1,
		D.��ü2,
		D.��ü3,
		E.APPROTITLE ǰ��,
		E.DELIVERYLIMITDATE ��������,
		E.DELIVERYMETHOD �ε�����,
		E.PAYMENTMETHOD ��������,
		E.REMARK1 Ư�����
    FROM
    	(
    	SELECT
    		A.DEPT_CODE,A.APPROYM,A.APPROSEQ,A.APPROVAL_UNQ_NUM,A.APPRODETAILSEQ,A.CHG_CNT,
    		A.NAME,
    		A.SSIZE,
        	A.QTY,
    		A.UNITPRICE,
    		A.AMT,
			B.QTY �����ǽþ�,
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
    		max(CASE WHEN ROWNUM = 1 THEN F.SBCR_NAME END) ��ü1,
    		max(CASE WHEN ROWNUM = 2 THEN F.SBCR_NAME END) ��ü2,
    		max(CASE WHEN ROWNUM = 3 THEN F.SBCR_NAME END) ��ü3
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