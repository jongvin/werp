<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WPersonOrderR.jsp(개인별발령사항)
/* 2. 유형(시나리오) : Left-Right(Master-Detail)
/* 3. 기  능  정  의 : 개인별발령사항 등록
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-03)
/* 5. 관련  프로그램 : 없음
/* 6. 특  기  사  항 : 없음
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
		
		if (strAct.equals("MASTER"))
		{
			String strNAME = CITCommon.toKOR(request.getParameter("NAME"));
			
			strSql  = " Select \n";
			strSql += " 	a.EMPNO, \n";
			strSql += " 	a.NAME, \n";
			strSql += " 	b.DEPT_CODE, \n";
			strSql += " 	b.DEPT_NAME \n";
			strSql += " From	Z_AUTHORITY_USER a, \n";
			strSql += " 		T_DEPT_CODE b \n";
			strSql += " Where	a.EMPNO || a.NAME ||Nvl(b.DEPT_NAME,'%') Like '%' ||  ?  || '%' \n";
			strSql += " And		a.DEPT_CODE = b.DEPT_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.NAME ";
			
			lrArgData.addColumn("1NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1NAME", strNAME);
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
		else if (strAct.equals("MAIN"))
		{
			String strEMP_NO = CITCommon.toKOR(request.getParameter("EMP_NO"));
			
			strSql  = " Select \n";
			strSql += " 	a.EMP_NO , \n";
			strSql += " 	a.ORDER_SEQ , \n";
			strSql += " 	a.DEPT_CODE , \n";
			strSql += " 	F_T_DATETOSTRING(a.ORDER_DT) ORDER_DT , \n";
			strSql += " 	a.SAFE_MNG_TAG , \n";
			strSql += " 	a.WORK_TAG , \n";
			strSql += " 	a.REMARKS, \n";
			strSql += " 	b.DEPT_NAME \n";
			strSql += " From	T_FIN_EMP_ORDER a, \n";
			strSql += " 		T_DEPT_CODE_ORG b \n";
			strSql += " Where	a.EMP_NO =  ?  \n";
			strSql += " And		a.DEPT_CODE = b.DEPT_CODE \n";
			strSql += " Order By \n";
			strSql += " 	a.ORDER_DT, \n";
			strSql += " 	a.ORDER_SEQ \n";
			strSql += "  ";
			
			lrArgData.addColumn("1EMP_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1EMP_NO", strEMP_NO);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrReturnData.setNotNull("ORDER_DT",true);
				lrReturnData.setNotNull("DEPT_CODE",true);
				


				
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
		else if (strAct.equals("ORDER_SEQ"))
		{
			
			strSql  = " Select SQ_T_ORDER_SEQ.NextVal ORDER_SEQ From Dual \n";
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
				GauceInfo.response.writeException("USER", "900001","ORDER_SEQ Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("EMP_LIST"))
		{
			
			strSql  = " Select 'XXXXXXXXXXXXXXXXXXXXXX' EMP_NO From Dual Where 1 = 0 \n";
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
				GauceInfo.response.writeException("USER", "900001","EMP_LIST Select 오류-> "+ ex.getMessage());
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