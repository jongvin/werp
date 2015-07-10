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
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.WORK_SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.CONTENTS , \n";
			strSql += " 	a.OUT_ACC_NO , \n";
			strSql += " 	a.COST_ACC_CODE , \n";
			strSql += " 	a.PAY_ACC_CODE , \n";
			strSql += " 	a.CHARGE_PERS, \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	aa.MAKE_SLIPNO, \n";
			strSql += " 	aa.MAKE_COMP_CODE, \n";
			strSql += " 	aa.MAKE_SEQ, \n";
			strSql += " 	aa.SLIP_KIND_TAG, \n";
			strSql += " 	aa.MAKE_DT_TRANS, \n";
			strSql += " 	aa.MAKE_SLIPCLS, \n";
			strSql += " 	b.ACC_NAME COST_ACC_CODE_NAME, \n";
			strSql += " 	c.ACC_NAME PAY_ACC_CODE_NAME, \n";
			strSql += " 	Decode(d.ACCNO,Null,Null,d.ACCT_NAME||'('||d.ACCNO||')') ACC_N_BANK_NAME, \n";
			strSql += " 	f.NAME CHARGE_PERS_NAME \n";
			strSql += " From	T_FIN_EMP_PAY_MAIN a, \n";
			strSql += " 		T_ACC_CODE b, \n";
			strSql += " 		T_ACC_CODE c, \n";
			strSql += " 		T_ACCNO_CODE d, \n";
			strSql += " 		T_BANK_CODE e, \n";
			strSql += " 		T_ACC_SLIP_HEAD aa, \n";
			strSql += " 		Z_AUTHORITY_USER f \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT Between F_T_STRINGTODATE( ? ) And F_T_STRINGTODATE( ? ) \n";
			strSql += " And		a.COST_ACC_CODE = b.ACC_CODE (+) \n";
			strSql += " And		a.PAY_ACC_CODE = c.ACC_CODE (+) \n";
			strSql += " And		a.OUT_ACC_NO = d.ACCNO (+) \n";
			strSql += " And		d.BANK_CODE = e.BANK_CODE (+) \n";
			strSql += " And		a.CHARGE_PERS = f.EMPNO (+) \n";
			strSql += " And		a.SLIP_ID = aa.SLIP_ID (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_DT , \n";
			strSql += " 	a.WORK_SEQ \n";
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
				lrReturnData.setKey("WORK_DT", true);
				lrReturnData.setKey("WORK_SEQ", true);

				
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
			
			strSql  = " Select SQ_T_WORK_SEQ.NextVal WORK_SEQ From Dual \n";
			
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
			strSql  = 
				"Select"+"\n"+
				"	a.IN_BANK_MAIN_CODE_2 IN_BANK_MAIN_CODE,"+"\n"+
				"	a.IN_ACC_NO_2 IN_ACC_NO,"+"\n"+
				"	b.NAME ACCNO_OWNER"+"\n"+
				"From	T_FIN_EMP_IN_ACC_NO a,"+"\n"+
				"		Z_AUTHORITY_USER b"+"\n"+
				"Where	a.ERMP_NO = ?"+"\n"+
				"And		a.ERMP_NO = b.EMPNO";
			
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
			String strWORK_DT = CITCommon.toKOR(request.getParameter("WORK_DT"));
			String strWORK_SEQ = CITCommon.toKOR(request.getParameter("WORK_SEQ"));
			
			strSql  = " Select \n";
			strSql += " 	a.WORK_SEQ , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EMP_NO , \n";
			strSql += " 	a.EXEC_AMT , \n";
			strSql += " 	a.IN_ACC_NO , \n";
			strSql += " 	a.IN_BANK_MAIN_CODE , \n";
			strSql += " 	a.ACCNO_OWNER , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID , \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	b.NAME, \n";
			strSql += " 	c.MAKE_SLIPNO, \n";
			strSql += " 	c.MAKE_COMP_CODE, \n";
			strSql += " 	c.MAKE_SEQ, \n";
			strSql += " 	c.SLIP_KIND_TAG, \n";
			strSql += " 	c.MAKE_DT_TRANS \n";
			strSql += " From	T_FIN_EMP_PAY_LIST a, \n";
			strSql += " 		Z_AUTHORITY_USER b, \n";
			strSql += " 		T_ACC_SLIP_HEAD c \n";
			strSql += " Where	a.EMP_NO = b.EMPNO (+) \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT = F_T_STRINGTODATE( ? ) \n";
			strSql += " And		a.WORK_SEQ =  ?  \n";
			strSql += " And		a.SLIP_ID = c.SLIP_ID (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.SEQ ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_DT", CITData.VARCHAR2);
			lrArgData.addColumn("3WORK_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_DT", strWORK_DT);
			lrArgData.setValue("3WORK_SEQ", strWORK_SEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("WORK_SEQ", true);
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_DT", true);
				lrReturnData.setKey("SEQ", true);

				
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
		else if (strAct.equals("REMOVE"))
		{

			
			strSql  = " Select 'XXXXXXXXXXXXX' COMP_CODE, F_T_DATETOSTRING(Sysdate) WORK_DT,0 WORK_SEQ From Dual ";
			

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
