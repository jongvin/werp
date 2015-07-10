<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. �� �� �� �� id : Lov_q(�����˾� Select Query ������)
/* 2. ����(�ó�����) : Select Page
/* 3. ��  ��  ��  �� : 
/* 4. ��  ��  ��  �� : ������ �ۼ�(2005-10-31)
/* 5. ����  ���α׷� : 
/* 6. Ư  ��  ��  �� :
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	
	Hashtable htArgs = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strAct = "";
	
	String strLOVSessionName = "LOV_PARAMETER";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		if (session.getAttribute(strLOVSessionName) != null)
		{
			htArgs = (Hashtable)session.getAttribute(strLOVSessionName);
		}
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			try
			{
				CITData lrLov = null;
				CITData lrArgs = null;
				CITData lrFilters = null;
				
				String strLovName = CITCommon.toKOR(request.getParameter("LOV_NAME"));
				
				lrArgData.addColumn("NAME", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("NAME", strLovName);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV \n";
				strSql += " Where  NAME = ? \n";
				
				lrLov = CITDatabase.selectQuery(strSql, lrArgData);
				
				if (lrLov == null || lrLov.getRowsCount() < 1) throw new Exception("�����˾��� �������� �ʽ��ϴ�(LOV_NAME:" + strLovName + ")");
				if (CITCommon.isNull(lrLov.toString(0, "SQL"))) throw new Exception("�����˾��� ������ �������� �ʽ��ϴ�(LOV_NAME:" + strLovName + ")");
				
				String strLovNo = lrLov.toString(0, "LOV_NO");
				
				lrArgData.removeAll();
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV_ARGS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ \n";
				
				lrArgs = CITDatabase.selectQuery(strSql, lrArgData);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV_FILTERS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ \n";
				
				lrFilters = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrArgData.removeAll();
				
				if (lrArgs.getRowsCount() > 0)
				{
					for (int i = 0; i < lrArgs.getRowsCount(); i++)
					{
						if (lrArgs.toString(i, "TYPE").equals("S"))
						{
							lrArgData.addColumn(lrArgs.toString(i, "ARG_SEQ"), CITData.VARCHAR2);
						}
						else if (lrArgs.toString(i, "TYPE").equals("N"))
						{
							lrArgData.addColumn(lrArgs.toString(i, "ARG_SEQ"), CITData.NUMBER);
						}
						else if (lrArgs.toString(i, "TYPE").equals("D"))
						{
							lrArgData.addColumn(lrArgs.toString(i, "ARG_SEQ"), CITData.DATE);
						}
					}
					
					lrArgData.addRow();
					
					for (int i = 0; i < lrArgs.getRowsCount(); i++)
					{
						if (lrArgs.toString(i, "SESSION_TAG").equals("T"))
						{
							lrArgData.setValue(lrArgs.toString(i, "ARG_SEQ"), htArgs.get(lrArgs.toString(i, "SESSION_NAME")));
						}
						else
						{
							lrArgData.setValue(lrArgs.toString(i, "ARG_SEQ"), htArgs.get(lrArgs.toString(i, "NAME")));
							//CITDebug.PrintMessages("lrArgs(" + lrArgs.toString(i, "NAME") + ") : " + htArgs.get(lrArgs.toString(i, "NAME")));
						}
					}
					
					for (int i = 0; i < lrFilters.getRowsCount(); i++)
					{
						if (CITCommon.isNull(lrFilters.toString(i, "RETURN_ARG_NAME"))) continue;
						
						for (int j = 0; j < lrArgs.getRowsCount(); j++)
						{
							if (lrFilters.toString(i, "RETURN_ARG_NAME").equals(lrArgs.toString(j, "NAME")))
							{
								String lsValue = CITCommon.toKOR(request.getParameter(lrFilters.toString(i, "FILTER_NAME")));
								lrArgData.setValue(lrArgs.toString(j, "ARG_SEQ"), lsValue);
								//CITDebug.PrintMessages("lrFilters(" + lrFilters.toString(i, "FILTER_NAME") + ") : " + lsValue);
							}
						}
					}
				}
				
				lrReturnData = CITDatabase.selectQuery(lrLov.toString(0, "SQL"), lrArgData);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "�����˾� ���� ���� -> " + ex.getMessage());
			}
		}
		else if (strAct.equals("FILTER"))
		{
			try
			{
				CITData lrArgs = null;
				CITData lrFilter = null;
				CITData lrFilterArgs = null;
				
				String	strLovNo = CITCommon.toKOR(request.getParameter("LOV_NO"));
				String	strFilterSeq = CITCommon.toKOR(request.getParameter("FILTER_SEQ"));
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV_ARGS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ \n";
				
				lrArgs = CITDatabase.selectQuery(strSql, lrArgData);
				
				lrArgData.removeAll();
				
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addColumn("FILTER_SEQ", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
				lrArgData.setValue("FILTER_SEQ", strFilterSeq);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV_FILTERS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += "  And   FILTER_SEQ = ? \n";
				
				lrFilter = CITDatabase.selectQuery(strSql, lrArgData);
				
				strSql  = " Select * \n";
				strSql += " From   T_LOV_FILTER_ARGS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += "  And   FILTER_SEQ = ? \n";
				strSql += " Order by DIS_SEQ \n";
				
				lrFilterArgs = CITDatabase.selectQuery(strSql, lrArgData);
				
				if (lrFilter == null || lrFilter.getRowsCount() < 1) throw new Exception("���������� �������� �ʽ��ϴ�(LOV_NO:" + strLovNo + ", FILTER_SEQ:" + strFilterSeq + ")");
				if (CITCommon.isNull(lrFilter.toString(0, "SQL"))) throw new Exception("������ ������ �������� �ʽ��ϴ�(LOV_NO:" + strLovNo + ", FILTER_SEQ:" + strFilterSeq + ")");
				
				lrArgData.removeAll();
				
				if (lrFilterArgs.getRowsCount() > 0)
				{
					for (int i = 0; i < lrFilterArgs.getRowsCount(); i++)
					{
						if (lrFilterArgs.toString(i, "TYPE").equals("A"))
						{
							for (int j = 0; j < lrArgs.getRowsCount(); j++)
							{
								if (!lrArgs.toString(j, "NAME").equals(lrFilterArgs.toString(i, "FILTER_ARG_NAME"))) continue;
								
								if (lrArgs.toString(j, "TYPE").equals("S"))
								{
									lrArgData.addColumn(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), CITData.VARCHAR2);
								}
								else if (lrArgs.toString(j, "TYPE").equals("N"))
								{
									lrArgData.addColumn(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), CITData.NUMBER);
								}
								else if (lrArgs.toString(j, "TYPE").equals("D"))
								{
									lrArgData.addColumn(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), CITData.DATE);
								}
							}
						}
						else if (lrFilterArgs.toString(i, "TYPE").equals("F"))
						{
							lrArgData.addColumn(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), CITData.VARCHAR2);
						}
					}
					
					lrArgData.addRow();
					
					for (int i = 0; i < lrFilterArgs.getRowsCount(); i++)
					{
						if (lrFilterArgs.toString(i, "TYPE").equals("A"))
						{
							lrArgData.setValue(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), htArgs.get(lrFilterArgs.toString(i, "FILTER_ARG_NAME")));
						}
						else if (lrFilterArgs.toString(i, "TYPE").equals("F"))
						{
							lrArgData.setValue(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), CITCommon.toKOR(request.getParameter(lrFilterArgs.toString(i, "FILTER_ARG_NAME"))));
						}
					}
				}
				
				lrReturnData = CITDatabase.selectQuery(lrFilter.toString(0, "SQL"), lrArgData);
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
				GauceInfo.response.enableFirstRow(lrDataset);
				lrDataset.flush();
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "COMBO FILTER Select ���� -> " + ex.getMessage());
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