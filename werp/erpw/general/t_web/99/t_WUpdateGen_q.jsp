<%@ page import="com.cj.common.*, com.cj.database.*, com.cj.util.*, com.gauce.*, com.gauce.io.*, java.sql.*" errorPage="../common/Error.jsp" contentType="text/html;charset=euc-kr"%>
<%
/***************************************************/
/* 최초작성자 : 김흥수
/* 최초작성일 : 2004-11-15
/* 최종수정자 : 
/* 최종수정일 : 
/***************************************************/

	CITGauceInfo GauceInfo = null;
	
	CITData lrReturnData = null;
	GauceDataSet lrDataset = null;
	String	strSql = "";
	
	String	strAct = "";
	String	strAct2 = "";
	
	String strCondition = "";
	try
	{
		GauceInfo=CITCommon.initServerPage(request, response, session, false);
		
		CITData lrArgData = new CITData();
		
		strAct = CITCommon.toKOR(request.getParameter("ACT"));
		
		if (strAct.equals("MAIN"))
		{
			String		strCONDITION = CITCommon.toKOR(request.getParameter("CONDITION"));
			strSql = 
				"Select"+"\r\n"+
				"	a.OWNER,"+"\r\n"+
				"	a.TABLE_NAME"+"\r\n"+
				"From	ALL_TABLES a"+"\r\n"+
				"Where	a.TABLE_NAME Like '%' || Upper(?) || '%'"+"\r\n"+
				"Order By"+"\r\n"+
				"	a.OWNER,"+"\r\n"+
				"	a.TABLE_NAME";
			lrArgData.addColumn("CONDITION", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("CONDITION", strCONDITION);
		}
		else if(strAct.equals("COLUMN"))
		{
			String		strOWNER = CITCommon.toKOR(request.getParameter("OWNER"));
			String		strTABLE_NAME = CITCommon.toKOR(request.getParameter("TABLE_NAME"));
			strSql = 
				"Select"+"\r\n"+
				"	a.OWNER,"+"\r\n"+
				"	a.TABLE_NAME,"+"\r\n"+
				"	a.COLUMN_NAME,"+"\r\n"+
				"	a.DATA_TYPE,"+"\r\n"+
				"	'T' ISSELECT,"+"\r\n"+
				"	Decode(t.COLUMN_NAME , null ,'F','T') ISKEY"+"\r\n"+
				"From	all_tab_columns a,"+"\r\n"+
				"		("+"\r\n"+
				"			Select"+"\r\n"+
				"				c.OWNER,"+"\r\n"+
				"				c.TABLE_NAME,"+"\r\n"+
				"				c.COLUMN_NAME"+"\r\n"+
				"			From	"+"\r\n"+
				"				all_constraints b,"+"\r\n"+
				"				all_cons_columns c"+"\r\n"+
				"			Where	b.OWNER = c.OWNER"+"\r\n"+
				"			And		b.CONSTRAINT_NAME = c.CONSTRAINT_NAME"+"\r\n"+
				"			And		b.TABLE_NAME = c.TABLE_NAME"+"\r\n"+
				"			And		b.CONSTRAINT_TYPE = 'P'"+"\r\n"+
				"			And		c.OWNER = ?"+"\r\n"+
				"			And		c.TABLE_NAME = ?"+"\r\n"+
				"		) t"+"\r\n"+
				"Where	a.OWNER = ?"+"\r\n"+
				"And		a.TABLE_NAME = ?"+"\r\n"+
				"And		a.OWNER = t.OWNER (+)"+"\r\n"+
				"And		a.TABLE_NAME = t.TABLE_NAME (+)"+"\r\n"+
				"And		a.COLUMN_NAME = t.COLUMN_NAME (+)"+"\r\n"+
				"Order By"+"\r\n"+
				"	a.COLUMN_ID";
			lrArgData.addColumn("OWNER1", CITData.VARCHAR2);
			lrArgData.addColumn("TABLE_NAME1", CITData.VARCHAR2);
			lrArgData.addColumn("OWNER2", CITData.VARCHAR2);
			lrArgData.addColumn("TABLE_NAME2", CITData.VARCHAR2);
			lrArgData.addRow();
			lrArgData.setValue("OWNER1", strOWNER);
			lrArgData.setValue("TABLE_NAME1", strTABLE_NAME);
			lrArgData.setValue("OWNER2", strOWNER);
			lrArgData.setValue("TABLE_NAME2", strTABLE_NAME);
		}
		try
		{
			lrReturnData = CITDatabase.selectQuery(strSql, lrArgData);
			lrDataset = CITCommon.toGauceDataSet(lrReturnData);
			GauceInfo.response.enableFirstRow(lrDataset);
			lrDataset.flush();
		}
		catch (Exception ex)
		{
			GauceInfo.response.writeException("USER", "900001", ex.getMessage());
		}
	}
	catch (Exception ex)
	{
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
	    	GauceInfo.response.writeException("SYS", "100002", "페이지 종료 오류 -> " + ex.getMessage());
	    }
	}
%>
