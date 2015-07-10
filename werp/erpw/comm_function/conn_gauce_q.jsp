
<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
DBProfile dbpro = context.getDBProfile();             // testdb의 정보 이용
Class.forName(dbpro.getDriver());                     // testdb의 driver정보 이용 
Connection conn = null;
conn = DriverManager.getConnection(dbpro.getURL(),dbpro.getUser(),dbpro.getPasswd());  // testdb정보(url,userid,passwor)를 이용하여 conn
Statement stmt = null;
stmt = conn.createStatement();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
try { 
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
%>