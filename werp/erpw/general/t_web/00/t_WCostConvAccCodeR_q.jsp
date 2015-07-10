<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2006-04-10)
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

			
			strSql  = " Select \n";
			strSql += " 	a.COST_CONV_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.SALE_ACC_CODE , \n";
			strSql += " 	b.ACC_NAME , \n";
			strSql += " 	a.COST_CONV_NAME \n";
			strSql += " From	T_SET_COST_CONV_CODE a , \n";
			strSql += " 		T_ACC_CODE b  \n";
			strSql += " Where	a.SALE_ACC_CODE = b.ACC_CODE (+)  \n";
			strSql += " Order By \n";
			strSql += " 	a.COST_CONV_CODE ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COST_CONV_CODE",true);
				lrReturnData.setNotNull("COST_CONV_NAME",true);
				


				
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
			String strCOST_CONV_CODE = CITCommon.toKOR(request.getParameter("COST_CONV_CODE"));
			
			strSql  = " Select \n";
			strSql += " 	a.COST_CONV_CODE, \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	a.R_ACC_CODE, \n";
			strSql += " 	a.R_ACC_CODE2, \n";
			strSql += " 	a.R_ACC_CODE3, \n";
			strSql += " 	a.R_ACC_CODE4, \n";
			strSql += " 	a.R_ACC_CODE5, \n";
			strSql += " 	b.ACC_NAME ACC_NAME_COST, \n";
			strSql += " 	d.ACC_NAME ACC_NAME_CONV2, \n";
			strSql += " 	e.ACC_NAME ACC_NAME_CONV3, \n";
			strSql += " 	f.ACC_NAME ACC_NAME_CONV4, \n";
			strSql += " 	g.ACC_NAME ACC_NAME_CONV5, \n";
			strSql += " 	c.ACC_NAME ACC_NAME_CONV \n";
			strSql += " From	T_SET_COST_CONV_ACC a, \n";
			strSql += " 		T_ACC_CODE b, \n";
			strSql += " 		T_ACC_CODE d, \n";
			strSql += " 		T_ACC_CODE e, \n";
			strSql += " 		T_ACC_CODE f, \n";
			strSql += " 		T_ACC_CODE g, \n";
			strSql += " 		T_ACC_CODE c \n";
			strSql += " Where	a.ACC_CODE = b.ACC_CODE \n";
			strSql += " And		a.R_ACC_CODE = c.ACC_CODE (+) \n";
			strSql += " And		a.R_ACC_CODE2 = d.ACC_CODE (+) \n";
			strSql += " And		a.R_ACC_CODE3 = e.ACC_CODE (+) \n";
			strSql += " And		a.R_ACC_CODE4 = f.ACC_CODE (+) \n";
			strSql += " And		a.R_ACC_CODE5 = g.ACC_CODE (+) \n";
			strSql += " And		a.COST_CONV_CODE =  ?  \n";
			strSql += " Order By \n";
			strSql += " 	a.ACC_CODE \n";
			strSql += "  ";
			
			lrArgData.addColumn("1COST_CONV_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("1COST_CONV_CODE", strCOST_CONV_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("COST_CONV_CODE",true);
				lrReturnData.setKey("ACC_CODE",true);
				lrReturnData.setNotNull("ACC_NAME_COST",true);


				
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