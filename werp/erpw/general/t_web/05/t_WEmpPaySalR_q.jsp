<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WEmpPaySalR.jsp(사원별급여지급내역현황)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 사원별지급내역현황조회
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
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
			strSql += " 	a.WORK_SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	F_T_STRINGTOYMFORMAT(a.WORK_YM) WORK_YM, \n";
			strSql += " 	F_T_DATETOSTRING(a.WORK_DT) WORK_DT , \n";
			strSql += " 	a.PAYGBN , \n";
			strSql += " 	a.CONTENTS , \n";
			strSql += " 	a.ACCNO , \n";
			strSql += " 	a.IGNORE_COMP_TAG , \n";
			strSql += " 	To_Char(a.SLIP_ID) SLIP_ID, \n";
			strSql += " 	To_Char(a.SLIP_IDSEQ) SLIP_IDSEQ, \n";
			strSql += " 	b.MAKE_SLIPCLS , \n";
			strSql += " 	b.MAKE_SLIPNO , \n";
			strSql += " 	b.MAKE_COMP_CODE , \n";
			strSql += " 	b.MAKE_DEPT_CODE , \n";
			strSql += " 	b.MAKE_DT_TRANS , \n";
			strSql += " 	b.MAKE_SEQ, \n";
			strSql += " 	b.SLIP_KIND_TAG \n";
			strSql += " From	T_FIN_PAY_SAL a, \n";
			strSql += " 		T_ACC_SLIP_HEAD b \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_DT Between F_T_STRINGTODATE( ? ) And F_T_STRINGTODATE( ? ) \n";
			strSql += " And		a.SLIP_ID = b.SLIP_ID (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.WORK_DT, \n";
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
				lrReturnData.setKey("WORK_SEQ", true);
				lrReturnData.setNotNull("WORK_YM", true);
				lrReturnData.setNotNull("WORK_DT", true);
				lrReturnData.setNotNull("PAYGBN", true);
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
		else if (strAct.equals("WORK_SEQ"))
		{
			
			strSql  = " Select SQ_T_WORK_SEQ_SAL.NextVal WORK_SEQ From Dual \n";
			
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
			
			strSql  = " Select SQ_T_SEQ_SAL.NextVal SEQ From Dual \n";
			
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
				"	a.EMPNO,"+"\n"+
				"	a.NAME,"+"\n"+
				"	a.DEPT_CODE,"+"\n"+
				"	a.DEPT_NAME,"+"\n"+
				"	a.SAFE_MNG_TAG"+"\n"+
				"From"+"\n"+
				"	("+"\n"+
				"		Select"+"\n"+
				"			a.EMPNO,"+"\n"+
				"			a.NAME,"+"\n"+
				"			b.DEPT_CODE,"+"\n"+
				"			b.SAFE_MNG_TAG,"+"\n"+
				"			c.DEPT_NAME,"+"\n"+
				"			Row_Number() Over ( Order By a.EMPNO,b.ORDER_DT desc,b.ORDER_SEQ desc ) rn"+"\n"+
				"		From	Z_AUTHORITY_USER a,"+"\n"+
				"				T_FIN_EMP_ORDER b,"+"\n"+
				"				T_DEPT_CODE c"+"\n"+
				"		Where	a.EMPNO = b.EMP_NO"+"\n"+
				"		And		a.EMPNO = ?"+"\n"+
				"		And		b.DEPT_CODE = c.DEPT_CODE"+"\n"+
				"		Order By a.EMPNO,b.ORDER_DT desc,b.ORDER_SEQ desc"+"\n"+
				"	) a"+"\n"+
				"Where	rn = 1"+"\n"
				;			
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
		else if (strAct.equals("PAYGBN"))
		{
			
			strSql  = "Select \n";
			strSql += "		a.CODE_LIST_ID AS CODE, \n";
			strSql += "		a.CODE_LIST_NAME AS NAME, \n";
			strSql += "		a.SEQ \n";
			strSql += "From	V_T_CODE_LIST a \n";
			strSql += "Where	a.CODE_GROUP_ID = 'PAYGBN' \n";
			strSql += "And	a.USE_TAG = 'T' \n";
			strSql += "Order By \n";
			strSql += "	3, 1 \n";
			

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
		else if (strAct.equals("SUM"))
		{
			
			strSql  = "Select 'XXXXXXXXXXXXXXXXXXXXX' COMP_CODE,0 WORK_SEQ from dual \n";
			

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
				GauceInfo.response.writeException("SUM", "900001","SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			String strWORK_SEQ = CITCommon.toKOR(request.getParameter("WORK_SEQ"));
			
			strSql  = " Select \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.WORK_SEQ , \n";
			strSql += " 	a.SEQ , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.EMP_NO , \n";
			strSql += " 	a.IN_OUT_TAG , \n";
			strSql += " 	a.SUDANGCD , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.SAFE_MNG_TAG , \n";
			strSql += " 	a.AMT, \n";
			strSql += " 	b.NAME, \n";
			strSql += " 	c.DEPT_NAME, \n";
			strSql += " 	d.HNAME \n";
			strSql += " From	T_FIN_PAY_SAL_LIST a, \n";
			strSql += " 		Z_AUTHORITY_USER b, \n";
			strSql += " 		T_DEPT_CODE c, \n";
			strSql += " 		( \n";
			strSql += " 			Select \n";
			strSql += " 				'1' IN_OUT_TAG, \n";
			strSql += " 				SUDANGCD, \n";
			strSql += " 				HNAME \n";
			strSql += " 			From	CSUD001VV \n";
			strSql += " 			Union All \n";
			strSql += " 			Select \n";
			strSql += " 				'2', \n";
			strSql += " 				SUBSCD, \n";
			strSql += " 				HNAME \n";
			strSql += " 			From	CSUB001VV \n";
			strSql += " 		) d \n";
			strSql += " Where	a.EMP_NO = b.EMPNO (+) \n";
			strSql += " And		a.DEPT_CODE = c.DEPT_CODE (+) \n";
			strSql += " And		a.IN_OUT_TAG = d.IN_OUT_TAG  \n";
			strSql += " And		a.SUDANGCD = d.SUDANGCD  \n";
			strSql += " And		a.COMP_CODE =  ?  \n";
			strSql += " And		a.WORK_SEQ =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	a.EMP_NO , \n";
			strSql += " 	a.IN_OUT_TAG , \n";
			strSql += " 	a.SUDANGCD \n";
			strSql += " 	 ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2WORK_SEQ", CITData.NUMBER);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2WORK_SEQ", strWORK_SEQ);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setKey("WORK_SEQ", true);
				lrReturnData.setKey("SEQ", true);
				lrReturnData.setNotNull("EMP_NO", true);
				lrReturnData.setNotNull("IN_OUT_TAG", true);
				lrReturnData.setNotNull("SUDANGCD", true);
				
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
