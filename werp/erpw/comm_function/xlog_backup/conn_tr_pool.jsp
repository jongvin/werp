<%@ page import="java.util.*,javax.sql.*,javax.naming.InitialContext,atom.xlog.jdbc.WpConnection"%>
<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();    // testdb context ����.
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
InitialContext ic = null;
DataSource ds = null;
Connection conn = null;
PreparedStatement stmt = null;
try { 
	  String session_temp = new String(session.getAttribute("database_user").toString());
	  ic = new InitialContext();
	  ds = (DataSource)ic.lookup("jdbc/OracleDS");
     conn = new WpConnection(ds.getConnection());
     conn.setAutoCommit(false);
%>