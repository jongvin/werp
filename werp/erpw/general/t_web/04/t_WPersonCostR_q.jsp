<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-03-07)
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
			strSql += " 	a.CONTENTS , \n";
			strSql += " 	a.ACCNO \n";
			strSql += " From	T_FIN_PERSON_COST a \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT Between F_T_STRINGTODATE( ? ) And F_T_STRINGTODATE( ? ) \n";
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
			
			strSql  = " Select SQ_T_PER_COST_WORK_NO.NextVal WORK_SEQ From Dual \n";
			
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
		else if (strAct.equals("SEQ"))
		{
			
			strSql  = " Select SQ_T_EMP_PAY_LIST_SEQ.NextVal SEQ From Dual \n";
			
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
				GauceInfo.response.writeException("USER", "900001","SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("ACCINFO"))
		{
			
			String strEMPNO = CITCommon.toKOR(request.getParameter("EMPNO"));
			strSql  = " Select '' IN_BANK_MAIN_CODE, '' IN_ACC_NO, '' ACCNO_OWNER  From Dual where 0 = ? \n";
			
			lrArgData.addColumn("EMPNO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("EMPNO", strEMPNO);

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
				GauceInfo.response.writeException("USER", "900001","SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_NO = CITCommon.toKOR(request.getParameter("WORK_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_ID) TARGET_SLIP_ID , \n";
			strSql += " 	To_Char(a.TARGET_SLIP_IDSEQ) TARGET_SLIP_IDSEQ , \n";
			strSql += " 	b.MAKE_SLIPCLS , \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	b1.MAKE_SLIPLINE , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_DEPT_CODE , \n";
			strSql += " 	b.MAKE_DT , \n";
			strSql += " 	b.MAKE_DT_TRANS , \n";
			strSql += " 	b.MAKE_SEQ , \n";
			strSql += " 	b.SLIP_KIND_TAG, \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.ERMP_NO , \n";
			strSql += " 	d.NAME, \n";
			strSql += " 	To_Char(a.CUST_SEQ) CUST_SEQ , \n";
			strSql += " 	f_t_cust_mask(c.CUST_CODE) CUST_CODE , \n";
			strSql += " 	a.CUST_NAME , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.IN_ACC_NO_OWNER , \n";
			strSql += " 	a.IN_TARGET_TAG, \n";
			strSql += " 	b1.SUMMARY1, \n";
			strSql += " 	b2.ACC_NAME, \n";
			strSql += " 	e.BANK_MAIN_NAME \n";
			strSql += " From	T_FIN_PERSON_COST_LIST a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b, \n";
			strSql += " 		T_ACC_SLIP_BODY b1, \n";
			strSql += " 		T_ACC_CODE b2, \n";
			strSql += " 		T_CUST_CODE c, \n";
			strSql += " 		Z_AUTHORITY_USER d, \n";
			strSql += " 		T_BANK_MAIN e \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_NO =  ?  \n";
			strSql += " And		a.TARGET_SLIP_ID = b.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_ID = b1.SLIP_ID \n";
			strSql += " And		a.TARGET_SLIP_IDSEQ = b1.SLIP_IDSEQ \n";
			strSql += " And		b1.ACC_CODE = b2.ACC_CODE \n";
			strSql += " And		a.CUST_SEQ = c.CUST_SEQ (+) \n";
			strSql += " And		a.ERMP_NO = d.EMPNO (+) \n";
			strSql += " And		a.IN_BANK_MAIN_CODE = e.BANK_MAIN_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_NO , \n";
			strSql += " 	a.SEQ \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_NO", CITData.VARCHAR2);
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
		else if (strAct.equals("BANK_MAIN"))
		{

			
			strSql  = " Select \n";
			strSql += " 	a.BANK_MAIN_CODE, \n";
			strSql += " 	a.BANK_MAIN_NAME \n";
			strSql += " From	T_BANK_MAIN a \n";
			strSql += " Union All \n";
			strSql += " Select \n";
			strSql += " 	'' BANK_MAIN_CODE, \n";
			strSql += " 	'' BANK_MAIN_NAME \n";
			strSql += " From	Dual \n";
			strSql += " Order By \n";
			strSql += " 	1 ";
			

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
				GauceInfo.response.writeException("USER", "900001","BANK_MAIN Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUM"))
		{
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX' COMP_CODE, 'XXXXXXXXXXXXXXXXXXXXXXXXXX' DEPT_CODE, 'XXXXXXXXXX' WORK_DT,0 WORK_NO From Dual \n";

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
				GauceInfo.response.writeException("USER", "900001","SUM Select 오류-> "+ ex.getMessage());
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
