<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();    // testdb context 생성.
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
String database_driver,database_url,database_user,database_password,session_temp;
database_driver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
Connection conn = null;
PreparedStatement stmt = null;
try { 
	  Class.forName(database_driver);                     // testdb의 driver정보 이용 
     conn = DriverManager.getConnection("jdbc:microsoft:sqlserver://192.168.1.5:1433;databasename=sso_worldro","sso_user","worldro");  // testdb정보(url,userid,passwor)를 이용하여 conn
     conn.setAutoCommit(false);
%>