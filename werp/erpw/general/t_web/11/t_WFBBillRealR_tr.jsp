<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsCOPY = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if(strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_SEND_BILL_TRANSFER(?,?,?,?,?,?,?,?,?,?,?)}";
							         
					lrArgData.addColumn("PAY_SEQ", CITData.NUMBER);
					lrArgData.addColumn("OUT_BANK_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("NAIVE_OUT_ACCOUNT_NO", CITData.VARCHAR2);
					lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("ACCOUNT_NO", CITData.VARCHAR2);
					lrArgData.addColumn("REGIST_NUM", CITData.VARCHAR2);
					lrArgData.addColumn("CHECK_NO", CITData.VARCHAR2);
					lrArgData.addColumn("FUTURE_YMD", CITData.VARCHAR2);
					lrArgData.addColumn("PAY_AMT", CITData.NUMBER);
					lrArgData.addColumn("FRANCHISE_NO", CITData.VARCHAR2);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("PAY_SEQ", rows[i].getString(dsCOPY.indexOfColumn("PAY_SEQ")));
					lrArgData.setValue("OUT_BANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("OUT_BANK_CODE")));
					lrArgData.setValue("NAIVE_OUT_ACCOUNT_NO", rows[i].getString(dsCOPY.indexOfColumn("OUT_ACCOUNT_NO")));
					lrArgData.setValue("BANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("BANK_CODE")));
					lrArgData.setValue("ACCOUNT_NO", rows[i].getString(dsCOPY.indexOfColumn("ACCOUNT_NO")));
					lrArgData.setValue("REGIST_NUM", rows[i].getString(dsCOPY.indexOfColumn("REGIST_NUM")));
					lrArgData.setValue("CHECK_NO", rows[i].getString(dsCOPY.indexOfColumn("CHECK_NO")));
					lrArgData.setValue("FUTURE_YMD", rows[i].getString(dsCOPY.indexOfColumn("FUTURE_YMD")));
					lrArgData.setValue("PAY_AMT", rows[i].getString(dsCOPY.indexOfColumn("PAY_AMT")));
					lrArgData.setValue("FRANCHISE_NO", rows[i].getString(dsCOPY.indexOfColumn("FRANCHISE_NO")));
					lrArgData.setValue("EMP_NO", strUserNo);

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "발행송신 처리 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
	conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>
