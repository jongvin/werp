<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Update Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 :  한재원 작성(2006-02-06)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	String strNAME = "";
	String strDeptCode = "";
	Connection conn = null;
	
	String strSLIP_ID = "";
	String strAUTO_B_F_SELL_SEQ = "";
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
	String strWORK_CODE ="";
	String strCUST_SEQ="";
	String strCUST_NAME="";
	
	String strFIX_ASSET_SEQ = "";
	String strINCREDU_SEQ = "";
	String strGET_AMT ="";
	String strDEPREC_AMT="";
	String strSELL_AMT="";
	
	String strVAT_DT="";
	String strVAT_TAG="";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* 세션정보 */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		strNAME = CITCommon.toKOR((String)session.getAttribute("name"));
		strDeptCode = CITCommon.NvlString(session.getAttribute("dept_code"));
		conn = CITConnectionManager.getConnection(false);
		
		strAUTO_B_F_SELL_SEQ = GauceInfo.request.getParameter("AUTO_BILL_FIX_SELL_SEQ");
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
		strWORK_CODE	       = GauceInfo.request.getParameter("WORK_CODE");
		
		strCUST_SEQ	       	= GauceInfo.request.getParameter("CUST_SEQ");
		strCUST_NAME	       	= GauceInfo.request.getParameter("CUST_NAME");
		
		strFIX_ASSET_SEQ	       = GauceInfo.request.getParameter("FIX_ASSET_SEQ");
		strINCREDU_SEQ	       = GauceInfo.request.getParameter("INCREDU_SEQ");
		strGET_AMT	       	= GauceInfo.request.getParameter("GET_AMT");
		strDEPREC_AMT	       = GauceInfo.request.getParameter("DEPREC_AMT");
		strSELL_AMT	       	= GauceInfo.request.getParameter("SELL_AMT");
		
		strVAT_DT      		= GauceInfo.request.getParameter("VAT_DT");
		strVAT_TAG	       	= GauceInfo.request.getParameter("VAT_TAG");
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if(strAct.equals("AUTO_BILL_FIX_SELL"))
		{
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
						strSql = "{call SP_T_AUTO_BILL_FIX_SELL_I(?,?,?,?,?)}";
						
						lrArgData.addColumn("AUTO_B_F_SELL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("INCSUB_AMT", CITData.NUMBER);
						lrArgData.addColumn("INCREDU_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						
						lrArgData.setValue("AUTO_B_F_SELL_SEQ", strAUTO_B_F_SELL_SEQ);
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("INCSUB_AMT", rows[i].getString(dsMAIN.indexOfColumn("INCSUB_AMT")));
						lrArgData.setValue("INCREDU_SEQ", rows[i].getString(dsMAIN.indexOfColumn("INCREDU_SEQ")));
						

					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_AUTO_BILL_FIX_GET_D(?,?)}";
						
						lrArgData.addColumn("AUTO_B_F_GET_SEQ", CITData.NUMBER);
						lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("AUTO_B_F_GET_SEQ", rows[i].getString(dsMAIN.indexOfColumn("AUTO_B_F_GET_SEQ")));
						lrArgData.setValue("FIX_ASSET_SEQ", rows[i].getString(dsMAIN.indexOfColumn("FIX_ASSET_SEQ")));


					}
					else
					{
						continue;
					}
					
					//CITDatabase.executeProcedure(strSql, lrArgData, conn);

				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIN_LOAN_SHEET 테이블 데이타 갱신 에러" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		} else if(strAct.equals("CONF_F")) {

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
		if(strAct.equals("AUTO_BILL_FIX_SELL"))
		{
			try
			{
				CITData lrArgData = new CITData();
				strSql = "{call SP_T_AUTO_BILL_FIX_SELL_SLIP(?,?,?,?,?,  ?,?,?,?,?,  ?,?,?,?,?,  ?,   ?,?,?,?,?,  ?,?)}";
						            
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
				lrArgData.addColumn("AUTO_BILL_FIX_SELL_SEQ", CITData.NUMBER);
				lrArgData.addColumn("WORK_SLIP_ID", CITData.NUMBER); 
				lrArgData.addColumn("WORK_SLIP_IDSEQ", CITData.NUMBER); 
				lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
				
				lrArgData.addColumn("WORK_CODE", CITData.VARCHAR2);
				
				lrArgData.addColumn("FIX_ASSET_SEQ", CITData.NUMBER); 
				lrArgData.addColumn("INCREDU_SEQ", CITData.NUMBER); 
				lrArgData.addColumn("GET_AMT", CITData.NUMBER); 
				lrArgData.addColumn("DEPREC_AMT", CITData.NUMBER); 
				lrArgData.addColumn("SELL_AMT", CITData.NUMBER); 
				
				lrArgData.addColumn("VAT_DT", CITData.VARCHAR2);
				lrArgData.addColumn("VAT_TAG", CITData.VARCHAR2);

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
				lrArgData.setValue("AUTO_BILL_FIX_SELL_SEQ", strAUTO_B_F_SELL_SEQ);
				lrArgData.setValue("WORK_SLIP_ID", strWORK_SLIP_ID);
				lrArgData.setValue("WORK_SLIP_IDSEQ", strWORK_SLIP_IDSEQ);
				lrArgData.setValue("CRTUSERNO", strUserNo);
				
				lrArgData.setValue("WORK_CODE", strWORK_CODE);
	
				lrArgData.setValue("FIX_ASSET_SEQ", strFIX_ASSET_SEQ);
				lrArgData.setValue("INCREDU_SEQ", strINCREDU_SEQ);
				lrArgData.setValue("GET_AMT", strGET_AMT);
				lrArgData.setValue("DEPREC_AMT", strDEPREC_AMT);
				lrArgData.setValue("SELL_AMT", strSELL_AMT);
				
				lrArgData.setValue("VAT_DT", strVAT_DT);
				lrArgData.setValue("VAT_TAG", strVAT_TAG);
				
	

				CITDatabase.executeProcedure(strSql, lrArgData, conn);
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "전표 생성  에러" + ex.getMessage());
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
		
		// 자동전표삭제
		if(strAct.equals("AUTO_SLIP_ID_DEL"))
		{
			try
			{
				CITData lrArgData = new CITData();
				strSql = "{call Pkg_T_Check_Slip.DeleteMaster(?,?)}";

				lrArgData.addColumn("SLIP_ID", CITData.NUMBER);
				lrArgData.addColumn("ModUser", CITData.NUMBER); //
				 
				lrArgData.addRow();
				
				lrArgData.setValue("SLIP_ID", strSLIP_ID);
				lrArgData.setValue("ModUser ", strUserNo);

				CITDatabase.executeProcedure(strSql, lrArgData, conn);
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "전표 삭제  에러" + ex.getMessage());
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
