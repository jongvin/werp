<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-18)
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

			
			strSql  = " SELECT  \n";
			strSql += " 	A.WORK_CODE ,  \n";
			strSql += " 	A.CRTUSERNO ,  \n";
			strSql += " 	A.CRTDATE ,  \n";
			strSql += " 	A.MODUSERNO ,  \n";
			strSql += " 	A.MODDATE ,  \n";
			strSql += " 	A.WORK_NAME ,  \n";
			strSql += " 	A.SLIP_UPDATE_CLS , \n";
			strSql += " 	A.CHARGE_PERS , \n";
			strSql += " 	ZZ.NAME CHARGE_PERS_NAME \n";
			strSql += " FROM \n";
			strSql += " 	T_WORK_CODE A, \n";
			strSql += " 	Z_AUTHORITY_USER ZZ \n";
			strSql += " WHERE \n";
			strSql += " 	A.CHARGE_PERS = ZZ.EMPNO(+) \n";
			strSql += " ORDER BY  \n";
			strSql += " 	A.WORK_CODE ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("WORK_CODE", true);
				lrReturnData.setNotNull("WORK_NAME", true);
				lrReturnData.setNotNull("SLIP_UPDATE_CLS", true);
				
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
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			String strCOST_DEPT_KND_TAG = CITCommon.toKOR(request.getParameter("COST_DEPT_KND_TAG"));
			
			strSql  = " SELECT \n";
			strSql += " 	A.WORK_CODE, \n";
			strSql += " 	A.COST_DEPT_KND_TAG, \n";
			strSql += " 	B.COST_DEPT_KND_NAME, \n";
			strSql += " 	A.ACC_CODE, \n";
			strSql += " 	C.ACC_NAME, \n";
			strSql += " 	A.ACC_POSITION, \n";
			strSql += " 	A.SUMMARY_CODE, \n";
			strSql += " 	A.SUMMARY1, \n";
			strSql += " 	A.SUMMARY2, \n";
			strSql += " 	A.VAT_CODE, \n";
			strSql += " 	A.SEQ, \n";
			strSql += " 	A.USE_TAG \n";
			strSql += " FROM \n";
			strSql += " 	T_WORK_ACC_CODE A, \n";
			strSql += " 	T_COST_DEPT_KIND B, \n";
			strSql += " 	T_ACC_CODE C \n";
			strSql += " WHERE \n";
			strSql += " 	A.COST_DEPT_KND_TAG = B.COST_DEPT_KND_TAG \n";
			strSql += " 	AND A.ACC_CODE = C.ACC_CODE \n";
			strSql += " 	AND A.WORK_CODE =  ?  \n";
			strSql += " 	AND A.COST_DEPT_KND_TAG LIKE  ? ||'%' ";
			
			lrArgData.addColumn("1WORK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COST_DEPT_KND_TAG", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_CODE", strWORK_CODE);
			lrArgData.setValue("2COST_DEPT_KND_TAG", strCOST_DEPT_KND_TAG);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("WORK_CODE", true);
				lrReturnData.setKey("COST_DEPT_KND_TAG", true);
				lrReturnData.setKey("COST_DEPT_KND_NAME", true);
				lrReturnData.setKey("ACC_CODE", true);
				lrReturnData.setKey("ACC_NAME", true);

				
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
		
		if (strAct.equals("SUB02"))
		{
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			String strCOST_DEPT_KND_TAG = CITCommon.toKOR(request.getParameter("COST_DEPT_KND_TAG"));
			
			strSql  = " SELECT  \n";
			strSql += " 	A.WORK_CODE, \n";
			strSql += " 	A.COST_DEPT_KND_TAG, \n";
			strSql += " 	B.COST_DEPT_KND_NAME, \n";
			strSql += " 	A.VAT_CODE, \n";
			strSql += " 	C.VAT_NAME, \n";
			strSql += " 	A.SEQ, \n";
			strSql += " 	A.USE_TAG \n";
			strSql += " FROM \n";
			strSql += " 	T_WORK_VAT_CODE A, \n";
			strSql += " 	T_COST_DEPT_KIND B, \n";
			strSql += " 	T_ACC_VAT_CODE C \n";
			strSql += " WHERE \n";
			strSql += " 	A.COST_DEPT_KND_TAG = B.COST_DEPT_KND_TAG \n";
			strSql += " 	AND A.VAT_CODE = C.VAT_CODE \n";
			strSql += " 	AND A.WORK_CODE =  ?  \n";
			strSql += " 	AND A.COST_DEPT_KND_TAG LIKE  ? ||'%' \n";
			strSql += "  ";
			
			lrArgData.addColumn("1WORK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COST_DEPT_KND_TAG", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_CODE", strWORK_CODE);
			lrArgData.setValue("2COST_DEPT_KND_TAG", strCOST_DEPT_KND_TAG);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("WORK_CODE", true);
				lrReturnData.setKey("COST_DEPT_KND_TAG", true);
				lrReturnData.setKey("COST_DEPT_KND_NAME", true);
				lrReturnData.setKey("VAT_CODE", true);
				lrReturnData.setKey("VAT_NAME", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB02 Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("SUB03"))
		{
			String strWORK_CODE = CITCommon.toKOR(request.getParameter("WORK_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.WORK_CODE , \n";
			strSql += " 	a.COMP_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.CHARGE_PERS, \n";
			strSql += " 	b.NAME CHARGE_PERS_NAME\n";
			strSql += " From	T_WORK_CHARGE_PERS a, \n";
			strSql += " 		Z_AUTHORITY_USER b \n";
			strSql += " Where	a.CHARGE_PERS = b.EMPNO \n";
			strSql += " And		a.WORK_CODE =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.WORK_CODE , \n";
			strSql += " 	a.COMP_CODE ";
			
			lrArgData.addColumn("1WORK_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1WORK_CODE", strWORK_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("WORK_CODE", true);
				lrReturnData.setKey("COMP_CODE", true);
				lrReturnData.setNotNull("CHARGE_PERS", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","SUB03 Select 오류-> "+ ex.getMessage());
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