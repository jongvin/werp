<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-01-16)
/* 5. 관련  프로그램 : 
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
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			
			strSql  = " Select  \n";
			strSql += " 	a.COMP_CODE COMP_CODE ,  \n";
			strSql += " 	a.CLSE_ACC_ID CLSE_ACC_ID ,  \n";
			strSql += " 	a.DEPT_CODE DEPT_CODE ,  \n";
			strSql += " 	a.WORK_YM, \n";
			strSql += " 	a.CRTUSERNO ,  \n";
			strSql += " 	a.CRTDATE ,  \n";
			strSql += " 	a.MODUSERNO ,  \n";
			strSql += " 	a.MODDATE ,  \n";
			strSql += " 	a.EXEC_CONFIRM_TAG PLAN_CONFIRM_TAG ,  \n";
			strSql += " 	a.REMARKS,  \n";
			strSql += " 	c.DEPT_NAME, \n";
			strSql += " 	Decode(  \n";
			strSql += " 	(  \n";
			strSql += " 		Select  \n";
			strSql += " 			Count(*)  \n";
			strSql += " 		From	T_FL_MONTH_PLAN_EXEC b  \n";
			strSql += " 		Where	a.COMP_CODE = b.COMP_CODE  \n";
			strSql += " 		And		a.CLSE_ACC_ID = b.CLSE_ACC_ID  \n";
			strSql += " 		And		a.DEPT_CODE = b.DEPT_CODE \n";
			strSql += " 		And		b.WORK_YM = a.WORK_YM  \n";
			strSql += " 		And		Nvl(b.EXEC_AMT,0) <> 0 \n";
			strSql += " 	) +   \n";
			strSql += " 	(  \n";
			strSql += " 		Select  \n";
			strSql += " 			Count(*)  \n";
			strSql += " 		From	T_FL_MONTH_PLAN_EXEC_PROJ_B b  \n";
			strSql += " 		Where	a.COMP_CODE = b.COMP_CODE  \n";
			strSql += " 		And		a.CLSE_ACC_ID = b.CLSE_ACC_ID  \n";
			strSql += " 		And		a.DEPT_CODE = b.DEPT_CODE  \n";
			strSql += " 		And		b.WORK_YM = a.WORK_YM  \n";
			strSql += " 		And		Nvl(b.EXEC_AMT,0) <> 0 \n";
			strSql += " 	) ,0,'F','T') IS_DATA_EXISTS  \n";
			strSql += " From	T_FL_DEPT_EXEC_CLOSE a,  \n";
			strSql += " 		T_DEPT_CODE_ORG c  \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " And		a.WORK_YM =  ?  \n";
			strSql += " And		a.DEPT_CODE = c.DEPT_CODE  \n";
			strSql += " Order By  \n";
			strSql += " 	a.COMP_CODE ,  \n";
			strSql += " 	a.CLSE_ACC_ID ,  \n";
			strSql += " 	a.DEPT_CODE  \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("WORK_YM", strWORK_YM);
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
				GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			
			strSql  = " Select \n";
			strSql += " 	SubStrb( ?  ,1,50) COMP_CODE , \n";
			strSql += " 	SubStrb( ?  ,1,50) CLSE_ACC_ID , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	 ?  WORK_YM, \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	'F' PLAN_CONFIRM_TAG , \n";
			strSql += " 	SubStrb(' ',1,500) REMARKS, \n";
			strSql += " 	a.DEPT_NAME, \n";
			strSql += " 	'F' IS_DATA_EXISTS \n";
			strSql += " From	T_DEPT_CODE_ORG a \n";
			strSql += " Where	a.DEPT_CODE Not In \n";
			strSql += " ( \n";
			strSql += " 	Select \n";
			strSql += " 		b.DEPT_CODE \n";
			strSql += " 	From	T_FL_DEPT_EXEC_CLOSE b \n";
			strSql += " 	Where	b.COMP_CODE =  ?  \n";
			strSql += " 	And		b.CLSE_ACC_ID =  ?  \n";
			strSql += " 	And		b.WORK_YM =  ?  \n";
			strSql += " ) \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID1", CITData.VARCHAR2);
			lrArgData.addColumn("WORK_YM1", CITData.VARCHAR2);
			lrArgData.addColumn("COMP_CODE2", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID2", CITData.VARCHAR2);
			lrArgData.addColumn("WORK_YM2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE1", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID1", strCLSE_ACC_ID);
			lrArgData.setValue("WORK_YM1", strWORK_YM);
			lrArgData.setValue("COMP_CODE2", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID2", strCLSE_ACC_ID);
			lrArgData.setValue("WORK_YM2", strWORK_YM);
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
				GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MASTER"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strCLSE_ACC_ID = CITCommon.toKOR(request.getParameter("CLSE_ACC_ID"));
			String strWORK_YM = CITCommon.toKOR(request.getParameter("WORK_YM"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CLSE_ACC_ID , \n";
			strSql += " 	a.WORK_YM, \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EXEC_CONFIRM_TAG PLAN_CONFIRM_TAG , \n";
			strSql += " 	SubStrb(Decode(a.EXEC_CONFIRM_TAG,'T','마감됨','마감안됨'),1,50) PLAN_CONFIRM_TAG_NM, \n";
			strSql += " 	a.REMARKS \n";
			strSql += " From	T_FL_COMP_EXEC_CLOSE a \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.CLSE_ACC_ID =  ?  \n";
			strSql += " And		a.WORK_YM =  ?  \n";
			strSql += "   \n";
			strSql += "  ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("CLSE_ACC_ID", CITData.VARCHAR2);
			lrArgData.addColumn("WORK_YM", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("CLSE_ACC_ID", strCLSE_ACC_ID);
			lrArgData.setValue("WORK_YM", strWORK_YM);
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
				GauceInfo.response.writeException("USER", "900001","MASTER Select 오류-> "+ ex.getMessage());
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