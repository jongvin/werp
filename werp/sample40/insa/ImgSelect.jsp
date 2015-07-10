<%@ page import="javax.sql.*,java.io.*,java.sql.*,com.gauce.*,com.gauce.io.*,com.gauce.http.*,com.gauce.common.*"%><%
GauceOutputStream gos = ((HttpGauceResponse) response).getGauceOutputStream();
GauceDataSet dSet = new GauceDataSet("tbds_list");
gos.fragment(dSet);
DataSource datasource = (DataSource)request.getAttribute("GauceDB");   
String empno = ((HttpGauceRequest)request).getParameter("empno");
try {
    Connection conn = datasource.getConnection();
    String query  = " SELECT '', PHOTO_URL FROM T_HM1000 WHERE EMP_NO = '" + empno + "'";
    Statement stmt = conn.createStatement();
	ResultSet rs = stmt.executeQuery(query);
	String photoName = empno + ".jpg";
	while(rs.next()) {
		String strPhotoURL = rs.getString("PHOTO_URL");
        dSet.put("PHOTO_NAME", photoName, 300); // data_name
        dSet.put("PHOTO_URL", new java.net.URL(strPhotoURL), 255);
        dSet.heap();
     }
} catch (Exception e) {
    e.printStackTrace();
}
gos.write(dSet);
gos.close();
%>