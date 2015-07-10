<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 홍길동 작성(2005-11-15)
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
		
		if (strAct.equals("ACC_CODE"))
		{
			String strACC_GRP = CITCommon.toKOR(request.getParameter("ACC_GRP"));
			String strACC_NAME = CITCommon.toKOR(request.getParameter("ACC_NAME"));
			
			strSql  = " Select \n";
			strSql += " 	a.ACC_CODE , \n";
			strSql += " 	'F' S_AMT_TAG , \n";
			strSql += " 	'T' T_DFLT_TAG , \n";
			strSql += " 	a.ACC_NAME , \n";
			strSql += " 	a.ACC_GRP , \n";
			strSql += " 	b.CODE_LIST_NAME as ACC_GRP_NM , \n";
			strSql += " 	a.ACC_LVL , \n";
			strSql += " 	c.CODE_LIST_NAME as ACC_LVL_NM \n";
			strSql += " from	T_ACC_CODE a , \n";
			strSql += " 		V_T_CODE_LIST b , \n";
			strSql += " 		V_T_CODE_LIST c \n";
			strSql += " where	a.FUND_INPUT_CLS = 'T' \n";
			strSql += " And	a.ACC_GRP = b.CODE_LIST_ID(+) \n";
			strSql += " And	b.CODE_GROUP_ID(+) = 'ACC_GRP' \n";
			strSql += " And	a.ACC_LVL = c.CODE_LIST_ID(+) \n";
			strSql += " And	c.CODE_GROUP_ID(+) = 'ACC_LVL' \n";
			strSql += " And	a.ACC_GRP like	'%'|| ? ||'%' \n";
			strSql += " and	a.ACC_NAME like '%'|| ? ||'%' \n";
			strSql += " and	a.ACC_CODE Not In ( Select x.ACC_CODE From T_SET_EMP_INSUR_ACC_CODE x) \n";
			strSql += " Order by \n";
			strSql += " 	a.ACC_GRP , \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	a.ACC_LVL \n";
			strSql += "  ";
			
			lrArgData.addColumn("ACC_GRP", CITData.VARCHAR2);
			lrArgData.addColumn("ACC_NAME", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("ACC_GRP", strACC_GRP);
			lrArgData.setValue("ACC_NAME", strACC_NAME);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				lrReturnData.setKey("ACC_CODE", true);
				lrReturnData.setNotNull("ACC_NAME", true);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","ACC_CODE Select 오류-> "+ ex.getMessage());
			}
		}
		else if (strAct.equals("MAIN"))
		{

			
			strSql  = " Select \n";
			strSql += " 	x.ACC_CODE , \n";
			strSql += " 	x.S_AMT_TAG , \n";
			strSql += " 	x.T_DFLT_TAG , \n";
			strSql += " 	a.ACC_NAME , \n";
			strSql += " 	a.ACC_GRP , \n";
			strSql += " 	b.CODE_LIST_NAME as ACC_GRP_NM , \n";
			strSql += " 	a.ACC_LVL , \n";
			strSql += " 	c.CODE_LIST_NAME as ACC_LVL_NM \n";
			strSql += " from	T_SET_EMP_INSUR_ACC_CODE x, \n";
			strSql += " 		T_ACC_CODE a , \n";
			strSql += " 		V_T_CODE_LIST b , \n";
			strSql += " 		V_T_CODE_LIST c \n";
			strSql += " where	a.FUND_INPUT_CLS = 'T' \n";
			strSql += " And	a.ACC_GRP = b.CODE_LIST_ID(+) \n";
			strSql += " And	b.CODE_GROUP_ID(+) = 'ACC_GRP' \n";
			strSql += " And	a.ACC_LVL = c.CODE_LIST_ID(+) \n";
			strSql += " And	c.CODE_GROUP_ID(+) = 'ACC_LVL' \n";
			strSql += " And	a.ACC_CODE = x.ACC_CODE \n";
			strSql += " Order by \n";
			strSql += " 	a.ACC_GRP , \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	a.ACC_LVL \n";
			strSql += "  ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ACC_CODE", true);

				
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