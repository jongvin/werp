<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-22)
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
			String strWORK_DT_F = CITCommon.toKOR(request.getParameter("WORK_DT_F"));
			String strWORK_DT_T = CITCommon.toKOR(request.getParameter("WORK_DT_T"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.CONTENTS, \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID, \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	b.MAKE_SLIPCLS , \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_DEPT_CODE , \n";
			strSql += " 	b.MAKE_DT , \n";
			strSql += " 	b.MAKE_DT_TRANS , \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG \n";
			strSql += " From	T_SET_CONS_INSUR_DEC_WORK a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT Between F_T_STRINGTODATE( ? ) And F_T_STRINGTODATE( ? ) \n";
			strSql += " And		a.SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.WORK_DT, \n";
			strSql += " 	a.WORK_NO \n";
			strSql += "  ";
			
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
				lrReturnData.setNotNull("CONTENTS", true);
				
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
		else if (strAct.equals("WORK_NO"))
		{
			
			strSql  = " Select SQ_T_WORK_NO_CONS_DEC.NextVal WORK_NO from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","WORK_NO Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAKE_DATA"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' COMP_CODE, 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE, 0 WORK_NO from dual \n";
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
				GauceInfo.response.writeException("USER", "900001","MAKE_DATA Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_NO = CITCommon.toKOR(request.getParameter("WORK_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	b.DEPT_NAME , \n";
			strSql += " 	a.INSUR_NO , \n";
			strSql += " 	a.DEC_NO , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.DEC_AMT , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	d.INSUR_AMT, \n";
			strSql += " 	( \n";
			strSql += " 		Select \n";
			strSql += " 			Sum(aa.DEC_AMT) \n";
			strSql += " 		From	T_SET_CONS_INSUR_DEC_AMT aa, \n";
			strSql += " 				T_SET_CONS_INSUR_DEC_WORK cc \n";
			strSql += " 		Where	aa.COMP_CODE = cc.COMP_CODE \n";
			strSql += " 		And		aa.WORK_NO = cc.WORK_NO \n";
			strSql += " 		And		aa.DEPT_CODE = a.DEPT_CODE \n";
			strSql += " 		And		aa.INSUR_NO = a.INSUR_NO \n";
			strSql += " 		And		cc.WORK_DT < c.WORK_DT \n";
			strSql += " 	) PRE_SUM_DEC_AMT, \n";
			strSql += " 	F_T_DATETOSTRING(d.INSUR_DT_F) INSUR_DT_F , \n";
			strSql += " 	F_T_DATETOSTRING(d.INSUR_DT_T) INSUR_DT_T \n";
			strSql += " From	T_SET_CONS_INSUR_DEC_AMT a, \n";
			strSql += " 		T_DEPT_CODE_ORG b, \n";
			strSql += " 		T_SET_CONS_INSUR_DEC_WORK c, \n";
			strSql += " 		T_SET_CONS_INSUR d \n";
			strSql += " Where	a.DEPT_CODE = b.DEPT_CODE \n";
			strSql += " And		a.COMP_CODE = c.COMP_CODE \n";
			strSql += " And		a.WORK_NO = c.WORK_NO \n";
			strSql += " And		a.DEPT_CODE = d.DEPT_CODE \n";
			strSql += " And		a.INSUR_NO = d.INSUR_NO \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_NO =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_NO", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_NO", strWORK_NO);
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