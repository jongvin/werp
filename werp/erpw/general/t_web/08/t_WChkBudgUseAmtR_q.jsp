<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id :
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 :
/* 4. 변  경  이  력 : 한재원 작성(2005-12-18)
/* 5. 관련  프로그램 :
/* 6. 특  기  사  항 :
/**************************************************************************/

	CITGauceInfo GauceInfo = null;

	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	String	strSql = "";
	String	strAct = "";
	String	strUserNo = "";
	String      ssCompCode = "";
	String      ssDeptCode = "";
	String      ssDeptName = "";
	String     ssPrivLevel ="";
	String     ssDeptShortName ="";
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		ssCompCode = CITCommon.toKOR((String)session.getAttribute("comp_code"));
		ssDeptCode = CITCommon.toKOR((String)session.getAttribute("dept_code"));
		ssDeptName = CITCommon.toKOR((String)session.getAttribute("long_name"));

		CITData lrArgData = new CITData();

		strAct = CITCommon.toKOR(request.getParameter("ACT"));

		if (strAct.equals("MAIN"))
		{
			strSql   = "Select \n";
			strSql  += "	A.COMP_CODE , \n";
			strSql  += "	A.COMPANY_NAME , \n";
			strSql  += "	F_T_CUST_MASK(A.BIZNO) BIZNO, \n";
			strSql  += "	A.DEPT_CODE , \n";
			strSql  += "     B.DEPT_NAME \n";
			strSql  += "     From	T_COMPANY A ,\n";
			strSql  += "	T_DEPT_CODE B \n";
			strSql  += "Where	A.DEPT_CODE = B.DEPT_CODE(+) \n";
			strSql  += "And		A.COMP_CODE In \n";
			strSql  += "(  \n";
			strSql  += "					Select \n";
			strSql  += "							b.COMP_CODE \n";
			strSql  += "					From	T_EMPNO_AUTH_COMP b \n";
			strSql  += "					Where	b.EMPNO = ? \n";
			strSql  += ") \n";
			strSql  += "Order by	A.COMP_CODE \n";

			lrArgData.addColumn("EMPNO",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMPNO",strUserNo);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("COMPANY_CODE",true);

				lrReturnData.setColumnDisplaySize("COMPANY_NAME", 100);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}
		else if (strAct.equals("LIST00_1"))
		{

			strSql  = "SELECT \n";
			strSql  += "    "+strUserNo+" USER_NO, \n";
			strSql  += "    '"+ssCompCode+"' COMPANY_CODE, \n";
			strSql  += "    '"+ssDeptCode+"' DEPT_CODE, \n";
			strSql  += "    '"+ssDeptName+"' DEPT_NAME \n";
			strSql  += "FROM \n";
			strSql  += "    DUAL \n";
			strSql  += "UNION ALL \n";
			strSql  += "SELECT \n";
			strSql  += "    a.USER_NO, \n";
			strSql  += "    b.COMPANY_CODE, \n";
			strSql  += "    a.DEPT_CODE, \n";
			strSql  += "    b.DEPT_NAME \n";
			strSql  += "FROM \n";
			strSql  += "    TIA_BAMS_DEPT_CODE a, \n";
			strSql  += "    TIA_DEPT_CODE b \n";
			strSql  += "WHERE \n";
			strSql  += "    a.USER_NO =  ?  \n";
			strSql  += "    AND a.DEPT_CODE = b.DEPT_CODE";

			lrArgData.addColumn("USER_NO",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("USER_NO",strUserNo);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","MAIN01 Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:MAIN01 Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("LIST00"))
		{
			String vCompCode = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String vBudgYyyy = CITCommon.toKOR(request.getParameter("BUDG_YYYY"));

				strSql  = "select '"+vCompCode+"' COMP_CODE, '%' DEPT_CODE, '전  체' DEPT_NAME, '전  체' DEPT_SHORT_NAME \n";
				strSql += "from dual a \n";
				strSql += "union all \n";
				strSql += "select a.COMP_CODE, a.DEPT_CODE, a.DEPT_NAME, a.DEPT_SHORT_NAME \n";
				strSql += "from T_DEPT_CODE a, \n";
				strSql += "	 ( \n";
				strSql += "	  SELECT DEPT_CODE \n";
				strSql += "	  FROM T_BUDG_DEPT \n";
				strSql += "	  group by DEPT_CODE \n";
				strSql += "	 ) b \n";
				strSql  += "WHERE \n";
				strSql  += "     a.COMP_CODE = '"+vCompCode+"' \n";
				strSql += "	  and a.DEPT_CODE = b.DEPT_CODE \n";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrReturnData.setKey("COMP_CODE",true);
				lrReturnData.setKey("DEPT_CODE",true);

				lrReturnData.setColumnDisplaySize("DEPT_NAME", 100);
				lrReturnData.setColumnDisplaySize("DEPT_SHORT_NAME", 200);


				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}
		//전체
		else if (strAct.equals("LIST02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strMONTH = CITCommon.toKOR(request.getParameter("MONTH"));
	
			String strBUDG_YM="";
			strBUDG_YM =  strCLSE_ACC_ID +"-" +strMONTH;
			//strBUDG_YM = "2006-02";
			
			strSql  = " Select \n";
			strSql += " 	a.BUDG_CODE_NO, \n";
			strSql += " 	a.CONTROL_BUDG_CODE_NAME budg_code_name, \n";
			strSql += " 	case \n";
			strSql += " 		when GROUPing(a.BUDG_CODE_NO) = 1 And GROUPing(a.CHK_DEPT_CODE) = 0 Then \n";
			strSql += " 			a.chk_dept_name ||' 계' \n";
			strSql += " 		when GROUPing(a.CHK_DEPT_CODE) = 1 Then \n";
			strSql += " 			'총 계' \n";
			strSql += " 	Else \n";
			strSql += " 		a.chk_dept_name \n";
			strSql += " 	End chk_dept_name, \n";
			strSql += " 	a.CHK_DEPT_CODE, \n";
			strSql += " 	a.RN_ORG, \n";
			strSql += " 	Sum(a.budg_plan_amt) budg_plan_amt, \n";
			strSql += " 	Sum(a.budg_add_amt) budg_add_amt , \n";
			strSql += " 	Sum(a.sil_amt) sil_amt, \n";
			strSql += " 	Sum(a.jan1) jan1, \n";
			strSql += " 	Sum(a.s_budg_plan_amt) s_budg_plan_amt, \n";
			strSql += " 	Sum(a.s_budg_add_amt) s_budg_add_amt, \n";
			strSql += " 	Sum(a.s_sil_amt) s_sil_amt, \n";
			strSql += " 	Sum(a.s_jan1) s_jan1 \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.COMP_CODE, \n";
			strSql += " 			a.CLSE_ACC_ID, \n";
			strSql += " 			a.DEPT_CODE, \n";
			strSql += " 			Nvl(b.BUDG_CODE_NO,a.BUDG_CODE_NO) BUDG_CODE_NO, \n";
			strSql += " 			Nvl(b.RN_ORG,c.RN) RN_ORG, \n";
			strSql += " 			Nvl(b.BUDG_CODE_NAME,c.BUDG_CODE_NAME) CONTROL_BUDG_CODE_NAME, \n";
			strSql += " 			c.BUDG_CODE_NAME BUDG_CODE_NAME, \n";
			strSql += " 			b.LEAF_BUDG_CODE_NO, \n";
			strSql += " 			e2.DEPT_CODE CHK_DEPT_CODE, \n";
			strSql += " 			e1.DEPT_NAME DEPT_NAME, \n";
			strSql += " 			e2.DEPT_NAME CHK_DEPT_NAME, \n";
			strSql += " 			a.BUDG_MONTH_ASSIGN_TOT_PLN s_budg_plan_amt, \n";
			strSql += " 			a.BUDG_MONTH_ASSIGN_NOW_PLN budg_plan_amt, \n";
			strSql += " 			Nvl(a.BUDG_MONTH_ASSIGN_TOT_LST,0) - Nvl(a.BUDG_MONTH_ASSIGN_TOT_PLN,0) s_budg_add_amt, \n";
			strSql += " 			Nvl(a.BUDG_MONTH_ASSIGN_NOW_LST,0) - Nvl(a.BUDG_MONTH_ASSIGN_NOW_PLN,0) budg_add_amt , \n";
			strSql += " 			Nvl(a.BUDG_MONTH_ASSIGN_NOW_LST,0) - Nvl(a.SIL_NOW,0) jan1, \n";
			strSql += " 			Nvl(a.BUDG_MONTH_ASSIGN_TOT_LST,0) - Nvl(a.SIL_TOT,0) s_jan1, \n";
			strSql += " 			a.SIL_TOT s_sil_amt, \n";
			strSql += " 			a.SIL_NOW sil_amt \n";
			strSql += " 		From \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					A1.COMP_CODE, \n";
			strSql += " 					A1.CLSE_ACC_ID, \n";
			strSql += " 					A1.DEPT_CODE, \n";
			strSql += " 					A1.BUDG_CODE_NO, \n";
			strSql += " 					Sum(A1.BUDG_MONTH_ASSIGN_TOT_PLN) BUDG_MONTH_ASSIGN_TOT_PLN, \n";
			strSql += " 					Sum(A1.BUDG_MONTH_ASSIGN_NOW_PLN) BUDG_MONTH_ASSIGN_NOW_PLN, \n";
			strSql += " 					Sum(A1.BUDG_MONTH_ASSIGN_TOT_LST) BUDG_MONTH_ASSIGN_TOT_LST, \n";
			strSql += " 					Sum(A1.BUDG_MONTH_ASSIGN_NOW_LST) BUDG_MONTH_ASSIGN_NOW_LST, \n";
			strSql += " 					Sum(A1.SIL_TOT) SIL_TOT, \n";
			strSql += " 					Sum(A1.SIL_NOW) SIL_NOW \n";
			strSql += " 				From \n";
			strSql += " 					( \n";
			strSql += " 						Select \n";
			strSql += " 							A1.COMP_CODE, \n";
			strSql += " 							A1.CLSE_ACC_ID, \n";
			strSql += " 							A1.DEPT_CODE, \n";
			strSql += " 							A1.BUDG_CODE_NO, \n";
			strSql += " 							Sum(B1.BUDG_MONTH_ASSIGN_AMT) BUDG_MONTH_ASSIGN_TOT_PLN, \n";
			strSql += " 							Sum( \n";
			strSql += " 							Case When To_Char(B1.BUDG_YM,'YYYY-MM') =  ?  Then \n";
			strSql += " 								B1.BUDG_MONTH_ASSIGN_AMT \n";
			strSql += " 							Else \n";
			strSql += " 								0 \n";
			strSql += " 							End) BUDG_MONTH_ASSIGN_NOW_PLN, \n";
			strSql += " 							0 BUDG_MONTH_ASSIGN_TOT_LST, \n";
			strSql += " 							0 BUDG_MONTH_ASSIGN_NOW_LST, \n";
			strSql += " 							0 SIL_TOT, \n";
			strSql += " 							0 SIL_NOW \n";
			strSql += " 						From	T_BUDG_DEPT_ITEM_H A1, \n";
			strSql += " 								T_BUDG_MONTH_AMT_H B1 \n";
			strSql += " 						Where	A1.COMP_CODE = B1.COMP_CODE \n";
			strSql += " 						And		A1.CLSE_ACC_ID = B1.CLSE_ACC_ID \n";
			strSql += " 						And		A1.DEPT_CODE = B1.DEPT_CODE \n";
			strSql += " 						And		A1.CHG_SEQ = B1.CHG_SEQ \n";
			strSql += " 						And		A1.BUDG_CODE_NO = B1.BUDG_CODE_NO \n";
			strSql += " 						And		A1.RESERVED_SEQ = B1.RESERVED_SEQ \n";
			strSql += " 						And		B1.CHG_SEQ = 0 \n";
			strSql += " 						And		B1.COMP_CODE =  ?  \n";
			strSql += " 						And		B1.CLSE_ACC_ID =  ?  \n";
			strSql += " 						And		B1.BUDG_YM <= Last_Day(To_Date( ?  || '-01','YYYY-MM-DD')) \n";
			strSql += " 						Group By \n";
			strSql += " 							A1.COMP_CODE, \n";
			strSql += " 							A1.CLSE_ACC_ID, \n";
			strSql += " 							A1.DEPT_CODE, \n";
			strSql += " 							A1.BUDG_CODE_NO \n";
			strSql += " 						Union All \n";
			strSql += " 						Select \n";
			strSql += " 							A1.COMP_CODE, \n";
			strSql += " 							A1.CLSE_ACC_ID, \n";
			strSql += " 							A1.DEPT_CODE, \n";
			strSql += " 							A1.BUDG_CODE_NO, \n";
			strSql += " 							0 BUDG_MONTH_ASSIGN_TOT_PLN, \n";
			strSql += " 							0 BUDG_MONTH_ASSIGN_NOW_PLN, \n";
			strSql += " 							Sum(B1.BUDG_MONTH_ASSIGN_AMT) BUDG_MONTH_ASSIGN_TOT_LST, \n";
			strSql += " 							Sum( \n";
			strSql += " 							Case When To_Char(B1.BUDG_YM,'YYYY-MM') =  ?  Then \n";
			strSql += " 								B1.BUDG_MONTH_ASSIGN_AMT \n";
			strSql += " 							Else \n";
			strSql += " 								0 \n";
			strSql += " 							End) BUDG_MONTH_ASSIGN_NOW_LST, \n";
			strSql += " 							0 SIL_TOT, \n";
			strSql += " 							0 SIL_NOW \n";
			strSql += " 						From	T_BUDG_DEPT_ITEM A1, \n";
			strSql += " 								T_BUDG_MONTH_AMT B1 \n";
			strSql += " 						Where	A1.COMP_CODE = B1.COMP_CODE \n";
			strSql += " 						And		A1.CLSE_ACC_ID = B1.CLSE_ACC_ID \n";
			strSql += " 						And		A1.DEPT_CODE = B1.DEPT_CODE \n";
			strSql += " 						And		A1.BUDG_CODE_NO = B1.BUDG_CODE_NO \n";
			strSql += " 						And		A1.RESERVED_SEQ = B1.RESERVED_SEQ \n";
			strSql += " 						And		B1.COMP_CODE =  ?  \n";
			strSql += " 						And		B1.CLSE_ACC_ID =  ?  \n";
			strSql += " 						And		B1.BUDG_YM <= Last_Day(To_Date( ?  || '-01','YYYY-MM-DD')) \n";
			strSql += " 						Group By \n";
			strSql += " 							A1.COMP_CODE, \n";
			strSql += " 							A1.CLSE_ACC_ID, \n";
			strSql += " 							A1.DEPT_CODE, \n";
			strSql += " 							A1.BUDG_CODE_NO \n";
			strSql += " 						Union All \n";
			strSql += " 						Select \n";
			strSql += " 							b.COMP_CODE, \n";
			strSql += " 							 ?  CLSE_ACC_ID, \n";
			strSql += " 							b.DEPT_CODE, \n";
			strSql += " 							c.LEAF_BUDG_CODE_NO BUDG_CODE_NO, \n";
			strSql += " 							0 BUDG_MONTH_ASSIGN_TOT_PLN, \n";
			strSql += " 							0 BUDG_MONTH_ASSIGN_NOW_PLN, \n";
			strSql += " 							0 BUDG_MONTH_ASSIGN_TOT_LST, \n";
			strSql += " 							0 BUDG_MONTH_ASSIGN_NOW_LST, \n";
			strSql += " 							SUM(nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0)) SIL_TOT, \n";
			strSql += " 							Sum(Case When To_Char(b.MAKE_DT,'YYYY-MM') =  ?  Then \n";
			strSql += " 								nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0) \n";
			strSql += " 							Else \n";
			strSql += " 								0 \n";
			strSql += " 							End) SIL_NOW \n";
			strSql += " 						From	T_ACC_SLIP_BODY1 b, \n";
			strSql += " 								( \n";
			strSql += " 									Select \n";
			strSql += " 										b.COMP_CODE, \n";
			strSql += " 										b.BUDG_CODE_NO , \n";
			strSql += " 										b.P_BUDG_CODE_NO, \n";
			strSql += " 										b.BUDG_CODE_NAME, \n";
			strSql += " 										b.ACC_CODE, \n";
			strSql += " 										b.USE_CLS , \n";
			strSql += " 										b.CONTROL_LEVEL_TAG , \n";
			strSql += " 										b.BUDG_ITEM_CODE, \n";
			strSql += " 										b.MAKE_DEPT_CLS, \n";
			strSql += " 									 	b.IS_LEAF, \n";
			strSql += " 										b.RN, \n";
			strSql += " 										b.Lv, \n";
			strSql += " 										b.RN_ORG, \n";
			strSql += " 										b.LV_ORG, \n";
			strSql += " 										b.LEAF_BUDG_CODE_NO, \n";
			strSql += " 										c.ACC_CODE CHILD_ACC_CODE \n";
			strSql += " 									From \n";
			strSql += " 										( \n";
			strSql += " 											Select \n";
			strSql += " 												b.COMP_CODE, \n";
			strSql += " 												b.BUDG_CODE_NO , \n";
			strSql += " 												b.P_BUDG_CODE_NO, \n";
			strSql += " 												b.BUDG_CODE_NAME, \n";
			strSql += " 												b.ACC_CODE, \n";
			strSql += " 												b.USE_CLS , \n";
			strSql += " 												b.CONTROL_LEVEL_TAG , \n";
			strSql += " 												b.BUDG_ITEM_CODE, \n";
			strSql += " 												b.MAKE_DEPT_CLS, \n";
			strSql += " 											 	b.IS_LEAF, \n";
			strSql += " 												b.RN, \n";
			strSql += " 												b.Lv, \n";
			strSql += " 												b.RN_ORG, \n";
			strSql += " 												b.LV_ORG, \n";
			strSql += " 												First_Value(b.BUDG_CODE_NO) Over(Order By  b.rn Range b.Lv - 1 Preceding ) LEAF_BUDG_CODE_NO \n";
			strSql += " 											From \n";
			strSql += " 												( \n";
			strSql += " 													Select \n";
			strSql += " 										    			b.COMP_CODE, \n";
			strSql += " 														b.BUDG_CODE_NO , \n";
			strSql += " 														b.P_BUDG_CODE_NO, \n";
			strSql += " 														b.BUDG_CODE_NAME, \n";
			strSql += " 														b.ACC_CODE, \n";
			strSql += " 														b.USE_CLS , \n";
			strSql += " 														b.CONTROL_LEVEL_TAG , \n";
			strSql += " 														b.BUDG_ITEM_CODE, \n";
			strSql += " 														b.MAKE_DEPT_CLS, \n";
			strSql += " 													 	b.Rn RN_ORG, \n";
			strSql += " 													 	b.LV LV_ORG, \n";
			strSql += " 													 	b.IS_LEAF, \n";
			strSql += " 														RowNum RN, \n";
			strSql += " 														Level Lv \n";
			strSql += " 													From \n";
			strSql += " 														( \n";
			strSql += " 														   Select \n";
			strSql += " 												    			b.COMP_CODE, \n";
			strSql += " 																b.BUDG_CODE_NO , \n";
			strSql += " 																b.P_BUDG_CODE_NO, \n";
			strSql += " 																b.BUDG_CODE_NAME, \n";
			strSql += " 																b.ACC_CODE, \n";
			strSql += " 																b.USE_CLS , \n";
			strSql += " 																b.CONTROL_LEVEL_TAG , \n";
			strSql += " 																b.BUDG_ITEM_CODE, \n";
			strSql += " 																b.MAKE_DEPT_CLS, \n";
			strSql += " 															 	b.Rn, \n";
			strSql += " 															 	b.Lv, \n";
			strSql += " 															 	Decode(b.BUDG_CODE_NO,lead(b.P_BUDG_CODE_NO) Over ( Order By b.rn) ,'F','T') IS_LEAF \n";
			strSql += " 															From \n";
			strSql += " 															    	( \n";
			strSql += " 															    		Select \n";
			strSql += " 															    			b.COMP_CODE, \n";
			strSql += " 															    			b.BUDG_CODE_NO , \n";
			strSql += " 															    			b.P_BUDG_CODE_NO, \n";
			strSql += " 															    			b.BUDG_CODE_NAME, \n";
			strSql += " 															    			b.ACC_CODE, \n";
			strSql += " 															    			b.USE_CLS , \n";
			strSql += " 															    			b.CONTROL_LEVEL_TAG , \n";
			strSql += " 															    			b.BUDG_ITEM_CODE, \n";
			strSql += " 															                Decode(nvl(b.MAKE_DEPT,1), '1', 'F','T')  MAKE_DEPT_CLS, \n";
			strSql += " 															    			RowNum Rn, \n";
			strSql += " 															                assign_tag, \n";
			strSql += " 															    			Level lv \n";
			strSql += " 																		from	(select * from t_budg_code b where comp_code =  ? ) b \n";
			strSql += " 																		Connect By \n";
			strSql += " 																			Prior	b.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
			strSql += " 															    		Start With	Not Exists \n";
			strSql += " 															    		( \n";
			strSql += " 															    			Select \n";
			strSql += " 															    				Null \n";
			strSql += " 															    			From	t_budg_code x \n";
			strSql += " 															    			Where	x.COMP_CODE = b.COMP_CODE \n";
			strSql += " 															    			And		x.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
			strSql += " 															    		) \n";
			strSql += " 															    		Order Siblings By \n";
			strSql += " 															    			b.LEVEL_SEQ \n";
			strSql += " 															    	) b \n";
			strSql += " 															Order By \n";
			strSql += " 																b.Rn \n";
			strSql += " 														) b \n";
			strSql += " 													Start With b.IS_LEAF = 'T' \n";
			strSql += " 													Connect By \n";
			strSql += " 														Prior	b.P_BUDG_CODE_NO = b.BUDG_CODE_NO \n";
			strSql += " 												) b \n";
			strSql += " 										) b, \n";
			strSql += " 										t_budg_code c \n";
			strSql += " 									Where	b.CONTROL_LEVEL_TAG = 'T' \n";
			strSql += " 									And		b.COMP_CODE = c.COMP_CODE \n";
			strSql += " 									And		b.LEAF_BUDG_CODE_NO = c.BUDG_CODE_NO \n";
			strSql += " 								) c \n";
			strSql += " 						Where	b.KEEP_DT is not null \n";
			strSql += " 						And		b.TRANSFER_TAG = 'F' \n";
			strSql += " 						And		b.MAKE_DT Between To_Date( ? ||'-01-01','YYYY-MM-DD') And Last_Day(To_Date( ?  || '-01','YYYY-MM-DD')) \n";
			strSql += " 						And		b.COMP_CODE =  ?  \n";
			strSql += " 						And		b.ACC_CODE  = c.CHILD_ACC_CODE \n";
			strSql += " 						And		b.COMP_CODE = c.COMP_CODE \n";
			strSql += " 						Group By \n";
			strSql += " 							b.COMP_CODE, \n";
			strSql += " 							b.DEPT_CODE, \n";
			strSql += " 							c.LEAF_BUDG_CODE_NO \n";
			strSql += " 					) A1 \n";
			strSql += " 				Group By \n";
			strSql += " 					A1.COMP_CODE, \n";
			strSql += " 					A1.CLSE_ACC_ID, \n";
			strSql += " 					A1.DEPT_CODE, \n";
			strSql += " 					A1.BUDG_CODE_NO \n";
			strSql += " 			) a, \n";
			strSql += " 			( \n";
			strSql += " 				Select \n";
			strSql += " 					b.COMP_CODE, \n";
			strSql += " 					b.BUDG_CODE_NO , \n";
			strSql += " 					b.P_BUDG_CODE_NO, \n";
			strSql += " 					b.BUDG_CODE_NAME, \n";
			strSql += " 					b.ACC_CODE, \n";
			strSql += " 					b.USE_CLS , \n";
			strSql += " 					b.CONTROL_LEVEL_TAG , \n";
			strSql += " 					b.BUDG_ITEM_CODE, \n";
			strSql += " 					b.MAKE_DEPT_CLS, \n";
			strSql += " 				 	b.IS_LEAF, \n";
			strSql += " 					b.RN, \n";
			strSql += " 					b.Lv, \n";
			strSql += " 					b.RN_ORG, \n";
			strSql += " 					b.LV_ORG, \n";
			strSql += " 					b.LEAF_BUDG_CODE_NO, \n";
			strSql += " 					c.ACC_CODE CHILD_ACC_CODE \n";
			strSql += " 				From \n";
			strSql += " 					( \n";
			strSql += " 						Select \n";
			strSql += " 							b.COMP_CODE, \n";
			strSql += " 							b.BUDG_CODE_NO , \n";
			strSql += " 							b.P_BUDG_CODE_NO, \n";
			strSql += " 							b.BUDG_CODE_NAME, \n";
			strSql += " 							b.ACC_CODE, \n";
			strSql += " 							b.USE_CLS , \n";
			strSql += " 							b.CONTROL_LEVEL_TAG , \n";
			strSql += " 							b.BUDG_ITEM_CODE, \n";
			strSql += " 							b.MAKE_DEPT_CLS, \n";
			strSql += " 						 	b.IS_LEAF, \n";
			strSql += " 							b.RN, \n";
			strSql += " 							b.Lv, \n";
			strSql += " 							b.RN_ORG, \n";
			strSql += " 							b.LV_ORG, \n";
			strSql += " 							First_Value(b.BUDG_CODE_NO) Over(Order By  b.rn Range b.Lv - 1 Preceding ) LEAF_BUDG_CODE_NO \n";
			strSql += " 						From \n";
			strSql += " 							( \n";
			strSql += " 								Select \n";
			strSql += " 					    			b.COMP_CODE, \n";
			strSql += " 									b.BUDG_CODE_NO , \n";
			strSql += " 									b.P_BUDG_CODE_NO, \n";
			strSql += " 									b.BUDG_CODE_NAME, \n";
			strSql += " 									b.ACC_CODE, \n";
			strSql += " 									b.USE_CLS , \n";
			strSql += " 									b.CONTROL_LEVEL_TAG , \n";
			strSql += " 									b.BUDG_ITEM_CODE, \n";
			strSql += " 									b.MAKE_DEPT_CLS, \n";
			strSql += " 								 	b.Rn RN_ORG, \n";
			strSql += " 								 	b.LV LV_ORG, \n";
			strSql += " 								 	b.IS_LEAF, \n";
			strSql += " 									RowNum RN, \n";
			strSql += " 									Level Lv \n";
			strSql += " 								From \n";
			strSql += " 									( \n";
			strSql += " 									   Select \n";
			strSql += " 							    			b.COMP_CODE, \n";
			strSql += " 											b.BUDG_CODE_NO , \n";
			strSql += " 											b.P_BUDG_CODE_NO, \n";
			strSql += " 											b.BUDG_CODE_NAME, \n";
			strSql += " 											b.ACC_CODE, \n";
			strSql += " 											b.USE_CLS , \n";
			strSql += " 											b.CONTROL_LEVEL_TAG , \n";
			strSql += " 											b.BUDG_ITEM_CODE, \n";
			strSql += " 											b.MAKE_DEPT_CLS, \n";
			strSql += " 										 	b.Rn, \n";
			strSql += " 										 	b.Lv, \n";
			strSql += " 										 	Decode(b.BUDG_CODE_NO,lead(b.P_BUDG_CODE_NO) Over ( Order By b.rn) ,'F','T') IS_LEAF \n";
			strSql += " 										From \n";
			strSql += " 										    	( \n";
			strSql += " 										    		Select \n";
			strSql += " 										    			b.COMP_CODE, \n";
			strSql += " 										    			b.BUDG_CODE_NO , \n";
			strSql += " 										    			b.P_BUDG_CODE_NO, \n";
			strSql += " 										    			b.BUDG_CODE_NAME, \n";
			strSql += " 										    			b.ACC_CODE, \n";
			strSql += " 										    			b.USE_CLS , \n";
			strSql += " 										    			b.CONTROL_LEVEL_TAG , \n";
			strSql += " 										    			b.BUDG_ITEM_CODE, \n";
			strSql += " 										                Decode(nvl(b.MAKE_DEPT,1), '1', 'F','T')  MAKE_DEPT_CLS, \n";
			strSql += " 										    			RowNum Rn, \n";
			strSql += " 										                assign_tag, \n";
			strSql += " 										    			Level lv \n";
			strSql += " 													from	(select * from t_budg_code b where comp_code =  ? ) b \n";
			strSql += " 													Connect By \n";
			strSql += " 														Prior	b.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
			strSql += " 										    		Start With	Not Exists \n";
			strSql += " 										    		( \n";
			strSql += " 										    			Select \n";
			strSql += " 										    				Null \n";
			strSql += " 										    			From	t_budg_code x \n";
			strSql += " 										    			Where	x.COMP_CODE = b.COMP_CODE \n";
			strSql += " 										    			And		x.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
			strSql += " 										    		) \n";
			strSql += " 										    		Order Siblings By \n";
			strSql += " 										    			b.LEVEL_SEQ \n";
			strSql += " 										    	) b \n";
			strSql += " 										Order By \n";
			strSql += " 											b.Rn \n";
			strSql += " 									) b \n";
			strSql += " 								Start With b.IS_LEAF = 'T' \n";
			strSql += " 								Connect By \n";
			strSql += " 									Prior	b.P_BUDG_CODE_NO = b.BUDG_CODE_NO \n";
			strSql += " 							) b \n";
			strSql += " 					) b, \n";
			strSql += " 					t_budg_code c \n";
			strSql += " 				Where	b.CONTROL_LEVEL_TAG = 'T' \n";
			strSql += " 				And		b.COMP_CODE = c.COMP_CODE \n";
			strSql += " 				And		b.LEAF_BUDG_CODE_NO = c.BUDG_CODE_NO \n";
			strSql += " 			) b, \n";
			strSql += " 			( \n";
			strSql += " 	    		Select \n";
			strSql += " 	    			b.COMP_CODE, \n";
			strSql += " 	    			b.BUDG_CODE_NO , \n";
			strSql += " 	    			b.P_BUDG_CODE_NO, \n";
			strSql += " 	    			b.BUDG_CODE_NAME, \n";
			strSql += " 	    			b.ACC_CODE, \n";
			strSql += " 	    			b.USE_CLS , \n";
			strSql += " 	    			b.CONTROL_LEVEL_TAG , \n";
			strSql += " 	    			b.BUDG_ITEM_CODE, \n";
			strSql += " 	                Decode(nvl(b.MAKE_DEPT,1), '1', 'F','T')  MAKE_DEPT_CLS, \n";
			strSql += " 	    			RowNum Rn, \n";
			strSql += " 	                assign_tag, \n";
			strSql += " 	    			Level lv \n";
			strSql += " 				from	(select * from t_budg_code b where comp_code =  ? ) b \n";
			strSql += " 				Connect By \n";
			strSql += " 					Prior	b.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
			strSql += " 	    		Start With	Not Exists \n";
			strSql += " 	    		( \n";
			strSql += " 	    			Select \n";
			strSql += " 	    				Null \n";
			strSql += " 	    			From	t_budg_code x \n";
			strSql += " 	    			Where	x.COMP_CODE = b.COMP_CODE \n";
			strSql += " 	    			And		x.BUDG_CODE_NO = b.P_BUDG_CODE_NO \n";
			strSql += " 	    		) \n";
			strSql += " 	    		Order Siblings By \n";
			strSql += " 	    			b.LEVEL_SEQ \n";
			strSql += " 			) c, \n";
			strSql += " 			t_budg_dept_map d, \n";
			strSql += " 			t_dept_code_org e1, \n";
			strSql += " 			t_dept_code_org e2 \n";
			strSql += " 		Where	a.COMP_CODE = b.COMP_CODE (+) \n";
			strSql += " 		And		a.BUDG_CODE_NO = b.LEAF_BUDG_CODE_NO (+) \n";
			strSql += " 		And		a.COMP_CODE = c.COMP_CODE (+) \n";
			strSql += " 		And		a.BUDG_CODE_NO = c.BUDG_CODE_NO (+) \n";
			strSql += " 		And		a.DEPT_CODE = d.DEPT_CODE \n";
			strSql += " 		And		a.DEPT_CODE = e1.DEPT_CODE (+) \n";
			strSql += " 		And		d.CHK_DEPT_CODE = e2.DEPT_CODE (+) \n";
			strSql += " 		And		(d.CHK_DEPT_CODE Like  ?  || '%' Or a.DEPT_CODE Like  ? || '%') \n";
			strSql += " 	) a \n";
			strSql += " Group By Grouping Sets \n";
			strSql += " ( \n";
			strSql += " ( \n";
			strSql += " 	a.BUDG_CODE_NO, \n";
			strSql += " 	a.CONTROL_BUDG_CODE_NAME, \n";
			strSql += " 	a.CHK_DEPT_CODE, \n";
			strSql += " 	a.CHK_DEPT_NAME, \n";
			strSql += " 	a.RN_ORG \n";
			strSql += " ), \n";
			strSql += " ( \n";
			strSql += " 	a.CHK_DEPT_CODE, \n";
			strSql += " 	a.CHK_DEPT_NAME \n";
			strSql += " ),(  )  \n";
			strSql += " ) \n";
			strSql += " Order By \n";
			strSql += " 	a.CHK_DEPT_CODE, \n";
			strSql += " 	a.RN_ORG \n";
			strSql += "  ";
			
			lrArgData.addColumn("1BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("4BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("5BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("6COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("8BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("9CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("10BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("11COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("12CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("13BUDG_YM", CITData.VARCHAR2);
			lrArgData.addColumn("14COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("15COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("16COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("17DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("18DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1BUDG_YM", strBUDG_YM);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("4BUDG_YM", strBUDG_YM);
			lrArgData.setValue("5BUDG_YM", strBUDG_YM);
			lrArgData.setValue("6COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("8BUDG_YM", strBUDG_YM);
			lrArgData.setValue("9CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("10BUDG_YM", strBUDG_YM);
			lrArgData.setValue("11COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("12CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("13BUDG_YM", strBUDG_YM);
			lrArgData.setValue("14COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("15COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("16COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("17DEPT_CODE", strDEPT_CODE);
			lrArgData.setValue("18DEPT_CODE", strDEPT_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);



				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}
		
		else if (strAct.equals("CLOSE"))
		{
			String vDeptCode = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String VClseMonth = CITCommon.toKOR(request.getParameter("CLSE_MONTH"));

			strSql   = "\nSELECT b.REQ_CLSE_CLS, b.CONF_CLSE_CLS ";
			strSql  += "\nFROM T_DEPT_CODE a, TBA_MONTH_CLOSE b ";
			strSql  += "\nWHERE ";
			strSql  += "\n     a.DEPT_CODE = '"+vDeptCode+"' ";
			strSql  += "\n     AND a.COMP_CODE = b.COMP_CODE ";
			strSql  += "\n     AND b.CLSE_MONTH = '"+VClseMonth+"' ";

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}
		
		else if (strAct.equals("DATE"))
		{
			
			strSql   = "\nSELECT to_char(sysdate, 'YYYY-MM') cdate ";
			strSql  += "\nFROM dual b ";
		

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}

	}
	catch (Exception ex)
	{
		if (GauceInfo != null)
		{
			GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		}
		else
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo != null)
			{
				GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
			}
			else
			{
				throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
			}
		}
	}
%>
