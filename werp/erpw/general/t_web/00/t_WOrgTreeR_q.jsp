<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-22)
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
			
		
			
			strSql  = " Select decode(p_dept_code, null, 0, p_dept_code) p_dept_code, \n";
			strSql += " 	   dept_code, \n";
			strSql += " 	   dept_name, \n";
			strSql += " 	   level lv \n";
			strSql += " From   t_dept_code a \n";
			strSql += " Where  a.COMP_CODE =  ?    \n";
			strSql += "  Start With a.dept_code = (select dept_code \n";
			strSql += "  	   	      from t_dept_code b \n";
			strSql += " 		      where b.COMP_CODE =  ?  \n";
			strSql += " 		     and dept_kind_tag = ( \n";
			strSql += " 				    select min(dept_kind_tag) \n";
			strSql += " 				   from t_dept_level) )  \n";
			strSql += "  Connect By  \n";
			strSql += "  	Prior	a.dept_code = a.p_dept_code  \n";
			strSql += "  Order Siblings By  \n";
			strSql += "  	a.dept_code ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);

			
		
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				//lrReturnData.setKey("BUDG_CODE_NO", true);

				
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
		else if (strAct.equals("MAIN_D"))
		{

			String strCOMP_CODE = CITCommon.toKOR(request.getParameter("COMP_CODE"));
			
			strSql  = " Select decode(p_dept_code, null, 0, p_dept_code) p_dept_code, \n";
			strSql += " 	   dept_code, \n";
			strSql += " 	   dept_name, \n";
			strSql += " 	   level lv\n";
			strSql += " From   t_dept_code a \n";
			strSql += " Where  a.COMP_CODE =  ?    \n";
			strSql += " And	RowNum < 1 \n";
			strSql += "  Start With a.dept_code = (select dept_code \n";
			strSql += "  	   	      from t_dept_code b\n";
			strSql += " 		      where b.COMP_CODE =  ?  \n";
			strSql += " 		     and dept_kind_tag = ( \n";
			strSql += " 				    select min(dept_kind_tag) \n";
			strSql += " 				   from t_dept_level) )  \n";
			strSql += "  Connect By  \n";
			strSql += "  	Prior	a.dept_code = a.p_dept_code  \n";
			strSql += "  Order Siblings By  \n";
			strSql += "  	a.dept_code ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);

			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				//lrReturnData.setKey("BUDG_CODE_NO", true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN_D Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("BUDG_CODE_NO"))
		{

			
			//strSql  = " Select SQ_T_BUDG_CODE_NO.NextVal BUDG_CODE_NO From Dual  \n";
			

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
				GauceInfo.response.writeException("USER", "900001","BUDG_CODE_NO Select 오류-> "+ ex.getMessage());
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