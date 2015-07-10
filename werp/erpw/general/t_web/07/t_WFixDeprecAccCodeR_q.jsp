<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-16)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
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

			String strASSET_CLS_CODE = CITCommon.toKOR(request.getParameter("ASSET_CLS_CODE"));
			String strCOST_DEPT_KND_TAG = CITCommon.toKOR(request.getParameter("COST_DEPT_KND_TAG"));
			
			strSql  = "select a.asset_cls_code, \n";
			strSql += "	   b.asset_cls_name,\n";
			strSql += "	   a.cost_dept_knd_tag,\n";
			strSql += "	   d.cost_dept_knd_name,\n";
			strSql += "	   a.acc_code,\n";
			strSql += "	   c.acc_name\n";
			strSql += "from   t_fix_deprec_acc_code a,\n";
			strSql += "	   t_fix_asset_cls_code b,\n";
			strSql += "	   t_acc_code c,\n";
			strSql += "	   t_cost_dept_kind d\n";
			strSql += "where  a.asset_cls_code = b.asset_cls_code \n";
			strSql += "and	   a.acc_code = c.acc_code \n";
			strSql += "and	   a.cost_dept_knd_tag = d.cost_dept_knd_tag \n";
			strSql += " and   a.ASSET_CLS_CODE = ? \n";
			strSql += " and   a.cost_dept_knd_tag = ? \n";
			
			lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
			lrArgData.addColumn("COST_DEPT_KND_TAG", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("ASSET_CLS_CODE", strASSET_CLS_CODE);
			lrArgData.setValue("COST_DEPT_KND_TAG", strCOST_DEPT_KND_TAG);
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ASSET_CLS_CODE", true);
				lrReturnData.setKey("COST_DEPT_KND_TAG", true);
				lrReturnData.setNotNull("ITEM_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		
		else if (strAct.equals("FIX_ASSET_CLS_CODE"))
		{

			strSql  = " select \n";
			strSql += " 	  a.ASSET_CLS_CODE, 	 \n";
			strSql += " 	  a.ASSET_CLS_NAME  \n";
			strSql += " from T_FIX_ASSET_CLS_CODE a \n";
			strSql += " ORDER by  ASSET_CLS_CODE";
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ASSET_CLS_CODE", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
		
		else if (strAct.equals("COST_DEPT_KND_TAG"))
		{

			strSql  = " select \n";
			strSql += " 	  a.COST_DEPT_KND_TAG, 	 \n";
			strSql += " 	  a.COST_DEPT_KND_NAME  \n";
			strSql += " from t_cost_dept_kind a \n";
			strSql += " ORDER by  COST_DEPT_KND_TAG desc";
			
			try
			{
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("ASSET_CLS_CODE", true);
				lrReturnData.setKey("ITEM_CODE", true);
				lrReturnData.setNotNull("ITEM_NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001","MAIN Select ����-> "+ ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
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
			GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
		}
	}
%>