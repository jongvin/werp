<%@ page import="java.util.*,javax.sql.*,javax.naming.InitialContext"%>
<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
InitialContext ic = null;
DataSource ds = null;
Connection conn = null;
Statement stmt = null;

try { 
	 // String session_temp = new String(session.getAttribute("database_user").toString());
	  ic = new InitialContext();
	  ds = (DataSource)ic.lookup("jdbc/OracleDS");
     conn = ds.getConnection();
     stmt = conn.createStatement();
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
%>