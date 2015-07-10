<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
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

			
			strSql  = " Select  \n";
			strSql += " 	a.SEQ_TYPE,  \n";
			strSql += " 	To_Char(a.CRTUSERNO) CRTUSERNO ,  \n";
			strSql += " 	a.CRTDATE ,  \n";
			strSql += " 	To_Char(a.MODUSERNO) MODUSERNO ,  \n";
			strSql += " 	a.MODDATE,  \n";
			strSql += " 	a.SEQ_TYPE_NAME  \n";
			strSql += " From	T_SHEET_SEQ_TYPE a  \n";
			strSql += " Order By  \n";
			strSql += " 	a.SEQ_TYPE \n";
			strSql += "  ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SEQ_TYPE", true);
				lrReturnData.setNotNull("SEQ_TYPE_NAME", true);
				
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
			String strSEQ_TYPE = CITCommon.toKOR(request.getParameter("SEQ_TYPE"));
			
			strSql  = " Select \n";
			strSql += " 	a.SEQ_TYPE , \n";
			strSql += " 	a.SEQ_SEQ , \n";
			strSql += " 	a.SEQ_TYPE_NAME , \n";
			strSql += " 	To_Char(a.CRTUSERNO) CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	To_Char(a.MODUSERNO) MODUSERNO , \n";
			strSql += " 	a.MODDATE \n";
			strSql += " From	T_SHEET_SEQ_TYPE_NAME a \n";
			strSql += " Where	a.SEQ_TYPE =   ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.SEQ_TYPE , \n";
			strSql += " 	a.SEQ_SEQ \n";
			strSql += "  ";
			
			lrArgData.addColumn("SEQ_TYPE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("SEQ_TYPE", strSEQ_TYPE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SEQ_TYPE", true);
				lrReturnData.setKey("SEQ_SEQ", true);
				lrReturnData.setNotNull("SEQ_TYPE_NAME", true);
				
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