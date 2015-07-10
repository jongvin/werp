<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCustCodeR_tr.jsp(고객코드)
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 최언회 작성(2005-11-28)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsCUST_ACCNO = null;
	GauceDataSet dsPAY_STOP = null;
	
	GauceDataRow[] Rows_Main = null;
	GauceDataRow[] Rows_Accno = null;
	GauceDataRow[] Rows_Paystop = null;
	
	
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
			//거래처코드
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			Rows_Main = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	Rows_Main.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (Rows_Main[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_CUST_CODE_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BOSS_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TRADE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BIZCOND", CITData.VARCHAR2);
						lrArgData.addColumn("BIZKND", CITData.VARCHAR2);
						lrArgData.addColumn("ZIPCODE", CITData.VARCHAR2);
						lrArgData.addColumn("ADDR1", CITData.VARCHAR2);
						lrArgData.addColumn("ADDR2", CITData.VARCHAR2);
						lrArgData.addColumn("TELNO", CITData.VARCHAR2);
						lrArgData.addColumn("GROUP_COMP_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REPRESENT_CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CUST_CODE", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_CODE")));
						lrArgData.setValue("CUST_NAME", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_NAME")));
						lrArgData.setValue("BOSS_NAME", Rows_Main[i].getString(dsMAIN.indexOfColumn("BOSS_NAME")));
						lrArgData.setValue("TRADE_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("TRADE_CLS")));
						lrArgData.setValue("BIZCOND", Rows_Main[i].getString(dsMAIN.indexOfColumn("BIZCOND")));
						lrArgData.setValue("BIZKND", Rows_Main[i].getString(dsMAIN.indexOfColumn("BIZKND")));
						lrArgData.setValue("ZIPCODE", Rows_Main[i].getString(dsMAIN.indexOfColumn("ZIPCODE")));
						lrArgData.setValue("ADDR1", Rows_Main[i].getString(dsMAIN.indexOfColumn("ADDR1")));
						lrArgData.setValue("ADDR2", Rows_Main[i].getString(dsMAIN.indexOfColumn("ADDR2")));
						lrArgData.setValue("TELNO", Rows_Main[i].getString(dsMAIN.indexOfColumn("TELNO")));
						lrArgData.setValue("GROUP_COMP_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("GROUP_COMP_CLS")));
						lrArgData.setValue("USE_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("USE_CLS")));
						lrArgData.setValue("REPRESENT_CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("REPRESENT_CUST_SEQ")));
					}
					else if (Rows_Main[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_CUST_CODE_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BOSS_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TRADE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BIZCOND", CITData.VARCHAR2);
						lrArgData.addColumn("BIZKND", CITData.VARCHAR2);
						lrArgData.addColumn("ZIPCODE", CITData.VARCHAR2);
						lrArgData.addColumn("ADDR1", CITData.VARCHAR2);
						lrArgData.addColumn("ADDR2", CITData.VARCHAR2);
						lrArgData.addColumn("TELNO", CITData.VARCHAR2);
						lrArgData.addColumn("GROUP_COMP_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REPRESENT_CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CUST_CODE", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_CODE")));
						lrArgData.setValue("CUST_NAME", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_NAME")));
						lrArgData.setValue("BOSS_NAME", Rows_Main[i].getString(dsMAIN.indexOfColumn("BOSS_NAME")));
						lrArgData.setValue("TRADE_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("TRADE_CLS")));
						lrArgData.setValue("BIZCOND", Rows_Main[i].getString(dsMAIN.indexOfColumn("BIZCOND")));
						lrArgData.setValue("BIZKND", Rows_Main[i].getString(dsMAIN.indexOfColumn("BIZKND")));
						lrArgData.setValue("ZIPCODE", Rows_Main[i].getString(dsMAIN.indexOfColumn("ZIPCODE")));
						lrArgData.setValue("ADDR1", Rows_Main[i].getString(dsMAIN.indexOfColumn("ADDR1")));
						lrArgData.setValue("ADDR2", Rows_Main[i].getString(dsMAIN.indexOfColumn("ADDR2")));
						lrArgData.setValue("TELNO", Rows_Main[i].getString(dsMAIN.indexOfColumn("TELNO")));
						lrArgData.setValue("GROUP_COMP_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("GROUP_COMP_CLS")));
						lrArgData.setValue("USE_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("USE_CLS")));
						lrArgData.setValue("REPRESENT_CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("REPRESENT_CUST_SEQ")));
					}
					else if (Rows_Main[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_CUST_CODE_D(?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_CUST_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
			//거래처지불계좌
	//복사시작
			dsCUST_ACCNO = GauceInfo.request.getGauceDataSet("dsCUST_ACCNO");
			
			if (dsCUST_ACCNO == null) throw new Exception("dsCUST_ACCNO이(가) 널(Null)입니다.");
			
			Rows_Accno = dsCUST_ACCNO.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	Rows_Accno.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (Rows_Accno[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_CUST_ACCNO_CODE_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TG", CITData.VARCHAR2);
						lrArgData.addColumn("OUT_ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("CLOSE_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACCNO", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("ACCNO")));
						lrArgData.setValue("SEQ", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_CODE", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("ACCNO_OWNER", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("ACCNO_CLS", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("ACCNO_CLS")));
						lrArgData.setValue("USE_TG", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("USE_TG")));
						lrArgData.setValue("OUT_ACCNO", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("OUT_ACCNO")));
						lrArgData.setValue("CLOSE_DT", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("CLOSE_DT")));
					}
					else if (Rows_Accno[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_CUST_ACCNO_CODE_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("BANK_MAIN_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_OWNER", CITData.VARCHAR2);
						lrArgData.addColumn("ACCNO_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_TG", CITData.VARCHAR2);
						lrArgData.addColumn("OUT_ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("CLOSE_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACCNO", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("ACCNO")));
						lrArgData.setValue("SEQ", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("BANK_MAIN_CODE", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("BANK_MAIN_CODE")));
						lrArgData.setValue("ACCNO_OWNER", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("ACCNO_OWNER")));
						lrArgData.setValue("ACCNO_CLS", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("ACCNO_CLS")));
						lrArgData.setValue("USE_TG", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("USE_TG")));
						lrArgData.setValue("OUT_ACCNO", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("OUT_ACCNO")));
						lrArgData.setValue("CLOSE_DT", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("CLOSE_DT")));
					}
					else if (Rows_Accno[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_CUST_ACCNO_CODE_D(?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ACCNO", CITData.VARCHAR2);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("ACCNO", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("ACCNO")));
						lrArgData.setValue("SEQ", Rows_Accno[i].getString(dsCUST_ACCNO.indexOfColumn("SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_CUST_ACCNO_CODE 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요

			
			//지불정지
			dsPAY_STOP = GauceInfo.request.getGauceDataSet("dsPAY_STOP");
			
			if (dsPAY_STOP == null) throw new Exception("dsPAY_STOP이(가) 널(Null)입니다.");
			
			Rows_Paystop = dsPAY_STOP.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	Rows_Paystop.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (Rows_Paystop[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_PAY_STOP_HISTORY_I(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("PAY_STOP_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOP_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPSTR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPEND_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPSTR_MEMO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPEND_MEMO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("PAY_STOP_SEQ", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOP_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("PAY_STOP_CLS", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOP_CLS")));
						lrArgData.setValue("PAY_STOPSTR_DT", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOPSTR_DT")));
						lrArgData.setValue("PAY_STOPEND_DT", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOPEND_DT")));
						lrArgData.setValue("PAY_STOPSTR_MEMO", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOPSTR_MEMO")));
						lrArgData.setValue("PAY_STOPEND_MEMO", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOPEND_MEMO")));
						lrArgData.setValue("DEPT_CODE", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("DEPT_CODE")));
					}
					else if (Rows_Paystop[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_PAY_STOP_HISTORY_U(?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("PAY_STOP_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOP_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPSTR_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPEND_DT", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPSTR_MEMO", CITData.VARCHAR2);
						lrArgData.addColumn("PAY_STOPEND_MEMO", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("PAY_STOP_SEQ", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOP_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("PAY_STOP_CLS", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOP_CLS")));
						lrArgData.setValue("PAY_STOPSTR_DT", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOPSTR_DT")));
						lrArgData.setValue("PAY_STOPEND_DT", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOPEND_DT")));
						lrArgData.setValue("PAY_STOPSTR_MEMO", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOPSTR_MEMO")));
						lrArgData.setValue("PAY_STOPEND_MEMO", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOPEND_MEMO")));
						lrArgData.setValue("DEPT_CODE", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("DEPT_CODE")));
					}
					else if (Rows_Paystop[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_PAY_STOP_HISTORY_D(?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("PAY_STOP_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("PAY_STOP_SEQ", Rows_Paystop[i].getString(dsPAY_STOP.indexOfColumn("PAY_STOP_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_PAY_STOP_HISTORY 테이블 데이타 갱신 에러" + ex.getMessage());
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
