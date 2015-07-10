<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-04-21)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(����)
	GauceDataSet dsMAIN = null;
	//Dataset�� �������̸� �̺κ��� ���翡 ���̼ſ�(��)
	//Dataset�� �������̸� �Ʒ� ��Ÿ���� �κ��� '//�������' ���� '//���糡' ������ ���� ���� �������� '//���⿡ �ٿ���������' �ڸ��� �ٿ���������
	GauceDataSet dsCOPY = null;
	
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
		
		if(!CITCommon.isNull(strAct) && strAct.equals("COPY"))
		{
			dsCOPY = GauceInfo.request.getGauceDataSet("dsCOPY");
			rows = dsCOPY.getDataRows();
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FL_COPY_M_MARKET(?,?)}";
					
					lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
					lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("WORK_DT", rows[i].getString(dsCOPY.indexOfColumn("WORK_DT")));
					lrArgData.setValue("CRTUSERNO", strUserNo);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_MONTH_AMT_H ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
		}
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
						strSql = "{call SP_T_FL_M_MARKET_I(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("M_MARKET_STAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_RATIO", CITData.NUMBER);
						lrArgData.addColumn("P_D_UD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("P_D_UD_POS", CITData.NUMBER);
						lrArgData.addColumn("P_M_UD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("P_M_UD_POS", CITData.NUMBER);
						lrArgData.addColumn("P_Y_UD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("P_Y_UD_POS", CITData.NUMBER);
						lrArgData.addColumn("P_ML_RATIO", CITData.NUMBER);
						lrArgData.addColumn("P_YL_RATIO", CITData.NUMBER);
						lrArgData.addColumn("P_D_RATIO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("M_MARKET_STAT_CODE", rows[i].getString(dsMAIN.indexOfColumn("M_MARKET_STAT_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ITR_RATIO", rows[i].getString(dsMAIN.indexOfColumn("ITR_RATIO")));
						lrArgData.setValue("P_D_UD_TAG", rows[i].getString(dsMAIN.indexOfColumn("P_D_UD_TAG")));
						lrArgData.setValue("P_D_UD_POS", rows[i].getString(dsMAIN.indexOfColumn("P_D_UD_POS")));
						lrArgData.setValue("P_M_UD_TAG", rows[i].getString(dsMAIN.indexOfColumn("P_M_UD_TAG")));
						lrArgData.setValue("P_M_UD_POS", rows[i].getString(dsMAIN.indexOfColumn("P_M_UD_POS")));
						lrArgData.setValue("P_Y_UD_TAG", rows[i].getString(dsMAIN.indexOfColumn("P_Y_UD_TAG")));
						lrArgData.setValue("P_Y_UD_POS", rows[i].getString(dsMAIN.indexOfColumn("P_Y_UD_POS")));
						lrArgData.setValue("P_ML_RATIO", rows[i].getString(dsMAIN.indexOfColumn("P_ML_RATIO")));
						lrArgData.setValue("P_YL_RATIO", rows[i].getString(dsMAIN.indexOfColumn("P_YL_RATIO")));
						lrArgData.setValue("P_D_RATIO", rows[i].getString(dsMAIN.indexOfColumn("P_YL_RATIO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FL_M_MARKET_U(?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("M_MARKET_STAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_RATIO", CITData.NUMBER);
						lrArgData.addColumn("P_D_UD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("P_D_UD_POS", CITData.NUMBER);
						lrArgData.addColumn("P_M_UD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("P_M_UD_POS", CITData.NUMBER);
						lrArgData.addColumn("P_Y_UD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("P_Y_UD_POS", CITData.NUMBER);
						lrArgData.addColumn("P_ML_RATIO", CITData.NUMBER);
						lrArgData.addColumn("P_YL_RATIO", CITData.NUMBER);
						lrArgData.addColumn("P_D_RATIO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("M_MARKET_STAT_CODE", rows[i].getString(dsMAIN.indexOfColumn("M_MARKET_STAT_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ITR_RATIO", rows[i].getString(dsMAIN.indexOfColumn("ITR_RATIO")));
						lrArgData.setValue("P_D_UD_TAG", rows[i].getString(dsMAIN.indexOfColumn("P_D_UD_TAG")));
						lrArgData.setValue("P_D_UD_POS", rows[i].getString(dsMAIN.indexOfColumn("P_D_UD_POS")));
						lrArgData.setValue("P_M_UD_TAG", rows[i].getString(dsMAIN.indexOfColumn("P_M_UD_TAG")));
						lrArgData.setValue("P_M_UD_POS", rows[i].getString(dsMAIN.indexOfColumn("P_M_UD_POS")));
						lrArgData.setValue("P_Y_UD_TAG", rows[i].getString(dsMAIN.indexOfColumn("P_Y_UD_TAG")));
						lrArgData.setValue("P_Y_UD_POS", rows[i].getString(dsMAIN.indexOfColumn("P_Y_UD_POS")));
						lrArgData.setValue("P_ML_RATIO", rows[i].getString(dsMAIN.indexOfColumn("P_ML_RATIO")));
						lrArgData.setValue("P_YL_RATIO", rows[i].getString(dsMAIN.indexOfColumn("P_YL_RATIO")));
						lrArgData.setValue("P_D_RATIO", rows[i].getString(dsMAIN.indexOfColumn("P_YL_RATIO")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FL_M_MARKET_D(?,?)}";
						
						lrArgData.addColumn("M_MARKET_STAT_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("WORK_DT", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("M_MARKET_STAT_CODE", rows[i].getString(dsMAIN.indexOfColumn("M_MARKET_STAT_CODE")));
						lrArgData.setValue("WORK_DT", rows[i].getString(dsMAIN.indexOfColumn("WORK_DT")));
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
				GauceInfo.response.writeException("USER", "900001", "t_fl_m_market ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
