<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* 최초작성자 : 강덕율
/* 최초작성일 : 2005-10-31
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/
 
	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	
	CITData lrLov = null;
	CITData lrArgs = null;
	CITData lrCols = null;
	
	String strSql = "";
	String strLovName = "";
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session, false);
		
		CITData lrArgData = new CITData();
		
		strLovName = CITCommon.toKOR(request.getParameter("LOV_NAME"));
		
		if (!CITCommon.isNull(strLovName))
		{
			try
			{
				lrArgData.addColumn("NAME", CITData.VARCHAR2);
				lrArgData.addRow();
				lrArgData.setValue("NAME", strLovName);
				
				// LOV Select
				strSql  = " Select LOV_NO, \n";
				strSql += "        SQL \n";
				strSql += " From   T_LOV \n";
				strSql += " Where  NAME = ? ";
				
				lrLov = CITDatabase.selectQuery(strSql, lrArgData);
				
				if (lrLov != null && lrLov.getRowsCount() > 0)
				{
					lrArgData.removeAll();
					
					lrArgData.addColumn("LOV_NO", CITData.NUMBER);
					lrArgData.addRow();
					lrArgData.setValue("LOV_NO", lrLov.toString(0, "LOV_NO"));
					
					// 인자정보 Select
					strSql  = " Select * \n";
					strSql += " From   T_LOV_ARGS \n";
					strSql += " Where  LOV_NO = ? \n";
					strSql += " Order by DIS_SEQ ";
					
					lrArgs = CITDatabase.selectQuery(strSql, lrArgData);
					
					// 현재 컬럼정보 Select
					strSql  = " Select * \n";
					strSql += " From   T_LOV_COLS \n";
					strSql += " Where  LOV_NO = ? \n";
					strSql += " Order by DIS_SEQ ";
	
					lrCols = CITDatabase.selectQuery(strSql, lrArgData);
					
					// SQL 인자 설정
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
							String lsArg = "";
							
							if (CITCommon.isNull(lrArgs.toString(i, "SESSION_NAME")))
							{
								lsArg = CITCommon.toKOR(request.getParameter(lrArgs.toString(i, "NAME")));
							}
							else
							{
								if (session.getAttribute(lrArgs.toString(i, "SESSION_NAME")) == null) throw new Exception("세션변수가 존재하지 않습니다.(" + "세션변수명:" + lrArgs.toString(i, "SESSION_NAME") + ")");
								
								lsArg = CITCommon.toKOR(session.getAttribute(lrArgs.toString(i, "SESSION_NAME")).toString());
							}
							
							lrArgData.setValue(lrArgs.toString(i, "NAME"), lsArg);
						}
					}
					
					// SQL 실행
					lrReturnData = CITDatabase.selectQuery(lrLov.toString(0, "SQL"), lrArgData);
					
					lrDataset = CITCommon.toGauceDataSet(lrReturnData);
					GauceInfo.response.enableFirstRow(lrDataset);
					lrDataset.flush();
				}
			}
			catch (Exception ex)
			{
				if (GauceInfo != null) GauceInfo.response.writeException("USER", "900001", "LOV Select 오류 -> " + ex.getMessage());
				throw new Exception("USER-900001:LOV Select 오류 -> " + ex.getMessage());
			}
		}
	}
	catch (Exception ex)
	{
		if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100001", "페이지 초기화 오류 -> " + ex.getMessage());
		throw new Exception("SYS-100001:페이지 초기화 오류 -> " + ex.getMessage());
	}
	finally
	{
		try
		{
			CITCommon.finalServerPage(GauceInfo);
		}
	    catch (Exception ex)
	    {
	    	if (GauceInfo != null) GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    	throw new Exception("SYS-100002:페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>