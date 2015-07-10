<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2006-01-10)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	String strCOMP_CODE = "";
	int		iCount = 0;
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		/* �������� */
		strUserNo = CITCommon.toKOR((String)session.getAttribute("emp_no"));
		conn = CITConnectionManager.getConnection(false);
		
		strAct = GauceInfo.request.getParameter("ACT");
		
		if (CITCommon.isNull(strAct))
		{
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					iCount ++;
					strCOMP_CODE = rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE"));
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_FL_ITR_INFO_I(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_DATE_F", CITData.VARCHAR2);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_DATE_TO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_RATIO_IN", CITData.NUMBER);
						lrArgData.addColumn("ITR_RATIO_OUT", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("ITR_DATE_F", rows[i].getString(dsMAIN.indexOfColumn("ITR_DATE_F")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ITR_DATE_TO", rows[i].getString(dsMAIN.indexOfColumn("ITR_DATE_TO")));
						lrArgData.setValue("ITR_RATIO_IN", rows[i].getString(dsMAIN.indexOfColumn("ITR_RATIO_IN")));
						lrArgData.setValue("ITR_RATIO_OUT", rows[i].getString(dsMAIN.indexOfColumn("ITR_RATIO_OUT")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_FL_ITR_INFO_U(?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_DATE_F", CITData.VARCHAR2);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_DATE_TO", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_RATIO_IN", CITData.NUMBER);
						lrArgData.addColumn("ITR_RATIO_OUT", CITData.NUMBER);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("ITR_DATE_F", rows[i].getString(dsMAIN.indexOfColumn("ITR_DATE_F")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ITR_DATE_TO", rows[i].getString(dsMAIN.indexOfColumn("ITR_DATE_TO")));
						lrArgData.setValue("ITR_RATIO_IN", rows[i].getString(dsMAIN.indexOfColumn("ITR_RATIO_IN")));
						lrArgData.setValue("ITR_RATIO_OUT", rows[i].getString(dsMAIN.indexOfColumn("ITR_RATIO_OUT")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_FL_ITR_INFO_D(?,?)}";
						
						lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("ITR_DATE_F", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("COMP_CODE", rows[i].getString(dsMAIN.indexOfColumn("COMP_CODE")));
						lrArgData.setValue("ITR_DATE_F", rows[i].getString(dsMAIN.indexOfColumn("ITR_DATE_F")));
					}
					else
					{
						continue;
					}
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
				if(iCount > 0 )
				{
					CITData lrArgData = new CITData();
					
					strSql = "{call SP_T_FL_SET_ITR_TO_DATE(?)}";
					
					lrArgData.addColumn("COMP_CODE", CITData.VARCHAR2);

					lrArgData.addRow();
					lrArgData.setValue("COMP_CODE", strCOMP_CODE);
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_FL_ITR_INFO ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
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
