<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : Lov_q(공통팝업 Select Query 페이지)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-10-31)
/* 5. 관련  프로그램 : 
/* 6. 특  기  사  항 :
/**************************************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	
	Hashtable htArgs = null;
	
	Connection conn = null;
	
	String strSql = "";
	String strAct = "";
	String strStep = "Start1";
	String strLovParam = "";
	
	String strLOVSessionName = "LOV_PARAMETER";
	
	try
	{
		strStep = "Start01";
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		if (session.getAttribute(strLOVSessionName) != null)
		{
			htArgs = (Hashtable)session.getAttribute(strLOVSessionName);
		}
		else
		{
			strLovParam = "strLovParam Is Null ";
		}
		
		strStep = "Start02";
		CITData lrArgData = new CITData();
		
		strStep = "Start03";
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		strStep = "Start04";
		if (strAct.equals("MAIN"))
		{
			try
			{
		strStep = "Start05";
				CITData lrLov = null;
				CITData lrArgs = null;
				CITData lrFilters = null;
				
		strStep = "Start06";
				String strLovName = CITCommon.toKOR(request.getParameter("LOV_NAME"));
				
		strStep = "Start07";
				lrArgData.addColumn("NAME", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("NAME", strLovName);
				
		strStep = "Start08";
				strSql  = " Select * \n";
				strSql += " From   T_LOV \n";
				strSql += " Where  NAME = ? \n";
				
		strStep = "Start09";
				lrLov = CITDatabase.selectQuery(strSql, lrArgData);
		strStep = "Start10";
				
				if (lrLov == null || lrLov.getRowsCount() < 1) throw new Exception("공통팝업이 존재하지 않습니다(LOV_NAME:" + strLovName + ")");
				if (CITCommon.isNull(lrLov.toString(0, "SQL"))) throw new Exception("공통팝업의 쿼리가 존재하지 않습니다(LOV_NAME:" + strLovName + ")");
				
		strStep = "Start11";
				String strLovNo = lrLov.toString(0, "LOV_NO");
				
		strStep = "Start12";
				lrArgData.removeAll();
				
		strStep = "Start13";
				lrArgData.addColumn("LOV_NO", CITData.NUMBER);
				lrArgData.addRow();
				lrArgData.setValue("LOV_NO", strLovNo);
				
		strStep = "Start14";
				strSql  = " Select * \n";
				strSql += " From   T_LOV_ARGS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ \n";
				
		strStep = "Start15";
				lrArgs = CITDatabase.selectQuery(strSql, lrArgData);
				
		strStep = "Start16";
				strSql  = " Select * \n";
				strSql += " From   T_LOV_FILTERS \n";
				strSql += " Where  LOV_NO = ? \n";
				strSql += " Order by DIS_SEQ \n";
				
		strStep = "Start17";
				lrFilters = CITDatabase.selectQuery(strSql, lrArgData);
		strStep = "Start18";
				
				lrArgData.removeAll();
				
		strStep = "Start19";
				if (lrArgs.getRowsCount() > 0)
				{
		strStep = "Start20";
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
					
		strStep = "Start21";
					lrArgData.addRow();
					
		strStep = "Start22";
					for (int i = 0; i < lrArgs.getRowsCount(); i++)
					{
		strStep = "Start22-1";
						if (lrArgs.toString(i, "SESSION_TAG").equals("T"))
						{
		strStep = "Start22-2";
							if(htArgs != null) lrArgData.setValue(lrArgs.toString(i, "ARG_SEQ"), htArgs.get(lrArgs.toString(i, "SESSION_NAME")).toString());
						}
						else
						{
		strStep = "Start22-3";
		//strStep = "Start22-3" + lrArgs.toString(i, "NAME");
		//strStep = "Start22-3" + lrArgs.toString(i, "NAME") + "," + htArgs.get(lrArgs.toString(i, "NAME")) + "," +strLovParam;
		//strStep = "Start22-3" + lrArgs.toString(i, "NAME") + ","  +strLovParam;
							//CITDebug.PrintMessages("NAME");
							//CITDebug.PrintMessages(lrArgs.toString(i, "NAME"));
							//CITDebug.PrintMessages("VALUE");
							//if(htArgs == null) CITDebug.PrintMessages("ht is null");
							//if(htArgs != null) CITDebug.PrintMessages( htArgs.get(lrArgs.toString(i, "NAME")).toString() );
							if(htArgs != null) lrArgData.setValue(lrArgs.toString(i, "ARG_SEQ"), htArgs.get(lrArgs.toString(i, "NAME")) );
							//CITDebug.PrintMessages("lrArgs(" + lrArgs.toString(i, "NAME") + ") : " + htArgs.get(lrArgs.toString(i, "NAME")));
						}
					}
					
		strStep = "Start23";
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
		strStep = "Start24";
				}
				
		strStep = "Start25";
				lrReturnData = CITDatabase.selectQuery(lrLov.toString(0, "SQL"), lrArgData);
		strStep = "Start26";
				
				lrDataset = CITCommon.toGauceDataSet(lrReturnData);
		strStep = "Start27";
				GauceInfo.response.enableFirstRow(lrDataset);
		strStep = "Start28";
				lrDataset.flush();
		strStep = "Start29";
			}
			catch (Exception ex)
			{
				if (GauceInfo == null) GauceInfo = new CITGauceInfo(request, response);
				GauceInfo.response.writeException("USER", "900001", "공통팝업 실행 오류 -> " + strStep +" "+ ex.getMessage());
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
				
				if (lrFilter == null || lrFilter.getRowsCount() < 1) throw new Exception("필터정보가 존재하지 않습니다(LOV_NO:" + strLovNo + ", FILTER_SEQ:" + strFilterSeq + ")");
				if (CITCommon.isNull(lrFilter.toString(0, "SQL"))) throw new Exception("필터의 쿼리가 존재하지 않습니다(LOV_NO:" + strLovNo + ", FILTER_SEQ:" + strFilterSeq + ")");
				
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
							if(htArgs != null) lrArgData.setValue(lrFilterArgs.toString(i, "FILTER_ARG_SEQ"), htArgs.get(lrFilterArgs.toString(i, "FILTER_ARG_NAME")));
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
				GauceInfo.response.writeException("USER", "900001", "COMBO FILTER Select 오류 -> " + ex.getMessage());
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