<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WVatCodeR_q.jsp(부가세코드 등록)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 김흥수 작성(2005-11-18)
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
			strSql += " 	a.VAT_CODE , \n";
			strSql += " 	a.CRTUSERNO , \n";
			strSql += " 	a.CRTDATE , \n";
			strSql += " 	a.MODUSERNO , \n";
			strSql += " 	a.MODDATE , \n";
			strSql += " 	a.VAT_NAME , \n";
			strSql += " 	a.SUBTR_CLS , \n";
			strSql += " 	a.SALEBUY_CLS , \n";
			strSql += " 	a.RCPTBILL_CLS , \n";
			strSql += " 	a.VATOCCUR_CLS , \n";
			strSql += " 	a.DIVI_CLS , \n";
			strSql += " 	a.SLIP_DETAIL_LIST , \n";
			strSql += " 	a.ACC_CODE, \n";
			strSql += " 	b.ACC_NAME, \n";
			strSql += " 	A.BRAIN_CLS \n";
			strSql += " From	T_ACC_VAT_CODE a, \n";
			strSql += " 		T_ACC_CODE b \n";
			strSql += " Where	a.ACC_CODE = b.ACC_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.VAT_CODE \n";
			strSql += "  ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("VAT_CODE", true);
				lrReturnData.setNotNull("VAT_NAME", true);
				lrReturnData.setNotNull("RCPTBILL_CLS", true);
				lrReturnData.setNotNull("SUBTR_CLS", true);
				lrReturnData.setNotNull("BRAIN_CLS", true);
				
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
