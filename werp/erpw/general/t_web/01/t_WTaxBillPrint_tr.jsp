<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-18)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsSUB01 = null;
	GauceDataSet dsSUB02 = null;	

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
	//복사시작
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
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						if ( "INSERT".equals( rows[i].getString(dsSUB01.indexOfColumn("TB_JOB")) ) )
						{
							strSql = "{call SP_T_TAX_BILL_HEAD_I(?,?,?,?,?,?)}";
							
							lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
							lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
							lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
							lrArgData.addColumn("BOOK_NO", CITData.NUMBER);
							lrArgData.addColumn("BOOK_SEQ", CITData.NUMBER);
							lrArgData.addColumn("SER_NO", CITData.VARCHAR2);

							lrArgData.addRow();
							lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
							lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
							lrArgData.setValue("CRTUSERNO", strUserNo);
							lrArgData.setValue("BOOK_NO", rows[i].getString(dsSUB01.indexOfColumn("BOOK_NO")));
							lrArgData.setValue("BOOK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("BOOK_SEQ")));
							lrArgData.setValue("SER_NO", rows[i].getString(dsSUB01.indexOfColumn("SER_NO")));
						}
						else if ( "UPDATE".equals( rows[i].getString(dsSUB01.indexOfColumn("TB_JOB")) ) )
						{
							strSql = "{call SP_T_TAX_BILL_HEAD_U(?,?,?,?,?,?)}";
							
							lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
							lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
							lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
							lrArgData.addColumn("BOOK_NO", CITData.NUMBER);
							lrArgData.addColumn("BOOK_SEQ", CITData.NUMBER);
							lrArgData.addColumn("SER_NO", CITData.VARCHAR2);

							lrArgData.addRow();
							lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
							lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
							lrArgData.setValue("MODUSERNO", strUserNo);
							lrArgData.setValue("BOOK_NO", rows[i].getString(dsSUB01.indexOfColumn("BOOK_NO")));
							lrArgData.setValue("BOOK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("BOOK_SEQ")));
							lrArgData.setValue("SER_NO", rows[i].getString(dsSUB01.indexOfColumn("SER_NO")));
						}
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_TAX_BILL_HEAD_D(?,?)}";
						
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_TAX_BILL_HEAD 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요
	//복사시작
			dsSUB02 = GauceInfo.request.getGauceDataSet("dsSUB02");
			
			if (dsSUB02 == null) throw new Exception("dsSUB02이(가) 널(Null)입니다.");
			
			rows = dsSUB02.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_TAX_BILL_BODY_I(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("BODY_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_SIZE", CITData.VARCHAR2);
						lrArgData.addColumn("CNT", CITData.NUMBER);
						lrArgData.addColumn("UCOST", CITData.NUMBER);
						lrArgData.addColumn("SUPAMT", CITData.NUMBER);
						lrArgData.addColumn("VATAMT", CITData.NUMBER);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB02.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB02.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("BODY_SEQ", rows[i].getString(dsSUB02.indexOfColumn("BODY_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsSUB02.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("ITEM", rows[i].getString(dsSUB02.indexOfColumn("ITEM")));
						lrArgData.setValue("ITEM_SIZE", rows[i].getString(dsSUB02.indexOfColumn("ITEM_SIZE")));
						lrArgData.setValue("CNT", rows[i].getString(dsSUB02.indexOfColumn("CNT")));
						lrArgData.setValue("UCOST", rows[i].getString(dsSUB02.indexOfColumn("UCOST")));
						lrArgData.setValue("SUPAMT", rows[i].getString(dsSUB02.indexOfColumn("SUPAMT")));
						lrArgData.setValue("VATAMT", rows[i].getString(dsSUB02.indexOfColumn("VATAMT")));
						lrArgData.setValue("REMARK", rows[i].getString(dsSUB02.indexOfColumn("REMARK")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_TAX_BILL_BODY_U(?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("BODY_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_SIZE", CITData.VARCHAR2);
						lrArgData.addColumn("CNT", CITData.NUMBER);
						lrArgData.addColumn("UCOST", CITData.NUMBER);
						lrArgData.addColumn("SUPAMT", CITData.NUMBER);
						lrArgData.addColumn("VATAMT", CITData.NUMBER);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB02.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB02.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("BODY_SEQ", rows[i].getString(dsSUB02.indexOfColumn("BODY_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsSUB02.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("ITEM", rows[i].getString(dsSUB02.indexOfColumn("ITEM")));
						lrArgData.setValue("ITEM_SIZE", rows[i].getString(dsSUB02.indexOfColumn("ITEM_SIZE")));
						lrArgData.setValue("CNT", rows[i].getString(dsSUB02.indexOfColumn("CNT")));
						lrArgData.setValue("UCOST", rows[i].getString(dsSUB02.indexOfColumn("UCOST")));
						lrArgData.setValue("SUPAMT", rows[i].getString(dsSUB02.indexOfColumn("SUPAMT")));
						lrArgData.setValue("VATAMT", rows[i].getString(dsSUB02.indexOfColumn("VATAMT")));
						lrArgData.setValue("REMARK", rows[i].getString(dsSUB02.indexOfColumn("REMARK")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_TAX_BILL_BODY_D(?,?,?)}";
						
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("BODY_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB02.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB02.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("BODY_SEQ", rows[i].getString(dsSUB02.indexOfColumn("BODY_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_TAX_BILL_BODY 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요


	//여기에 붙여넣으세요
		}

		else if ("PRINT01".equals(strAct))
		{
			CITData lrArgData = new CITData();

			strSql = "{call SP_T_WORK_REPORT_D_ALL(?)}";

			lrArgData.addColumn("PAGE_ID", CITData.VARCHAR2);

			lrArgData.addRow();
			lrArgData.setValue("PAGE_ID",  "["+strUserNo+"]"+"t_WTaxBillPrint");

			CITDatabase.executeProcedure(strSql, lrArgData);
	//복사시작
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			
			if (dsSUB01 == null) throw new Exception("dsSUB01이(가) 널(Null)입니다.");
			
			rows = dsSUB01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					lrArgData = new CITData();
					
					if ("T".equals(rows[i].getString(dsSUB01.indexOfColumn("CHK_CLS"))))
					{
						strSql = "{call SP_T_WORK_REPORT_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("PAGE_ID", CITData.VARCHAR2);
						lrArgData.addColumn("JOB_SEQ", CITData.NUMBER);
						lrArgData.addColumn("COL_NAME01", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE01", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME02", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE02", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME03", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE03", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME04", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE04", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME05", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE05", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME06", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE06", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME07", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE07", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME08", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE08", CITData.VARCHAR2);
						lrArgData.addColumn("COL_NAME09", CITData.VARCHAR2);
						lrArgData.addColumn("COL_VALUE09", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("PAGE_ID", "["+strUserNo+"]"+"t_WTaxBillPrint");
						lrArgData.setValue("JOB_SEQ", "-1");
						lrArgData.setValue("COL_NAME01", "SLIP_ID");
						lrArgData.setValue("COL_VALUE01", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("COL_NAME02", "SLIP_IDSEQ");
						lrArgData.setValue("COL_VALUE02", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("COL_NAME03", "");
						lrArgData.setValue("COL_VALUE03", "");
						lrArgData.setValue("COL_NAME04", "");
						lrArgData.setValue("COL_VALUE04", "");
						lrArgData.setValue("COL_NAME05", "");
						lrArgData.setValue("COL_VALUE05", "");
						lrArgData.setValue("COL_NAME06", "");
						lrArgData.setValue("COL_VALUE06", "");
						lrArgData.setValue("COL_NAME07", "");
						lrArgData.setValue("COL_VALUE07", "");
						lrArgData.setValue("COL_NAME08", "");
						lrArgData.setValue("COL_VALUE08", "");
						lrArgData.setValue("COL_NAME09", "");
						lrArgData.setValue("COL_VALUE09", "");
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_ACC_TAX_BILL_MEDIA 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요
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
