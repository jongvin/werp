<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();    // testdb context ����.
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
String database_driver,database_url,database_user,database_password,session_temp;
database_driver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
Connection conn = null;
PreparedStatement stmt = null;
try { 
	  Class.forName(database_driver);                     // testdb�� driver���� �̿� 
     conn = DriverManager.getConnection("jdbc:microsoft:sqlserver://218.49.235.196:1433;databasename=hp_plus","midas","midasit");  // testdb����(url,userid,passwor)�� �̿��Ͽ� conn
     conn.setAutoCommit(false);
%>