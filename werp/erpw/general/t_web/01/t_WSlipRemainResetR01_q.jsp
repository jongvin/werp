<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-21)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{			
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DEPT_CODE = CITCommon.toKOR(request.getParameter("MAKE_DEPT_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			String strEXPR_DT_F = CITCommon.toKOR(request.getParameter("EXPR_DT_F"));
			String strEXPR_DT_T = CITCommon.toKOR(request.getParameter("EXPR_DT_T"));
			
			strSql  = " SELECT  \n";
			strSql += " 	'F' CHK_CLS, \n";
			strSql += " 	F_T_DateToString(B3.PAY_CON_BILL_DT) PAY_CON_BILL_DT_GRP,   \n";
			strSql += " 	F_T_DateToString(B3.PAY_CON_BILL_DT) PAY_CON_BILL_DT,   \n";
			strSql += " 	a.SLIP_ID ,   \n";
			strSql += " 	a.SLIP_IDSEQ ,  \n";
			strSql += " 	d.ACC_CODE ,   \n";
			strSql += " 	d.ACC_NAME ,   \n";
			strSql += " 	d.ACC_REMAIN_POSITION ,   \n";
			strSql += " 	C.NAME ACC_REMAIN_POSITION_NAME ,    \n";
			strSql += " 	e.COMP_CODE,     \n";
			strSql += " 	e.COMPANY_NAME COMP_NAME,   \n";
			strSql += " 	f.DEPT_CODE,  \n";
			strSql += " 	f.DEPT_NAME,  \n";
			strSql += " 	g.CUST_SEQ ,   \n";
			strSql += " 	g.CUST_CODE ,   \n";
			strSql += " 	g.CUST_NAME ,    \n";
			strSql += " 	A.SET_AMT,  \n";
			strSql += " 	A.RESET_AMT,   \n";
			strSql += " 	A.NOT_RESET_AMT,  \n";
			strSql += " 	A.SET_AMT - A.RESET_AMT REMAIN_AMT,  \n";
			strSql += " 	0 INPUT_AMT,  \n";
			strSql += " 	b1.MAKE_SLIPNO||'-'||b2.MAKE_SLIPLINE MAKE_SLIPNOLINE,  \n";
			strSql += " 	b3.SUMMARY1,  \n";
			strSql += " 	-- 전표조회 인자  \n";
			strSql += " 	b1.MAKE_COMP_CODE ,   \n";
			strSql += " 	F_T_DateToString(b1.MAKE_DT) MAKE_DT,   \n";
			strSql += " 	b1.MAKE_SEQ ,   \n";
			strSql += " 	b1.SLIP_KIND_TAG  \n";
			strSql += " FROM  \n";
			strSql += " (  \n";
			strSql += " 	SELECT     \n";
			strSql += " 		A.ACC_CODE,    \n";
			strSql += " 		A.COMP_CODE,    \n";
			strSql += " 		A.DEPT_CODE,    \n";
			strSql += " 		A.CUST_SEQ,    \n";
			strSql += " 		A.SLIP_ID ,      \n";
			strSql += " 		A.SLIP_IDSEQ,    \n";
			strSql += " 		D.ACC_REMAIN_POSITION,    \n";
			strSql += " 		-- 설정     \n";
			strSql += " 		DECODE(D.ACC_REMAIN_POSITION, 'D', 1, 0)*NVL(A.DB_AMT,0)   \n";
			strSql += " 		+   \n";
			strSql += " 		DECODE(D.ACC_REMAIN_POSITION, 'C', 1, 0)*NVL(A.CR_AMT,0) SET_AMT,   \n";
			strSql += " 		-- 반제확정   \n";
			strSql += " 		DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B1.DB_AMT,0)   \n";
			strSql += " 		+   \n";
			strSql += " 		DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B1.CR_AMT,0) RESET_AMT,    \n";
			strSql += " 		-- 반제미확정   \n";
			strSql += " 		DECODE(D.ACC_REMAIN_POSITION, 'D', -1, 1)*NVL(B2.DB_AMT,0)   \n";
			strSql += " 		+   \n";
			strSql += " 		DECODE(D.ACC_REMAIN_POSITION, 'C', -1, 1)*NVL(B2.CR_AMT,0) NOT_RESET_AMT     \n";
			strSql += " 	FROM     \n";
			strSql += " 		T_ACC_SLIP_BODY1 A,      \n";
			strSql += " 		T_ACC_SLIP_BODY2 A1,      \n";
			strSql += " 		(   \n";
			strSql += " 			SELECT   \n";
			strSql += " 				A.RESET_SLIP_ID,   \n";
			strSql += " 				A.RESET_SLIP_IDSEQ,   \n";
			strSql += " 				NVL(SUM(A.DB_AMT),0) DB_AMT,   \n";
			strSql += " 				NVL(SUM(A.CR_AMT),0) CR_AMT   \n";
			strSql += " 			FROM   \n";
			strSql += " 				T_ACC_SLIP_BODY1 A \n";
			strSql += " 			WHERE     \n";
			strSql += " 				--A.SLIP_ID <> A.RESET_SLIP_ID      \n";
			strSql += " 				--AND	      \n";
			strSql += " 				A.ACC_CODE In ('210010300','210010301','210010390')   \n";
			strSql += " 				AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ      \n";
			strSql += " 				AND A.KEEP_DT IS NOT NULL     \n";
			strSql += " 				AND A.TRANSFER_TAG <> 'T' \n";
			strSql += " 				AND A.IGNORE_SET_RESET_TAG <> 'T' \n";
			strSql += " 			GROUP BY   \n";
			strSql += " 				A.RESET_SLIP_ID,   \n";
			strSql += " 				A.RESET_SLIP_IDSEQ   \n";
			strSql += " 		) B1,     \n";
			strSql += " 		(   \n";
			strSql += " 			SELECT   \n";
			strSql += " 				A.RESET_SLIP_ID,   \n";
			strSql += " 				A.RESET_SLIP_IDSEQ,   \n";
			strSql += " 				NVL(SUM(A.DB_AMT),0) DB_AMT,   \n";
			strSql += " 				NVL(SUM(A.CR_AMT),0) CR_AMT   \n";
			strSql += " 			FROM   \n";
			strSql += " 				T_ACC_SLIP_BODY1 A \n";
			strSql += " 			WHERE     \n";
			strSql += " 				--A.SLIP_ID <> A.RESET_SLIP_ID      \n";
			strSql += " 				--AND  \n";
			strSql += " 			A.ACC_CODE  In ('210010300','210010301','210010390')   \n";
			strSql += " 				AND A.SLIP_IDSEQ <> A.RESET_SLIP_IDSEQ      \n";
			strSql += " 				AND A.KEEP_DT IS NULL   \n";
			strSql += " 				AND A.TRANSFER_TAG <> 'T' \n";
			strSql += " 				AND A.IGNORE_SET_RESET_TAG <> 'T' \n";
			strSql += " 			GROUP BY   \n";
			strSql += " 				A.RESET_SLIP_ID,   \n";
			strSql += " 				A.RESET_SLIP_IDSEQ   \n";
			strSql += " 		) B2,     \n";
			strSql += " 		T_CUST_CODE C,     \n";
			strSql += " 		T_ACC_CODE D \n";
			strSql += " 	WHERE \n";
			strSql += " 		A.SLIP_ID = A.RESET_SLIP_ID      \n";
			strSql += " 		AND	A.SLIP_IDSEQ = A.RESET_SLIP_IDSEQ      \n";
			strSql += " 		AND	A.SLIP_ID = A1.SLIP_ID     \n";
			strSql += "    		AND	A.SLIP_IDSEQ = A1.SLIP_IDSEQ \n";
			strSql += " 		AND	A.SLIP_ID = B1.RESET_SLIP_ID (+)   \n";
			strSql += " 		AND	A.SLIP_IDSEQ = B1.RESET_SLIP_IDSEQ (+)     \n";
			strSql += " 		AND	A.SLIP_ID = B2.RESET_SLIP_ID (+)   \n";
			strSql += " 		AND	A.SLIP_IDSEQ = B2.RESET_SLIP_IDSEQ (+)     \n";
			strSql += " 		AND	A.CUST_SEQ = C.CUST_SEQ      \n";
			strSql += " 		AND	A.ACC_CODE = D.ACC_CODE     \n";
			strSql += " 		AND A.KEEP_DT IS NOT NULL     \n";
			strSql += " 		AND A.TRANSFER_TAG <> 'T' \n";
			strSql += " 		AND A.IGNORE_SET_RESET_TAG <> 'T' \n";
			strSql += " 		AND	A.MAKE_COMP_CODE =   ?     \n";
			strSql += " 		AND	A.MAKE_DEPT_CODE  LIKE   ?    || '%'  \n";
			strSql += " 		AND	A.COMP_CODE =   ?     \n";
			strSql += " 		AND	A.DEPT_CODE  LIKE   ?    || '%'  \n";
			strSql += " 		AND	A.MAKE_DT BETWEEN F_T_STRINGTODATE(  ?  ) AND F_T_STRINGTODATE(  ?  )  \n";
			strSql += " 		AND	A.ACC_CODE  In ('210010300','210010301','210010390')   \n";
			strSql += " 		AND	C.CUST_CODE LIKE   ?    || '%'  \n";
			strSql += " 		AND	A1.PAY_CON_BILL_DT BETWEEN F_T_Stringtodate( ? ) AND F_T_Stringtodate( ? )  \n";
			strSql += " 		AND D.Acc_REMAIN_MNG = 'T'  \n";
			strSql += " 		AND D.CHK_NO_MNG = 'F' \n";
			strSql += " 		AND D.BILL_NO_MNG = 'F' \n";
			strSql += " 		AND D.REC_BILL_NO_MNG = 'F' \n";
			strSql += " 		AND D.CP_NO_MNG = 'F' \n";
			strSql += " 		AND D.SECU_MNG = 'F' \n";
			strSql += " 		AND D.LOAN_NO_MNG = 'F' \n";
			strSql += " 		AND D.FIXED_MNG = 'F' \n";
			strSql += " 		AND D.BILL_EXPR_MNG = 'T' \n";
			strSql += " 	) A,  \n";
			strSql += "  	T_ACC_SLIP_HEAD B1,      \n";
			strSql += "  	T_ACC_SLIP_BODY1 B2,      \n";
			strSql += "  	T_ACC_SLIP_BODY2 B3,      \n";
			strSql += " 	(   \n";
			strSql += " 		SELECT   \n";
			strSql += " 			a.CODE_LIST_ID AS CODE,   \n";
			strSql += " 			a.CODE_LIST_NAME AS NAME   \n";
			strSql += " 		FROM   \n";
			strSql += " 			V_T_CODE_LIST a   \n";
			strSql += " 		WHERE   \n";
			strSql += " 			a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION'   \n";
			strSql += " 	) C, \n";
			strSql += "  	T_ACC_CODE D,      \n";
			strSql += "  	T_COMPANY E,     \n";
			strSql += "  	T_DEPT_CODE F,     \n";
			strSql += "  	T_CUST_CODE G    \n";
			strSql += " WHERE   \n";
			strSql += "  	A.SLIP_ID = B1.SLIP_ID(+)      \n";
			strSql += "  	AND	A.SLIP_ID = B2.SLIP_ID(+)      \n";
			strSql += "  	AND	A.SLIP_IDSEQ = B2.SLIP_IDSEQ(+)    \n";
			strSql += "  	AND	A.SLIP_ID = B3.SLIP_ID(+)      \n";
			strSql += "  	AND	A.SLIP_IDSEQ = B3.SLIP_IDSEQ(+)    \n";
			strSql += "  	AND	A.ACC_CODE = D.ACC_CODE(+)    \n";
			strSql += "  	AND	D.ACC_REMAIN_POSITION = C.CODE(+)    \n";
			strSql += "  	AND	A.COMP_CODE = E.COMP_CODE(+)    \n";
			strSql += "  	AND	A.DEPT_CODE = F.DEPT_CODE(+)    \n";
			strSql += "  	AND	A.CUST_SEQ = G.CUST_SEQ(+) \n";
			strSql += "   	-- 미반제   \n";
			strSql += "    	AND	A.SET_AMT - A.RESET_AMT > 0     \n";
			strSql += " ORDER BY  \n";
			strSql += " 	A.ACC_CODE,  \n";
			strSql += " 	B3.PAY_CON_BILL_DT,  \n";
			strSql += " 	B2.MAKE_DT,  \n";
			strSql += " 	B1.MAKE_SEQ,  \n";
			strSql += " 	A.COMP_CODE,    \n";
			strSql += " 	A.DEPT_CODE,    \n";
			strSql += " 	A.CUST_SEQ,    \n";
			strSql += " 	A.SLIP_ID ,      \n";
			strSql += " 	A.SLIP_IDSEQ ";
			
			lrArgData.addColumn("3MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("6DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("7DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("8DT_T", CITData.VARCHAR2);
			lrArgData.addColumn("10CUST_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("11EXPR_DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("12EXPR_DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("3MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("4MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("5COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("6DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("7DT_F", strDT_F);
			lrArgData.setValue("8DT_T", strDT_T);
			lrArgData.setValue("10CUST_CODE", strCUST_CODE);
			lrArgData.setValue("11EXPR_DT_F", strEXPR_DT_F);
			lrArgData.setValue("12EXPR_DT_T", strEXPR_DT_T);
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}

		}
		else if (strAct.equals("MAIN01"))
		{			
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DEPT_CODE = CITCommon.toKOR(request.getParameter("MAKE_DEPT_CODE"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strCUST_CODE = CITCommon.toKOR(request.getParameter("CUST_CODE"));
			String strEXPR_DT_F = CITCommon.toKOR(request.getParameter("EXPR_DT_F"));
			String strEXPR_DT_T = CITCommon.toKOR(request.getParameter("EXPR_DT_T"));
			
			strSql  = " SELECT \n";
			strSql += " 	'F' CHK_CLS, \n";
			strSql += "  	DECODE(b.KEEP_DT,NULL,'F','T') KEEP_CLS, \n";
			strSql += "  	b.SLIP_ID ,   \n";
			strSql += "  	b.SLIP_IDSEQ ,  \n";
			strSql += "  	b.ACC_CODE ,   \n";
			strSql += "  	b.ACC_NAME ,   \n";
			strSql += "  	b.ACC_REMAIN_POSITION ,   \n";
			strSql += " 	C.NAME ACC_REMAIN_POSITION_NAME ,    \n";
			strSql += " 	b.COMP_CODE, \n";
			strSql += " 	b.COMP_NAME, \n";
			strSql += " 	b.DEPT_CODE, \n";
			strSql += " 	b.DEPT_NAME, \n";
			strSql += "  	b.CUST_SEQ , \n";
			strSql += "  	b.CUST_CODE, \n";
			strSql += "  	b.CUST_NAME, \n";
			strSql += "  	b.MAKE_SLIPNO||'-'||b.MAKE_SLIPLINE RESET_MAKE_SLIPNOLINE,  \n";
			strSql += "  	b.SUMMARY1,  \n";
			strSql += "  	-- 전표조회 인자  \n";
			strSql += "  	b.MAKE_COMP_CODE ,   \n";
			strSql += "  	F_T_DateToString(b.MAKE_DT) MAKE_DT,   \n";
			strSql += "  	b.MAKE_SEQ ,   \n";
			strSql += "  	b.SLIP_KIND_TAG, \n";
			strSql += "  	NVL(b.DB_AMT,0)+NVL(b.CR_AMT,0) RESET_AMT,   \n";
			strSql += "  	NVL(E.DB_AMT,0)+NVL(E.CR_AMT,0) SET_AMT,  \n";
			strSql += " 	E.MAKE_SLIPNO||'-'||E.MAKE_SLIPLINE SET_MAKE_SLIPNOLINE,  \n";
			strSql += " 	F_T_DATETOSTRING(E.PAY_CON_BILL_DT) PAY_CON_BILL_DT, \n";
			strSql += "  	0 NOT_RESET_AMT,  \n";
			strSql += "  	0 REMAIN_AMT  \n";
			strSql += "  FROM  \n";
			strSql += "  T_ACC_SLIP_VIEW B,   \n";
			strSql += "  (   \n";
			strSql += " 	SELECT   \n";
			strSql += " 		a.CODE_LIST_ID AS CODE,   \n";
			strSql += " 		a.CODE_LIST_NAME AS NAME   \n";
			strSql += " 	FROM   \n";
			strSql += " 		V_T_CODE_LIST a   \n";
			strSql += " 	WHERE   \n";
			strSql += " 	a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION'   \n";
			strSql += " ) C , \n";
			strSql += " T_ACC_CODE D, \n";
			strSql += " T_ACC_SLIP_VIEW E \n";
			strSql += " WHERE   \n";
			strSql += " 	B.SLIP_ID <> B.RESET_SLIP_ID  \n";
			strSql += " 	AND	B.SLIP_IDSEQ <> B.RESET_SLIP_IDSEQ   \n";
			strSql += " 	AND	B.ACC_REMAIN_POSITION = C.CODE \n";
			strSql += " 	AND B.ACC_CODE = D.ACC_CODE  \n";
			strSql += " 	AND B.RESET_SLIP_ID = E.SLIP_ID  \n";
			strSql += " 	AND	B.RESET_SLIP_IDSEQ = E.SLIP_IDSEQ   \n";
			strSql += " 	AND B.TRANSFER_TAG <> 'T' \n";
			strSql += " 	AND B.IGNORE_SET_RESET_TAG <> 'T' \n";
			strSql += " 	AND	b.MAKE_COMP_CODE =   ?    \n";
			strSql += " 	AND	b.MAKE_DEPT_CODE  LIKE   ? || '%'  \n";
			strSql += " 	AND	b.COMP_CODE =   ?    \n";
			strSql += " 	AND	b.DEPT_CODE  LIKE   ? ||'%'  \n";
			strSql += " 	AND	b.MAKE_DT BETWEEN F_T_STRINGTODATE(  ?  ) AND F_T_STRINGTODATE(  ?  )  \n";
			strSql += " 	AND	b.ACC_CODE  In ('210010300','210010301','210010390')   \n";
			strSql += " 	AND	b.CUST_CODE LIKE   ? ||'%'  \n";
			strSql += " 	AND	e.PAY_CON_BILL_DT BETWEEN F_T_Stringtodate( ? ) AND F_T_Stringtodate( ? )  \n";
			strSql += " 	AND d.Acc_REMAIN_MNG = 'T'  \n";
			strSql += " 	AND d.CHK_NO_MNG = 'F'  \n";
			strSql += " 	AND d.BILL_NO_MNG = 'F'  \n";
			strSql += " 	AND d.REC_BILL_NO_MNG = 'F'  \n";
			strSql += " 	AND d.CP_NO_MNG = 'F'  \n";
			strSql += " 	AND d.SECU_MNG = 'F'  \n";
			strSql += " 	AND d.LOAN_NO_MNG = 'F'  \n";
			strSql += " 	AND d.FIXED_MNG = 'F'  \n";
			strSql += " 	AND D.BILL_EXPR_MNG = 'T'   ";
			strSql += " ORDER BY  \n";
			strSql += " 	b.MAKE_SLIPNO ,  \n";
			strSql += " 	b.MAKE_SLIPLINE \n";

			lrArgData.addColumn("1MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("5DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("6DT_T", CITData.VARCHAR2);
			lrArgData.addColumn("8CUST_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("9EXPR_DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("10EXPR_DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("2MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			lrArgData.setValue("3COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("5DT_F", strDT_F);
			lrArgData.setValue("6DT_T", strDT_T);
			lrArgData.setValue("8CUST_CODE", strCUST_CODE);
			lrArgData.setValue("9EXPR_DT_F", strEXPR_DT_F);
			lrArgData.setValue("10EXPR_DT_T", strEXPR_DT_T);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}

		}
		else if (strAct.equals("MAKE_SEQ"))
		{
			String strMAKE_COMP_CODE = CITCommon.toKOR(request.getParameter("MAKE_COMP_CODE"));
			String strMAKE_DT_TRANS = CITCommon.toKOR(request.getParameter("MAKE_DT_TRANS"));
			
			strSql  = " Select F_T_GET_NEW_MAKE_SEQ(?,?) MAKE_SEQ	From DUAL ";
			
			lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DT_TRANS", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MAKE_COMP_CODE", strMAKE_COMP_CODE);
			lrArgData.setValue("MAKE_DT_TRANS", strMAKE_DT_TRANS);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAKE_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		
		else if (strAct.equals("WORK_SLIP_IDSEQ"))
		{
			String strGET_TYPE = CITCommon.toKOR(request.getParameter("GET_TYPE"));
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			if("NEW".equals(strGET_TYPE)) {
				strSql  = " Select SQ_T_WORK_SLIP_ID.NEXTVAL WORK_SLIP_ID, SQ_T_WORK_SLIP_IDSEQ.NEXTVAL WORK_SLIP_IDSEQ From DUAL ";
			} else if("CUR".equals(strGET_TYPE)) {
				strSql  = " Select \n";
				strSql += " 	NVL(B.SLIP_ID,0) WORK_SLIP_ID, \n";
				strSql += " 	NVL(B.SLIP_IDSEQ,0) WORK_SLIP_IDSEQ \n";
				strSql += " From DUAL A, \n";
				strSql += " ( \n";
				strSql += " 	Select ROWNUM RN \n";
				strSql += " 	From DUAL \n";
				strSql += " ) A, \n";
				strSql += " ( \n";
				strSql += " 	SELECT ROWNUM RN, SLIP_ID, SLIP_IDSEQ \n";
				strSql += " 	FROM T_WORK_ACC_SLIP_BODY \n";
				strSql += " 	WHERE \n";
				strSql += " 		WORK_CODE =  ?  \n";
				strSql += " 		AND DEPT_CODE =  ?  \n";
				strSql += " 		AND CRTDATE = ( \n";
				strSql += " 			SELECT MAX(CRTDATE) \n";
				strSql += " 			FROM T_WORK_ACC_SLIP_BODY \n";
				strSql += " 			WHERE \n";
				strSql += " 				WORK_CODE =  ?  \n";
				strSql += " 				AND DEPT_CODE =  ?  \n";
				strSql += " 		) \n";
				strSql += " ) B \n";
				strSql += " WHERE \n";
				strSql += " 	A.RN = B.RN(+) ";
				
				lrArgData.addColumn("1WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("2DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("3WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1WORK_CODE", strWORK_CODE);
				lrArgData.setValue("2DEPT_CODE", strDEPT_CODE);
				lrArgData.setValue("3WORK_CODE", strWORK_CODE);
				lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
			} else {
			}

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("AUTO_REMAIN_RESET_SEQ"))
		{
			strSql  = " Select SQ_T_AUTO_REMAIN_RESET.NEXTVAL AUTO_REMAIN_RESET_SEQ From DUAL ";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SLIP_ID Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("NEW_WORK_SLIP"))
		{
			String strWORK_SLIP_ID = CITCommon.toKOR(request.getParameter("WORK_SLIP_ID"));
			String strWORK_SLIP_IDSEQ = CITCommon.toKOR(request.getParameter("WORK_SLIP_IDSEQ"));
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));

			try
			{
				strSql = "{call SP_T_WORK_ACC_SLIP_BODY_EMY_I(?,?,?,?,?)}";
				
				lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
				lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
				lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
				lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("SLIP_ID", strWORK_SLIP_ID);
				lrArgData.setValue("SLIP_IDSEQ", strWORK_SLIP_IDSEQ);
				lrArgData.setValue("CRTUSERNO", strUserNo);
				lrArgData.setValue("WORK_CODE", strWORK_CODE);
				lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
				
				CITDatabase.executeProcedure(strSql, lrArgData);
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAKE_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("DAY_CLOSE"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCLSE_DAY = CITCommon.toKOR(request.getParameter("CLSE_DAY"));
			
			strSql  = " SELECT \n";
			strSql += " 	ROWNUM, \n";
			strSql += " 	A.COMP_CODE,   \n";
			strSql += " 	A.CLSE_ACC_ID,   \n";
			strSql += " 	A.ACC_ID,   \n";
			strSql += " 	F_T_DATETOSTRING(A.ACCOUNT_FDT) ACCOUNT_FDT,   \n";
			strSql += " 	F_T_DATETOSTRING(A.ACCOUNT_EDT) ACCOUNT_EDT,   \n";
			strSql += " 	NVL(A.CLSE_CLS, 'F') ACC_CLSE_CLS,   \n";
			strSql += " 	B.CLSE_MONTH,   \n";
			strSql += " 	NVL(B.CLSE_CLS, 'F') MON_CLSE_CLS, 				  \n";
			strSql += " 	F_T_DateToString(C.CLSE_DAY) CLSE_DAY,   \n";
			strSql += " 	NVL(C.CLSE_CLS, 'F') DAY_CLSE_CLS ,  \n";
			strSql += " 	D.INPUT_DT_F, \n";
			strSql += " 	D.INPUT_DT_T, \n";
			strSql += " 	D.INPUT_DT_F||'~'||D.INPUT_DT_T INPUT_DT, \n";
			strSql += " 	D.DEPT_CLSE_CLS, \n";
			strSql += " 	(  \n";
			strSql += " 		CASE  \n";
			strSql += " 			WHEN (A.CLSE_CLS='T') OR (B.CLSE_CLS='T') OR (B.CLSE_CLS='T') OR (D.DEPT_CLSE_CLS='T') THEN 'T'  \n";
			strSql += " 			ELSE 'F'  \n";
			strSql += " 		END  \n";
			strSql += " 	) CLSE_CLS \n";
			strSql += " FROM  \n";
			strSql += " 	T_YEAR_CLOSE A,  \n";
			strSql += " 	T_MONTH_CLOSE B,  \n";
			strSql += " 	T_DAY_CLOSE C, \n";
			strSql += " 	( \n";
			strSql += " 	 	-- 부서 입력기간 체크 \n";
			strSql += " 		SELECT \n";
			strSql += " 			 ROWNUM RN, \n";
			strSql += " 			 F_T_DATETOSTRING(NVL(INPUT_DT_F, '19000101')) INPUT_DT_F, \n";
			strSql += " 			 F_T_DATETOSTRING(NVL(INPUT_DT_T, '19000101')) INPUT_DT_T, \n";
			strSql += " 			 CASE \n";
			strSql += " 			 	 WHEN ( F_T_DATETOSTRING(F_T_STRINGTODATE(?)) BETWEEN F_T_DATETOSTRING(NVL(INPUT_DT_F, '19000101')) AND F_T_DATETOSTRING(NVL(INPUT_DT_T, '19000101')) ) \n";
			strSql += " 				 THEN 'F' -- 입력기간 \n";
			strSql += " 				 ELSE 'T' -- 입력마감 \n";
			strSql += " 			END DEPT_CLSE_CLS \n";
			strSql += " 		FROM \n";
			strSql += " 			T_DEPT_CODE_ORG A \n";
			strSql += " 		WHERE   \n";
			strSql += " 			A.COMP_CODE = ? \n";
			strSql += " 			AND DEPT_CODE = ? \n";
			strSql += " 	) D \n";
			strSql += " WHERE   \n";
			strSql += " 	A.COMP_CODE = B.COMP_CODE  \n";
			strSql += " 	AND A.CLSE_ACC_ID = B.CLSE_ACC_ID  \n";
			strSql += " 	AND B.COMP_CODE = C.COMP_CODE  \n";
			strSql += " 	AND B.CLSE_ACC_ID = C.CLSE_ACC_ID  \n";
			strSql += " 	AND B.CLSE_MONTH = C.CLSE_MONTH  \n";
			strSql += " 	AND ROWNUM = D.RN(+) \n";
			strSql += " 	AND A.COMP_CODE = ? \n";
			strSql += " 	AND C.CLSE_DAY = ? ";

			lrArgData.addColumn("CLSE_DAY1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE1", CITData.VARCHAR2);
			
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_DAY2", CITData.VARCHAR2);
			
			lrArgData.addRow();
			
			lrArgData.setValue("CLSE_DAY1", strCLSE_DAY);
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("DEPT_CODE1", strDEPT_CODE);

			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("CLSE_DAY2", strCLSE_DAY);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","CLSE_CLS Select 오류-> "+ ex.getMessage());
			}
		}

	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
			GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
		}
	}
%>