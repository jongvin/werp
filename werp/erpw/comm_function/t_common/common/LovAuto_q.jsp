<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*, java.util.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/**************************************************************************/
/* 1. 프 로 그 램 id : Lov_q(공통팝업 Select Query 페이지)
/* 2. 유형(시나리오) : Select Page
/* 3. 기  능  정  의 : 
/* 4. 변  경  이  력 : 강덕율 작성(2005-10-31),김흥수 수정(2005-11-24)
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
	
	
	try
	{
		GauceInfo = CITCommon.initServerPage(request, response, session);
		
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
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
			
			if (lrLov == null || lrLov.getRowsCount() < 1) throw new Exception("공통팝업이 존재하지 않습니다(LOV_NAME:" + strLovName + ")");
			if (CITCommon.isNull(lrLov.toString(0, "SQL"))) throw new Exception("공통팝업의 쿼리가 존재하지 않습니다(LOV_NAME:" + strLovName + ")");
			
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
					String lsArg = "";
					
					if (lrArgs.toString(i, "SESSION_TAG").equals("F"))
					{
						lsArg = CITCommon.toKOR(request.getParameter(lrArgs.toString(i, "NAME")));
					}
					else
					{
						String lsSession_Name = lrArgs.toString(i, "SESSION_NAME");
						lsArg = CITCommon.toKOR((String)session.getAttribute(lsSession_Name));
					}
					
					lrArgData.setValue(lrArgs.toString(i, "ARG_SEQ"), lsArg);
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
			GauceInfo.response.writeException("USER", "900001", "공통팝업 실행 오류 -> " + ex.getMessage());
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