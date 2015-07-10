<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.http.*"%><%
GauceOutputStream gos = ((HttpGauceResponse) response).getGauceOutputStream();
//gos.writeTo(response.getOutputStream());
GauceDataSet dSet = new GauceDataSet();
gos.fragment(dSet);
for (int i = 1; i <= 100; i++) {
    dSet.put("zip_code", "10000" + i, 6);
    dSet.put("province", "°¡¿ì½º", 10);
    dSet.put("city", "Gauce", 10);
    dSet.put("town", "Town " + i*10, 10);
    dSet.put("numtest", i, 5);
    dSet.put("dec", (double)i/2, 15.2);
    dSet.heap();
}
gos.write(dSet);
gos.close();
%>