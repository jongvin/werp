<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCardCodeR_tr.jsp(신용카드관리)
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-25)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsSUB01 = null;
	
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
						strSql = "{call SP_T_ACC_CREDCARD_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CARD_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CARDNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_DATE", CITData.NUMBER);
						lrArgData.addColumn("EXPR_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("LIMIT_AMT", CITData.NUMBER);
						lrArgData.addColumn("USE_TG", CITData.VARCHAR2);
						lrArgData.addColumn("UNUSED_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CARD_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CARD_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CARDNO", rows[i].getString(dsMAIN.indexOfColumn("CARDNO")));
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CARD_NAME", rows[i].getString(dsMAIN.indexOfColumn("CARD_NAME")));
						lrArgData.setValue("CARD_CLS", rows[i].getString(dsMAIN.indexOfColumn("CARD_CLS")));
						lrArgData.setValue("CARD_OWNER", rows[i].getString(dsMAIN.indexOfColumn("CARD_OWNER")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsMAIN.indexOfColumn("ACCNO")));
						lrArgData.setValue("PAY_DATE", rows[i].getString(dsMAIN.indexOfColumn("PAY_DATE")));
						lrArgData.setValue("EXPR_MONTH", rows[i].getString(dsMAIN.indexOfColumn("EXPR_MONTH")));
						lrArgData.setValue("LIMIT_AMT", rows[i].getString(dsMAIN.indexOfColumn("LIMIT_AMT")));
						lrArgData.setValue("USE_TG", rows[i].getString(dsMAIN.indexOfColumn("USE_TG")));
						lrArgData.setValue("UNUSED_DT", rows[i].getString(dsMAIN.indexOfColumn("UNUSED_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_CREDCARD_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CARD_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CARDNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_DATE", CITData.NUMBER);
						lrArgData.addColumn("EXPR_MONTH", CITData.VARCHAR2);
						lrArgData.addColumn("LIMIT_AMT", CITData.NUMBER);
						lrArgData.addColumn("USE_TG", CITData.VARCHAR2);
						lrArgData.addColumn("UNUSED_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CARD_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CARD_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CARDNO", rows[i].getString(dsMAIN.indexOfColumn("CARDNO")));
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("CARD_NAME", rows[i].getString(dsMAIN.indexOfColumn("CARD_NAME")));
						lrArgData.setValue("CARD_CLS", rows[i].getString(dsMAIN.indexOfColumn("CARD_CLS")));
						lrArgData.setValue("CARD_OWNER", rows[i].getString(dsMAIN.indexOfColumn("CARD_OWNER")));
						lrArgData.setValue("BANK_CODE", rows[i].getString(dsMAIN.indexOfColumn("BANK_CODE")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsMAIN.indexOfColumn("ACCNO")));
						lrArgData.setValue("PAY_DATE", rows[i].getString(dsMAIN.indexOfColumn("PAY_DATE")));
						lrArgData.setValue("EXPR_MONTH", rows[i].getString(dsMAIN.indexOfColumn("EXPR_MONTH")));
						lrArgData.setValue("LIMIT_AMT", rows[i].getString(dsMAIN.indexOfColumn("LIMIT_AMT")));
						lrArgData.setValue("USE_TG", rows[i].getString(dsMAIN.indexOfColumn("USE_TG")));
						lrArgData.setValue("UNUSED_DT", rows[i].getString(dsMAIN.indexOfColumn("UNUSED_DT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACC_CREDCARD_D(?)}";
						
						lrArgData.addColumn("CARD_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CARD_SEQ", rows[i].getString(dsMAIN.indexOfColumn("CARD_SEQ")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_ACC_CREDCARD 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			
			if (dsSUB01 == null) throw new Exception("dsSUB01이(가) 널(Null)입니다.");
			
			rows = dsSUB01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_CARD_MEMBER_HISTORY_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CARD_SEQ", CITData.NUMBER);
						lrArgData.addColumn("USESTARTDATE", CITData.VARCHAR2);
						lrArgData.addColumn("USEENDDATE", CITData.VARCHAR2);
						lrArgData.addColumn("CARDNUMBER", CITData.VARCHAR2);
						lrArgData.addColumn("CARDOWNEREMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("CARDSUBSTITUTEEMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHANGEREASON", CITData.VARCHAR2);
						lrArgData.addColumn("FIRSTREGISTEREMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("FIRSTREGISTERDATE", CITData.VARCHAR2);
						lrArgData.addColumn("LASTMODIFYEMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("LASTMODIFYDATE", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE1", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE2", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE3", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CARD_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CARD_SEQ")));
						lrArgData.setValue("USESTARTDATE", rows[i].getString(dsSUB01.indexOfColumn("USESTARTDATE")));
						lrArgData.setValue("USEENDDATE", rows[i].getString(dsSUB01.indexOfColumn("USEENDDATE")));
						lrArgData.setValue("CARDNUMBER", rows[i].getString(dsSUB01.indexOfColumn("CARDNUMBER")));
						lrArgData.setValue("CARDOWNEREMPNO", rows[i].getString(dsSUB01.indexOfColumn("CARDOWNEREMPNO")));
						lrArgData.setValue("CARDSUBSTITUTEEMPNO", rows[i].getString(dsSUB01.indexOfColumn("CARDSUBSTITUTEEMPNO")));
						lrArgData.setValue("CHANGEREASON", rows[i].getString(dsSUB01.indexOfColumn("CHANGEREASON")));
						lrArgData.setValue("FIRSTREGISTEREMPNO", strUserNo);
						lrArgData.setValue("FIRSTREGISTERDATE", rows[i].getString(dsSUB01.indexOfColumn("FIRSTREGISTERDATE")));
						lrArgData.setValue("LASTMODIFYEMPNO", strUserNo);
						lrArgData.setValue("LASTMODIFYDATE", rows[i].getString(dsSUB01.indexOfColumn("LASTMODIFYDATE")));
						lrArgData.setValue("ATTRIBUTE1", rows[i].getString(dsSUB01.indexOfColumn("ATTRIBUTE1")));
						lrArgData.setValue("ATTRIBUTE2", rows[i].getString(dsSUB01.indexOfColumn("ATTRIBUTE2")));
						lrArgData.setValue("ATTRIBUTE3", rows[i].getString(dsSUB01.indexOfColumn("ATTRIBUTE3")));
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsSUB01.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsSUB01.indexOfColumn("ACCNO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB01.indexOfColumn("ACCNO_OWNER")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_CARD_MEMBER_HISTORY_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CARD_SEQ", CITData.NUMBER);
						lrArgData.addColumn("USESTARTDATE", CITData.VARCHAR2);
						lrArgData.addColumn("USEENDDATE", CITData.VARCHAR2);
						lrArgData.addColumn("CARDNUMBER", CITData.VARCHAR2);
						lrArgData.addColumn("CARDOWNEREMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("CARDSUBSTITUTEEMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("CHANGEREASON", CITData.VARCHAR2);
						lrArgData.addColumn("FIRSTREGISTEREMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("FIRSTREGISTERDATE", CITData.VARCHAR2);
						lrArgData.addColumn("LASTMODIFYEMPNO", CITData.VARCHAR2);
						lrArgData.addColumn("LASTMODIFYDATE", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE1", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE2", CITData.VARCHAR2);
						lrArgData.addColumn("ATTRIBUTE3", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CARD_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CARD_SEQ")));
						lrArgData.setValue("USESTARTDATE", rows[i].getString(dsSUB01.indexOfColumn("USESTARTDATE")));
						lrArgData.setValue("USEENDDATE", rows[i].getString(dsSUB01.indexOfColumn("USEENDDATE")));
						lrArgData.setValue("CARDNUMBER", rows[i].getString(dsSUB01.indexOfColumn("CARDNUMBER")));
						lrArgData.setValue("CARDOWNEREMPNO", rows[i].getString(dsSUB01.indexOfColumn("CARDOWNEREMPNO")));
						lrArgData.setValue("CARDSUBSTITUTEEMPNO", rows[i].getString(dsSUB01.indexOfColumn("CARDSUBSTITUTEEMPNO")));
						lrArgData.setValue("CHANGEREASON", rows[i].getString(dsSUB01.indexOfColumn("CHANGEREASON")));
						lrArgData.setValue("FIRSTREGISTEREMPNO", strUserNo);
						lrArgData.setValue("FIRSTREGISTERDATE", rows[i].getString(dsSUB01.indexOfColumn("FIRSTREGISTERDATE")));
						lrArgData.setValue("LASTMODIFYEMPNO", strUserNo);
						lrArgData.setValue("LASTMODIFYDATE", rows[i].getString(dsSUB01.indexOfColumn("LASTMODIFYDATE")));
						lrArgData.setValue("ATTRIBUTE1", rows[i].getString(dsSUB01.indexOfColumn("ATTRIBUTE1")));
						lrArgData.setValue("ATTRIBUTE2", rows[i].getString(dsSUB01.indexOfColumn("ATTRIBUTE2")));
						lrArgData.setValue("ATTRIBUTE3", rows[i].getString(dsSUB01.indexOfColumn("ATTRIBUTE3")));
						lrArgData.setValue("BANK_MAIN_CODE", rows[i].getString(dsSUB01.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("ACCNO", rows[i].getString(dsSUB01.indexOfColumn("ACCNO")));
						lrArgData.setValue("ACCNO_OWNER", rows[i].getString(dsSUB01.indexOfColumn("ACCNO_OWNER")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_CARD_MEMBER_HISTORY_D(?,?)}";
						
						lrArgData.addColumn("CARD_SEQ", CITData.NUMBER);
						lrArgData.addColumn("USESTARTDATE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CARD_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CARD_SEQ")));
						lrArgData.setValue("USESTARTDATE", rows[i].getString(dsSUB01.indexOfColumn("USESTARTDATE")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_CARD_MEMBER_HISTORY 테이블 데이타 갱신 에러" + ex.getMessage());
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
