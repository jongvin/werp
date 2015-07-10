<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-12-05)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsMAIN01 = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	String strNAME = "";
	String strDeptCode = "";
	Connection conn = null;
	
	String strSLIP_ID = "";
	String strAUTO_REMAIN_RESET_SEQ = "";
	String strMAKE_SLIP_NO = "";
	String strMAKE_DT = "";
	String strMAKE_SEQ = "";
	String strSLIP_KIND_TAG	= "";
	String strMAKE_COMP_CODE = "";
	
	String strMAKE_DEPT_CODE = "";
	String strCHARGE_PERS = "";
	String strINOUT_DEPT_CODE = "";
	
	String strWORK_SLIP_ID = "";
	String strWORK_SLIP_IDSEQ = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strNAME = CITCommon.toKOR((String)session.getAttribute("name"));
		strDeptCode = CITCommon.NvlString(session.getAttribute("dept_code"));
		conn = CITConnectionManager.getConnection(false);

		strAct = GauceInfo.request.getParameter("ACT");
		
		
		if(strAct.equals("AUTO_REMAIN_RESET"))
		{
			strAUTO_REMAIN_RESET_SEQ = GauceInfo.request.getParameter("AUTO_REMAIN_RESET_SEQ");
			strMAKE_SLIP_NO	= GauceInfo.request.getParameter("SLIP_MAKE_SLIP_NO");
			strMAKE_DT	= GauceInfo.request.getParameter("SLIP_MAKE_DT");
			strMAKE_SEQ	= GauceInfo.request.getParameter("SLIP_MAKE_SEQ");
			strSLIP_KIND_TAG	= GauceInfo.request.getParameter("SLIP_KIND_TAG");
			strMAKE_COMP_CODE	= GauceInfo.request.getParameter("SLIP_MAKE_COMP_CODE");

			strMAKE_DEPT_CODE	= GauceInfo.request.getParameter("SLIP_MAKE_DEPT_CODE");
			strCHARGE_PERS		= GauceInfo.request.getParameter("SLIP_CHARGE_PERS");
			strINOUT_DEPT_CODE	= GauceInfo.request.getParameter("SLIP_INOUT_DEPT_CODE");
			
			strWORK_SLIP_ID		= GauceInfo.request.getParameter("WORK_SLIP_ID");
			strWORK_SLIP_IDSEQ	= GauceInfo.request.getParameter("WORK_SLIP_IDSEQ");

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
						strSql = "{call SP_T_AUTO_REMAIN_RESET_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("AUTO_REMAIN_RESET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("INPUT_AMT", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("AUTO_REMAIN_RESET_SEQ", strAUTO_REMAIN_RESET_SEQ);
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("INPUT_AMT", rows[i].getString(dsMAIN.indexOfColumn("INPUT_AMT")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_AUTO_REMAIN_RESET_D(?,?,?)}";
						
						lrArgData.addColumn("AUTO_REMAIN_RESET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
						lrArgData.addColumn("SLIP_IDSEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("AUTO_REMAIN_RESET_SEQ", strAUTO_REMAIN_RESET_SEQ);
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN.indexOfColumn("SLIP_ID")));
						lrArgData.setValue("SLIP_IDSEQ", rows[i].getString(dsMAIN.indexOfColumn("SLIP_IDSEQ")));
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
				strSql = "{call SP_T_AUTO_REMAIN_RESET_SLIP(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";

				lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
				lrArgData.addColumn("MAKE_SLIP_NO", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_DT", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_SEQ", CITData.VARCHAR2);
				lrArgData.addColumn("SLIP_KIND_TAG", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_COMP_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("CHARGE_PERS", CITData.NUMBER);
				lrArgData.addColumn("INOUT_DEPT_CODE", CITData.VARCHAR2);
				lrArgData.addColumn("MAKE_PERS ", CITData.NUMBER);
				lrArgData.addColumn("MAKE_NAME", CITData.VARCHAR2);
				lrArgData.addColumn("AUTO_REMAIN_RESET_SEQ", CITData.NUMBER);
				lrArgData.addColumn("WORK_SLIP_ID", CITData.NUMBER);
				lrArgData.addColumn("WORK_SLIP_IDSEQ", CITData.NUMBER);
				lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("SLIP_ID", strSLIP_ID);
				lrArgData.setValue("MAKE_SLIP_NO", strMAKE_SLIP_NO);
				lrArgData.setValue("MAKE_DT", strMAKE_DT);
				lrArgData.setValue("MAKE_SEQ", strMAKE_SEQ);
				lrArgData.setValue("SLIP_KIND_TAG", strSLIP_KIND_TAG);
				lrArgData.setValue("MAKE_COMP_CODE", strMAKE_COMP_CODE);
				lrArgData.setValue("MAKE_DEPT_CODE", strMAKE_DEPT_CODE);
				lrArgData.setValue("CHARGE_PERS", strCHARGE_PERS);
				lrArgData.setValue("INOUT_DEPT_CODE", strINOUT_DEPT_CODE);
				lrArgData.setValue("MAKE_PERS ", strUserNo);
				lrArgData.setValue("MAKE_NAME", strNAME);
				lrArgData.setValue("AUTO_REMAIN_RESET_SEQ", strAUTO_REMAIN_RESET_SEQ);
				lrArgData.setValue("WORK_SLIP_ID", strWORK_SLIP_ID);
				lrArgData.setValue("WORK_SLIP_IDSEQ", strWORK_SLIP_IDSEQ);
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
		
		else if(strAct.equals("DELETE_REMAIN_RESET")) {
			dsMAIN01 = GauceInfo.request.getGauceDataSet("dsMAIN01");
			
			if (dsMAIN01 == null) throw new Exception("dsMAIN01이(가) 널(Null)입니다.");
			
			rows = dsMAIN01.getDataRows();
			
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
						lrArgData.setValue("SLIP_ID", rows[i].getString(dsMAIN01.indexOfColumn("SLIP_ID")));
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

				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
		
		else {
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
