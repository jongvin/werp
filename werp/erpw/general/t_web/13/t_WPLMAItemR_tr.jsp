<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : 
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ����� �ۼ�(2005-11-23)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	GauceDataSet dsMAIN_D = null;
	GauceDataSet dsSUB01 = null;
	
	GauceDataRow[] rows = null;
	
	String strSql = "";
	String strAct = "";
	String strUserNo = "";
	Connection conn = null;
	int		iCnt = 0;
	
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
			dsMAIN_D = GauceInfo.request.getGauceDataSet("dsMAIN_D");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			if (dsMAIN_D == null) throw new Exception("dsMAIN_D��(��) ��(Null)�Դϴ�.");
			
			rows = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					++iCnt;
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_PL_MA_ITEM_I(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("P_NO", CITData.NUMBER);
						lrArgData.addColumn("BIZ_PLAN_ITEM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_LEVEL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ITEM_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("MNG_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IS_LEAF_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("P_NO", rows[i].getString(dsMAIN.indexOfColumn("P_NO")));
						lrArgData.setValue("BIZ_PLAN_ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("BIZ_PLAN_ITEM_NAME")));
						lrArgData.setValue("ITEM_LEVEL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("ITEM_LEVEL_SEQ")));
						lrArgData.setValue("ITEM_TAG", rows[i].getString(dsMAIN.indexOfColumn("ITEM_TAG")));
						lrArgData.setValue("FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("FUNC_NO")));
						lrArgData.setValue("MNG_CODE", rows[i].getString(dsMAIN.indexOfColumn("MNG_CODE")));
						lrArgData.setValue("IS_LEAF_TAG", rows[i].getString(dsMAIN.indexOfColumn("IS_LEAF_TAG")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_PL_MA_ITEM_U(?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("P_NO", CITData.NUMBER);
						lrArgData.addColumn("BIZ_PLAN_ITEM_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("ITEM_LEVEL_SEQ", CITData.NUMBER);
						lrArgData.addColumn("ITEM_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("FUNC_NO", CITData.NUMBER);
						lrArgData.addColumn("MNG_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("IS_LEAF_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsMAIN.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("P_NO", rows[i].getString(dsMAIN.indexOfColumn("P_NO")));
						lrArgData.setValue("BIZ_PLAN_ITEM_NAME", rows[i].getString(dsMAIN.indexOfColumn("BIZ_PLAN_ITEM_NAME")));
						lrArgData.setValue("ITEM_LEVEL_SEQ", rows[i].getString(dsMAIN.indexOfColumn("ITEM_LEVEL_SEQ")));
						lrArgData.setValue("ITEM_TAG", rows[i].getString(dsMAIN.indexOfColumn("ITEM_TAG")));
						lrArgData.setValue("FUNC_NO", rows[i].getString(dsMAIN.indexOfColumn("FUNC_NO")));
						lrArgData.setValue("MNG_CODE", rows[i].getString(dsMAIN.indexOfColumn("MNG_CODE")));
						lrArgData.setValue("IS_LEAF_TAG", rows[i].getString(dsMAIN.indexOfColumn("IS_LEAF_TAG")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsMAIN.indexOfColumn("REMARKS")));
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
				GauceInfo.response.writeException("USER", "900001", "T_FL_BIZ_PLAN_ITEM_NO ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			rows = dsMAIN_D.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					++iCnt;
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_PL_MA_ITEM_D(?)}";
						
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsMAIN_D.indexOfColumn("ITEM_NO")));
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
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//�������
			dsSUB01 = GauceInfo.request.getGauceDataSet("dsSUB01");
			
			if (dsSUB01 == null) throw new Exception("dsSUB01��(��) ��(Null)�Դϴ�.");
			
			rows = dsSUB01.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	rows.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (rows[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_PL_MA_ITEM_ACC_CODE_I(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("APPLY_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SIGN_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_SUM_MTHD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("DVD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SUM_TAR_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DVD_TAR_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DVD_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsSUB01.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("APPLY_SEQ", rows[i].getString(dsSUB01.indexOfColumn("APPLY_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("SIGN_TAG", rows[i].getString(dsSUB01.indexOfColumn("SIGN_TAG")));
						lrArgData.setValue("SLIP_SUM_MTHD_TAG", rows[i].getString(dsSUB01.indexOfColumn("SLIP_SUM_MTHD_TAG")));
						lrArgData.setValue("DVD_TAG", rows[i].getString(dsSUB01.indexOfColumn("DVD_TAG")));
						lrArgData.setValue("SUM_TAR_CODE", rows[i].getString(dsSUB01.indexOfColumn("SUM_TAR_CODE")));
						lrArgData.setValue("DVD_TAR_CODE", rows[i].getString(dsSUB01.indexOfColumn("DVD_TAR_CODE")));
						lrArgData.setValue("DVD_CODE", rows[i].getString(dsSUB01.indexOfColumn("DVD_CODE")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB01.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_PL_MA_ITEM_ACC_CODE_U(?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("APPLY_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("ACC_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("SIGN_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SLIP_SUM_MTHD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("DVD_TAG", CITData.VARCHAR2);
						lrArgData.addColumn("SUM_TAR_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DVD_TAR_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("DVD_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("REMARKS", CITData.VARCHAR2);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsSUB01.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("APPLY_SEQ", rows[i].getString(dsSUB01.indexOfColumn("APPLY_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("ACC_CODE", rows[i].getString(dsSUB01.indexOfColumn("ACC_CODE")));
						lrArgData.setValue("SIGN_TAG", rows[i].getString(dsSUB01.indexOfColumn("SIGN_TAG")));
						lrArgData.setValue("SLIP_SUM_MTHD_TAG", rows[i].getString(dsSUB01.indexOfColumn("SLIP_SUM_MTHD_TAG")));
						lrArgData.setValue("DVD_TAG", rows[i].getString(dsSUB01.indexOfColumn("DVD_TAG")));
						lrArgData.setValue("SUM_TAR_CODE", rows[i].getString(dsSUB01.indexOfColumn("SUM_TAR_CODE")));
						lrArgData.setValue("DVD_TAR_CODE", rows[i].getString(dsSUB01.indexOfColumn("DVD_TAR_CODE")));
						lrArgData.setValue("DVD_CODE", rows[i].getString(dsSUB01.indexOfColumn("DVD_CODE")));
						lrArgData.setValue("REMARKS", rows[i].getString(dsSUB01.indexOfColumn("REMARKS")));
					}
					else if (rows[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_PL_MA_ITEM_ACC_CODE_D(?,?)}";
						
						lrArgData.addColumn("ITEM_NO", CITData.NUMBER);
						lrArgData.addColumn("APPLY_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("ITEM_NO", rows[i].getString(dsSUB01.indexOfColumn("ITEM_NO")));
						lrArgData.setValue("APPLY_SEQ", rows[i].getString(dsSUB01.indexOfColumn("APPLY_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_PL_MA_ITEM_ACC_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
	//���糡
		}
		if(iCnt > 0)
		{
			try
			{
				CITData lrArgData = new CITData();
				strSql = "{call SP_T_SET_PL_MA_ITEM_LEAF()}";
				
				CITDatabase.executeProcedure(strSql, lrArgData, conn);
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_BUDG_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
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
