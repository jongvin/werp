<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : t_WLovR_q(�����˾� ����� Select Query ������)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-10-31)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strAct = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			try
			{
				String	strName = CITCommon.toKOR(request.getParameter("NAME"));
				String	strTitle = CITCommon.toKOR(request.getParameter("TITLE"));
				
				CITDebug.PrintMessages("strTitle=" + strTitle);
			
				lrArgData.addColumn("NAME", CITData.VARCHAR2);
				lrArgData.addColumn("TITLE", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("NAME", strName);
				lrArgData.setValue("TITLE", strTitle);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV \n";
				strSql += " Where  NAME Like '%' || ? || '%' \n";
				strSql += "  And   TITLE Like '%' || ? || '%' \n";
				strSql += " Order by NAME ";
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOV_NO", true);
				
				lrReturnData.setNotNull("NAME", true);
				lrReturnData.setNotNull("TITLE", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_LOV ���̺� Select ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("ARGS"))
		{
			try
			{
				String	strLovNo = CITCommon.toKOR(request.getParameter("LOV_NO"));
			
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV_ARGS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ ";
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOV_NO", true);
				lrReturnData.setKey("ARG_SEQ", true);
				
				lrReturnData.setNotNull("DIS_SEQ", true);
				lrReturnData.setNotNull("NAME", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_LOV_ARGS ���̺� Select ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("COLS"))
		{
			try
			{
				String	strLovNo = CITCommon.toKOR(request.getParameter("LOV_NO"));
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
			
				strSql  = " Select * \n";
				strSql += " From   T_LOV_COLS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ ";
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrReturnData.setKey("LOV_NO", true);
				lrReturnData.setKey("COL_SEQ", true);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "T_LOV_COLS ���̺� Select ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("LOV_NO"))
		{
			try
			{
				strSql  = " Select SQ_T_LOV.nextval as LOV_NO \n";
				strSql += " From   DUAL ";
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SQ_T_LOV Sequence Select ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("NEW_NAME"))
		{
			try
			{
				String	strLovNo = CITCommon.toKOR(request.getParameter("LOV_NO"));
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
			
				strSql  = " Select F_T_Gen_NewLovName( ? ) NEW_NAME \n";
				strSql += " From   DUAL \n";
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SQ_T_LOV Sequence Select ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("COPY_LOV"))
		{
			try
			{
			
				strSql  = " Select 0 F,0 T \n";
				strSql += " From   DUAL \n";
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SQ_T_LOV Sequence Select ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("LOV_ARGS_SEQ"))
		{
			try
			{
				strSql  = " Select SQ_T_LOV_ARGS.nextval as ARG_SEQ \n";
				strSql += " From   DUAL ";
				
				lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SQ_T_LOV_ARGS Sequence Select ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("SQL"))
		{
			try
			{
				CITData lrLov = null;
				CITData lrArgs = null;
				CITData lrCols = null;
				CITData lrTemp = null;
				CITData lrNewCols = null;
				String	strLovNo = CITCommon.toKOR(request.getParameter("LOV_NO"));
				
				conn = CITConnectionManager.getConnection(false);
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
				
				// LOV Select
				strSql  = " Select LOV_NO, \n";
				strSql += "        SQL \n";
				strSql += " From   T_LOV \n";
				strSql += " Where  LOV_NO = ? ";
				
				lrLov = CITDatabase.selectQuery(strSql, lrArgData, conn);
				
				// �������� Select
				strSql  = " Select * \n";
				strSql += " From   T_LOV_ARGS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ ";
				
				lrArgs = CITDatabase.selectQuery(strSql, lrArgData, conn);
				
				// ���� �÷����� Select
				strSql  = " Select * \n";
				strSql += " From   T_LOV_COLS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ ";
				
				lrCols = CITDatabase.selectQuery(strSql, lrArgData, conn);
				
				// SQL ���� ����
				lrArgData.removeAll();
				
				if (lrArgs.getRowsCount() > 0)
				{
					for (int i = 0; i < lrArgs.getRowsCount(); i++)
					{
						if (lrArgs.toString(i, "TYPE").equals("S"))
						{
							lrArgData.addColumn(lrArgs.toString(i, "NAME"), CITData.VARCHAR2);
						}
						else if (lrArgs.toString(i, "TYPE").equals("N"))
						{
							lrArgData.addColumn(lrArgs.toString(i, "NAME"), CITData.NUMBER);
						}
						else if (lrArgs.toString(i, "TYPE").equals("D"))
						{
							lrArgData.addColumn(lrArgs.toString(i, "NAME"), CITData.DATE);
						}
					}
					
					lrArgData.addRow();
					
					for (int i = 0; i < lrArgs.getRowsCount(); i++)
					{
						lrArgData.setValue(lrArgs.toString(i, "NAME"), lrArgs.toString(i, "DEFAULT_VALUE"));
					}
				}
				
				// SQL ����
				lrTemp = CITDatabase.selectQuery(lrLov.toString(0, "SQL"), lrArgData, conn);
				
				// SQL ������ �÷����� ����
				lrNewCols = new CITData();
				
				lrNewCols.addColumn("LOV_NO", CITData.NUMBER);
				lrNewCols.addColumn("DIS_SEQ", CITData.NUMBER);
				lrNewCols.addColumn("NAME", CITData.VARCHAR2);
				lrNewCols.addColumn("TITLE", CITData.VARCHAR2);
				lrNewCols.addColumn("WIDTH", CITData.NUMBER);
				lrNewCols.addColumn("ALIGN", CITData.VARCHAR2);
				lrNewCols.addColumn("MASK", CITData.VARCHAR2);
				lrNewCols.addColumn("VISIBLE", CITData.VARCHAR2);
				
				for (int i = 0; i < lrTemp.getColsCount(); i++)
				{
					lrNewCols.addRow();
					lrNewCols.setValue("LOV_NO", strLovNo);
					lrNewCols.setValue("DIS_SEQ", Integer.toString(i+1));
					lrNewCols.setValue("NAME", lrTemp.getColumnName(i));
					lrNewCols.setValue("TITLE", lrTemp.getColumnName(i));
					lrNewCols.setValue("WIDTH", "70");
					lrNewCols.setValue("ALIGN", lrTemp.getColumnType(i) == CITData.NUMBER ? "R" : "L");
					lrNewCols.setValue("MASK", "");
					lrNewCols.setValue("VISIBLE", "T");
				}
				
				// ���� �÷����� ����
				strSql = "{call SP_T_LOV_COLS_D(?)}";
				
				lrArgData.removeAll();
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO",  strLovNo);
				
				CITDatabase.executeProcedure(strSql, lrArgData, conn);
				
				// �ű� �÷����� �Է�
				strSql = "{call SP_T_LOV_COLS_I(?,?,?,?,?,?,?,?)}";
				
				for (int i = 0; i < lrNewCols.getRowsCount(); i++)
				{
					for (int j = 0; j < lrCols.getRowsCount(); j++)
					{
						if (lrNewCols.toString(i, "NAME").equals(lrCols.toString(j, "NAME")))
						{
							lrNewCols.setValue(i, "TITLE", lrCols.toString(j, "TITLE"));
							lrNewCols.setValue(i, "WIDTH", lrCols.toString(j, "WIDTH"));
							lrNewCols.setValue(i, "ALIGN", lrCols.toString(j, "ALIGN"));
							lrNewCols.setValue(i, "MASK", lrCols.toString(j, "MASK"));
							lrNewCols.setValue(i, "VISIBLE", lrCols.toString(j, "VISIBLE"));
							break;
						}
					}
					
					lrArgData.removeAll();
				
					lrArgData.addColumn("LOV_NO", CITData.NUMBER);
					lrArgData.addColumn("DIS_SEQ", CITData.NUMBER);
					lrArgData.addColumn("NAME", CITData.VARCHAR2);
					lrArgData.addColumn("TITLE", CITData.VARCHAR2);
					lrArgData.addColumn("WIDTH", CITData.NUMBER);
					lrArgData.addColumn("ALIGN", CITData.VARCHAR2);
					lrArgData.addColumn("MASK", CITData.VARCHAR2);
					lrArgData.addColumn("VISIBLE", CITData.VARCHAR2);
					lrArgData.addRow();
					lrArgData.setValue("LOV_NO",  lrNewCols.getValue(i, "LOV_NO"));
					lrArgData.setValue("DIS_SEQ",  lrNewCols.getValue(i, "DIS_SEQ"));
					lrArgData.setValue("NAME",  lrNewCols.getValue(i, "NAME"));
					lrArgData.setValue("TITLE",  lrNewCols.getValue(i, "TITLE"));
					lrArgData.setValue("WIDTH",  lrNewCols.getValue(i, "WIDTH"));
					lrArgData.setValue("ALIGN",  lrNewCols.getValue(i, "ALIGN"));
					lrArgData.setValue("MASK",  lrNewCols.getValue(i, "MASK"));
					lrArgData.setValue("VISIBLE",  lrNewCols.getValue(i, "VISIBLE"));
					
					CITDatabase.executeProcedure(strSql, lrArgData, conn);
				}
				
				// ����� �÷����� Select
				lrArgData.removeAll();
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV_COLS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ ";
				
				lrCols = CITDatabase.selectQuery(strSql, lrArgData, conn);
				
				conn.commit();
				
				lrDataset = CITCommon.toGauceDataSet(lrCols);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (conn != null) conn.rollback();
				
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "SQL ���� ���� -> " + ex.getMessage());
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