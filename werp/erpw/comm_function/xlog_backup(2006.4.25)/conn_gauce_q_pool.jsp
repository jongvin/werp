<%@ page import="java.util.*,javax.sql.*,javax.naming.InitialContext
                 atom.xlog.jdbc.WpConnection,
                 atom.xlog.filter.XLogFilter,
                 atom.xlog.XLog
"%>

<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
//DBProfile dbpro = context.getDBProfile();  
InitialContext ic = null;
DataSource ds = null;
Connection conn = null;
Statement stmt = null;



XLogFilter  xfilter = new XLogFilter(this);
boolean xfilter_flag = xfilter.begin(request);



try { 
	  ic = new InitialContext();
	  ds = (DataSource)ic.lookup("jdbc/OracleDS");
     conn = new WpConnection(ds.getConnection());
     stmt = conn.createStatement();
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
%>