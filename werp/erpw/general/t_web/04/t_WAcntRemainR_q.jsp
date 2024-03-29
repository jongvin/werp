<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-05-21)
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
			String strMAKE_DT = CITCommon.toKOR(request.getParameter("MAKE_DT"));
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	b.ACC_NAME, \n";
			strSql += " 	d.BANK_MAIN_SHORT_NAME, \n";
			strSql += " 	Sum(a.REMAIN_AMT) REMAIN_AMT \n";
			strSql += " From \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.BANK_CODE, \n";
			strSql += " 			Nvl(Sum(a.DB_AMT),0) - Nvl(Sum(a.CR_AMT),0) REMAIN_AMT \n";
			strSql += " 		From	T_ACC_SLIP_BODY1 a \n";
			strSql += " 		Where	a.ACC_CODE In \n";
			strSql += " 						('111010200', \n";
			strSql += " 						'111010100', \n";
			strSql += " 						'111010300', \n";
			strSql += " 						'111010400', \n";
			strSql += " 						'111010500', \n";
			strSql += " 						'111010600', \n";
			strSql += " 						'111010700', \n";
			strSql += " 						'111010900') \n";
			strSql += " 		And		a.TRANSFER_TAG = 'F' \n";
			strSql += " 		And		a.MAKE_DT <=  ?  \n";
			strSql += " 		And		a.COMP_CODE Like  ?  \n";
			strSql += " 		And		a.KEEP_DT Is Not Null \n";
			strSql += " 		Group By \n";
			strSql += " 			a.ACC_CODE, \n";
			strSql += " 			a.BANK_CODE \n";
			strSql += " 	) a, \n";
			strSql += " 	T_ACC_CODE b, \n";
			strSql += " 	T_BANK_CODE c, \n";
			strSql += " 	T_BANK_MAIN d \n";
			strSql += " Where	a.BANK_CODE = c.BANK_CODE (+) \n";
			strSql += " And		c.BANK_MAIN_CODE = d.BANK_MAIN_CODE (+) \n";
			strSql += " And		a.ACC_CODE = b.ACC_CODE \n";
			strSql += " Group By \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	b.ACC_NAME, \n";
			strSql += " 	d.BANK_MAIN_CODE, \n";
			strSql += " 	d.BANK_MAIN_SHORT_NAME \n";
			strSql += "  ";
			
			lrArgData.addColumn("1MAKE_DT", CITData.DATE);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1MAKE_DT", strMAKE_DT);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
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