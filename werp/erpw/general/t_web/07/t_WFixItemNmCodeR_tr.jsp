<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ȫ�浿 �ۼ�(2006-05-12)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(��)
	//Dataset�� �������̸� �Ʒ� ��Ÿ���� �κ��� '//�������' ���� '//���糡' ������ ���� ���� �������� '//���⿡ �ٿ���������' �ڸ��� �ٿ���������
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
	//�������
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FIX_ITEM_NM_CODE_I(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_CODE")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ITEM_NM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_NAME")));
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("DEPREC_RAT", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT")));
						lrArgData.setValue("DEPREC_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FIX_ITEM_NM_CODE_U(?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("SRVLIFE", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_RAT", CITData.NUMBER);
						lrArgData.addColumn("DEPREC_CLS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_CODE")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ITEM_NM_NAME", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_NAME")));
						lrArgData.setValue("SRVLIFE", rows[i].getString(dsMAIN.indexOfColumn("SRVLIFE")));
						lrArgData.setValue("DEPREC_RAT", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_RAT")));
						lrArgData.setValue("DEPREC_CLS", rows[i].getString(dsMAIN.indexOfColumn("DEPREC_CLS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FIX_ITEM_NM_CODE_D(?,?,?)}";
						
						lrArgData.addColumn("ASSET_CLS_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_NM_CODE", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ASSET_CLS_CODE", rows[i].getString(dsMAIN.indexOfColumn("ASSET_CLS_CODE")));
						lrArgData.setValue("ITEM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_CODE")));
						lrArgData.setValue("ITEM_NM_CODE", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NM_CODE")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FIX_ITEM_NM_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
	//���⿡ �ٿ���������
		}
		conn.commit();
	}
	catch (Exception ex)
	{
		if (conn != null) conn.rollback();
		if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
		GauceInfo.response.writeException("SYS", "100001", "������ �ʱ�ȭ ���� -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITConnectionManager.freeConnection(conn);
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
			if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
	    	GauceInfo.response.writeException("SYS", "100002", "������ ���� ���� -> " + ex.getMessage());
	    }
	}
%>
