<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
String database_driver,database_url,database_user,database_password,session_temp;
database_driver = "oracle.jdbc.driver.OracleDriver";
Connection conn = null;
Statement stmt = null;
try { 
	 // session_temp = new String(session.getAttribute("database_user").toString());
     int index = session_temp.indexOf('*');
     database_user = session_temp.substring(0,index);
     session_temp =  session_temp.substring(index + 1);
     index = session_temp.indexOf('*');
     database_password = session_temp.substring(0,index);
     session_temp =  session_temp.substring(index + 1);
     index = session_temp.indexOf('*');
     database_url = session_temp.substring(index + 1);
	  Class.forName(database_driver);                     // testdb의 driver정보 이용 
     conn = DriverManager.getConnection(database_url,database_user,database_password);  // testdb정보(url,userid,passwor)를 이용하여 conn
     stmt = conn.createStatement();
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
%>