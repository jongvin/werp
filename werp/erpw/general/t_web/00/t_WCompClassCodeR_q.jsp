<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-02)
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

			
			strSql  = " select a.comp_code, \n";
			strSql += "        a.company_name \n";
			strSql += " from   T_COMPANY  a \n";
			strSql += " order by comp_code ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COMP_CODE", true);

				
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
		else if (strAct.equals("MAIN01"))
		{

			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = "SELECT \n";
			strSql += "	DEPT_CODE, \n";
			strSql += "	DEPT_NAME, \n";
			strSql += "	DEPT_SHORT_NAME \n";
			strSql += "FROM \n";
			strSql += "	T_DEPT_CODE_ORG \n";
			strSql += "WHERE \n";
			strSql += "	COMP_CODE = ? \n";
			strSql += "ORDER BY \n";
			strSql += "	DEPT_CODE \n";

			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("DEPT_CODE", true);

				
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

			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " select a.CLASS_CODE, 							\n";
			strSql += "        c.CLASS_CODE_NAME, 						\n";
			strSql += "        a.dept_CODE, 							\n";
			strSql += "        b.dept_NAME, 							\n";
			strSql += "        a.DFLT_TAG 							    \n";
			strSql += " from   T_DEPT_CLASS_CODE a, 					\n";
			strSql += "        T_DEPT_CODE_ORG b, 							\n";
			strSql += "        T_CLASS_CODE c 							\n";
			strSql += " where  a.class_code = c.class_code 				\n";
			strSql += " and	   a.DEPT_CODE  = b.DEPT_CODE 				\n";
			strSql += " and    a.DEPT_CODE = ? 							\n";
			strSql += " and    exists ( select * 					\n";
			strSql += " 	         		from t_dept_class_code a1 	\n";
			strSql += " 		            where a1.DEPT_CODE = ? )		\n";
			strSql += " order by 	a.CLASS_CODE        \n";
			
			lrArgData.addColumn("DEPT_CODE1", CITData.VARCHAR2);
			lrArgData.addColumn("DEPT_CODE2", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("DEPT_CODE1", strDEPT_CODE);
			lrArgData.setValue("DEPT_CODE2", strDEPT_CODE);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CLASS_CODE", true);
				lrReturnData.setKey("DEPT_CODE", true);

				
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
		else if (strAct.equals("SUB02"))
		{

			String strDEPT_CODE = CITCommon.toKOR(request.getParameter("DEPT_CODE"));
			
			strSql  = " select a.CLASS_CODE, \n";
			strSql += "        a.CLASS_CODE_NAME \n";
			strSql += " from   T_CLASS_CODE a \n";
			strSql += " where    class_code not in ( select class_code \n";
			strSql += " 		             from t_dept_class_code a \n";
			strSql += " 		             where a.DEPT_CODE = ? \n";
			strSql += "                     ) ";
			strSql += " order by 	a.CLASS_CODE        \n";
			
			lrArgData.addColumn("DEPT_CODE", CITData.VARCHAR2);
			lrArgData.addRow();                                   
			lrArgData.setValue("DEPT_CODE", strDEPT_CODE);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("CLASS_CODE", true);

				
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