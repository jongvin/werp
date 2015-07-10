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
			strSql  += "     a.COMP_CODE = ? \n";
			strSql += "	  and a.DEPT_CODE = b.DEPT_CODE \n";

			lrArgData.addColumn("COMP_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE",vCompCode);

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
		else if (strAct.equals("LIST02"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strDEPT_CODE   = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("BUDG_YYYY"));
			String strDEPT_FLAG = CITCommon.toKOR(request.getParameter("DEPT_FLAG"));
			
			if(strDEPT_FLAG.equals("ALL"))
			{
				strSql  = " Select \n";
				strSql += " 	COMP_CODE, \n";
				strSql += " 	DEPT_CODE, \n";
				strSql += " 	CLSE_ACC_ID, \n";
				strSql += " 	P_BUDG_CODE_NO, \n";
				strSql += " 	BUDG_CODE_NO, \n";
				strSql += " 	BUDG_CODE_NAME acc_name, \n";
				strSql += " 	P_RN, \n";
				strSql += " 	RN, \n";
				strSql += " 	GrTot, \n";
				strSql += " 	P_BUDG_CODE_NAME p_acc_name, \n";
				strSql += " 	DEPT_NAME, \n";
				strSql += " 	PB1, \n";
				strSql += " 	PB2, \n";
				strSql += " 	PB3, \n";
				strSql += " 	PB4, \n";
				strSql += " 	PB5, \n";
				strSql += " 	PB6, \n";
				strSql += " 	PB7, \n";
				strSql += " 	PB8, \n";
				strSql += " 	PB9, \n";
				strSql += " 	PB10, \n";
				strSql += " 	PB11, \n";
				strSql += " 	PB12, \n";
				strSql += " 	PB1+PB2+PB3 PB14, \n";
				strSql += " 	PB4+PB5+PB6 PB24, \n";
				strSql += " 	PB7+PB8+PB9 PB34, \n";
				strSql += " 	PB10+PB11+PB12 PB44, \n";
				strSql += " 	PB1+PB2+PB3+PB4+PB5+PB6 PB012, \n";
				strSql += " 	PB7+PB8+PB9+PB10+PB11+PB12 PB022, \n";
				strSql += " 	S1, \n";
				strSql += " 	S2, \n";
				strSql += " 	S3, \n";
				strSql += " 	S4, \n";
				strSql += " 	S5, \n";
				strSql += " 	S6, \n";
				strSql += " 	S7, \n";
				strSql += " 	S8, \n";
				strSql += " 	S9, \n";
				strSql += " 	S10, \n";
				strSql += " 	S11, \n";
				strSql += " 	S12, \n";
				strSql += "     S1 +S2 +S3  S14, \n";
				strSql += "     S4 +S5 +S6  S24, \n";
				strSql += "     S7 +S8 +S9  S34, \n";
				strSql += "     S10+S11+S12 S44, \n";
				strSql += "     S1+S2+S3+S4+S5+S6 S012, \n";
				strSql += "     S7+S8+S9+S10+S11+S12 S022, \n";
				strSql += "     TO_CHAR( 100 * S1/nullif(PB1,0) , '999,999,999,999,999.99') R1, \n";
				strSql += "     TO_CHAR( 100 * S2/nullif(PB2,0), '999,999,999,999,999.99') R2, \n";
				strSql += "     TO_CHAR( 100 * S3/nullif(PB3,0), '999,999,999,999,999.99') R3, \n";
				strSql += "     TO_CHAR( 100 * S4/nullif(PB4,0), '999,999,999,999,999.99') R4, \n";
				strSql += "     TO_CHAR( 100 * S5/nullif(PB5,0), '999,999,999,999,999.99') R5, \n";
				strSql += "     TO_CHAR( 100 * S6/nullif(PB6,0), '999,999,999,999,999.99') R6, \n";
				strSql += "     TO_CHAR( 100 * S7/nullif(PB7,0), '999,999,999,999,999.99') R7, \n";
				strSql += "     TO_CHAR( 100 * S8/nullif(PB8,0), '999,999,999,999,999.99') R8, \n";
				strSql += "     TO_CHAR( 100 * S9/nullif(PB9,0), '999,999,999,999,999.99') R9, \n";
				strSql += " 	TO_CHAR( 100 * S10/nullif(PB10,0), '999,999,999,999,999.99') R10, \n";
				strSql += " 	TO_CHAR( 100 * S11/nullif(PB11,0), '999,999,999,999,999.99') R11, \n";
				strSql += " 	TO_CHAR( 100 * S12/nullif(PB12,0), '999,999,999,999,999.99') R12, \n";
				strSql += " 	TO_CHAR( DECODE((PB1 +PB2 +PB3 ), 0, 0, 100*(S1 +S2 +S3 )/(PB1 +PB2 +PB3 )), '999,999,999,999,999.99') R14, \n";
				strSql += " 	TO_CHAR( DECODE((PB4 +PB5 +PB6 ), 0, 0, 100*(S4 +S5 +S6 )/(PB4 +PB5 +PB6 )), '999,999,999,999,999.99') R24, \n";
				strSql += " 	TO_CHAR( DECODE((PB7 +PB8 +PB9 ), 0, 0, 100*(S7 +S8 +S9 )/(PB7 +PB8 +PB9 )), '999,999,999,999,999.99') R34, \n";
				strSql += " 	TO_CHAR( DECODE((PB10+PB11+PB12), 0, 0, 100*(S10+S11+S12)/(PB10+PB11+PB12)), '999,999,999,999,999.99') R44, \n";
				strSql += " 	TO_CHAR( DECODE((PB1 +PB2 +PB3 +PB4 +PB5 +PB6 ), 0, 0, 100*(S1 +S2 +S3 + S4 + S5 +  S6)/(PB1 +PB2 +PB3 +PB4 +PB5 +PB6 )), '999,999,999,999,999.99') R012, \n";
				strSql += " 	TO_CHAR( DECODE((PB7 +PB8 +PB9 +PB10+PB11+PB12), 0, 0, 100*(S7 +S8 +S9 +S10+S11+S12)/(PB7 +PB8 +PB9 +PB10+PB11+PB12)), '999,999,999,999,999.99') R022 \n";
				strSql += " From \n";
				strSql += " 	( \n";
				strSql += " 		Select \n";
				strSql += " 			a.COMP_CODE, \n";
				strSql += " 			a.DEPT_CODE, \n";
				strSql += " 			a.CLSE_ACC_ID, \n";
				strSql += " 			a.P_BUDG_CODE_NO, \n";
				strSql += " 			a.BUDG_CODE_NO, \n";
				strSql += " 			a.BUDG_CODE_NAME, \n";
				strSql += " 			b.RN P_RN, \n";
				strSql += " 			a.RN, \n";
				strSql += " 			Grouping(a.DEPT_CODE) GrTot, \n";
				strSql += " 			Case When Grouping(b.RN) = 1 Then ' ' When Grouping(a.RN) = 1 Then b.BUDG_CODE_NAME ||' 계' Else b.BUDG_CODE_NAME End P_BUDG_CODE_NAME, \n";
				strSql += " 			Case When Grouping(b.RN) = 1 Then c.DEPT_NAME ||' 계' Else c.DEPT_NAME End DEPT_NAME, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '01'Then a.BUDG_AMT Else 0 End ) PB1, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '02'Then a.BUDG_AMT Else 0 End ) PB2, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '03'Then a.BUDG_AMT Else 0 End ) PB3, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '04'Then a.BUDG_AMT Else 0 End ) PB4, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '05'Then a.BUDG_AMT Else 0 End ) PB5, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '06'Then a.BUDG_AMT Else 0 End ) PB6, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '07'Then a.BUDG_AMT Else 0 End ) PB7, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '08'Then a.BUDG_AMT Else 0 End ) PB8, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '09'Then a.BUDG_AMT Else 0 End ) PB9, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '10'Then a.BUDG_AMT Else 0 End ) PB10, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '11'Then a.BUDG_AMT Else 0 End ) PB11, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '12'Then a.BUDG_AMT Else 0 End ) PB12, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '01'Then a.SIL_AMT Else 0 End ) S1, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '02'Then a.SIL_AMT Else 0 End ) S2, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '03'Then a.SIL_AMT Else 0 End ) S3, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '04'Then a.SIL_AMT Else 0 End ) S4, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '05'Then a.SIL_AMT Else 0 End ) S5, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '06'Then a.SIL_AMT Else 0 End ) S6, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '07'Then a.SIL_AMT Else 0 End ) S7, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '08'Then a.SIL_AMT Else 0 End ) S8, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '09'Then a.SIL_AMT Else 0 End ) S9, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '10'Then a.SIL_AMT Else 0 End ) S10, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '11'Then a.SIL_AMT Else 0 End ) S11, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '12'Then a.SIL_AMT Else 0 End ) S12 \n";
				strSql += " 		From \n";
				strSql += " 			( \n";
				strSql += " 				Select \n";
				strSql += " 					A.COMP_CODE, \n";
				strSql += " 					' ' DEPT_CODE, \n";
				strSql += " 					A.CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					A.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(B.BUDG_YM,'MM') BUDG_MM, \n";
				strSql += " 					Sum(B.BUDG_MONTH_ASSIGN_AMT) BUDG_AMT, \n";
				strSql += " 					0 SIL_AMT \n";
				strSql += " 				From	T_BUDG_DEPT_ITEM A, \n";
				strSql += " 						T_BUDG_MONTH_AMT B, \n";
				strSql += " 						( \n";
				strSql += " 							Select  \n";
				strSql += " 								c.BUDG_CODE_NO , \n";
				strSql += " 								c.CRTUSERNO , \n";
				strSql += " 								c.CRTDATE , \n";
				strSql += " 								c.MODUSERNO , \n";
				strSql += " 								c.MODDATE , \n";
				strSql += " 								c.P_BUDG_CODE_NO , \n";
				strSql += " 								c.LEVEL_SEQ , \n";
				strSql += " 								c.LEGACY_BUDG_CODE , \n";
				strSql += " 								c.BUDG_CODE_NAME , \n";
				strSql += " 								c.ACC_CODE , \n";
				strSql += " 								c.USE_CLS , \n";
				strSql += " 								c.CONTROL_LEVEL_TAG , \n";
				strSql += " 								c.BUDG_ITEM_CODE , \n";
				strSql += " 								c.MAKE_DEPT , \n";
				strSql += " 								c.ASSIGN_TAG , \n";
				strSql += " 								c.COMP_CODE, \n";
				strSql += " 								RowNum Rn \n";
				strSql += " 							From T_BUDG_CODE C \n";
				strSql += " 							Start With \n";
				strSql += " 									COMP_CODE =  ?  \n";
				strSql += " 							And		Not Exists \n";
				strSql += " 									( \n";
				strSql += " 										Select \n";
				strSql += " 											Null \n";
				strSql += " 										From	t_budg_code x \n";
				strSql += " 										Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 										And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 									) \n";
				strSql += " 							Connect By \n";
				strSql += " 								Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							Order Siblings By \n";
				strSql += " 								c.LEVEL_SEQ \n";
				strSql += " 						) C, \n";
				strSql += " 						T_BUDG_DEPT_MAP d \n";
				strSql += " 				Where	A.COMP_CODE 	 = B.COMP_CODE \n";
				strSql += " 				And		A.CLSE_ACC_ID  = B.CLSE_ACC_ID \n";
				strSql += " 				And		A.DEPT_CODE 	 = B.DEPT_CODE \n";
				strSql += " 				And		A.BUDG_CODE_NO = B.BUDG_CODE_NO \n";
				strSql += " 				And		A.RESERVED_SEQ = B.RESERVED_SEQ \n";
				strSql += " 				And		A.BUDG_CODE_NO = C.BUDG_CODE_NO \n";
				strSql += " 				And		A.COMP_CODE =  ?  \n";
				strSql += " 				And		a.CLSE_ACC_ID =  ?  \n";
				strSql += " 				And		a.DEPT_CODE = d.DEPT_CODE \n";
				strSql += " 				Group by \n";
				strSql += " 					A.COMP_CODE, \n";
				strSql += " 					A.CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					A.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(B.BUDG_YM,'MM') \n";
				strSql += " 				Union All \n";
				strSql += " 				Select \n";
				strSql += " 					b.COMP_CODE, \n";
				strSql += " 					' ' DEPT_CODE, \n";
				strSql += " 					 ?  CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(b.MAKE_DT,'MM') BUDG_MM, \n";
				strSql += " 					0 BUDG_AMT, \n";
				strSql += " 					SUM(nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0)) SIL_AMT \n";
				strSql += " 				From	T_ACC_SLIP_BODY1 b, \n";
				strSql += " 						( \n";
				strSql += " 							Select  \n";
				strSql += " 								c.BUDG_CODE_NO , \n";
				strSql += " 								c.CRTUSERNO , \n";
				strSql += " 								c.CRTDATE , \n";
				strSql += " 								c.MODUSERNO , \n";
				strSql += " 								c.MODDATE , \n";
				strSql += " 								c.P_BUDG_CODE_NO , \n";
				strSql += " 								c.LEVEL_SEQ , \n";
				strSql += " 								c.LEGACY_BUDG_CODE , \n";
				strSql += " 								c.BUDG_CODE_NAME , \n";
				strSql += " 								c.ACC_CODE , \n";
				strSql += " 								c.USE_CLS , \n";
				strSql += " 								c.CONTROL_LEVEL_TAG , \n";
				strSql += " 								c.BUDG_ITEM_CODE , \n";
				strSql += " 								c.MAKE_DEPT , \n";
				strSql += " 								c.ASSIGN_TAG , \n";
				strSql += " 								c.COMP_CODE, \n";
				strSql += " 								RowNum Rn \n";
				strSql += " 							From T_BUDG_CODE C \n";
				strSql += " 							Start With \n";
				strSql += " 									COMP_CODE =  ?  \n";
				strSql += " 							And		Not Exists \n";
				strSql += " 									( \n";
				strSql += " 										Select \n";
				strSql += " 											Null \n";
				strSql += " 										From	t_budg_code x \n";
				strSql += " 										Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 										And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 									) \n";
				strSql += " 							Connect By \n";
				strSql += " 								Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							Order Siblings By \n";
				strSql += " 								c.LEVEL_SEQ \n";
				strSql += " 						) C, \n";
				strSql += " 						T_BUDG_DEPT_MAP d \n";
				strSql += " 				Where	b.KEEP_DT is not null \n";
				strSql += " 				And		b.TRANSFER_TAG = 'F' \n";
				strSql += " 				And		b.MAKE_DT Between To_Date( ? ||'-01-01','YYYY-MM-DD') And To_Date( ? ||'-12-31','YYYY-MM-DD') \n";
				strSql += " 				And		b.COMP_CODE =  ?  \n";
				strSql += " 				And		b.ACC_CODE  = c.ACC_CODE \n";
				strSql += " 				And		b.COMP_CODE = c.COMP_CODE \n";
				strSql += " 				And		b.DEPT_CODE = d.DEPT_CODE \n";
				strSql += " 				Group By \n";
				strSql += " 					b.COMP_CODE, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(b.MAKE_DT,'MM') \n";
				strSql += " 			) a, \n";
				strSql += " 			( \n";
				strSql += " 				Select  \n";
				strSql += " 					c.BUDG_CODE_NO , \n";
				strSql += " 					c.CRTUSERNO , \n";
				strSql += " 					c.CRTDATE , \n";
				strSql += " 					c.MODUSERNO , \n";
				strSql += " 					c.MODDATE , \n";
				strSql += " 					c.P_BUDG_CODE_NO , \n";
				strSql += " 					c.LEVEL_SEQ , \n";
				strSql += " 					c.LEGACY_BUDG_CODE , \n";
				strSql += " 					c.BUDG_CODE_NAME , \n";
				strSql += " 					c.ACC_CODE , \n";
				strSql += " 					c.USE_CLS , \n";
				strSql += " 					c.CONTROL_LEVEL_TAG , \n";
				strSql += " 					c.BUDG_ITEM_CODE , \n";
				strSql += " 					c.MAKE_DEPT , \n";
				strSql += " 					c.ASSIGN_TAG , \n";
				strSql += " 					c.COMP_CODE, \n";
				strSql += " 					RowNum Rn \n";
				strSql += " 				From T_BUDG_CODE C \n";
				strSql += " 				Start With \n";
				strSql += " 						COMP_CODE =  ?  \n";
				strSql += " 				And		Not Exists \n";
				strSql += " 						( \n";
				strSql += " 							Select \n";
				strSql += " 								Null \n";
				strSql += " 							From	t_budg_code x \n";
				strSql += " 							Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 							And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 						) \n";
				strSql += " 				Connect By \n";
				strSql += " 					Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 				Order Siblings By \n";
				strSql += " 					c.LEVEL_SEQ \n";
				strSql += " 			) b, \n";
				strSql += " 			T_DEPT_CODE_ORG c \n";
				strSql += " 		Where	a.P_BUDG_CODE_NO = b.BUDG_CODE_NO (+) \n";
				strSql += " 		And		a.DEPT_CODE = c.DEPT_CODE (+) \n";
				strSql += " 		Group By Grouping Sets \n";
				strSql += " 		( \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				a.P_BUDG_CODE_NO, \n";
				strSql += " 				a.BUDG_CODE_NO, \n";
				strSql += " 				a.BUDG_CODE_NAME, \n";
				strSql += " 				b.RN, \n";
				strSql += " 				a.RN, \n";
				strSql += " 				c.DEPT_NAME, \n";
				strSql += " 				b.BUDG_CODE_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				a.P_BUDG_CODE_NO, \n";
				strSql += " 				b.RN, \n";
				strSql += " 				c.DEPT_NAME, \n";
				strSql += " 				b.BUDG_CODE_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				c.DEPT_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 			) \n";
				strSql += " 		) \n";
				strSql += " 	) \n";
				strSql += " Where	GrTot <> 1 \n";
				strSql += " Order By \n";
				strSql += " 	DEPT_CODE, \n";
				strSql += " 	P_RN, \n";
				strSql += " 	RN \n";
				strSql += "  ";
				
				lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("4CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("5COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("6CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("8COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("9COMP_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("4CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("5COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("6CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("8COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("9COMP_CODE", strCOMP_CODE);
			}
			else if(strDEPT_FLAG.equals("CHK_DEPT"))
			{
				strSql  = " Select \n";
				strSql += " 	COMP_CODE, \n";
				strSql += " 	DEPT_CODE CHK_DEPT_CODE, \n";
				strSql += " 	CLSE_ACC_ID, \n";
				strSql += " 	P_BUDG_CODE_NO, \n";
				strSql += " 	BUDG_CODE_NO, \n";
				strSql += " 	BUDG_CODE_NAME acc_name, \n";
				strSql += " 	P_RN, \n";
				strSql += " 	RN, \n";
				strSql += " 	GrTot, \n";
				strSql += " 	P_BUDG_CODE_NAME p_acc_name, \n";
				strSql += " 	DEPT_NAME CHK_DEPT_NAME, \n";
				strSql += " 	PB1, \n";
				strSql += " 	PB2, \n";
				strSql += " 	PB3, \n";
				strSql += " 	PB4, \n";
				strSql += " 	PB5, \n";
				strSql += " 	PB6, \n";
				strSql += " 	PB7, \n";
				strSql += " 	PB8, \n";
				strSql += " 	PB9, \n";
				strSql += " 	PB10, \n";
				strSql += " 	PB11, \n";
				strSql += " 	PB12, \n";
				strSql += " 	PB1+PB2+PB3 PB14, \n";
				strSql += " 	PB4+PB5+PB6 PB24, \n";
				strSql += " 	PB7+PB8+PB9 PB34, \n";
				strSql += " 	PB10+PB11+PB12 PB44, \n";
				strSql += " 	PB1+PB2+PB3+PB4+PB5+PB6 PB012, \n";
				strSql += " 	PB7+PB8+PB9+PB10+PB11+PB12 PB022, \n";
				strSql += " 	S1, \n";
				strSql += " 	S2, \n";
				strSql += " 	S3, \n";
				strSql += " 	S4, \n";
				strSql += " 	S5, \n";
				strSql += " 	S6, \n";
				strSql += " 	S7, \n";
				strSql += " 	S8, \n";
				strSql += " 	S9, \n";
				strSql += " 	S10, \n";
				strSql += " 	S11, \n";
				strSql += " 	S12, \n";
				strSql += "     S1 +S2 +S3  S14, \n";
				strSql += "     S4 +S5 +S6  S24, \n";
				strSql += "     S7 +S8 +S9  S34, \n";
				strSql += "     S10+S11+S12 S44, \n";
				strSql += "     S1+S2+S3+S4+S5+S6 S012, \n";
				strSql += "     S7+S8+S9+S10+S11+S12 S022, \n";
				strSql += "     TO_CHAR( 100 * S1/nullif(PB1,0) , '999,999,999,999,999.99') R1, \n";
				strSql += "     TO_CHAR( 100 * S2/nullif(PB2,0), '999,999,999,999,999.99') R2, \n";
				strSql += "     TO_CHAR( 100 * S3/nullif(PB3,0), '999,999,999,999,999.99') R3, \n";
				strSql += "     TO_CHAR( 100 * S4/nullif(PB4,0), '999,999,999,999,999.99') R4, \n";
				strSql += "     TO_CHAR( 100 * S5/nullif(PB5,0), '999,999,999,999,999.99') R5, \n";
				strSql += "     TO_CHAR( 100 * S6/nullif(PB6,0), '999,999,999,999,999.99') R6, \n";
				strSql += "     TO_CHAR( 100 * S7/nullif(PB7,0), '999,999,999,999,999.99') R7, \n";
				strSql += "     TO_CHAR( 100 * S8/nullif(PB8,0), '999,999,999,999,999.99') R8, \n";
				strSql += "     TO_CHAR( 100 * S9/nullif(PB9,0), '999,999,999,999,999.99') R9, \n";
				strSql += " 	TO_CHAR( 100 * S10/nullif(PB10,0), '999,999,999,999,999.99') R10, \n";
				strSql += " 	TO_CHAR( 100 * S11/nullif(PB11,0), '999,999,999,999,999.99') R11, \n";
				strSql += " 	TO_CHAR( 100 * S12/nullif(PB12,0), '999,999,999,999,999.99') R12, \n";
				strSql += " 	TO_CHAR( DECODE((PB1 +PB2 +PB3 ), 0, 0, 100*(S1 +S2 +S3 )/(PB1 +PB2 +PB3 )), '999,999,999,999,999.99') R14, \n";
				strSql += " 	TO_CHAR( DECODE((PB4 +PB5 +PB6 ), 0, 0, 100*(S4 +S5 +S6 )/(PB4 +PB5 +PB6 )), '999,999,999,999,999.99') R24, \n";
				strSql += " 	TO_CHAR( DECODE((PB7 +PB8 +PB9 ), 0, 0, 100*(S7 +S8 +S9 )/(PB7 +PB8 +PB9 )), '999,999,999,999,999.99') R34, \n";
				strSql += " 	TO_CHAR( DECODE((PB10+PB11+PB12), 0, 0, 100*(S10+S11+S12)/(PB10+PB11+PB12)), '999,999,999,999,999.99') R44, \n";
				strSql += " 	TO_CHAR( DECODE((PB1 +PB2 +PB3 +PB4 +PB5 +PB6 ), 0, 0, 100*(S1 +S2 +S3 + S4 + S5 +  S6)/(PB1 +PB2 +PB3 +PB4 +PB5 +PB6 )), '999,999,999,999,999.99') R012, \n";
				strSql += " 	TO_CHAR( DECODE((PB7 +PB8 +PB9 +PB10+PB11+PB12), 0, 0, 100*(S7 +S8 +S9 +S10+S11+S12)/(PB7 +PB8 +PB9 +PB10+PB11+PB12)), '999,999,999,999,999.99') R022 \n";
				strSql += " From \n";
				strSql += " 	( \n";
				strSql += " 		Select \n";
				strSql += " 			a.COMP_CODE, \n";
				strSql += " 			a.DEPT_CODE, \n";
				strSql += " 			a.CLSE_ACC_ID, \n";
				strSql += " 			a.P_BUDG_CODE_NO, \n";
				strSql += " 			a.BUDG_CODE_NO, \n";
				strSql += " 			a.BUDG_CODE_NAME, \n";
				strSql += " 			b.RN P_RN, \n";
				strSql += " 			a.RN, \n";
				strSql += " 			Grouping(a.DEPT_CODE) GrTot, \n";
				strSql += " 			Case When Grouping(b.RN) = 1 Then ' ' When Grouping(a.RN) = 1 Then b.BUDG_CODE_NAME ||' 계' Else b.BUDG_CODE_NAME End P_BUDG_CODE_NAME, \n";
				strSql += " 			Case When Grouping(b.RN) = 1 Then c.DEPT_NAME ||' 계' Else c.DEPT_NAME End DEPT_NAME, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '01'Then a.BUDG_AMT Else 0 End ) PB1, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '02'Then a.BUDG_AMT Else 0 End ) PB2, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '03'Then a.BUDG_AMT Else 0 End ) PB3, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '04'Then a.BUDG_AMT Else 0 End ) PB4, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '05'Then a.BUDG_AMT Else 0 End ) PB5, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '06'Then a.BUDG_AMT Else 0 End ) PB6, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '07'Then a.BUDG_AMT Else 0 End ) PB7, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '08'Then a.BUDG_AMT Else 0 End ) PB8, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '09'Then a.BUDG_AMT Else 0 End ) PB9, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '10'Then a.BUDG_AMT Else 0 End ) PB10, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '11'Then a.BUDG_AMT Else 0 End ) PB11, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '12'Then a.BUDG_AMT Else 0 End ) PB12, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '01'Then a.SIL_AMT Else 0 End ) S1, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '02'Then a.SIL_AMT Else 0 End ) S2, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '03'Then a.SIL_AMT Else 0 End ) S3, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '04'Then a.SIL_AMT Else 0 End ) S4, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '05'Then a.SIL_AMT Else 0 End ) S5, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '06'Then a.SIL_AMT Else 0 End ) S6, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '07'Then a.SIL_AMT Else 0 End ) S7, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '08'Then a.SIL_AMT Else 0 End ) S8, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '09'Then a.SIL_AMT Else 0 End ) S9, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '10'Then a.SIL_AMT Else 0 End ) S10, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '11'Then a.SIL_AMT Else 0 End ) S11, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '12'Then a.SIL_AMT Else 0 End ) S12 \n";
				strSql += " 		From \n";
				strSql += " 			( \n";
				strSql += " 				Select \n";
				strSql += " 					A.COMP_CODE, \n";
				strSql += " 					d.CHK_DEPT_CODE DEPT_CODE, \n";
				strSql += " 					A.CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					A.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(B.BUDG_YM,'MM') BUDG_MM, \n";
				strSql += " 					Sum(B.BUDG_MONTH_ASSIGN_AMT) BUDG_AMT, \n";
				strSql += " 					0 SIL_AMT \n";
				strSql += " 				From	T_BUDG_DEPT_ITEM A, \n";
				strSql += " 						T_BUDG_MONTH_AMT B, \n";
				strSql += " 						( \n";
				strSql += " 							Select  \n";
				strSql += " 								c.BUDG_CODE_NO , \n";
				strSql += " 								c.CRTUSERNO , \n";
				strSql += " 								c.CRTDATE , \n";
				strSql += " 								c.MODUSERNO , \n";
				strSql += " 								c.MODDATE , \n";
				strSql += " 								c.P_BUDG_CODE_NO , \n";
				strSql += " 								c.LEVEL_SEQ , \n";
				strSql += " 								c.LEGACY_BUDG_CODE , \n";
				strSql += " 								c.BUDG_CODE_NAME , \n";
				strSql += " 								c.ACC_CODE , \n";
				strSql += " 								c.USE_CLS , \n";
				strSql += " 								c.CONTROL_LEVEL_TAG , \n";
				strSql += " 								c.BUDG_ITEM_CODE , \n";
				strSql += " 								c.MAKE_DEPT , \n";
				strSql += " 								c.ASSIGN_TAG , \n";
				strSql += " 								c.COMP_CODE, \n";
				strSql += " 								RowNum Rn \n";
				strSql += " 							From T_BUDG_CODE C \n";
				strSql += " 							Start With \n";
				strSql += " 									COMP_CODE =  ?  \n";
				strSql += " 							And		Not Exists \n";
				strSql += " 									( \n";
				strSql += " 										Select \n";
				strSql += " 											Null \n";
				strSql += " 										From	t_budg_code x \n";
				strSql += " 										Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 										And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 									) \n";
				strSql += " 							Connect By \n";
				strSql += " 								Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							Order Siblings By \n";
				strSql += " 								c.LEVEL_SEQ \n";
				strSql += " 						) C, \n";
				strSql += " 						T_BUDG_DEPT_MAP d \n";
				strSql += " 				Where	A.COMP_CODE 	 = B.COMP_CODE \n";
				strSql += " 				And		A.CLSE_ACC_ID  = B.CLSE_ACC_ID \n";
				strSql += " 				And		A.DEPT_CODE 	 = B.DEPT_CODE \n";
				strSql += " 				And		A.BUDG_CODE_NO = B.BUDG_CODE_NO \n";
				strSql += " 				And		A.RESERVED_SEQ = B.RESERVED_SEQ \n";
				strSql += " 				And		A.BUDG_CODE_NO = C.BUDG_CODE_NO \n";
				strSql += " 				And		A.COMP_CODE =  ?  \n";
				strSql += " 				And		a.CLSE_ACC_ID =  ?  \n";
				strSql += " 				And		a.DEPT_CODE = d.DEPT_CODE \n";
				strSql += " 				And		d.CHK_DEPT_CODE like  ?  || '%' \n";
				strSql += " 				Group by \n";
				strSql += " 					A.COMP_CODE, \n";
				strSql += " 					d.CHK_DEPT_CODE, \n";
				strSql += " 					A.CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					A.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(B.BUDG_YM,'MM') \n";
				strSql += " 				Union All \n";
				strSql += " 				Select \n";
				strSql += " 					b.COMP_CODE, \n";
				strSql += " 					d.CHK_DEPT_CODE DEPT_CODE, \n";
				strSql += " 					 ?  CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(b.MAKE_DT,'MM') BUDG_MM, \n";
				strSql += " 					0 BUDG_AMT, \n";
				strSql += " 					SUM(nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0)) SIL_AMT \n";
				strSql += " 				From	T_ACC_SLIP_BODY1 b, \n";
				strSql += " 						( \n";
				strSql += " 							Select  \n";
				strSql += " 								c.BUDG_CODE_NO , \n";
				strSql += " 								c.CRTUSERNO , \n";
				strSql += " 								c.CRTDATE , \n";
				strSql += " 								c.MODUSERNO , \n";
				strSql += " 								c.MODDATE , \n";
				strSql += " 								c.P_BUDG_CODE_NO , \n";
				strSql += " 								c.LEVEL_SEQ , \n";
				strSql += " 								c.LEGACY_BUDG_CODE , \n";
				strSql += " 								c.BUDG_CODE_NAME , \n";
				strSql += " 								c.ACC_CODE , \n";
				strSql += " 								c.USE_CLS , \n";
				strSql += " 								c.CONTROL_LEVEL_TAG , \n";
				strSql += " 								c.BUDG_ITEM_CODE , \n";
				strSql += " 								c.MAKE_DEPT , \n";
				strSql += " 								c.ASSIGN_TAG , \n";
				strSql += " 								c.COMP_CODE, \n";
				strSql += " 								RowNum Rn \n";
				strSql += " 							From T_BUDG_CODE C \n";
				strSql += " 							Start With \n";
				strSql += " 									COMP_CODE =  ?  \n";
				strSql += " 							And		Not Exists \n";
				strSql += " 									( \n";
				strSql += " 										Select \n";
				strSql += " 											Null \n";
				strSql += " 										From	t_budg_code x \n";
				strSql += " 										Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 										And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 									) \n";
				strSql += " 							Connect By \n";
				strSql += " 								Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							Order Siblings By \n";
				strSql += " 								c.LEVEL_SEQ \n";
				strSql += " 						) C, \n";
				strSql += " 						T_BUDG_DEPT_MAP d \n";
				strSql += " 				Where	b.KEEP_DT is not null \n";
				strSql += " 				And		b.TRANSFER_TAG = 'F' \n";
				strSql += " 				And		b.MAKE_DT Between To_Date( ? ||'-01-01','YYYY-MM-DD') And To_Date( ? ||'-12-31','YYYY-MM-DD') \n";
				strSql += " 				And		b.COMP_CODE =  ?  \n";
				strSql += " 				And		b.ACC_CODE  = c.ACC_CODE \n";
				strSql += " 				And		b.COMP_CODE = c.COMP_CODE \n";
				strSql += " 				And		b.DEPT_CODE = d.DEPT_CODE \n";
				strSql += " 				And		d.CHK_DEPT_CODE like  ? ||'%' \n";
				strSql += " 				Group By \n";
				strSql += " 					b.COMP_CODE, \n";
				strSql += " 					d.CHK_DEPT_CODE, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(b.MAKE_DT,'MM') \n";
				strSql += " 			) a, \n";
				strSql += " 			( \n";
				strSql += " 				Select  \n";
				strSql += " 					c.BUDG_CODE_NO , \n";
				strSql += " 					c.CRTUSERNO , \n";
				strSql += " 					c.CRTDATE , \n";
				strSql += " 					c.MODUSERNO , \n";
				strSql += " 					c.MODDATE , \n";
				strSql += " 					c.P_BUDG_CODE_NO , \n";
				strSql += " 					c.LEVEL_SEQ , \n";
				strSql += " 					c.LEGACY_BUDG_CODE , \n";
				strSql += " 					c.BUDG_CODE_NAME , \n";
				strSql += " 					c.ACC_CODE , \n";
				strSql += " 					c.USE_CLS , \n";
				strSql += " 					c.CONTROL_LEVEL_TAG , \n";
				strSql += " 					c.BUDG_ITEM_CODE , \n";
				strSql += " 					c.MAKE_DEPT , \n";
				strSql += " 					c.ASSIGN_TAG , \n";
				strSql += " 					c.COMP_CODE, \n";
				strSql += " 					RowNum Rn \n";
				strSql += " 				From T_BUDG_CODE C \n";
				strSql += " 				Start With \n";
				strSql += " 						COMP_CODE =  ?  \n";
				strSql += " 				And		Not Exists \n";
				strSql += " 						( \n";
				strSql += " 							Select \n";
				strSql += " 								Null \n";
				strSql += " 							From	t_budg_code x \n";
				strSql += " 							Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 							And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 						) \n";
				strSql += " 				Connect By \n";
				strSql += " 					Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 				Order Siblings By \n";
				strSql += " 					c.LEVEL_SEQ \n";
				strSql += " 			) b, \n";
				strSql += " 			T_DEPT_CODE_ORG c \n";
				strSql += " 		Where	a.P_BUDG_CODE_NO = b.BUDG_CODE_NO (+) \n";
				strSql += " 		And		a.DEPT_CODE = c.DEPT_CODE (+) \n";
				strSql += " 		Group By Grouping Sets \n";
				strSql += " 		( \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				a.P_BUDG_CODE_NO, \n";
				strSql += " 				a.BUDG_CODE_NO, \n";
				strSql += " 				a.BUDG_CODE_NAME, \n";
				strSql += " 				b.RN, \n";
				strSql += " 				a.RN, \n";
				strSql += " 				c.DEPT_NAME, \n";
				strSql += " 				b.BUDG_CODE_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				a.P_BUDG_CODE_NO, \n";
				strSql += " 				b.RN, \n";
				strSql += " 				c.DEPT_NAME, \n";
				strSql += " 				b.BUDG_CODE_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				c.DEPT_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 			) \n";
				strSql += " 		) \n";
				strSql += " 	) \n";
				strSql += " Order By \n";
				strSql += " 	DEPT_CODE, \n";
				strSql += " 	P_RN, \n";
				strSql += " 	RN \n";
				strSql += "  ";
				
				lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("5CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("6COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("9COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("10DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("11COMP_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
				lrArgData.setValue("5CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("6COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("9COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("10DEPT_CODE", strDEPT_CODE);
				lrArgData.setValue("11COMP_CODE", strCOMP_CODE);
			}
			else if(strDEPT_FLAG.equals("DEPT"))
			{
				strSql  = " Select \n";
				strSql += " 	COMP_CODE, \n";
				strSql += " 	CHK_DEPT_CODE, \n";
				strSql += " 	CHK_DEPT_NAME, \n";
				strSql += " 	DEPT_CODE, \n";
				strSql += " 	DEPT_NAME, \n";
				strSql += " 	CLSE_ACC_ID, \n";
				strSql += " 	P_BUDG_CODE_NO, \n";
				strSql += " 	BUDG_CODE_NO, \n";
				strSql += " 	BUDG_CODE_NAME acc_name, \n";
				strSql += " 	P_RN, \n";
				strSql += " 	RN, \n";
				strSql += " 	GrTot, \n";
				strSql += " 	P_BUDG_CODE_NAME p_acc_name, \n";
				strSql += " 	PB1, \n";
				strSql += " 	PB2, \n";
				strSql += " 	PB3, \n";
				strSql += " 	PB4, \n";
				strSql += " 	PB5, \n";
				strSql += " 	PB6, \n";
				strSql += " 	PB7, \n";
				strSql += " 	PB8, \n";
				strSql += " 	PB9, \n";
				strSql += " 	PB10, \n";
				strSql += " 	PB11, \n";
				strSql += " 	PB12, \n";
				strSql += " 	PB1+PB2+PB3 PB14, \n";
				strSql += " 	PB4+PB5+PB6 PB24, \n";
				strSql += " 	PB7+PB8+PB9 PB34, \n";
				strSql += " 	PB10+PB11+PB12 PB44, \n";
				strSql += " 	PB1+PB2+PB3+PB4+PB5+PB6 PB012, \n";
				strSql += " 	PB7+PB8+PB9+PB10+PB11+PB12 PB022, \n";
				strSql += " 	S1, \n";
				strSql += " 	S2, \n";
				strSql += " 	S3, \n";
				strSql += " 	S4, \n";
				strSql += " 	S5, \n";
				strSql += " 	S6, \n";
				strSql += " 	S7, \n";
				strSql += " 	S8, \n";
				strSql += " 	S9, \n";
				strSql += " 	S10, \n";
				strSql += " 	S11, \n";
				strSql += " 	S12, \n";
				strSql += "     S1 +S2 +S3  S14, \n";
				strSql += "     S4 +S5 +S6  S24, \n";
				strSql += "     S7 +S8 +S9  S34, \n";
				strSql += "     S10+S11+S12 S44, \n";
				strSql += "     S1+S2+S3+S4+S5+S6 S012, \n";
				strSql += "     S7+S8+S9+S10+S11+S12 S022, \n";
				strSql += "     TO_CHAR( 100 * S1/nullif(PB1,0) , '999,999,999,999,999.99') R1, \n";
				strSql += "     TO_CHAR( 100 * S2/nullif(PB2,0), '999,999,999,999,999.99') R2, \n";
				strSql += "     TO_CHAR( 100 * S3/nullif(PB3,0), '999,999,999,999,999.99') R3, \n";
				strSql += "     TO_CHAR( 100 * S4/nullif(PB4,0), '999,999,999,999,999.99') R4, \n";
				strSql += "     TO_CHAR( 100 * S5/nullif(PB5,0), '999,999,999,999,999.99') R5, \n";
				strSql += "     TO_CHAR( 100 * S6/nullif(PB6,0), '999,999,999,999,999.99') R6, \n";
				strSql += "     TO_CHAR( 100 * S7/nullif(PB7,0), '999,999,999,999,999.99') R7, \n";
				strSql += "     TO_CHAR( 100 * S8/nullif(PB8,0), '999,999,999,999,999.99') R8, \n";
				strSql += "     TO_CHAR( 100 * S9/nullif(PB9,0), '999,999,999,999,999.99') R9, \n";
				strSql += " 	TO_CHAR( 100 * S10/nullif(PB10,0), '999,999,999,999,999.99') R10, \n";
				strSql += " 	TO_CHAR( 100 * S11/nullif(PB11,0), '999,999,999,999,999.99') R11, \n";
				strSql += " 	TO_CHAR( 100 * S12/nullif(PB12,0), '999,999,999,999,999.99') R12, \n";
				strSql += " 	TO_CHAR( DECODE((PB1 +PB2 +PB3 ), 0, 0, 100*(S1 +S2 +S3 )/(PB1 +PB2 +PB3 )), '999,999,999,999,999.99') R14, \n";
				strSql += " 	TO_CHAR( DECODE((PB4 +PB5 +PB6 ), 0, 0, 100*(S4 +S5 +S6 )/(PB4 +PB5 +PB6 )), '999,999,999,999,999.99') R24, \n";
				strSql += " 	TO_CHAR( DECODE((PB7 +PB8 +PB9 ), 0, 0, 100*(S7 +S8 +S9 )/(PB7 +PB8 +PB9 )), '999,999,999,999,999.99') R34, \n";
				strSql += " 	TO_CHAR( DECODE((PB10+PB11+PB12), 0, 0, 100*(S10+S11+S12)/(PB10+PB11+PB12)), '999,999,999,999,999.99') R44, \n";
				strSql += " 	TO_CHAR( DECODE((PB1 +PB2 +PB3 +PB4 +PB5 +PB6 ), 0, 0, 100*(S1 +S2 +S3 + S4 + S5 +  S6)/(PB1 +PB2 +PB3 +PB4 +PB5 +PB6 )), '999,999,999,999,999.99') R012, \n";
				strSql += " 	TO_CHAR( DECODE((PB7 +PB8 +PB9 +PB10+PB11+PB12), 0, 0, 100*(S7 +S8 +S9 +S10+S11+S12)/(PB7 +PB8 +PB9 +PB10+PB11+PB12)), '999,999,999,999,999.99') R022 \n";
				strSql += " From \n";
				strSql += " 	( \n";
				strSql += " 		Select \n";
				strSql += " 			a.COMP_CODE, \n";
				strSql += " 			a.DEPT_CODE, \n";
				strSql += " 			a.CLSE_ACC_ID, \n";
				strSql += " 			a.P_BUDG_CODE_NO, \n";
				strSql += " 			a.BUDG_CODE_NO, \n";
				strSql += " 			a.BUDG_CODE_NAME, \n";
				strSql += " 			d.CHK_DEPT_CODE, \n";
				strSql += " 			b.RN P_RN, \n";
				strSql += " 			a.RN, \n";
				strSql += " 			Grouping(d.CHK_DEPT_CODE) GrTot, \n";
				strSql += " 			Case When Grouping(d.CHK_DEPT_CODE) = 1 Then '총  계' When Grouping(a.DEPT_CODE) = 1 Then e.DEPT_NAME||' 계' Else e.DEPT_NAME End CHK_DEPT_NAME, \n";
				strSql += " 			Case When Grouping(b.RN) = 1 Then ' ' When Grouping(a.RN) = 1 Then b.BUDG_CODE_NAME ||' 계' Else b.BUDG_CODE_NAME End P_BUDG_CODE_NAME, \n";
				strSql += " 			Case When Grouping(a.DEPT_CODE) = 1 Then ' ' When Grouping(b.RN) = 1 Then c.DEPT_NAME ||' 계' Else c.DEPT_NAME End DEPT_NAME, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '01'Then a.BUDG_AMT Else 0 End ) PB1, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '02'Then a.BUDG_AMT Else 0 End ) PB2, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '03'Then a.BUDG_AMT Else 0 End ) PB3, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '04'Then a.BUDG_AMT Else 0 End ) PB4, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '05'Then a.BUDG_AMT Else 0 End ) PB5, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '06'Then a.BUDG_AMT Else 0 End ) PB6, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '07'Then a.BUDG_AMT Else 0 End ) PB7, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '08'Then a.BUDG_AMT Else 0 End ) PB8, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '09'Then a.BUDG_AMT Else 0 End ) PB9, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '10'Then a.BUDG_AMT Else 0 End ) PB10, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '11'Then a.BUDG_AMT Else 0 End ) PB11, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '12'Then a.BUDG_AMT Else 0 End ) PB12, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '01'Then a.SIL_AMT Else 0 End ) S1, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '02'Then a.SIL_AMT Else 0 End ) S2, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '03'Then a.SIL_AMT Else 0 End ) S3, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '04'Then a.SIL_AMT Else 0 End ) S4, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '05'Then a.SIL_AMT Else 0 End ) S5, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '06'Then a.SIL_AMT Else 0 End ) S6, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '07'Then a.SIL_AMT Else 0 End ) S7, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '08'Then a.SIL_AMT Else 0 End ) S8, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '09'Then a.SIL_AMT Else 0 End ) S9, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '10'Then a.SIL_AMT Else 0 End ) S10, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '11'Then a.SIL_AMT Else 0 End ) S11, \n";
				strSql += " 			Sum( Case When a.BUDG_MM = '12'Then a.SIL_AMT Else 0 End ) S12 \n";
				strSql += " 		From \n";
				strSql += " 			( \n";
				strSql += " 				Select \n";
				strSql += " 					A.COMP_CODE, \n";
				strSql += " 					A.DEPT_CODE DEPT_CODE, \n";
				strSql += " 					A.CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					A.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(B.BUDG_YM,'MM') BUDG_MM, \n";
				strSql += " 					Sum(B.BUDG_MONTH_ASSIGN_AMT) BUDG_AMT, \n";
				strSql += " 					0 SIL_AMT \n";
				strSql += " 				From	T_BUDG_DEPT_ITEM A, \n";
				strSql += " 						T_BUDG_MONTH_AMT B, \n";
				strSql += " 						( \n";
				strSql += " 							Select  \n";
				strSql += " 								c.BUDG_CODE_NO , \n";
				strSql += " 								c.CRTUSERNO , \n";
				strSql += " 								c.CRTDATE , \n";
				strSql += " 								c.MODUSERNO , \n";
				strSql += " 								c.MODDATE , \n";
				strSql += " 								c.P_BUDG_CODE_NO , \n";
				strSql += " 								c.LEVEL_SEQ , \n";
				strSql += " 								c.LEGACY_BUDG_CODE , \n";
				strSql += " 								c.BUDG_CODE_NAME , \n";
				strSql += " 								c.ACC_CODE , \n";
				strSql += " 								c.USE_CLS , \n";
				strSql += " 								c.CONTROL_LEVEL_TAG , \n";
				strSql += " 								c.BUDG_ITEM_CODE , \n";
				strSql += " 								c.MAKE_DEPT , \n";
				strSql += " 								c.ASSIGN_TAG , \n";
				strSql += " 								c.COMP_CODE, \n";
				strSql += " 								RowNum Rn \n";
				strSql += " 							From T_BUDG_CODE C \n";
				strSql += " 							Start With \n";
				strSql += " 									COMP_CODE =  ?  \n";
				strSql += " 							And		Not Exists \n";
				strSql += " 									( \n";
				strSql += " 										Select \n";
				strSql += " 											Null \n";
				strSql += " 										From	t_budg_code x \n";
				strSql += " 										Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 										And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 									) \n";
				strSql += " 							Connect By \n";
				strSql += " 								Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							Order Siblings By \n";
				strSql += " 								c.LEVEL_SEQ \n";
				strSql += " 						) C \n";
				strSql += " 				Where	A.COMP_CODE 	 = B.COMP_CODE \n";
				strSql += " 				And		A.CLSE_ACC_ID  = B.CLSE_ACC_ID \n";
				strSql += " 				And		A.DEPT_CODE 	 = B.DEPT_CODE \n";
				strSql += " 				And		A.BUDG_CODE_NO = B.BUDG_CODE_NO \n";
				strSql += " 				And		A.RESERVED_SEQ = B.RESERVED_SEQ \n";
				strSql += " 				And		A.BUDG_CODE_NO = C.BUDG_CODE_NO \n";
				strSql += " 				And		A.COMP_CODE =  ?  \n";
				strSql += " 				And		a.CLSE_ACC_ID =  ?  \n";
				strSql += " 				And		a.DEPT_CODE like  ?  || '%' \n";
				strSql += " 				Group by \n";
				strSql += " 					A.COMP_CODE, \n";
				strSql += " 					a.DEPT_CODE, \n";
				strSql += " 					A.CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					A.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(B.BUDG_YM,'MM') \n";
				strSql += " 				Union All \n";
				strSql += " 				Select \n";
				strSql += " 					b.COMP_CODE, \n";
				strSql += " 					b.DEPT_CODE DEPT_CODE, \n";
				strSql += " 					 ?  CLSE_ACC_ID, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(b.MAKE_DT,'MM') BUDG_MM, \n";
				strSql += " 					0 BUDG_AMT, \n";
				strSql += " 					SUM(nvl(b.DB_AMT,0) + nvl(b.CR_AMT,0)) SIL_AMT \n";
				strSql += " 				From	T_ACC_SLIP_BODY1 b, \n";
				strSql += " 						( \n";
				strSql += " 							Select  \n";
				strSql += " 								c.BUDG_CODE_NO , \n";
				strSql += " 								c.CRTUSERNO , \n";
				strSql += " 								c.CRTDATE , \n";
				strSql += " 								c.MODUSERNO , \n";
				strSql += " 								c.MODDATE , \n";
				strSql += " 								c.P_BUDG_CODE_NO , \n";
				strSql += " 								c.LEVEL_SEQ , \n";
				strSql += " 								c.LEGACY_BUDG_CODE , \n";
				strSql += " 								c.BUDG_CODE_NAME , \n";
				strSql += " 								c.ACC_CODE , \n";
				strSql += " 								c.USE_CLS , \n";
				strSql += " 								c.CONTROL_LEVEL_TAG , \n";
				strSql += " 								c.BUDG_ITEM_CODE , \n";
				strSql += " 								c.MAKE_DEPT , \n";
				strSql += " 								c.ASSIGN_TAG , \n";
				strSql += " 								c.COMP_CODE, \n";
				strSql += " 								RowNum Rn \n";
				strSql += " 							From T_BUDG_CODE C \n";
				strSql += " 							Start With \n";
				strSql += " 									COMP_CODE =  ?  \n";
				strSql += " 							And		Not Exists \n";
				strSql += " 									( \n";
				strSql += " 										Select \n";
				strSql += " 											Null \n";
				strSql += " 										From	t_budg_code x \n";
				strSql += " 										Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 										And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 									) \n";
				strSql += " 							Connect By \n";
				strSql += " 								Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 							Order Siblings By \n";
				strSql += " 								c.LEVEL_SEQ \n";
				strSql += " 						) C \n";
				strSql += " 				Where	b.KEEP_DT is not null \n";
				strSql += " 				And		b.TRANSFER_TAG = 'F' \n";
				strSql += " 				And		b.MAKE_DT Between To_Date( ? ||'-01-01','YYYY-MM-DD') And To_Date( ? ||'-12-31','YYYY-MM-DD') \n";
				strSql += " 				And		b.COMP_CODE =  ?  \n";
				strSql += " 				And		b.ACC_CODE  = c.ACC_CODE \n";
				strSql += " 				And		b.COMP_CODE = c.COMP_CODE \n";
				strSql += " 				And		b.DEPT_CODE like  ?  || '%' \n";
				strSql += " 				Group By \n";
				strSql += " 					b.COMP_CODE, \n";
				strSql += " 					b.DEPT_CODE, \n";
				strSql += " 					C.P_BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NO, \n";
				strSql += " 					C.BUDG_CODE_NAME, \n";
				strSql += " 					C.RN, \n";
				strSql += " 					To_Char(b.MAKE_DT,'MM') \n";
				strSql += " 			) a, \n";
				strSql += " 			( \n";
				strSql += " 				Select  \n";
				strSql += " 					c.BUDG_CODE_NO , \n";
				strSql += " 					c.CRTUSERNO , \n";
				strSql += " 					c.CRTDATE , \n";
				strSql += " 					c.MODUSERNO , \n";
				strSql += " 					c.MODDATE , \n";
				strSql += " 					c.P_BUDG_CODE_NO , \n";
				strSql += " 					c.LEVEL_SEQ , \n";
				strSql += " 					c.LEGACY_BUDG_CODE , \n";
				strSql += " 					c.BUDG_CODE_NAME , \n";
				strSql += " 					c.ACC_CODE , \n";
				strSql += " 					c.USE_CLS , \n";
				strSql += " 					c.CONTROL_LEVEL_TAG , \n";
				strSql += " 					c.BUDG_ITEM_CODE , \n";
				strSql += " 					c.MAKE_DEPT , \n";
				strSql += " 					c.ASSIGN_TAG , \n";
				strSql += " 					c.COMP_CODE, \n";
				strSql += " 					RowNum Rn \n";
				strSql += " 				From T_BUDG_CODE C \n";
				strSql += " 				Start With \n";
				strSql += " 						COMP_CODE =  ?  \n";
				strSql += " 				And		Not Exists \n";
				strSql += " 						( \n";
				strSql += " 							Select \n";
				strSql += " 								Null \n";
				strSql += " 							From	t_budg_code x \n";
				strSql += " 							Where	x.COMP_CODE = c.COMP_CODE \n";
				strSql += " 							And		x.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 						) \n";
				strSql += " 				Connect By \n";
				strSql += " 					Prior	c.BUDG_CODE_NO = c.P_BUDG_CODE_NO \n";
				strSql += " 				Order Siblings By \n";
				strSql += " 					c.LEVEL_SEQ \n";
				strSql += " 			) b, \n";
				strSql += " 			T_DEPT_CODE_ORG c, \n";
				strSql += " 			T_BUDG_DEPT_MAP d, \n";
				strSql += " 			T_DEPT_CODE_ORG e \n";
				strSql += " 		Where	a.P_BUDG_CODE_NO = b.BUDG_CODE_NO (+) \n";
				strSql += " 		And		a.DEPT_CODE = c.DEPT_CODE (+) \n";
				strSql += " 		And		a.DEPT_CODE = d.DEPT_CODE (+) \n";
				strSql += " 		And		d.CHK_DEPT_CODE = e.DEPT_CODE (+) \n";
				strSql += " 		Group By Grouping Sets \n";
				strSql += " 		( \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				d.CHK_DEPT_CODE, \n";
				strSql += " 				e.DEPT_NAME, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				a.P_BUDG_CODE_NO, \n";
				strSql += " 				a.BUDG_CODE_NO, \n";
				strSql += " 				a.BUDG_CODE_NAME, \n";
				strSql += " 				b.RN, \n";
				strSql += " 				a.RN, \n";
				strSql += " 				c.DEPT_NAME, \n";
				strSql += " 				b.BUDG_CODE_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				d.CHK_DEPT_CODE, \n";
				strSql += " 				e.DEPT_NAME, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				a.P_BUDG_CODE_NO, \n";
				strSql += " 				b.RN, \n";
				strSql += " 				c.DEPT_NAME, \n";
				strSql += " 				b.BUDG_CODE_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				d.CHK_DEPT_CODE, \n";
				strSql += " 				e.DEPT_NAME, \n";
				strSql += " 				a.DEPT_CODE, \n";
				strSql += " 				a.CLSE_ACC_ID, \n";
				strSql += " 				c.DEPT_NAME \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 				a.COMP_CODE, \n";
				strSql += " 				d.CHK_DEPT_CODE, \n";
				strSql += " 				e.DEPT_NAME, \n";
				strSql += " 				a.CLSE_ACC_ID \n";
				strSql += " 			), \n";
				strSql += " 			( \n";
				strSql += " 			) \n";
				strSql += " 		) \n";
				strSql += " 	) \n";
				strSql += " Order By \n";
				strSql += " 	CHK_DEPT_CODE, \n";
				strSql += " 	DEPT_CODE, \n";
				strSql += " 	P_RN, \n";
				strSql += " 	RN \n";
				strSql += "  ";
				
				lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("3CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("4DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("5CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("6COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("7CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("8CLSE_ACC_ID", CITData.VARCHAR2);
				lrArgData.addColumn("9COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("10DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("11COMP_CODE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("3CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("4DEPT_CODE", strDEPT_CODE);
				lrArgData.setValue("5CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("6COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("7CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("8CLSE_ACC_ID", strCLSE_ACC_ID);
				lrArgData.setValue("9COMP_CODE", strCOMP_CODE);
				lrArgData.setValue("10DEPT_CODE", strDEPT_CODE);
				lrArgData.setValue("11COMP_CODE", strCOMP_CODE);
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
