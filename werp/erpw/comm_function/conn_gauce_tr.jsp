<% ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();    // testdb context ����.
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
DBProfile dbpro = context.getDBProfile();             // testdb�� ���� �̿�
Class.forName(dbpro.getDriver());                     // testdb�� driver���� �̿� 
Connection conn = null;
conn = DriverManager.getConnection(dbpro.getURL(),dbpro.getUser(),dbpro.getPasswd());  // testdb����(url,userid,passwor)�� �̿��Ͽ� conn
PreparedStatement stmt = null;
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
try { 
%>