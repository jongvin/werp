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
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strDT_F = CITCommon.toKOR(request.getParameter("DT_F"));
			String strDT_T = CITCommon.toKOR(request.getParameter("DT_T"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strMAKE_DEPT_CODE = CITCommon.toKOR(request.getParameter("MAKE_DEPT_CODE"));
			String strMAKE_SLIPCLS =  CITCommon.toKOR(request.getParameter("MAKE_SLIPCLS"));
			
			strSql  = " SELECT    \n";
			strSql += "   	A.SLIP_ID ,      \n";
			strSql += "   	A.SLIP_IDSEQ ,      \n";
			strSql += "   	A.MAKE_COMP_CODE ,      \n";
			strSql += "  	A.MAKE_COMP_NAME ,      \n";
			strSql += "  	A.MAKE_DEPT_CODE ,      \n";
			strSql += "  	A.MAKE_DEPT_NAME ,      \n";
			strSql += "   	A.MAKE_DT ,        \n";
			strSql += " 	A.MAKE_SEQ , \n";
			strSql += "   	A.SLIP_KIND_TAG ,      \n";
			strSql += "   	DECODE( A.MAKE_SLIPLINE, NULL, NULL, A.MAKE_SLIPNO) MAKE_SLIPNO ,      \n";
			strSql += "   	''||A.MAKE_SLIPLINE MAKE_SLIPLINE,    \n";
			strSql += "   	DECODE( A.MAKE_SLIPLINE, NULL, NULL, A.MAKE_SLIPNO||'-'||A.MAKE_SLIPLINE) MAKE_SLIPNOLINE,      \n";
			strSql += "   	DECODE( A.MAKE_SLIPLINE, NULL, '  '||COUNT(A.ACC_CODE)||' 항목', A.ACC_CODE) ACC_CODE,      \n";
			strSql += "   	DECODE( A.MAKE_SLIPNO, NULL, '  전 체 계   ', DECODE( A.MAKE_SLIPLINE, NULL, '  전 표 계   ', A.ACC_NAME)) ACC_NAME,    \n";
			strSql += "   	A.ACC_REMAIN_POSITION ,      \n";
			strSql += "   	SUM(A.DB_AMT) DB_AMT,       \n";
			strSql += "   	SUM(A.CR_AMT) CR_AMT,      \n";
			strSql += "   	A.SUMMARY_CODE ,      \n";
			strSql += "   	A.SUMMARY1 ,      \n";
			strSql += "   	A.SUMMARY2 ,      \n";
			strSql += "   	A.TAX_COMP_CODE ,      \n";
			strSql += "   	A.TAX_COMP_NAME,      \n";
			strSql += "   	A.COMP_CODE ,      \n";
			strSql += "   	--귀속부서      \n";
			strSql += "   	A.DEPT_CODE ,      \n";
			strSql += "   	A.DEPT_NAME ,      \n";
			strSql += "   	--부문코드      \n";
			strSql += "   	A.CLASS_CODE ,      \n";
			strSql += "   	A.CLASS_CODE_NAME ,      \n";
			strSql += "   	--증빙코드      \n";
			strSql += "   	A.VAT_CODE ,      \n";
			strSql += "   	A.VAT_NAME ,      \n";
			strSql += "   	A.VAT_DT ,      \n";
			strSql += "   	A.SUPAMT ,      \n";
			strSql += "   	A.VATAMT ,        \n";
			strSql += "   	--거래처코드관리        \n";
			strSql += "   	A.CUST_SEQ ,      \n";
			strSql += "   	A.CUST_CODE ,         \n";
			strSql += "   	A.CUST_NAME ,      \n";
			strSql += "   	--은행관리         \n";
			strSql += "   	A.BANK_CODE ,      \n";
			strSql += "   	A.BANK_NAME,    \n";
			strSql += "   	--사원번호        \n";
			strSql += "   	A.EMP_NO ,      \n";
			strSql += "   	A.EMP_NAME    \n";
			strSql += "   FROM    \n";
			strSql += "   	( \n";
			strSql += " 		SELECT \n";
			strSql += " 			A2.SLIP_ID , \n";
			strSql += " 			A2.SLIP_IDSEQ , \n";
			strSql += " 			A2.MAKE_SLIPLINE , \n";
			strSql += " 			A2.MAKE_COMP_CODE , \n";
			strSql += " 			C.COMPANY_NAME MAKE_COMP_NAME, \n";
			strSql += " 			A2.MAKE_DEPT_CODE , \n";
			strSql += " 			D.DEPT_NAME MAKE_DEPT_NAME , \n";
			strSql += " 			A2.MAKE_DT , \n";
			strSql += " 			A1.MAKE_SEQ , \n";
			strSql += " 			A2.KEEP_DT , \n";
			strSql += " 			A2.SLIP_KIND_TAG , \n";
			strSql += " 			I.CODE_LIST_NAME SLIP_KIND_NAME, \n";
			strSql += " 			NVL(A2.TRANSFER_TAG, 'F') TRANSFER_TAG, \n";
			strSql += " 			NVL(A2.IGNORE_SET_RESET_TAG, 'F') IGNORE_SET_RESET_TAG, \n";
			strSql += " 			A2.ACC_CODE , \n";
			strSql += " 			b1.ACC_name , \n";
			strSql += " 			b1.ACC_REMAIN_POSITION, \n";
			strSql += " 			b1.ACC_GRP, \n";
			strSql += " 			A2.DB_AMT , \n";
			strSql += " 			A2.CR_AMT , \n";
			strSql += " 			A2.SUMMARY_CODE , \n";
			strSql += " 			A2.TAX_COMP_CODE , \n";
			strSql += " 			b8.COMPANY_NAME TAX_COMP_NAME, \n";
			strSql += " 			A2.COMP_CODE , \n";
			strSql += " 			b2.COMPANY_NAME COMP_NAME, \n";
			strSql += " 			A2.DEPT_CODE , \n";
			strSql += " 			b3.DEPT_NAME, \n";
			strSql += " 			A2.CLASS_CODE , \n";
			strSql += " 			b4.CLASS_CODE_NAME, \n";
			strSql += " 			A2.VAT_CODE , \n";
			strSql += " 			b5.VAT_NAME, \n";
			strSql += " 			A2.VAT_DT , \n";
			strSql += " 			A2.SUPAMT , \n";
			strSql += " 			A2.VATAMT , \n";
			strSql += " 			A2.CUST_SEQ , \n";
			strSql += " 			F_T_Cust_Mask(b7.CUST_CODE) CUST_CODE, \n";
			strSql += " 			A2.CUST_NAME , \n";
			strSql += " 			A2.BANK_CODE , \n";
			strSql += " 			b6.BANK_NAME, \n";
			strSql += " 			A2.ACCNO , \n";
			strSql += " 			A2.RESET_SLIP_ID , \n";
			strSql += " 			A2.RESET_SLIP_IDSEQ, \n";
			strSql += " 			A3.SUMMARY1 , \n";
			strSql += " 			A3.SUMMARY2 , \n";
			strSql += " 			A3.CHK_NO , \n";
			strSql += " 			A3.BILL_NO , \n";
			strSql += " 			A3.REC_BILL_NO , \n";
			strSql += " 			A3.CP_NO , \n";
			strSql += " 			A3.SECU_NO , \n";
			strSql += " 			A3.LOAN_NO , \n";
			strSql += " 			A3.LOAN_REFUND_NO , \n";
			strSql += " 			A3.LOAN_REFUND_SEQ , \n";
			strSql += " 			A3.DEPOSIT_ACCNO , \n";
			strSql += " 			A3.PAYMENT_SEQ , \n";
			strSql += " 			A3.PAY_CON_CASH , \n";
			strSql += " 			A3.PAY_CON_BILL , \n";
			strSql += " 			A3.PAY_CON_BILL_DT , \n";
			strSql += " 			A3.PAY_CON_BILL_DAYS , \n";
			strSql += " 			A3.EMP_NO , \n";
			strSql += " 			b9.NAME EMP_NAME , \n";
			strSql += " 			A3.ANTICIPATION_DT , \n";
			strSql += " 			A3.MNG_ITEM_CHAR1 , \n";
			strSql += " 			A3.MNG_ITEM_CHAR2 , \n";
			strSql += " 			A3.MNG_ITEM_CHAR3 , \n";
			strSql += " 			A3.MNG_ITEM_CHAR4 , \n";
			strSql += " 			A3.MNG_ITEM_NUM1 , \n";
			strSql += " 			A3.MNG_ITEM_NUM2 , \n";
			strSql += " 			A3.MNG_ITEM_NUM3 , \n";
			strSql += " 			A3.MNG_ITEM_NUM4 , \n";
			strSql += " 			A3.MNG_ITEM_DT1 , \n";
			strSql += " 			A3.MNG_ITEM_DT2 , \n";
			strSql += " 			A3.MNG_ITEM_DT3 , \n";
			strSql += " 			A3.MNG_ITEM_DT4, \n";
			strSql += " 			A3.FIX_ASSET_SEQ, \n";
			strSql += " 			A1.MAKE_SLIPNO \n";
			strSql += " 		FROM \n";
			strSql += " 			T_ACC_SLIP_HEAD A1, \n";
			strSql += " 			T_ACC_SLIP_BODY1 A2, \n";
			strSql += " 			T_ACC_SLIP_BODY2 A3, \n";
			strSql += " 			T_COMPANY C, \n";
			strSql += " 			T_DEPT_CODE D, \n";
			strSql += " 			( \n";
			strSql += " 				SELECT \n";
			strSql += " 					CODE_LIST_ID, \n";
			strSql += " 					CODE_LIST_NAME \n";
			strSql += " 				FROM \n";
			strSql += " 					V_T_CODE_LIST \n";
			strSql += " 				WHERE \n";
			strSql += " 					CODE_GROUP_ID = 'SLIP_KIND_TAG' \n";
			strSql += " 			) I, \n";
			strSql += " 			T_ACC_CODE b1, \n";
			strSql += " 		  	T_COMPANY b2, \n";
			strSql += " 		  	T_DEPT_CODE b3, \n";
			strSql += " 		  	T_CLASS_CODE b4, \n";
			strSql += " 		  	T_ACC_VAT_CODE b5, \n";
			strSql += " 		  	T_BANK_CODE b6, \n";
			strSql += " 		  	T_CUST_CODE b7, \n";
			strSql += " 		  	T_COMPANY b8, \n";
			strSql += " 			Z_AUTHORITY_USER b9 \n";
			strSql += " 		WHERE \n";
			strSql += " 			A1.SLIP_ID = A2.SLIP_ID \n";
			strSql += " 			AND	A2.SLIP_ID = A3.SLIP_ID \n";
			strSql += " 			AND	A2.SLIP_IDSEQ = A3.SLIP_IDSEQ \n";
			strSql += " 			AND	A2.MAKE_COMP_CODE = C.COMP_CODE \n";
			strSql += " 			AND	A2.MAKE_DEPT_CODE = D.DEPT_CODE \n";
			strSql += " 			AND	A2.SLIP_KIND_TAG = I.CODE_LIST_ID(+) \n";
			strSql += " 			AND	A2.ACC_CODE = b1.ACC_CODE \n";
			strSql += " 			AND	A2.COMP_CODE = b2.COMP_CODE \n";
			strSql += " 			AND	A2.DEPT_CODE = b3.DEPT_CODE \n";
			strSql += " 			AND	A2.CLASS_CODE = b4.CLASS_CODE(+) \n";
			strSql += " 			AND	A2.VAT_CODE = b5.VAT_CODE(+) \n";
			strSql += " 			AND	A2.BANK_CODE = b6.BANK_CODE(+) \n";
			strSql += " 			AND	A2.CUST_SEQ = b7.CUST_SEQ(+) \n";
			strSql += " 			AND	A2.TAX_COMP_CODE = b8.COMP_CODE(+) \n";
			strSql += " 			AND	A3.EMP_NO = b9.EMPNO(+) \n";
			strSql += " 		 	--발의일자   \n";
			strSql += " 		 	AND	A1.MAKE_SLIPCLS Like ? || '%'   \n";
			strSql += " 		 	AND	A2.MAKE_DT BETWEEN  F_T_STRINGTODATE(   ?    )  AND  F_T_STRINGTODATE(     ?    )   \n";
			strSql += " 		 	--사업장    \n";
			strSql += " 		 	AND A2.MAKE_COMP_CODE LIKE     ?    ||'%'    \n";
			strSql += " 		 	--확정구분    \n";
			strSql += " 		 	AND A2.KEEP_DT IS NOT NULL    \n";
			strSql += " 		 	--발의부서    \n";
			strSql += " 		 	AND A2.MAKE_DEPT_CODE LIKE      ?     ||'%'   \n";
			strSql += " 	) A    \n";
			strSql += "   GROUP BY GROUPING SETS    \n";
			strSql += "   (    \n";
			strSql += "   	(    \n";
			strSql += "   		A.SLIP_ID ,      \n";
			strSql += "   		A.SLIP_IDSEQ ,      \n";
			strSql += "   		A.MAKE_COMP_CODE ,      \n";
			strSql += "   		A.MAKE_COMP_NAME ,      \n";
			strSql += "   		A.MAKE_DEPT_CODE ,      \n";
			strSql += "   		A.MAKE_DEPT_NAME ,      \n";
			strSql += "   		A.MAKE_DT ,         \n";
			strSql += " 		A.MAKE_SEQ , \n";
			strSql += "   		A.SLIP_KIND_TAG ,      \n";
			strSql += "   		A.MAKE_SLIPNO ,      \n";
			strSql += "   		A.MAKE_SLIPLINE,   \n";
			strSql += "   		A.ACC_CODE ,      \n";
			strSql += "   		A.ACC_NAME ,      \n";
			strSql += "   		A.ACC_REMAIN_POSITION ,      \n";
			strSql += "   		A.DB_AMT ,        \n";
			strSql += "   		A.CR_AMT ,           \n";
			strSql += "   		A.SUMMARY_CODE ,      \n";
			strSql += "   		A.SUMMARY1 ,      \n";
			strSql += "   		A.SUMMARY2 ,      \n";
			strSql += "   		A.TAX_COMP_CODE ,      \n";
			strSql += "   		A.TAX_COMP_NAME,      \n";
			strSql += "   		A.COMP_CODE ,      \n";
			strSql += "   		--귀속부서      \n";
			strSql += "   		A.DEPT_CODE ,      \n";
			strSql += "   		A.DEPT_NAME ,      \n";
			strSql += "   		--부문코드      \n";
			strSql += "   		A.CLASS_CODE ,      \n";
			strSql += "   		A.CLASS_CODE_NAME ,      \n";
			strSql += "   		--증빙코드      \n";
			strSql += "   		A.VAT_CODE ,      \n";
			strSql += "   		A.VAT_NAME ,      \n";
			strSql += "   		A.VAT_DT ,      \n";
			strSql += "   		A.SUPAMT ,      \n";
			strSql += "   		A.VATAMT ,           \n";
			strSql += "   		--거래처코드관리       \n";
			strSql += "   		A.CUST_SEQ ,      \n";
			strSql += "   		A.CUST_CODE ,         \n";
			strSql += "   		A.CUST_NAME ,      \n";
			strSql += "   		--은행관리        \n";
			strSql += "   		A.BANK_CODE ,      \n";
			strSql += "   		A.BANK_NAME ,    \n";
			strSql += "   		--사원번호      \n";
			strSql += "   		A.EMP_NO ,      \n";
			strSql += "   		A.EMP_NAME    \n";
			strSql += "   	),    \n";
			strSql += "   	(    \n";
			strSql += "   		A.MAKE_SLIPNO,      \n";
			strSql += "   		A.SLIP_ID ,      \n";
			strSql += "   		A.MAKE_COMP_CODE ,      \n";
			strSql += "   		A.MAKE_COMP_NAME ,      \n";
			strSql += "   		A.MAKE_DEPT_CODE ,      \n";
			strSql += "   		A.MAKE_DEPT_NAME ,      \n";
			strSql += "   		A.MAKE_DT ,      \n";
			strSql += "   		A.SLIP_KIND_TAG       \n";
			strSql += "   	),    \n";
			strSql += "   	()    \n";
			strSql += "   )    \n";
			strSql += "   ORDER BY   \n";
			strSql += "   	A.MAKE_SLIPNO, \n";
			strSql += " 	A.MAKE_SLIPLINE ";
			
			
			lrArgData.addColumn("MAKE_SLIPCLS", CITData.VARCHAR2);
			lrArgData.addColumn("DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("DT_T", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("MAKE_SLIPCLS", strMAKE_SLIPCLS);
			lrArgData.setValue("DT_F", strDT_F);
			lrArgData.setValue("DT_T", strDT_T);
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
			
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