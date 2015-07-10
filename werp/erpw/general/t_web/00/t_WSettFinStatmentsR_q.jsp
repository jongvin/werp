<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* 이 프로그램은 대보시스템(주) 의 재산입니다.
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-12-01
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/
 
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

			
			strSql  = "Select \n";
			strSql  += "	a.SHEET_CODE , \n";
			strSql  += "	To_Char(a.CRTUSERNO) CRTUSERNO, \n";
			strSql  += "	a.CRTDATE , \n";
			strSql  += "	To_Char(a.MODUSERNO) MODUSERNO , \n";
			strSql  += "	a.MODDATE , \n";
			strSql  += "	a.SHEET_NAME , \n";
			strSql  += "	a.SHEET_PRINT_NAME , \n";
			strSql  += "	a.SHEET_TYPE , \n";
			strSql  += "	Nvl(a.AMTUNIT,0) AMTUNIT , \n";
			strSql  += "	Nvl(a.INDENTCNT,0) INDENTCNT , \n";
			strSql  += "	a.ROUND_CLS , \n";
			strSql  += "	a.COST_CODE , \n";
			strSql  += "	a.ZERO_CLS , \n";
			strSql  += "	a.MONTH_SUM_TAG , \n";
			strSql  += "	a.SHEET_ENG_NAME \n";
			strSql  += "From	T_SHEET_CODE a \n";
			strSql  += "Order By \n";
			strSql  += "	a.SHEET_CODE";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SHEET_CODE",true);
				lrReturnData.setNotNull("SHEET_NAME",true);
				lrReturnData.setNotNull("SHEET_TYPE",true);
				lrReturnData.setNotNull("ROUND_CLS",true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","MAIN Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:MAIN Select 오류 -> " + ex.getMessage());
				}
			}
		}
		else if (strAct.equals("SHEET_TYPE"))
		{

			
			strSql  = "Select \n";
			strSql  += "	a.CODE_LIST_ID , \n";
			strSql  += "	a.CODE_LIST_NAME , \n";
			strSql  += "	a.SEQ \n";
			strSql  += "From	V_T_CODE_LIST a \n";
			strSql  += "Where	a.CODE_GROUP_ID = 'SHEET_TYPE' \n";
			strSql  += "And		a.USE_TAG = 'T' \n";
			strSql  += "Order By \n";
			strSql  += "	a.SEQ, \n";
			strSql  += "	a.CODE_LIST_ID";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","SHEET_TYPE Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:SHEET_TYPE Select 오류 -> " + ex.getMessage());
				}
			}
		}
		else if (strAct.equals("ROUND_CLS"))
		{

			
			strSql  = "Select \n";
			strSql  += "	a.CODE_LIST_ID , \n";
			strSql  += "	a.CODE_LIST_NAME , \n";
			strSql  += "	a.SEQ \n";
			strSql  += "From	V_T_CODE_LIST a \n";
			strSql  += "Where	a.CODE_GROUP_ID = 'ROUND_CLS' \n";
			strSql  += "And		a.USE_TAG = 'T' \n";
			strSql  += "Order By \n";
			strSql  += "	a.SEQ, \n";
			strSql  += "	a.CODE_LIST_ID";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null)
				{
					GauceInfo.response.writeException("USER", "900001","ROUND_CLS Select 오류-> "+ ex.getMessage());
				}
				else
				{
					throw new Exception("USER-900001:ROUND_CLS Select 오류 -> " + ex.getMessage());
				}
			}
		}
		else if (strAct.equals("SUB01"))
		{
			String	strSHEET_CODE = CITCommon.toKOR(request.getParameter("SHEET_CODE"));
			
			strSql  = "Select \n";
			strSql  += "	a.SHEET_CODE , \n";
			strSql  += "	To_Char(a.ITEM_LVL) ITEM_LVL , \n";
			strSql  += "	a.SEQ_TYPE , \n";
			strSql  += "	To_Char(a.CRTUSERNO) CRTUSERNO , \n";
			strSql  += "	a.CRTDATE , \n";
			strSql  += "	To_Char(a.MODUSERNO) MODUSERNO , \n";
			strSql  += "	a.MODDATE \n";
			strSql  += "From	T_SHEET_CODE_LVL a \n";
			strSql  += "Where	a.SHEET_CODE =  ?  \n";
			strSql  += "Order By \n";
			strSql  += "	a.SHEET_CODE , \n";
			strSql  += "	a.ITEM_LVL";
			
			lrArgData.addColumn("SHEET_CODE",CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("SHEET_CODE",strSHEET_CODE);
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SHEET_CODE",true);
				lrReturnData.setKey("ITEM_LVL",true);
				lrReturnData.setNotNull("SEQ_TYPE",true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","SUB01 Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:SUB01 Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("SEQ_TYPE"))
		{

			
			strSql  = "Select \n";
			strSql  += "	a.SEQ_TYPE, \n";
			strSql  += "	a.SEQ_TYPE_NAME \n";
			strSql  += "From	T_SHEET_SEQ_TYPE a \n";
			strSql  += "Order By \n";
			strSql  += "	a.SEQ_TYPE";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("SEQ_TYPE",true);

				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","SEQ_TYPE Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:SEQ_TYPE Select 오류 -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("ITEM_LVL"))
		{

			
			strSql  = "Select \n";
			strSql  += "	a.CODE_LIST_ID , \n";
			strSql  += "	a.CODE_LIST_NAME \n";
			strSql  += "From	V_T_CODE_LIST a \n";
			strSql  += "Where	a.CODE_GROUP_ID = 'ITEM_LVL' \n";
			strSql  += "Order By \n";
			strSql  += "	a.SEQ";
			

			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				


				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001","ITEM_LVL Select 오류-> "+ ex.getMessage());
				throw new Exception("USER-900001:ITEM_LVL Select 오류 -> " + ex.getMessage());
			}
		}


	}
	catch (Exception ex)
	{
		if (GauceInfo != null)
		{
			GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		}
		else
		{
			throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
		}
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
		catch (Exception ex)
		{
			if (GauceInfo != null)
			{
				GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
			}
			else
			{
				throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
			}
		}
	}
%>