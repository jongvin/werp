<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : t_WSubCdR.jsp(공제계정등록)
/* 2. 유형(시나리오) : shared window 조회 및 입력
/* 3. 기  능  정  의 : 공제계정등록
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

			
			strSql  = " Select \n";
			strSql += " 	a.SUBSCD SUDANGCD , \n";
			strSql += " 	a.HNAME, \n";
			strSql += " 	b.ACC_CODE , \n";
			strSql += " 	b.ACC_CODE2, \n";
			strSql += " 	b.INCLUDE_TAG, \n";
			strSql += " 	c1.ACC_NAME ACC_NAME_1, \n";
			strSql += " 	c2.ACC_NAME ACC_NAME_2 \n";
			strSql += " From	CSUB001VV a, \n";
			strSql += " 		T_FIN_SUB_ACC_CODE b, \n";
			strSql += " 		T_ACC_CODE c1, \n";
			strSql += " 		T_ACC_CODE c2 \n";
			strSql += " Where	a.SUBSCD = b.SUBSCD (+) \n";
			strSql += " And		b.ACC_CODE = c1.ACC_CODE (+) \n";
			strSql += " And		b.ACC_CODE2 = c2.ACC_CODE (+) \n";
			strSql += " Order By \n";
			strSql += " 	a.SUBSCD \n";
			strSql += "  ";
			

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