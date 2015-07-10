<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WAccCodeR_q.jsp(계정과목등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-16)
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
			String strACC_GRP = CITCommon.toKOR(request.getParameter("ACC_GRP"));
			String strACC_NAME = CITCommon.toKOR(request.getParameter("ACC_NAME"));
			
			strSql  = " Select \n";
			strSql += " 	A.ACC_CODE , \n";
			strSql += " 	A.CRTUSERNO , \n";
			strSql += " 	A.CRTDATE , \n";
			strSql += " 	A.MODUSERNO , \n";
			strSql += " 	A.MODDATE , \n";
			strSql += " 	A.ACC_SHRT_NAME , \n";
			strSql += " 	A.ACC_NAME , \n";
			strSql += " 	A.SHRT_CODE , \n";
			strSql += " 	A.COMPUTER_ACC , \n";
			strSql += " 	Nvl(A.ACC_GRP,'F') ACC_GRP , \n";
			strSql += " 	Nvl(A.ACC_LVL,'F')  ACC_LVL, \n";
			strSql += " 	Nvl(A.ACC_REMAIN_POSITION,'F')  ACC_REMAIN_POSITION, \n";
			strSql += " 	Nvl(A.FUND_INPUT_CLS,'F')  FUND_INPUT_CLS, \n";
			strSql += " 	Nvl(A.ACC_REMAIN_MNG,'F')  ACC_REMAIN_MNG, \n";
			strSql += " 	Nvl(A.SUMMARY_CLS,'F')  SUMMARY_CLS, \n";
			strSql += " 	Nvl(A.CUST_CODE_MNG,'F')  CUST_CODE_MNG, \n";
			strSql += " 	Nvl(A.CUST_CODE_MNG_TG,'F') CUST_CODE_MNG_TG , \n";
			strSql += " 	Nvl(A.CUST_NAME_MNG,'F') CUST_NAME_MNG , \n";
			strSql += " 	Nvl(A.CUST_NAME_MNG_TG,'F') CUST_NAME_MNG_TG , \n";
			strSql += " 	Nvl(A.BUDG_MNG,'F') BUDG_MNG , \n";
			strSql += " 	Nvl(A.BUDG_EXEC_CLS,'F') BUDG_EXEC_CLS , \n";
			strSql += " 	Nvl(A.BANK_MNG,'F') BANK_MNG , \n";
			strSql += " 	Nvl(A.BANK_MNG_TG,'F') BANK_MNG_TG , \n";
			strSql += " 	Nvl(A.ACCNO_MNG,'F') ACCNO_MNG , \n";
			strSql += " 	Nvl(A.ACCNO_MNG_TG,'F') ACCNO_MNG_TG , \n";
			strSql += " 	Nvl(A.CARD_SEQ_MNG,'F') CARD_SEQ_MNG , \n";
			strSql += " 	Nvl(A.CARD_SEQ_MNG_TG,'F') CARD_SEQ_MNG_TG , \n";
			strSql += " 	Nvl(A.CHK_NO_MNG,'F') CHK_NO_MNG , \n";
			strSql += " 	Nvl(A.CHK_NO_MNG_TG,'F') CHK_NO_MNG_TG , \n";
			strSql += " 	Nvl(A.BILL_NO_MNG,'F') BILL_NO_MNG , \n";
			strSql += " 	Nvl(A.BILL_NO_MNG_TG,'F') BILL_NO_MNG_TG , \n";
			strSql += " 	Nvl(A.REC_BILL_NO_MNG,'F')  REC_BILL_NO_MNG, \n";
			strSql += " 	Nvl(A.REC_BILL_NO_MNG_TG,'F') REC_BILL_NO_MNG_TG , \n";
			strSql += " 	Nvl(A.CP_NO_MNG,'F') CP_NO_MNG , \n";
			strSql += " 	Nvl(A.CP_NO_MNG_TG,'F') CP_NO_MNG_TG , \n";
			strSql += " 	Nvl(A.SECU_MNG,'F') SECU_MNG , \n";
			strSql += " 	Nvl(A.SECU_MNG_TG,'F')SECU_MNG_TG  , \n";
			strSql += " 	Nvl(A.LOAN_NO_MNG,'F') LOAN_NO_MNG , \n";
			strSql += " 	Nvl(A.LOAN_NO_MNG_TG,'F') LOAN_NO_MNG_TG , \n";
			strSql += " 	Nvl(A.FIXED_MNG,'F')  FIXED_MNG, \n";
			strSql += " 	Nvl(A.FIXED_MNG_TG,'F')  FIXED_MNG_TG, \n";
			strSql += " 	Nvl(A.DEPOSIT_PAY_MNG,'F')  DEPOSIT_PAY_MNG, \n";
			strSql += " 	Nvl(A.DEPOSIT_PAY_MNG_TG,'F') DEPOSIT_PAY_MNG_TG , \n";
			strSql += " 	Nvl(A.PAY_CON_MNG,'F')  PAY_CON_MNG, \n";
			strSql += " 	Nvl(A.PAY_CON_MNG_TG,'F')  PAY_CON_MNG_TG, \n";
			strSql += " 	Nvl(A.BILL_EXPR_MNG,'F')  BILL_EXPR_MNG, \n";
			strSql += " 	Nvl(A.BILL_EXPR_MNG_TG,'F')  BILL_EXPR_MNG_TG, \n";
			strSql += " 	Nvl(A.ANTICIPATION_DT_MNG,'F')  ANTICIPATION_DT_MNG, \n";
			strSql += " 	Nvl(A.ANTICIPATION_DT_MNG_TG,'F') ANTICIPATION_DT_MNG_TG , \n";
			strSql += " 	Nvl(A.EMP_NO_MNG,'F') EMP_NO_MNG , \n";
			strSql += " 	Nvl(A.PRINT_SHEET_TAG,'F') PRINT_SHEET_TAG , \n";
			strSql += " 	Nvl(A.EMP_NO_MNG_TG,'F') EMP_NO_MNG_TG , \n";
			strSql += " 	A.MNG_NAME_CHAR1  , \n";
			strSql += " 	Nvl(A.MNG_TG_CHAR1,'F')  MNG_TG_CHAR1, \n";
			strSql += " 	A.MNG_NAME_CHAR2 , \n";
			strSql += " 	Nvl(A.MNG_TG_CHAR2,'F')  MNG_TG_CHAR2, \n";
			strSql += " 	A.MNG_NAME_CHAR3 , \n";
			strSql += " 	Nvl(A.MNG_TG_CHAR3,'F') MNG_TG_CHAR3 , \n";
			strSql += " 	A.MNG_NAME_CHAR4 , \n";
			strSql += " 	Nvl(A.MNG_TG_CHAR4,'F') MNG_TG_CHAR4 , \n";
			strSql += " 	A.MNG_NAME_NUM1 , \n";
			strSql += " 	Nvl(A.MNG_TG_NUM1,'F')  MNG_TG_NUM1, \n";
			strSql += " 	A.MNG_NAME_NUM2 , \n";
			strSql += " 	Nvl(A.MNG_TG_NUM2,'F')  MNG_TG_NUM2, \n";
			strSql += " 	A.MNG_NAME_NUM3 , \n";
			strSql += " 	Nvl(A.MNG_TG_NUM3,'F') MNG_TG_NUM3 , \n";
			strSql += " 	A.MNG_NAME_NUM4 , \n";
			strSql += " 	Nvl(A.MNG_TG_NUM4,'F') MNG_TG_NUM4 , \n";
			strSql += " 	A.MNG_NAME_DT1 , \n";
			strSql += " 	Nvl(A.MNG_TG_DT1,'F') MNG_TG_DT1 , \n";
			strSql += " 	A.MNG_NAME_DT2 , \n";
			strSql += " 	Nvl(A.MNG_TG_DT2,'F') MNG_TG_DT2 , \n";
			strSql += " 	A.MNG_NAME_DT3 , \n";
			strSql += " 	Nvl(A.MNG_TG_DT3,'F') MNG_TG_DT3 , \n";
			strSql += " 	A.MNG_NAME_DT4 , \n";
			strSql += " 	Nvl(A.MNG_TG_DT4,'F') MNG_TG_DT4 \n";
			strSql += " from \n";
			strSql += " 	T_ACC_CODE A  \n";
			strSql += " Where	A.ACC_GRP like	'%'|| ? ||'%' \n";
			strSql += " and	A.ACC_NAME like '%'|| ? ||'%' \n";
			strSql += " Order By \n";
			strSql += " 	a.ACC_CODE ";
			
			lrArgData.addColumn("ACC_GRP", CITData.VARCHAR2);
			lrArgData.addColumn("ACC_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("ACC_GRP", strACC_GRP);
			lrArgData.setValue("ACC_NAME", strACC_NAME);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ACC_CODE", true);
				lrReturnData.setNotNull("ACC_GRP", true);
				lrReturnData.setNotNull("ACC_LVL", true);
				lrReturnData.setNotNull("ACC_NAME", true);
				lrReturnData.setNotNull("ACC_REMAIN_POSITION", true);
				lrReturnData.setNotNull("FUND_INPUT_CLS", true);
				lrReturnData.setNotNull("PRINT_SHEET_TAG", true);


				
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
		else if (strAct.equals("ACC_REMAIN_POSITION"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.CODE_LIST_ID, \n";
			strSql += " 	a.CODE_LIST_NAME, \n";
			strSql += " 	a.SEQ \n";
			strSql += " From \n";
			strSql += " 	V_T_CODE_LIST a \n";
			strSql += " Where	a.CODE_GROUP_ID = 'ACC_REMAIN_POSITION' \n";
			strSql += " And	a.USE_TAG = 'T' \n";
			strSql += " Order By \n";
			strSql += " 	SEQ ";
			

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