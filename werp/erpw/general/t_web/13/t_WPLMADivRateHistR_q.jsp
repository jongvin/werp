<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-18)
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
			strSql  = " SELECT \n";
			strSql += " 	HIST_SEQ, \n";
			strSql += " 	NAME, \n";
			strSql += " 	F_T_DateToString(APPL_DT) APPL_DT \n";
			strSql += " FROM \n";
			strSql += " 	T_PL_MA_DVD_RAT_HIST ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("HIST_SEQ", true);
				lrReturnData.setNotNull("NAME", true);
				lrReturnData.setNotNull("APPL_DT", true);
				
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
		else if (strAct.equals("SUB01"))
		{
			String strHIST_SEQ = CITCommon.toKOR(request.getParameter("HIST_SEQ"));
			String strDVD_CODE = CITCommon.toKOR(request.getParameter("DVD_CODE"));
			
			strSql  = " SELECT \n";
			strSql += " 	A.HIST_SEQ, \n";
			strSql += " 	A.DVD_CODE, \n";
			strSql += " 	B.DVD_NAME, \n";
			strSql += " 	A.DEPT_CODE, \n";
			strSql += " 	C.DEPT_NAME, \n";
			strSql += " 	A.DVD_RAT_POSITION \n";
			strSql += " FROM \n";
			strSql += " 	T_PL_MA_DVD_RAT_LIST A, \n";
			strSql += " 	T_PL_MA_DVD_CODE B, \n";
			strSql += " 	T_DEPT_CODE_ORG C \n";
			strSql += " WHERE \n";
			strSql += " 	A.DVD_CODE = B.DVD_CODE \n";
			strSql += " 	AND A.DEPT_CODE = C.DEPT_CODE \n";
			strSql += " 	AND A.HIST_SEQ =  ?  \n";
			strSql += " 	AND A.DVD_CODE LIKE  ?  ||'%' \n";
			strSql += " ORDER BY \n";
			strSql += " 	A.HIST_SEQ, \n";
			strSql += " 	A.DVD_CODE, \n";
			strSql += " 	A.DEPT_CODE ";
			
			lrArgData.addColumn("1HIST_SEQ", CITData.VARCHAR2);
			lrArgData.addColumn("2DVD_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1HIST_SEQ", strHIST_SEQ);
			lrArgData.setValue("2DVD_CODE", strDVD_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setNotNull("HIST_SEQ", true);
				lrReturnData.setNotNull("DVD_CODE", true);
				lrReturnData.setNotNull("DVD_NAME", true);
				lrReturnData.setNotNull("DEPT_CODE", true);
				lrReturnData.setNotNull("DEPT_NAME", true);
				lrReturnData.setNotNull("DVD_RAT_POSITION", true);
				
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
		else if (strAct.equals("SEQ"))
		{
			strSql  = " Select SQ_T_DVD_RAT_HIST_SEQ.NEXTVAL SEQ From DUAL ";

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
				GauceInfo.response.writeException("USER", "900001","SLIP_IDSEQ Select 오류-> "+ ex.getMessage());
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