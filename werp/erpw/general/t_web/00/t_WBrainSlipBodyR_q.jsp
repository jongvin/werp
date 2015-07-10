<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : 
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 한재원 작성(2005-12-06)
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
			String strBRAIN_SLIP_SEQ1 = CITCommon.toKOR(request.getParameter("BRAIN_SLIP_SEQ1"));
			String strBRAIN_SLIP_SEQ2 = CITCommon.toKOR(request.getParameter("BRAIN_SLIP_SEQ2"));
			
			strSql  = " SELECT \n";
			strSql += "        A.BRAIN_SLIP_SEQ1, \n";
			strSql += "        A.BRAIN_SLIP_SEQ2, \n";
			strSql += "        A.BRAIN_SLIP_LINE, \n";
			strSql += "        A.ACC_CODE, \n";
			strSql += "        B.ACC_NAME, \n";
			strSql += "        A.ACC_POSITION, \n";
			strSql += "        A.SUMMARY_CODE, \n";
			strSql += "        A.SUMMARY1, \n";
			strSql += "        A.SUMMARY2, \n";
			strSql += "        A.BRAIN_SORT_SEQ, \n";
			strSql += " 	A.BRAIN_CLS, \n";
			strSql += " 	NVL(A.BRAIN_REPEAT_CLS, 'F') BRAIN_REPEAT_CLS, \n";
			strSql += " 	NVL(A.MAIN_ACC_CODE_TAG, 'F') MAIN_ACC_CODE_TAG, \n";
			strSql += " 	NVL(A.BRAIN_DEL_CLS, 'F') BRAIN_DEL_CLS \n";
			strSql += " FROM \n";
			strSql += "     T_BRAIN_SLIP_BODY A, \n";
			strSql += "     T_ACC_CODE B \n";
			strSql += " WHERE	A.ACC_CODE = B.ACC_CODE(+) \n";
			strSql += " AND   	A.BRAIN_SLIP_SEQ1 = ?   		\n";
			strSql += " AND   	A.BRAIN_SLIP_SEQ2 = ?   		\n";
			strSql += " ORDER BY BRAIN_SORT_SEQ   		    \n";
			
			lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
			lrArgData.addColumn("BRAIN_SLIP_SEQ2", CITData.NUMBER);
			lrArgData.addRow();                                   
			lrArgData.setValue("BRAIN_SLIP_SEQ1", strBRAIN_SLIP_SEQ1);
			lrArgData.setValue("BRAIN_SLIP_SEQ2", strBRAIN_SLIP_SEQ2);

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("BRAIN_SLIP_SEQ1", true);
				lrReturnData.setKey("BRAIN_SLIP_SEQ2", true);
				lrReturnData.setKey("BRAIN_SLIP_LINE", true);
				lrReturnData.setNotNull("ACC_CODE", true);
				lrReturnData.setNotNull("ACC_POSITION", true);
				//lrReturnData.setNotNull("SUMMARY_CODE", true);
				//lrReturnData.setNotNull("SUMMARY1", true);
				//lrReturnData.setNotNull("VAT_CODE", true);
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
		
		else if (strAct.equals("BRAIN_SLIP_SEQ2"))
		{
			String strBRAIN_SLIP_SEQ1 = CITCommon.toKOR(request.getParameter("BRAIN_SLIP_SEQ1"));
			
			strSql  = " SELECT                        \n";
			strSql += "        A.BRAIN_SLIP_SEQ2,     \n";
			strSql += "        A.BRAIN_SLIP_NAME2     \n";
			strSql += " FROM  T_BRAIN_SLIP_HEAD A     \n";
			strSql += " WHERE  A.BRAIN_SLIP_SEQ1 = ?   \n";
			strSql += " ORDER BY BRAIN_SLIP_SEQ2       ";
			
			lrArgData.addColumn("BRAIN_SLIP_SEQ1", CITData.NUMBER);
			lrArgData.addRow();                                   
			lrArgData.setValue("BRAIN_SLIP_SEQ1", strBRAIN_SLIP_SEQ1);
			
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
		
		else if (strAct.equals("BRAIN_SLIP_SEQ1"))
		{

			strSql  = " SELECT                    \n";
			strSql += "        A.BRAIN_SLIP_SEQ1, \n";
			strSql += "        A.BRAIN_SLIP_NAME1 \n";
			strSql += " FROM  T_BRAIN_SLIP A     \n";
			strSql += " ORDER BY BRAIN_SLIP_SEQ1    ";
			
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
		else if (strAct.equals("SEQ"))
		{
			strSql  = " SELECT                    			     \n";
			strSql += "        SQ_T_BRAIN_SLIP_BODY.nextval SEQ  \n";
			strSql += " FROM  dual     						     \n";
			
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