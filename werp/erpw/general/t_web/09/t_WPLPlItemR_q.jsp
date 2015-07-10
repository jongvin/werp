<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-22)
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

			
			strSql  = " Select \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	To_Char(a.P_NO) P_NO , \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NAME , \n";
			strSql += " 	a.ITEM_LEVEL_SEQ , \n";
			strSql += " 	a.ITEM_TAG , \n";
			strSql += " 	a.LEVEL_TAG , \n";
			strSql += " 	a.DEPT_TAG , \n";
			strSql += " 	a.MNG_CODE , \n";
			strSql += " 	To_Char(a.COMP_PLN_FUNC_NO) COMP_PLN_FUNC_NO , \n";
			strSql += " 	To_Char(a.COMP_FOR_FUNC_NO) COMP_FOR_FUNC_NO , \n";
			strSql += " 	To_Char(a.COMP_EXE_FUNC_NO) COMP_EXE_FUNC_NO , \n";
			strSql += " 	To_Char(a.COMP_PLN_FUNC_NO_B) COMP_PLN_FUNC_NO_B , \n";
			strSql += " 	To_Char(a.COMP_FOR_FUNC_NO_B) COMP_FOR_FUNC_NO_B , \n";
			strSql += " 	To_Char(a.COMP_EXE_FUNC_NO_B) COMP_EXE_FUNC_NO_B , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	LEVEL LV \n";
			strSql += " From	T_PL_ITEM a \n";
			strSql += " Start With \n";
			strSql += " 	a.P_NO = 0 \n";
			strSql += " Connect By \n";
			strSql += " 	Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO \n";
			strSql += " Order Siblings By \n";
			strSql += " 	a.ITEM_LEVEL_SEQ ";
			

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
		else if (strAct.equals("MAIN_D"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	To_Char(a.P_NO) P_NO , \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NAME , \n";
			strSql += " 	a.ITEM_LEVEL_SEQ , \n";
			strSql += " 	a.ITEM_TAG , \n";
			strSql += " 	a.LEVEL_TAG , \n";
			strSql += " 	a.DEPT_TAG , \n";
			strSql += " 	To_Char(a.COMP_PLN_FUNC_NO) COMP_PLN_FUNC_NO , \n";
			strSql += " 	To_Char(a.COMP_FOR_FUNC_NO) COMP_FOR_FUNC_NO , \n";
			strSql += " 	To_Char(a.COMP_EXE_FUNC_NO) COMP_EXE_FUNC_NO , \n";
			strSql += " 	To_Char(a.COMP_PLN_FUNC_NO_B) COMP_PLN_FUNC_NO_B , \n";
			strSql += " 	To_Char(a.COMP_FOR_FUNC_NO_B) COMP_FOR_FUNC_NO_B , \n";
			strSql += " 	To_Char(a.COMP_EXE_FUNC_NO_B) COMP_EXE_FUNC_NO_B , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	LEVEL LV \n";
			strSql += " From	T_PL_ITEM a \n";
			strSql += " Where rowNum < 1 \n";
			strSql += " Start With \n";
			strSql += " 	a.P_NO = 0 \n";
			strSql += " Connect By \n";
			strSql += " 	Prior	a.BIZ_PLAN_ITEM_NO = a.P_NO \n";
			strSql += " Order Siblings By \n";
			strSql += " 	a.ITEM_LEVEL_SEQ ";
			

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
				GauceInfo.response.writeException("USER", "900001","MAIN_D Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("BIZ_PLAN_ITEM_NO"))
		{

			
			strSql  = " Select SQ_T_BIZ_PLAN_ITEM_NO.NextVal BIZ_PLAN_ITEM_NO From Dual  \n";
			

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
				GauceInfo.response.writeException("USER", "900001","BUDG_CODE_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("APPLY_SEQ"))
		{

			
			strSql  = " Select SQ_T_APPLY_SEQ.NextVal APPLY_SEQ From Dual  \n";
			

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
				GauceInfo.response.writeException("USER", "900001","BUDG_CODE_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strBIZ_PLAN_ITEM_NO = CITCommon.toKOR(request.getParameter("BIZ_PLAN_ITEM_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.BIZ_PLAN_ITEM_NO , \n";
			strSql += " 	a.APPLY_SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	a.SETOFF_ACC_CODE , \n";
			strSql += " 	a.SUM_MTHD_TAG , \n";
			strSql += " 	a.SIGN_TAG , \n";
			strSql += " 	a.SLIP_SUM_MTHD_TAG , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	b.ACC_NAME, \n";
			strSql += " 	c.ACC_NAME SETOFF_ACC_NAME\n";
			strSql += " From	T_PL_FLOW_ACC_CODE a, \n";
			strSql += " 		T_ACC_CODE b, \n";
			strSql += " 		T_ACC_CODE c \n";
			strSql += " Where	a.BIZ_PLAN_ITEM_NO =  ?  \n";
			strSql += " And		a.ACC_CODE = b.ACC_CODE (+) \n";
			strSql += " And		a.SETOFF_ACC_CODE = c.ACC_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.ACC_CODE ";
			
			lrArgData.addColumn("BIZ_PLAN_ITEM_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("BIZ_PLAN_ITEM_NO", strBIZ_PLAN_ITEM_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("BIZ_PLAN_ITEM_NO", true);
				lrReturnData.setKey("APPLY_SEQ", true);
				lrReturnData.setNotNull("ACC_CODE", true);
				lrReturnData.setNotNull("SUM_MTHD_TAG", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}
		else 		if (strAct.equals("ACC_CODE"))
		{
			String strACC_CODE = CITCommon.toKOR(request.getParameter("ACC_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.ACC_SHRT_NAME , \n";
			strSql += " 	a.ACC_NAME , \n";
			strSql += " 	a.SHRT_CODE , \n";
			strSql += " 	a.COMPUTER_ACC , \n";
			strSql += " 	a.ACC_GRP , \n";
			strSql += " 	a.ACC_LVL , \n";
			strSql += " 	a.ACC_REMAIN_POSITION , \n";
			strSql += " 	a.FUND_INPUT_CLS , \n";
			strSql += " 	a.ACC_REMAIN_MNG , \n";
			strSql += " 	a.SUMMARY_CLS , \n";
			strSql += " 	a.CUST_CODE_MNG , \n";
			strSql += " 	a.CUST_CODE_MNG_TG , \n";
			strSql += " 	a.CUST_NAME_MNG , \n";
			strSql += " 	a.CUST_NAME_MNG_TG , \n";
			strSql += " 	a.BUDG_MNG , \n";
			strSql += " 	a.BUDG_EXEC_CLS , \n";
			strSql += " 	a.BANK_MNG , \n";
			strSql += " 	a.BANK_MNG_TG , \n";
			strSql += " 	a.ACCNO_MNG , \n";
			strSql += " 	a.ACCNO_MNG_TG , \n";
			strSql += " 	a.CHK_NO_MNG , \n";
			strSql += " 	a.CHK_NO_MNG_TG , \n";
			strSql += " 	a.BILL_NO_MNG , \n";
			strSql += " 	a.BILL_NO_MNG_TG , \n";
			strSql += " 	a.REC_BILL_NO_MNG , \n";
			strSql += " 	a.REC_BILL_NO_MNG_TG , \n";
			strSql += " 	a.CP_NO_MNG , \n";
			strSql += " 	a.CP_NO_MNG_TG , \n";
			strSql += " 	a.SECU_MNG , \n";
			strSql += " 	a.SECU_MNG_TG , \n";
			strSql += " 	a.LOAN_NO_MNG , \n";
			strSql += " 	a.LOAN_NO_MNG_TG , \n";
			strSql += " 	a.FIXED_MNG , \n";
			strSql += " 	a.FIXED_MNG_TG , \n";
			strSql += " 	a.DEPOSIT_PAY_MNG , \n";
			strSql += " 	a.DEPOSIT_PAY_MNG_TG , \n";
			strSql += " 	a.PAY_CON_MNG , \n";
			strSql += " 	a.PAY_CON_MNG_TG , \n";
			strSql += " 	a.BILL_EXPR_MNG , \n";
			strSql += " 	a.BILL_EXPR_MNG_TG , \n";
			strSql += " 	a.ANTICIPATION_DT_MNG , \n";
			strSql += " 	a.ANTICIPATION_DT_MNG_TG , \n";
			strSql += " 	a.EMP_NO_MNG , \n";
			strSql += " 	a.EMP_NO_MNG_TG , \n";
			strSql += " 	a.MNG_NAME_CHAR1 , \n";
			strSql += " 	a.MNG_TG_CHAR1 , \n";
			strSql += " 	a.MNG_NAME_CHAR2 , \n";
			strSql += " 	a.MNG_TG_CHAR2 , \n";
			strSql += " 	a.MNG_NAME_CHAR3 , \n";
			strSql += " 	a.MNG_TG_CHAR3 , \n";
			strSql += " 	a.MNG_NAME_CHAR4 , \n";
			strSql += " 	a.MNG_TG_CHAR4 , \n";
			strSql += " 	a.MNG_NAME_NUM1 , \n";
			strSql += " 	a.MNG_TG_NUM1 , \n";
			strSql += " 	a.MNG_NAME_NUM2 , \n";
			strSql += " 	a.MNG_TG_NUM2 , \n";
			strSql += " 	a.MNG_NAME_NUM3 , \n";
			strSql += " 	a.MNG_TG_NUM3 , \n";
			strSql += " 	a.MNG_NAME_NUM4 , \n";
			strSql += " 	a.MNG_TG_NUM4 , \n";
			strSql += " 	a.MNG_NAME_DT1 , \n";
			strSql += " 	a.MNG_TG_DT1 , \n";
			strSql += " 	a.MNG_NAME_DT2 , \n";
			strSql += " 	a.MNG_TG_DT2 , \n";
			strSql += " 	a.MNG_NAME_DT3 , \n";
			strSql += " 	a.MNG_TG_DT3 , \n";
			strSql += " 	a.MNG_NAME_DT4 , \n";
			strSql += " 	a.MNG_TG_DT4 , \n";
			strSql += " 	a.ACC_CODE_NO , \n";
			strSql += " 	a.P_NO , \n";
			strSql += " 	a.LEVEL_SEQ \n";
			strSql += " From	T_ACC_CODE a \n";
			strSql += " Where	a.FUND_INPUT_CLS = 'T' \n";
			strSql += " And		a.ACC_CODE In \n";
			strSql += " ( \n";
			strSql += " 	Select \n";
			strSql += " 		b.CHILD_ACC_CODE \n";
			strSql += " 	From	T_ACC_CODE_CHILD b \n";
			strSql += " 	Where	b.PARENT_ACC_CODE =  ?  \n";
			strSql += " ) \n";
			strSql += "  ";
			
			lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("ACC_CODE", strACC_CODE);
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
				GauceInfo.response.writeException("USER", "900001","ACC_CODE Select 오류-> "+ ex.getMessage());
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