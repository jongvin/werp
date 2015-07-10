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
					
					strSql = "{call SP_BILL_PAY_REQ_UPDATE(?,?,?)}";
																
					lrArgData.addColumn("PROC_GUBUN", CITData.VARCHAR2);
					lrArgData.addColumn("PAY_SEQ", CITData.NUMBER);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("PROC_GUBUN", "CREATE");										
					lrArgData.setValue("PAY_SEQ", rows[i].getString(dsCOPY.indexOfColumn("PAY_SEQ")));
					lrArgData.setValue("EMP_NO", strUserNo);

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "생성요청여부(CREATE) 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}				

			try
			{				
				CITData lrArgData = new CITData();

				strSql = "{call SP_CREATE_BILL_EDI_FILE(?,?,?,?,?,?,?)}";	
				
				lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("PAY_GUBUN", CITData.VARCHAR2);
				lrArgData.addColumn("PAY_YMD", CITData.VARCHAR2);
				lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("ACCOUNT_NO", CITData.VARCHAR2);
				lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
				lrArgData.addColumn("RET_MSG", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("COMP_CODE", rows[0].getString(dsCOPY.indexOfColumn("COMP_CODE")));
				lrArgData.setValue("PAY_GUBUN", rows[0].getString(dsCOPY.indexOfColumn("PAY_GUBUN")));
				lrArgData.setValue("PAY_YMD",rows[0].getString(dsCOPY.indexOfColumn("PAY_YMD")));
				lrArgData.setValue("BANK_CODE",rows[0].getString(dsCOPY.indexOfColumn("BANK_CODE")));
		    lrArgData.setValue("ACCOUNT_NO",rows[0].getString(dsCOPY.indexOfColumn("ACCOUNT_NO")));
				lrArgData.setValue("EMP_NO",strUserNo );
				lrArgData.setValue("RET_MSG", "");	
				
				CITDatabase.executeProcedure(strSql, lrArgData, conn);		
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "EDI파일생성요청여부 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}								

			try
			{								
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_BILL_PAY_REQ_UPDATE(?,?,?)}";
																
					lrArgData.addColumn("PROC_GUBUN", CITData.VARCHAR2);
					lrArgData.addColumn("PAY_SEQ", CITData.NUMBER);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("PROC_GUBUN", "FINISH");										
					lrArgData.setValue("PAY_SEQ", rows[i].getString(dsCOPY.indexOfColumn("PAY_SEQ")));
					lrArgData.setValue("EMP_NO", strUserNo);

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}										
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "생성요청여부(FINISH) 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if (strAct.equals("COPY2"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_DELETE_BILL_EDI_FILE(?,?)}";
																
					lrArgData.addColumn("EDI_SEQ", CITData.VARCHAR2);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("EDI_SEQ", rows[i].getString(dsCOPY.indexOfColumn("PAY_SEQ")));							
					lrArgData.setValue("EMP_NO", strUserNo);

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "파일삭제 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}				
		}
		else if (strAct.equals("COPY3"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_BILL_SEND_FILE(?,?,?,?,?)}";
																				
					lrArgData.addColumn("FILE_NAME", CITData.VARCHAR2);
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("EDI_SEQ", CITData.VARCHAR2);
					lrArgData.addColumn("PAY_YMD", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("FILE_NAME", rows[i].getString(dsCOPY.indexOfColumn("FILE_NAME")));
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCOPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("BANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("BANK_CODE")));
					lrArgData.setValue("EDI_SEQ", rows[i].getString(dsCOPY.indexOfColumn("PAY_SEQ")));
					lrArgData.setValue("PAY_YMD", rows[i].getString(dsCOPY.indexOfColumn("PAY_YMD")));

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "파일송신에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}				
		}
		else if (strAct.equals("COPY4"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_READ_BILL_RESULT(?,?)}";
																				
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
//					lrArgData.addColumn("FILE_NAME", CITData.VARCHAR2);
//					lrArgData.addColumn("EDI_SEQ", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCOPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("BANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("BANK_CODE")));					
//					lrArgData.setValue("FILE_NAME", rows[i].getString(dsCOPY.indexOfColumn("FILE_NAME")));
//					lrArgData.setValue("EDI_SEQ", rows[i].getString(dsCOPY.indexOfColumn("PAY_SEQ")));

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}			
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "처리결과수신 에러" + ex.getMessage());
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
