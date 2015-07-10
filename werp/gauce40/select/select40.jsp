<%@ page import="com.gauce.*,com.gauce.http.*,com.gauce.io.*,com.gauce.log.*"%><%
GauceOutputStream gos = ((HttpGauceResponse) response).getGauceOutputStream();
GauceDataSet dSet = new GauceDataSet();
gos.fragment(dSet);
dSet.addDataColumn(new GauceDataColumn("zip_code", GauceDataColumn.TB_STRING, 6));
dSet.addDataColumn(new GauceDataColumn("province", GauceDataColumn.TB_STRING, 10));
dSet.addDataColumn(new GauceDataColumn("city", GauceDataColumn.TB_STRING, 10));
dSet.addDataColumn(new GauceDataColumn("town", GauceDataColumn.TB_STRING, 10));
dSet.addDataColumn(new GauceDataColumn("numtest", GauceDataColumn.TB_INT, 5));
dSet.addDataColumn(new GauceDataColumn("dec", GauceDataColumn.TB_DECIMAL, 15, 2));

for (int i = 1; i <= 50000; i++) { 
    GauceDataRow row = dSet.newDataRow();
    row.setString(0, "10000" + i);
    row.setString(1, "test");
    row.setString(2, "Gauce");
    row.setString(3, "Town " + i*10);
    row.setInt(4, i);
    row.setDouble(5, i/0.2);
    dSet.addDataRow(row);
}
gos.write(dSet);
%>