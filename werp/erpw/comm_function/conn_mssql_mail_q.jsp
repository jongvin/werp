<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
String database_driver,database_url,database_user,database_password,session_temp;
database_driver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
Connection conn = null;
Statement stmt = null;
try { 
	  Class.forName(database_driver);                     // testdb�� driver���� �̿� 
     conn = DriverManager.getConnection("jdbc:microsoft:sqlserver://192.168.1.5:1433;databasename=evada","gwuser","ezflow2000");  // testdb����(url,userid,passwor)�� �̿��Ͽ� conn
     stmt = conn.createStatement();
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
%>