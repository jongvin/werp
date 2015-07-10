<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-02)
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

			
			strSql  = " select '0000000000' COMP_CODE, '0000000000' CLSE_ACC_ID From Dual \n";
			

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

		else if (strAct.equals("SLIP_CHECK"))
		{

			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strMAKE_DT	= CITCommon.toKOR(request.getParameter("MAKE_DT"));

			strSql  = " SELECT COUNT(*) CNT FROM T_ACC_SLIP_HEAD 	\n";
			strSql += " WHERE \n";
			strSql += " MAKE_COMP_CODE = ? \n";
			strSql += " AND MAKE_DT_TRANS = ? \n";
			strSql += " AND SLIP_KIND_TAG = 'D' \n";
			strSql += " AND TRANSFER_TAG = 'T' \n";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("MAKE_DT", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("MAKE_DT", strMAKE_DT);

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
				GauceInfo.response.writeException("USER", "900001","CLSE_ACC_ID Select 오류-> "+ ex.getMessage());
			}
		}

		else if (strAct.equals("CLSE_ACC_ID"))
		{

			String strCOMP_CODE 	= CITCommon.toKOR(request.getParameter("COMP_CODE"));

			strSql  = " SELECT  '[' ||  ACC_ID || '기] ' || A.CLSE_ACC_ID || '년' NAME, 	\n";
			strSql += "         A.CLSE_ACC_ID CLSE_ACC_ID, 	    \n";
			strSql += "         A.COMP_CODE, 	    \n";
			strSql += "         A.ACCOUNT_FDT, 			  		\n";
			strSql += "         A.ACCOUNT_EDT, 	 			  	\n";
			strSql += "         nvl(A.CLSE_CLS, 'F') CLSE_CLS \n";
			strSql += " FROM T_YEAR_CLOSE A \n";
			strSql += " WHERE COMP_CODE = ? 		\n";
			strSql += " ORDER BY CLSE_ACC_ID ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);

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
				GauceInfo.response.writeException("USER", "900001","CLSE_ACC_ID Select 오류-> "+ ex.getMessage());
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