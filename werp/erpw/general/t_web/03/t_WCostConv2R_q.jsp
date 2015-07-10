<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WCostConv2R.jsp(원가대체전표생성)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 원가대체전표생성
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
/* 5. 관련  프로그램 : 관련된 프로그램에 대한 주석처리
/* 6. 특  기  사  항 :
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;

	String	strSql = "";
	String	strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_DT_F = CITCommon.toKOR(request.getParameter("WORK_DT_F"));
			String strWORK_DT_T = CITCommon.toKOR(request.getParameter("WORK_DT_T"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	To_Char(a.WORK_DT,'YYYY-MM') WORK_DT , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	b.MAKE_SLIPCLS , \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_DEPT_CODE , \n";
			strSql += " 	b.MAKE_DT , \n";
			strSql += " 	b.MAKE_DT_TRANS , \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG \n";
			strSql += " From	T_SET_COST_CONV_SLIP a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT Between Trunc(F_T_STRINGTODATE( ? ),'MM') And Last_Day(F_T_STRINGTODATE( ? )) \n";
			strSql += " And		a.SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.WORK_DT, \n";
			strSql += " 	a.WORK_NO ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT_F", CITData.VARCHAR2);
			lrArgData.addColumn("3WORK_DT_T", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT_F", strWORK_DT_F);
			lrArgData.setValue("3WORK_DT_T", strWORK_DT_T);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_NO", true);
				lrReturnData.setNotNull("WORK_DT", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("WORK_SEQ"))
		{
			
			strSql  = " Select SQ_T_WORK_NO_CONV_COST.NextVal WORK_NO From Dual \n";
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","WORK_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE"))
		{

			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE,'XXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE,  F_T_DATETOSTRING(Sysdate) WORK_DT,0 WORK_NO From Dual ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","REMOVE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("REMOVE"))
		{

			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE, F_T_DATETOSTRING(Sysdate) WORK_DT,0 WORK_NO From Dual ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","REMOVE Select 오류-> "+ ex.getMessage());
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
