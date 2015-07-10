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
	String strNAME = "";
	Connection conn = null;

	String strSLIP_ID = "";
	String strAUTO_FBS_CASH_TRANS_SEQ = "";
	String strMAKE_DT = "";
	String strSLIP_KIND_TAG	= "";
	String strMAKE_COMP_CODE = "";
	
	String strMAKE_DEPT_CODE = "";
	String strCHARGE_PERS = "";
	String strINOUT_DEPT_CODE = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strNAME = CITCommon.toKOR((String)session.getAttribute("name"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");

		if(strAct.equals("COPY1"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_CASH_TRANSFER_IDS('INSERT',?,?,?,?,?,?,?,?,?,?)}";
																
					lrArgData.addColumn("TRANSFER_SEQ", CITData.NUMBER);
					lrArgData.addColumn("REQUEST_YMD", CITData.VARCHAR2);
					lrArgData.addColumn("OUTACCOUNT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("OUTBANK_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("INACCOUNT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("INBANK_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("TRANSFER_AMT", CITData.NUMBER);
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("DESCRIPTION", CITData.VARCHAR2);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("TRANSFER_SEQ", rows[i].getString(dsCOPY.indexOfColumn("TRANSFER_SEQ")));
					lrArgData.setValue("REQUEST_YMD", rows[i].getString(dsCOPY.indexOfColumn("REQUEST_YMD")));
					lrArgData.setValue("OUTACCOUNT_CODE", rows[i].getString(dsCOPY.indexOfColumn("OUTACCOUNT_CODE")));
					lrArgData.setValue("OUTBANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("OUTBANK_CODE")));
					lrArgData.setValue("INACCOUNT_CODE", rows[i].getString(dsCOPY.indexOfColumn("INACCOUNT_CODE")));
					lrArgData.setValue("INBANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("INBANK_CODE")));
					lrArgData.setValue("TRANSFER_AMT", rows[i].getString(dsCOPY.indexOfColumn("TRANSFER_AMT")));
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCOPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("DESCRIPTION", rows[i].getString(dsCOPY.indexOfColumn("DESCRIPTION")));
					lrArgData.setValue("EMP_NO", strUserNo);

					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "지급이체데이타 생성 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(strAct.equals("COPY2"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_CASH_TRANSFER_IDS('DELETE',?,'','','','','','','','','')}";
																
					lrArgData.addColumn("TRANSFER_SEQ", CITData.NUMBER);
					lrArgData.addRow();
					lrArgData.setValue("TRANSFER_SEQ", rows[i].getString(dsCOPY.indexOfColumn("TRANSFER_SEQ")));
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "지급이체데이타 생성 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}		
		else if(strAct.equals("COPY3"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_CASH_PAY_DATA_CREATE(?,?)}";
																
					lrArgData.addColumn("TRANSFER_SEQ", CITData.NUMBER);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
					lrArgData.addRow();
					lrArgData.setValue("TRANSFER_SEQ", rows[i].getString(dsCOPY.indexOfColumn("TRANSFER_SEQ")));
					lrArgData.setValue("EMP_NO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "지급이체데이타 생성 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}				
		else if(strAct.equals("COPY4"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			
			if (dsCOPY == null) throw new Exception("dsCOPY이(가) 널(Null)입니다.");
			
			rows = dsCOPY.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();

					strSql = "{call SP_CASH_TRANSFER_IDS('UPDATE',?,?,?,?,?,?,?,?,?,?)}";
																
					lrArgData.addColumn("TRANSFER_SEQ", CITData.NUMBER);
					lrArgData.addColumn("REQUEST_YMD", CITData.VARCHAR2);
					lrArgData.addColumn("OUTACCOUNT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("OUTBANK_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("INACCOUNT_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("INBANK_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("TRANSFER_AMT", CITData.NUMBER);
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
					lrArgData.addColumn("DESCRIPTION", CITData.VARCHAR2);
					lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("TRANSFER_SEQ", rows[i].getString(dsCOPY.indexOfColumn("TRANSFER_SEQ")));
					lrArgData.setValue("REQUEST_YMD", rows[i].getString(dsCOPY.indexOfColumn("REQUEST_YMD")));
					lrArgData.setValue("OUTACCOUNT_CODE", rows[i].getString(dsCOPY.indexOfColumn("OUTACCOUNT_CODE")));
					lrArgData.setValue("OUTBANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("OUTBANK_CODE")));
					lrArgData.setValue("INACCOUNT_CODE", rows[i].getString(dsCOPY.indexOfColumn("INACCOUNT_CODE")));
					lrArgData.setValue("INBANK_CODE", rows[i].getString(dsCOPY.indexOfColumn("INBANK_CODE")));
					lrArgData.setValue("TRANSFER_AMT", rows[i].getString(dsCOPY.indexOfColumn("TRANSFER_AMT")));
					lrArgData.setValue("COMP_CODE", rows[i].getString(dsCOPY.indexOfColumn("COMP_CODE")));
					lrArgData.setValue("DESCRIPTION", rows[i].getString(dsCOPY.indexOfColumn("DESCRIPTION")));
					lrArgData.setValue("EMP_NO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "지급이체데이타 생성 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		else if(strAct.equals("AUTO_FBS_CASH_TRANS"))
		{
			strAUTO_FBS_CASH_TRANS_SEQ = GauceInfo.request.getParameter("AUTO_FBS_CASH_TRANS_SEQ");
			strMAKE_DT	= GauceInfo.request.getParameter("SLIP_MAKE_DT");
			strSLIP_KIND_TAG	= GauceInfo.request.getParameter("SLIP_KIND_TAG");
			strMAKE_COMP_CODE	= GauceInfo.request.getParameter("SLIP_MAKE_COMP_CODE");

			strMAKE_DEPT_CODE	= GauceInfo.request.getParameter("SLIP_MAKE_DEPT_CODE");
			strCHARGE_PERS		= GauceInfo.request.getParameter("SLIP_CHARGE_PERS");
			strINOUT_DEPT_CODE	= GauceInfo.request.getParameter("SLIP_INOUT_DEPT_CODE");

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
						strSql = "{call SP_T_AUTO_FBS_CASH_TRANS_I(?,?,?)}";
						
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("TRANSFER_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("SEQ", strAUTO_FBS_CASH_TRANS_SEQ);
						lrArgData.setValue("TRANSFER_SEQ", rows[i].getString(dsMAIN.indexOfColumn("TRANSFER_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_AUTO_FBS_CASH_TRANS_D(?,?)}";
						
						lrArgData.addColumn("SEQ", CITData.NUMBER);
						lrArgData.addColumn("TRANSFER_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("SEQ", strAUTO_FBS_CASH_TRANS_SEQ);
						lrArgData.setValue("TRANSFER_SEQ", rows[i].getString(dsMAIN.indexOfColumn("TRANSFER_SEQ")));
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
				strSql = "{call SP_T_AUTO_FBS_CASH_TRANS_SLIP(?,?,?,?,?,?,?,?,?,?,?)}";

				lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
				lrArgData.addColumn("MAKE_DT", CITData.VARCHAR2);
				lrArgData.addColumn("SLIP_KIND_TAG", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("CHARGE_PERS", CITData.NUMBER);
				lrArgData.addColumn("INOUT_DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_PERS ", CITData.NUMBER);
				lrArgData.addColumn("MAKE_NAME", CITData.VARCHAR2);
				lrArgData.addColumn("AUTO_FBS_CASH_TRANS_SEQ", CITData.NUMBER);
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
				lrArgData.setValue("AUTO_FBS_CASH_TRANS_SEQ", strAUTO_FBS_CASH_TRANS_SEQ);
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
		else if(strAct.equals("DELETE_FBS_CASH_TRANS")) {
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN이(가) 널(Null)입니다.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
							try
							{   
								  CITData lrArgData = new CITData();
								  
									strSql = "{call SP_CASH_PAY_DATA_DELETE(?,?)}";
																				
									lrArgData.addColumn("TRANSFER_SEQ", CITData.NUMBER);
									lrArgData.addColumn("EMP_NO", CITData.VARCHAR2);
									lrArgData.addRow();
									lrArgData.setValue("TRANSFER_SEQ", rows[i].getString(dsMAIN.indexOfColumn("TRANSFER_SEQ")));
									lrArgData.setValue("EMP_NO", strUserNo);
									
									CITDatabase.executeProcedure(strSql, lrArgData, conn);
							}
							catch (Exception ex)
							{
								if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
								GauceInfo.response.writeException("USER", "900001", "이체데이타 삭제" + ex.getMessage());
								throw new Exception(ex.getMessage());
							}
							
							try
							{  
									CITData lrArgData = new CITData();
									
									strSql = "{call Pkg_T_Check_Slip.DeleteMaster(?,?)}";
			
									lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
									lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
			
									lrArgData.addRow();
									lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
									lrArgData.setValue("MODUSERNO", strUserNo); 
									
									CITDatabase.executeProcedure(strSql, lrArgData, conn);
							}
							catch (Exception ex)
							{
								if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
								GauceInfo.response.writeException("USER", "900001", "전표데이타 삭제" + ex.getMessage());
								throw new Exception(ex.getMessage());
							}	
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
					}
					else
					{
						continue;
					}
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
