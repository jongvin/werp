<%@ page import="java.io.*,com.gauce.*,com.gauce.io.*,com.gauce.http.*,com.gauce.common.*"%><%
GauceOutputStream gos = ((HttpGauceResponse) response).getGauceOutputStream();
GauceDataSet dSet = new GauceDataSet("tbds_list");
gos.fragment(dSet);

String dir = pageContext.getServletContext().getRealPath("gauce40/blob.dat");
FileInputStream is = new FileInputStream(dir);
String[][] values = CommonUtil.loadCSV(is);
for (int i = 0; i < values.length; i++) {
    dSet.put("data_name", values[i][0], 50); // data_name
    dSet.put("data_url", new java.net.URL(values[i][1]), 100); // data_url 
    dSet.heap();
}
gos.write(dSet);
gos.close();
%>