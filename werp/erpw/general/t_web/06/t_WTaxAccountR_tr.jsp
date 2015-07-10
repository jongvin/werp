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
	//GauceDataSet dsSUB02 = null;	

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
						strSql = "{call SP_T_ACC_TAX_BILL_MEDIA_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMMBUY_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BOOK_NO", CITData.NUMBER);
						lrArgData.addColumn("BOOK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SUPAMT", CITData.NUMBER);
						lrArgData.addColumn("VATAMT", CITData.NUMBER);
						lrArgData.addColumn("ANNULMENT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("ANNULMENT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("OUT_CNT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("MISSING_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("UDT_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_CASH_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("COMMBUY_CLS", rows[i].getString(dsSUB01.indexOfColumn("COMMBUY_CLS")));
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsSUB01.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("VAT_CODE", rows[i].getString(dsSUB01.indexOfColumn("VAT_CODE")));
						lrArgData.setValue("BOOK_NO", rows[i].getString(dsSUB01.indexOfColumn("BOOK_NO")));
						lrArgData.setValue("BOOK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("BOOK_SEQ")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("SUPAMT", rows[i].getString(dsSUB01.indexOfColumn("SUPAMT")));
						lrArgData.setValue("VATAMT", rows[i].getString(dsSUB01.indexOfColumn("VATAMT")));
						lrArgData.setValue("ANNULMENT_CLS", rows[i].getString(dsSUB01.indexOfColumn("ANNULMENT_CLS")));
						lrArgData.setValue("ANNULMENT_DT", rows[i].getString(dsSUB01.indexOfColumn("ANNULMENT_DT")));
						lrArgData.setValue("OUT_CNT", rows[i].getString(dsSUB01.indexOfColumn("OUT_CNT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("MISSING_TAG", rows[i].getString(dsSUB01.indexOfColumn("MISSING_TAG")));
						lrArgData.setValue("REMARK", rows[i].getString(dsSUB01.indexOfColumn("REMARK")));
						lrArgData.setValue("UDT_TAG", rows[i].getString(dsSUB01.indexOfColumn("UDT_TAG")));
						lrArgData.setValue("CARD_CASH_NO", rows[i].getString(dsSUB01.indexOfColumn("CARD_CASH_NO")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_ACC_TAX_BILL_MEDIA_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("TAX_COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("COMMBUY_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("PUBL_DT", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("BOOK_NO", CITData.NUMBER);
						lrArgData.addColumn("BOOK_SEQ", CITData.NUMBER);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SUPAMT", CITData.NUMBER);
						lrArgData.addColumn("VATAMT", CITData.NUMBER);
						lrArgData.addColumn("ANNULMENT_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("ANNULMENT_DT", CITData.VARCHAR2);
						lrArgData.addColumn("OUT_CNT", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("MISSING_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARK", CITData.VARCHAR2);
						lrArgData.addColumn("UDT_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("CARD_CASH_NO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("TAX_COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("TAX_COMP_CODE")));
						lrArgData.setValue("COMMBUY_CLS", rows[i].getString(dsSUB01.indexOfColumn("COMMBUY_CLS")));
						lrArgData.setValue("PUBL_DT", rows[i].getString(dsSUB01.indexOfColumn("PUBL_DT")));
						lrArgData.setValue("VAT_CODE", rows[i].getString(dsSUB01.indexOfColumn("VAT_CODE")));
						lrArgData.setValue("BOOK_NO", rows[i].getString(dsSUB01.indexOfColumn("BOOK_NO")));
						lrArgData.setValue("BOOK_SEQ", rows[i].getString(dsSUB01.indexOfColumn("BOOK_SEQ")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsSUB01.indexOfColumn("DEPT_CODE")));
						lrArgData.setValue("CUST_SEQ", rows[i].getString(dsSUB01.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("SUPAMT", rows[i].getString(dsSUB01.indexOfColumn("SUPAMT")));
						lrArgData.setValue("VATAMT", rows[i].getString(dsSUB01.indexOfColumn("VATAMT")));
						lrArgData.setValue("ANNULMENT_CLS", rows[i].getString(dsSUB01.indexOfColumn("ANNULMENT_CLS")));
						lrArgData.setValue("ANNULMENT_DT", rows[i].getString(dsSUB01.indexOfColumn("ANNULMENT_DT")));
						lrArgData.setValue("OUT_CNT", rows[i].getString(dsSUB01.indexOfColumn("OUT_CNT")));
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsSUB01.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsSUB01.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("MISSING_TAG", rows[i].getString(dsSUB01.indexOfColumn("MISSING_TAG")));
						lrArgData.setValue("REMARK", rows[i].getString(dsSUB01.indexOfColumn("REMARK")));
						lrArgData.setValue("UDT_TAG", rows[i].getString(dsSUB01.indexOfColumn("UDT_TAG")));
						lrArgData.setValue("CARD_CASH_NO", rows[i].getString(dsSUB01.indexOfColumn("CARD_CASH_NO")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_ACC_TAX_BILL_MEDIA_D(?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_NO", CITData.NUMBER);
						lrArgData.addColumn("SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsSUB01.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("WORK_NO", rows[i].getString(dsSUB01.indexOfColumn("WORK_NO")));
						lrArgData.setValue("SEQ", rows[i].getString(dsSUB01.indexOfColumn("SEQ")));
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
