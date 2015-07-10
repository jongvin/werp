<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-17)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_BANK_CODE_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("CURACCT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CURACCT_MAX_AMT", CITData.NUMBER);
						lrArgData.addColumn("HSELL_USE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("BANK_NAME", rows[i].getString(dsMAIN.indexOfColumn("BANK_NAME")));
						lrArgData.setValue("CURACCT_CLS", rows[i].getString(dsMAIN.indexOfColumn("CURACCT_CLS")));
						lrArgData.setValue("BILL_CLS", rows[i].getString(dsMAIN.indexOfColumn("BILL_CLS")));
						lrArgData.setValue("CURACCT_MAX_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURACCT_MAX_AMT")));
						lrArgData.setValue("HSELL_USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("HSELL_USE_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_BANK_CODE_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("CURACCT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BILL_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CURACCT_MAX_AMT", CITData.NUMBER);
						lrArgData.addColumn("HSELL_USE_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("BANK_NAME", rows[i].getString(dsMAIN.indexOfColumn("BANK_NAME")));
						lrArgData.setValue("CURACCT_CLS", rows[i].getString(dsMAIN.indexOfColumn("CURACCT_CLS")));
						lrArgData.setValue("BILL_CLS", rows[i].getString(dsMAIN.indexOfColumn("BILL_CLS")));
						lrArgData.setValue("CURACCT_MAX_AMT", rows[i].getString(dsMAIN.indexOfColumn("CURACCT_MAX_AMT")));
						lrArgData.setValue("HSELL_USE_CLS", rows[i].getString(dsMAIN.indexOfColumn("HSELL_USE_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_BANK_CODE_D(?)}";
						
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BANK_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
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
