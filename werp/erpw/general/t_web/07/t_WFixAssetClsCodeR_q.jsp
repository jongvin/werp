<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2006-01-16)
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

			
			strSql  = " select \n";
			strSql += " 	  a.ASSET_CLS_CODE, 	 \n";
			strSql += " 	  a.ASSET_CLS_NAME,  \n";
			strSql += " 	  a.ASSET_ACC_CODE, \n";
			strSql += " 	  b1.ACC_NAME ASSET_ACC_NAME,	 	 \n";
			strSql += " 	  a.DEPREC_CLS,  \n";
			strSql += " 	  a.SRVLIFE,  \n";
			strSql += " 	  a.DISLIFE,  \n";
			strSql += " 	  a.SUM_ACC_CODE,  \n";
			strSql += " 	  b2.ACC_NAME SUM_ACC_NAME,	\n";
			strSql += " 	  a.SELL_PORF_ACC_CODE, 	       \n";
			strSql += " 	  b3.ACC_NAME SELL_PORF_ACC_NAME,	\n";
			strSql += " 	  a.SELL_LOSS_ACC_CODE, 	       \n";
			strSql += " 	  b4.ACC_NAME SELL_LOSS_ACC_NAME,	\n";
			strSql += " 	  a.APPR_PROF_ACC_CODE, 	       \n";
			strSql += " 	  b5.ACC_NAME APPR_PROF_ACC_NAME,	\n";
			strSql += " 	  a.APPR_LOSS_ACC_CODE,           \n";
			strSql += " 	  b6.ACC_NAME APPR_LOSS_ACC_NAME,	\n";
			strSql += " 	  a.CAP_EXP_ACC_CODE,              \n";
			strSql += " 	  b7.ACC_NAME CAP_EXP_ACC_NAME,	\n";
			strSql += " 	  a.VAT_ACC_CODE,                     \n";
			strSql += " 	  b8.ACC_NAME VAT_ACC_NAME,	\n";
			strSql += " 	  a.CAP_EXP_VAT_ACC_CODE,       \n";
			strSql += " 	  b9.ACC_NAME CAP_EXP_VAT_ACC_NAME,	\n";
			strSql += " 	  a.SELL_ACC_CODE,                    \n";
			strSql += " 	  b10.ACC_NAME SELL_ACC_NAME,	\n";
			strSql += " 	  a.TRA_ACC_CODE,                     \n";
			strSql += " 	  b11.ACC_NAME TRA_ACC_NAME,	\n";
			strSql += " 	  a.SELL_VAT_ACC_CODE,                     \n";
			strSql += " 	  b12.ACC_NAME SELL_VAT_ACC_NAME	\n";
			strSql += " from T_FIX_ASSET_CLS_CODE a,        \n";
			strSql += " 	 T_ACC_CODE b1, \n";
			strSql += " 	 T_ACC_CODE b2, \n";
			strSql += " 	 T_ACC_CODE b3, \n";
			strSql += " 	 T_ACC_CODE b4, \n";
			strSql += " 	 T_ACC_CODE b5, \n";
			strSql += " 	 T_ACC_CODE b6, \n";
			strSql += " 	 T_ACC_CODE b7, \n";
			strSql += " 	 T_ACC_CODE b8, \n";
			strSql += " 	 T_ACC_CODE b9, \n";
			strSql += " 	 T_ACC_CODE b10, \n";
			strSql += " 	 T_ACC_CODE b11, \n";
			strSql += " 	 T_ACC_CODE b12 \n";
			strSql += " where a.ASSET_ACC_CODE = b1.ACC_CODE(+) ";
			strSql += " and     a.SUM_ACC_CODE = b2.ACC_CODE(+) ";
			strSql += " and     a.SELL_PORF_ACC_CODE = b3.ACC_CODE(+) ";
			strSql += " and     a.SELL_LOSS_ACC_CODE = b4.ACC_CODE(+) ";
			strSql += " and     a.APPR_PROF_ACC_CODE = b5.ACC_CODE(+) ";
			strSql += " and     a.APPR_LOSS_ACC_CODE = b6.ACC_CODE(+) ";
			strSql += " and     a.CAP_EXP_ACC_CODE     = b7.ACC_CODE(+) ";
			strSql += " and     a.VAT_ACC_CODE = b8.ACC_CODE(+) ";
			strSql += " and     a.CAP_EXP_VAT_ACC_CODE = b9.ACC_CODE(+) ";
			strSql += " and     a.SELL_ACC_CODE = b10.ACC_CODE(+) ";
			strSql += " and     a.TRA_ACC_CODE = b11.ACC_CODE(+) ";
			strSql += " and     a.SELL_VAT_ACC_CODE = b12.ACC_CODE(+) ";
			strSql += " ORDER by  ASSET_CLS_CODE";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ASSET_CLS_CODE", true);
				lrReturnData.setNotNull("ASSET_CLS_NAME", true);
				lrReturnData.setNotNull("ASSET_ACC_CODE", true);
				
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