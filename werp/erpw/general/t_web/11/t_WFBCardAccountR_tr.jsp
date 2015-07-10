<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-02-22)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(시작)
	GauceDataSet dsMAIN = null;
	GauceDataSet dsCOPY = null;
	//Dataset이 여러개이면 이부분을 복사에 붙이셔요(끝)
	//Dataset이 여러개이면 아래 나타나는 부분중 '//복사시작' 에서 '//복사끝' 까지를 기존 갱신 페이지의 '//여기에 붙여넣으세요' 자리에 붙여넣으세요
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	String strNAME = "";
	Connection conn = null;

	String strSLIP_ID = "";
	String strAUTO_FBS_CARD_ACNT_SEQ = "";
	String strMAKE_DT = "";
	String strSLIP_KIND_TAG	= "";
	String strMAKE_COMP_CODE = "";
	
	String strMAKE_DEPT_CODE = "";
	String strCHARGE_PERS = "";
	String strINOUT_DEPT_CODE = "";
	String strPAYHOPEDATE = "";

	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strNAME = CITCommon.toKOR((String)session.getAttribute("name"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		//if (CITCommon.isNull(strAct))
		{
	//복사시작
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_CARD_ACCOUNTING_DETAIL(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CARDNUMBER", CITData.VARCHAR2);
						lrArgData.addColumn("ADJUSTYEARMONTH", CITData.VARCHAR2);
						lrArgData.addColumn("ACCTSUBSEQ", CITData.NUMBER);
						lrArgData.addColumn("SUPPLYAMT", CITData.NUMBER);
						lrArgData.addColumn("VATAMT", CITData.NUMBER);
						lrArgData.addColumn("USAGEGUBUN", CITData.VARCHAR2);
						lrArgData.addColumn("PAYHOPEDATE", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("VAT_ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("CARDNUMBER", rows[i].getString(dsMAIN.indexOfColumn("CARDNUMBER")));
						lrArgData.setValue("ADJUSTYEARMONTH", rows[i].getString(dsMAIN.indexOfColumn("ADJUSTYEARMONTH")));
						lrArgData.setValue("ACCTSUBSEQ", rows[i].getString(dsMAIN.indexOfColumn("ACCTSUBSEQ")));
						lrArgData.setValue("SUPPLYAMT", rows[i].getString(dsMAIN.indexOfColumn("SUPPLYAMT")));
						lrArgData.setValue("VATAMT", rows[i].getString(dsMAIN.indexOfColumn("VATAMT")));
						lrArgData.setValue("USAGEGUBUN", rows[i].getString(dsMAIN.indexOfColumn("USAGEGUBUN")));
						lrArgData.setValue("PAYHOPEDATE", rows[i].getString(dsMAIN.indexOfColumn("PAYHOPEDATE")));
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("VAT_ACC_CODE", rows[i].getString(dsMAIN.indexOfColumn("VAT_ACC_CODE")));
						lrArgData.setValue("DEPT_CODE", rows[i].getString(dsMAIN.indexOfColumn("DEPT_CODE")));
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
				GauceInfo.response.writeException("USER", "900001", "T_CARD_ACCOUNTING 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//복사끝
	//여기에 붙여넣으세요
		}

		if (CITCommon.isNull(strAct))
		{
		}
		else if(strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_CARD_ACCOUNTING(?,?,?)}";
																
					lrArgData.addColumn("CARDNUMBER", CITData.VARCHAR2);
					lrArgData.addColumn("ADJUSTYEARMONTH", CITData.VARCHAR2);
					lrArgData.addColumn("ACCTSUBSEQ", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("CARDNUMBER", rows[i].getString(dsCOPY.indexOfColumn("CARDNUMBER")));
					lrArgData.setValue("ADJUSTYEARMONTH", rows[i].getString(dsCOPY.indexOfColumn("ADJUSTYEARMONTH")));
					lrArgData.setValue("ACCTSUBSEQ", rows[i].getString(dsCOPY.indexOfColumn("ACCTSUBSEQ")));

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "신규잔액조회 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(strAct.equals("AUTO_FBS_CARD_ACNT"))
		{
			strAUTO_FBS_CARD_ACNT_SEQ = GauceInfo.request.getParameter("AUTO_FBS_CARD_ACNT_SEQ");
			strMAKE_DT	= GauceInfo.request.getParameter("SLIP_MAKE_DT");
			strSLIP_KIND_TAG	= GauceInfo.request.getParameter("SLIP_KIND_TAG");
			strMAKE_COMP_CODE	= GauceInfo.request.getParameter("SLIP_MAKE_COMP_CODE");

			strMAKE_DEPT_CODE	= GauceInfo.request.getParameter("SLIP_MAKE_DEPT_CODE");
			strCHARGE_PERS		= GauceInfo.request.getParameter("SLIP_CHARGE_PERS");
			strINOUT_DEPT_CODE	= GauceInfo.request.getParameter("SLIP_INOUT_DEPT_CODE");

			strPAYHOPEDATE	= GauceInfo.request.getParameter("PAYHOPEDATE");

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
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						if( "T".equals( rows[i].getString(dsMAIN.indexOfColumn("SELECT_YN")) ) ) {
							strSql = "{call SP_T_AUTO_FBS_CARD_ACNT_I(?,?,?,?,?)}";
							
							lrArgData.addColumn("SEQ", CITData.NUMBER);
							lrArgData.addColumn("CARDNUMBER", CITData.NUMBER);
							lrArgData.addColumn("ADJUSTYEARMONTH", CITData.VARCHAR2);
							lrArgData.addColumn("ACCTSUBSEQ", CITData.VARCHAR2);
							lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

							lrArgData.addRow();
							lrArgData.setValue("SEQ", strAUTO_FBS_CARD_ACNT_SEQ);
							lrArgData.setValue("CARDNUMBER", rows[i].getString(dsMAIN.indexOfColumn("CARDNUMBER")));
							lrArgData.setValue("ADJUSTYEARMONTH", rows[i].getString(dsMAIN.indexOfColumn("ADJUSTYEARMONTH")));
							lrArgData.setValue("ACCTSUBSEQ", rows[i].getString(dsMAIN.indexOfColumn("ACCTSUBSEQ")));
							lrArgData.setValue("CRTUSERNO", strUserNo);

							CITDatabase.executeProcedure(strSql, lrArgData, conn);
						}
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_AUTO_FBS_CARD_ACNT_D(?,?,?,?)}";
						
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("CARDNUMBER", CITData.NUMBER);
						lrArgData.addColumn("ADJUSTYEARMONTH", CITData.VARCHAR2);
						lrArgData.addColumn("ACCTSUBSEQ", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEQ", strAUTO_FBS_CARD_ACNT_SEQ);
						lrArgData.setValue("CARDNUMBER", rows[i].getString(dsMAIN.indexOfColumn("CARDNUMBER")));
						lrArgData.setValue("ADJUSTYEARMONTH", rows[i].getString(dsMAIN.indexOfColumn("ADJUSTYEARMONTH")));
						lrArgData.setValue("ACCTSUBSEQ", rows[i].getString(dsMAIN.indexOfColumn("ACCTSUBSEQ")));

						CITDatabase.executeProcedure(strSql, lrArgData, conn);
					}
					else
					{
						continue;
					}
					
					// CITDatabase.executeProcedure(strSql, lrArgData, conn);

				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}

			try
			{
				CITData lrArgData = new CITData();
				strSql  = " Select F_T_Get_NewSlip_Id() SLIP_ID	From DUAL ";
				

				CITData lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				strSLIP_ID = lrReturnData.toString(0,"SLIP_ID");
			}
			catch (Exception ex)
			{
				throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
			}
		
			// 자동전표생성
			try
			{
				CITData lrArgData = new CITData();
				strSql = "{call SP_T_AUTO_FBS_CARD_ACNT_SLIP(?,?,?,?,?,?,?,?,?,?,?,?)}";

				lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
				lrArgData.addColumn("MAKE_DT", CITData.VARCHAR2);
				lrArgData.addColumn("SLIP_KIND_TAG", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("CHARGE_PERS", CITData.NUMBER);
				lrArgData.addColumn("INOUT_DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_PERS ", CITData.NUMBER);
				lrArgData.addColumn("MAKE_NAME", CITData.VARCHAR2);
				lrArgData.addColumn("AUTO_FBS_CARD_ACNT_SEQ", CITData.NUMBER);
				lrArgData.addColumn("PAYHOPEDATE", CITData.VARCHAR2);
				lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("SLIP_ID", strSLIP_ID);
				lrArgData.setValue("MAKE_DT", strMAKE_DT);
				lrArgData.setValue("SLIP_KIND_TAG", strSLIP_KIND_TAG);
				lrArgData.setValue("MAKE_COMP_CODE", strMAKE_COMP_CODE);
				lrArgData.setValue("MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
				lrArgData.setValue("CHARGE_PERS", strCHARGE_PERS);
				lrArgData.setValue("INOUT_DEPT_CODE", strINOUT_DEPT_CODE);
				lrArgData.setValue("MAKE_PERS ", strUserNo);
				lrArgData.setValue("MAKE_NAME", strNAME);
				lrArgData.setValue("AUTO_FBS_CARD_ACNT_SEQ", strAUTO_FBS_CARD_ACNT_SEQ);
				lrArgData.setValue("PAYHOPEDATE", strPAYHOPEDATE);
				lrArgData.setValue("CRTUSERNO", strUserNo);

				CITDatabase.executeProcedure(strSql, lrArgData, conn);
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "전표 오류 체크 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}

			// 전표 오류 CHECK
			if(!CITCommon.isNull(strSLIP_ID))
			{
				try
				{
					CITData lrArgData = new CITData();
					strSql = "{call SP_T_CHECK_SLIP(?,?,?,?)}";

					lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
					lrArgData.addColumn("Check_Rela_Work", CITData.VARCHAR2);
					lrArgData.addColumn("Check_Confirmed_Remain", CITData.VARCHAR2);
					lrArgData.addColumn("UPDATE_CLS", CITData.VARCHAR2);
					lrArgData.addRow();
					lrArgData.setValue("SLIP_ID",  strSLIP_ID);
					lrArgData.setValue("Check_Rela_Work", "N");
					lrArgData.setValue("Check_Confirmed_Remain", "Y");
					lrArgData.setValue("UPDATE_CLS", "1");

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
				catch (Exception ex)
				{
					if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
					GauceInfo.response.writeException("USER", "900001", "전표 오류 체크 에러" + ex.getMessage());
					throw new Exception(ex.getMessage());
				}
			}

		}
		else if(strAct.equals("DELETE_FBS_CARD_ACNT")) {
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
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call Pkg_T_Check_Slip.DeleteMaster(?,?)}";

						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("MODUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
					
					lrArgData = new CITData();
					strSql = "{call Sp_T_Card_Slip_Delete(?,?,?)}";

					lrArgData.addColumn("CARDNUMBER", 			CITData.VARCHAR2);
					lrArgData.addColumn("ADJUSTYEARMONTH", 	CITData.VARCHAR2);
					lrArgData.addColumn("ACCTSUBSEQ", 			CITData.NUMBER);

					lrArgData.addRow();
					lrArgData.setValue("CARDNUMBER", 			rows[i].getString(dsMAIN.indexOfColumn("CARDNUMBER")));
					lrArgData.setValue("ADJUSTYEARMONTH", rows[i].getString(dsMAIN.indexOfColumn("ADJUSTYEARMONTH")));
					lrArgData.setValue("ACCTSUBSEQ", 			rows[i].getString(dsMAIN.indexOfColumn("ACCTSUBSEQ")));

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
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
