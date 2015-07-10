<%@ page language="java" import="com.cj.common.*, com.cj.database.*, com.cj.util.*, oracle.jdbc.pool.*, javax.naming.*, java.sql.*, javax.sql.*" contentType="text/html;charset=euc-kr" %>
<%
	CITCommon.initPage(request, response, session, false);
	
	System.setProperty("cj.datasource_name", "jdbc/OracleDS");
	System.setProperty("cj.database_user", "erpw*erpw*jdbc:oracle:thin:@52.10.125.209:1521:erp");
	CITConnectionManager.clearConnectionPools();
	
	out.println("Database Info=" + CITCommon.getProperty(CITDatabase.DATABASE_INFO_KEY) + "<BR>");
	out.println("URL=" + CITDatabase.getURL() + "<BR>");
	out.println("User=" + CITDatabase.getUser() + "<BR>");
	out.println("Password=" + CITDatabase.getPassword() + "<BR>");
	/*
	Context initContext = new InitialContext();
	Context envContext = (Context) initContext.lookup("java:/comp/env");
	OracleDataSource ds = (OracleDataSource) envContext.lookup("jdbc/OracleDS");
	Connection conn = ds.getConnection();
	
	out.println("ds.getDatabaseName=" + ds.getDatabaseName() + "<BR>");
	out.println("ds.getDataSourceName=" + ds.getDataSourceName() + "<BR>");
	out.println("ds.getDescription=" + ds.getDescription() + "<BR>");
	out.println("ds.getDriverType=" + ds.getDriverType() + "<BR>");
	out.println("ds.getExplicitCachingEnabled=" + ds.getExplicitCachingEnabled() + "<BR>");
	out.println("ds.getImplicitCachingEnabled=" + ds.getImplicitCachingEnabled() + "<BR>");
	out.println("ds.getLoginTimeout=" + ds.getLoginTimeout() + "<BR>");
	out.println("ds.getMaxStatements=" + ds.getMaxStatements() + "<BR>");
	out.println("ds.getNetworkProtocol=" + ds.getNetworkProtocol() + "<BR>");
	out.println("ds.getPortNumber=" + ds.getPortNumber() + "<BR>");
	out.println("ds.getReference=" + ds.getReference() + "<BR>");
	out.println("ds.getServerName=" + ds.getServerName() + "<BR>");
	out.println("ds.getServiceName=" + ds.getServiceName() + "<BR>");
	out.println("ds.getTNSEntryName=" + ds.getTNSEntryName() + "<BR>");
	out.println("ds.getURL=" + ds.getURL() + "<BR>");
	out.println("ds.getUser=" + ds.getUser() + "<BR>");
	
	Connection conn = CITConnectionManager.getConnection();
	
	String lsSql = "";
	
	lsSql += " Select PROJ_CODE, ";
	lsSql += "        PROJ_NAME ";
	lsSql += " From   TCC_PROJ_CODE ";
	lsSql += " Where  COMPANY_CODE = ? ";
	lsSql += "  And   USE_TAG = 'T' ";
	lsSql += " Order by 1 ";
	
	CITData lrArgData = new CITData();
	
	lrArgData.addColumn("COMPANY_CODE", CITData.VARCHAR2);
	lrArgData.addRow();
	lrArgData.setValue("COMPANY_CODE", "200");
	
	CITData lrReturnData = CITDatabase.selectQuery(lsSql, lrArgData);
	
	for (int i = 0; i < lrReturnData.getRowsCount(); i++)
	{
		out.println(i + ". " + lrReturnData.toString(i, "PROJ_NAME") + "(" + lrReturnData.toString(i, "PROJ_CODE") + ")<BR>");
	}
	
	CITConnectionManager.freeConnection(conn);
	*/
%> 