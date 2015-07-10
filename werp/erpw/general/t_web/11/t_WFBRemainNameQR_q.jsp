<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 배민정 작성(2006-01-20)
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
			String strBANK_CD   = CITCommon.toKOR(request.getParameter("BANK_CD"));
			String strACCNO_CD  = CITCommon.toKOR(request.getParameter("ACCNO_CD"));
			String strBASE_NO   = CITCommon.toKOR(request.getParameter("BASE_NO"));
			
 			strSql  = " Select f_retrive_acct_holder_name(?,?,?,?) RET_VAL  FROM Dual "+"\r\n";
		
			lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("BANK_CD", CITData.VARCHAR2);
			lrArgData.addColumn("ACCNO_CD", CITData.VARCHAR2);
			lrArgData.addColumn("BASE_NO", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("COMP_CODE", strCOMP_CODE);
			lrArgData.setValue("BANK_CD", strBANK_CD);
			lrArgData.setValue("ACCNO_CD", strACCNO_CD);
			lrArgData.setValue("BASE_NO", strBASE_NO);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
		}
		else if (strAct.equals("SUB"))
		{			
			String strBANK_CODE  = CITCommon.toKOR(request.getParameter("BANK_CODE"));
			String strACCNO_CODE = CITCommon.toKOR(request.getParameter("ACCNO_CODE"));
       			
			strSql  = " Select f_select_remains(?,?) RET_VAL FROM Dual "+"\r\n";
		
			lrArgData.addColumn("BANK_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("ACCNO_CODE", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("BANK_CODE", strBANK_CODE);
			lrArgData.setValue("ACCNO_CODE", strACCNO_CODE);
			
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

		}
		else if (strAct.equals("STR"))
		{			
			String strVALUE  = CITCommon.toKOR(request.getParameter("RET_VAL"));
			String strGubun  = CITCommon.toKOR(request.getParameter("GUBUN"));

      if (strGubun.equals("Name"))
      {
				strSql  = " Select SUBSTRB(?,1,14) VALUE1, "+"\r\n"+
				          "        SUBSTRB(?,15,LENGTH(?)) VALUE2 "+"\r\n"+
				          " FROM   DUAL "+"\r\n";
			
				lrArgData.addColumn("RET_VAL1", CITData.VARCHAR2);
				lrArgData.addColumn("RET_VAL2", CITData.VARCHAR2);
				lrArgData.addColumn("RET_VAL3", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("RET_VAL1", strVALUE);
				lrArgData.setValue("RET_VAL2", strVALUE);
				lrArgData.setValue("RET_VAL3", strVALUE);
			}
			else if (strGubun.equals("Remain"))
			{
				strSql  = " Select to_number(SUBSTRB(?,1,1)||SUBSTRB(?,2,13)) VALUE1, "+"\r\n"+
				          "        to_number(SUBSTRB(?,15,13)) VALUE2, "+"\r\n"+
				          "        SUBSTRB(?,28,LENGTH(?)) VALUE3 "+"\r\n"+
				          " FROM   DUAL "+"\r\n";
			
				lrArgData.addColumn("RET_VAL1", CITData.VARCHAR2);
				lrArgData.addColumn("RET_VAL2", CITData.VARCHAR2);
				lrArgData.addColumn("RET_VAL3", CITData.VARCHAR2);
				lrArgData.addColumn("RET_VAL4", CITData.VARCHAR2);
				lrArgData.addColumn("RET_VAL5", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("RET_VAL1", strVALUE);
				lrArgData.setValue("RET_VAL2", strVALUE);
				lrArgData.setValue("RET_VAL3", strVALUE);	
				lrArgData.setValue("RET_VAL4", strVALUE);	
				lrArgData.setValue("RET_VAL5", strVALUE);	
			}				
		
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);

		}		
		try
		{
			lrDataset = CITCommon.toGauceDataSet(lrReturnData);
			GauceInfo.response.enableFirstRow(lrDataset);
			lrDataset.flush();
		}
		catch (Exception ex)
		{
			GauceInfo.response.writeException("USER", "900001", ex.getMessage());
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