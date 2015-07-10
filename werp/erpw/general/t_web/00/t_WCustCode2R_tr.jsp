<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WCustCodeR_tr.jsp(���ڵ�)
/* 2. ����(�ó�����) : Update Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : �־�ȸ �ۼ�(2005-11-28)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� : 
/**************************************************************************/
	CITGauceInfo GauceInfo = null;
	
	GauceDataSet dsMAIN = null;
	
	GauceDataSet dsPAY_STOP = null;
	
	GauceDataRow[] Rows_Main = null;
	GauceDataRow[] Rows_Accno = null;
	GauceDataRow[] Rows_Paystop = null;
	
	
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
			//�ŷ�ó�ڵ�
			dsMAIN = GauceInfo.request.getGauceDataSet("dsMAIN");
			
			if (dsMAIN == null) throw new Exception("dsMAIN��(��) ��(Null)�Դϴ�.");
			
			Rows_Main = dsMAIN.getDataRows();
			
			try
			{
				for	(int i = 0;	i <	Rows_Main.length; i++)
				{
					CITData lrArgData = new CITData();
					
					if (Rows_Main[i].getJobType() == GauceDataRow.TB_JOB_INSERT)
					{
						strSql = "{call SP_T_CUST_CODE_I(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("CRTUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BOSS_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TRADE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BIZCOND", CITData.VARCHAR2);
						lrArgData.addColumn("BIZKND", CITData.VARCHAR2);
						lrArgData.addColumn("ZIPCODE", CITData.VARCHAR2);
						lrArgData.addColumn("ADDR1", CITData.VARCHAR2);
						lrArgData.addColumn("ADDR2", CITData.VARCHAR2);
						lrArgData.addColumn("TELNO", CITData.VARCHAR2);
						lrArgData.addColumn("GROUP_COMP_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REPRESENT_CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("CRTUSERNO", strUserNo);
						lrArgData.setValue("CUST_CODE", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_CODE")));
						lrArgData.setValue("CUST_NAME", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_NAME")));
						lrArgData.setValue("BOSS_NAME", Rows_Main[i].getString(dsMAIN.indexOfColumn("BOSS_NAME")));
						lrArgData.setValue("TRADE_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("TRADE_CLS")));
						lrArgData.setValue("BIZCOND", Rows_Main[i].getString(dsMAIN.indexOfColumn("BIZCOND")));
						lrArgData.setValue("BIZKND", Rows_Main[i].getString(dsMAIN.indexOfColumn("BIZKND")));
						lrArgData.setValue("ZIPCODE", Rows_Main[i].getString(dsMAIN.indexOfColumn("ZIPCODE")));
						lrArgData.setValue("ADDR1", Rows_Main[i].getString(dsMAIN.indexOfColumn("ADDR1")));
						lrArgData.setValue("ADDR2", Rows_Main[i].getString(dsMAIN.indexOfColumn("ADDR2")));
						lrArgData.setValue("TELNO", Rows_Main[i].getString(dsMAIN.indexOfColumn("TELNO")));
						lrArgData.setValue("GROUP_COMP_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("GROUP_COMP_CLS")));
						lrArgData.setValue("USE_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("USE_CLS")));
						lrArgData.setValue("REPRESENT_CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("REPRESENT_CUST_SEQ")));
					}
					else if (Rows_Main[i].getJobType() == GauceDataRow.TB_JOB_UPDATE)
					{
						strSql = "{call SP_T_CUST_CODE_U(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);
						lrArgData.addColumn("MODUSERNO", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_CODE", CITData.VARCHAR2);
						lrArgData.addColumn("CUST_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("BOSS_NAME", CITData.VARCHAR2);
						lrArgData.addColumn("TRADE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("BIZCOND", CITData.VARCHAR2);
						lrArgData.addColumn("BIZKND", CITData.VARCHAR2);
						lrArgData.addColumn("ZIPCODE", CITData.VARCHAR2);
						lrArgData.addColumn("ADDR1", CITData.VARCHAR2);
						lrArgData.addColumn("ADDR2", CITData.VARCHAR2);
						lrArgData.addColumn("TELNO", CITData.VARCHAR2);
						lrArgData.addColumn("GROUP_COMP_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("USE_CLS", CITData.VARCHAR2);
						lrArgData.addColumn("REPRESENT_CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
						lrArgData.setValue("MODUSERNO", strUserNo);
						lrArgData.setValue("CUST_CODE", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_CODE")));
						lrArgData.setValue("CUST_NAME", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_NAME")));
						lrArgData.setValue("BOSS_NAME", Rows_Main[i].getString(dsMAIN.indexOfColumn("BOSS_NAME")));
						lrArgData.setValue("TRADE_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("TRADE_CLS")));
						lrArgData.setValue("BIZCOND", Rows_Main[i].getString(dsMAIN.indexOfColumn("BIZCOND")));
						lrArgData.setValue("BIZKND", Rows_Main[i].getString(dsMAIN.indexOfColumn("BIZKND")));
						lrArgData.setValue("ZIPCODE", Rows_Main[i].getString(dsMAIN.indexOfColumn("ZIPCODE")));
						lrArgData.setValue("ADDR1", Rows_Main[i].getString(dsMAIN.indexOfColumn("ADDR1")));
						lrArgData.setValue("ADDR2", Rows_Main[i].getString(dsMAIN.indexOfColumn("ADDR2")));
						lrArgData.setValue("TELNO", Rows_Main[i].getString(dsMAIN.indexOfColumn("TELNO")));
						lrArgData.setValue("GROUP_COMP_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("GROUP_COMP_CLS")));
						lrArgData.setValue("USE_CLS", Rows_Main[i].getString(dsMAIN.indexOfColumn("USE_CLS")));
						lrArgData.setValue("REPRESENT_CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("REPRESENT_CUST_SEQ")));
					}
					else if (Rows_Main[i].getJobType() == GauceDataRow.TB_JOB_DELETE)
					{
						strSql = "{call SP_T_CUST_CODE_D(?)}";
						
						lrArgData.addColumn("CUST_SEQ", CITData.NUMBER);

						lrArgData.addRow();
						lrArgData.setValue("CUST_SEQ", Rows_Main[i].getString(dsMAIN.indexOfColumn("CUST_SEQ")));
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
				GauceInfo.response.writeException("USER", "900001", "T_CUST_CODE ���̺� ����Ÿ ���� ����" + ex.getMessage());
				throw new Exception(ex.getMessage());
			}
			
		
	//���糡
	//���⿡ �ٿ���������

			conn.commit();
		}
		
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
