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
			
			strSql  = " Select                     \n";
			strSql += " 	a.BUDG_CODE_NO ,       \n";
			strSql += " 	a.comp_code ,       \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	To_Char(a.P_BUDG_CODE_NO) P_BUDG_CODE_NO, \n";
			strSql += " 	a.LEVEL_SEQ , \n";
			strSql += " 	a.LEGACY_BUDG_CODE , \n";
			strSql += " 	a.BUDG_CODE_NAME , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	(Select b.ACC_NAME  From	T_ACC_CODE b Where	a.ACC_CODE = b.ACC_CODE ) ACC_NAME , \n"; 
			strSql += " 	a.USE_CLS , \n";
			strSql += " 	a.CONTROL_LEVEL_TAG , \n";
			strSql += " 	Level LV , \n";
			strSql += " 	a.BUDG_ITEM_CODE, \n";
			strSql += " 	a.MAKE_DEPT,  \n";
			strSql += " 	nvl(a.ASSIGN_TAG,'F')  ASSIGN_TAG, \n";
			strSql += " 	(Select b.DEPT_NAME  From	T_DEPT_CODE b Where	a.MAKE_DEPT = b.DEPT_CODE ) MAKE_DEPT_NAME  \n"; 
			strSql += " From	T_BUDG_CODE a \n";
			strSql += " Where	a.COMP_CODE =  ?  \n";
			strSql += " Start With a.P_BUDG_CODE_NO = (select p_budg_code_no \n";
			strSql += " 							   from t_budg_code \n";
			strSql += " 							   where budg_code_no = (select min(budg_code_no) \n";
	  		strSql += " 							   	   	  from t_budg_code \n";
			strSql += " 							   		  where comp_code = ?)) \n"; //530000000
			strSql += " Connect By \n";
			strSql += " 	Prior	a.BUDG_CODE_NO = a.P_BUDG_CODE_NO \n";
			strSql += " Order Siblings By \n";
			strSql += " 	a.LEVEL_SEQ ";
			
			lrArgData.addColumn("1COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("2COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("2COMP_CODE", strCOMP_CODE);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("BUDG_CODE_NO", true);

				
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
			
			strSql  = " Select \n";
			strSql += " 	a.BUDG_CODE_NO , \n";
			strSql += " 	a.comp_code ,       \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	To_Char(a.P_BUDG_CODE_NO) P_BUDG_CODE_NO, \n";
			strSql += " 	a.LEVEL_SEQ , \n";
			strSql += " 	a.LEGACY_BUDG_CODE , \n";
			strSql += " 	a.BUDG_CODE_NAME , \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	a.USE_CLS , \n";
			strSql += " 	a.CONTROL_LEVEL_TAG , \n";
			strSql += " 	Level LV , \n";
			strSql += " 	a.BUDG_ITEM_CODE, \n";
			strSql += " 	a.MAKE_DEPT,  \n";
			strSql += " 	nvl(a.ASSIGN_TAG,'F')  ASSIGN_TAG \n";
			strSql += " From	T_BUDG_CODE a \n";
			strSql += " Where	RowNum < 1 \n";
			strSql += " And	a.COMP_CODE =  ?  \n";
			strSql += " Start With a.P_BUDG_CODE_NO = 0 \n";
			strSql += " Connect By \n";
			strSql += " 	Prior	a.BUDG_CODE_NO = a.P_BUDG_CODE_NO \n";
			strSql += " Order Siblings By \n";
			strSql += " 	a.LEVEL_SEQ ";
			
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("BUDG_CODE_NO", true);

				
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

			
			strSql  = " Select SQ_T_BUDG_CODE_NO.NextVal BUDG_CODE_NO From Dual  \n";
			

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