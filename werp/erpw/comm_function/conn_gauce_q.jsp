
<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
DBProfile dbpro = context.getDBProfile();             // testdb�� ���� �̿�
Class.forName(dbpro.getDriver());                     // testdb�� driver���� �̿� 
Connection conn = null;
conn = DriverManager.getConnection(dbpro.getURL(),dbpro.getUser(),dbpro.getPasswd());  // testdb����(url,userid,passwor)�� �̿��Ͽ� conn
Statement stmt = null;
stmt = conn.createStatement();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
try { 
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
%>