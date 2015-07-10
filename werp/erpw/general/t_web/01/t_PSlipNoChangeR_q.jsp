<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSlipR_q.jsp(전표등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-21)
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
		
		if (strAct.equals("EXEC_PROC"))
		{
			strSql  = " SELECT \n";
			strSql += " 	'                    ' CMD, \n";
			strSql += " 	'                    ' SLIP_ID, \n";
			strSql += " 	'                    ' KEEP_SLIPNO, \n";
			strSql += " 	'                    ' KEEP_DT, \n";
			strSql += " 	'                    ' DEPT_CODE, \n";
			strSql += " 	'                    ' KEEP_KEEPER	 \n";
			strSql += " FROM \n";
			strSql += " 	DUAL ";
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("BUDG_CODE_NO", true);

				
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
		else if (strAct.equals("MAIN"))
		{
			String strSLIP_ID = CITCommon.toKOR(request.getParameter("SLIP_ID"));
			strSql  = "SELECT \n";
			strSql += " MAKE_COMP_CODE, \n";
			strSql += " MAKE_DT_TRANS, \n";
			strSql += " F_T_DateToString(MAKE_DT) MAKE_DT, \n";
			strSql += " SLIP_KIND_TAG, \n";
			strSql += "	MAKE_SEQ	 \n";
			strSql += "FROM \n";
			strSql += "	T_ACC_SLIP_HEAD \n";
			strSql += "WHERE \n";
			strSql += "	SLIP_ID = ?  \n";

			lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("SLIP_ID", strSLIP_ID);
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