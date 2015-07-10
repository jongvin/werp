<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.log.*"%><%
ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
GauceContext context = service.getContext();
Logger logger = context.getLogger();
try {
    GauceResponse res = service.getGauceResponse();
    GauceRequest req = service.getGauceRequest();
    
    GauceDataSet dSet = new GauceDataSet();
    res.enableFirstRow(dSet);
    dSet.addDataColumn(new GauceDataColumn("zip_code", GauceDataColumn.TB_STRING, 6));
    dSet.addDataColumn(new GauceDataColumn("province", GauceDataColumn.TB_STRING, 10));
    dSet.addDataColumn(new GauceDataColumn("city", GauceDataColumn.TB_STRING, 10));
    dSet.addDataColumn(new GauceDataColumn("town", GauceDataColumn.TB_STRING, 10));
    dSet.addDataColumn(new GauceDataColumn("numtest", GauceDataColumn.TB_INT, 5));
    dSet.addDataColumn(new GauceDataColumn("dec", GauceDataColumn.TB_DECIMAL, 15, 3));

    for (int i = 1; i <= 10; i++) {
        GauceDataRow row = dSet.newDataRow();

        row.addColumnValue("10000" + i);
        row.addColumnValue("gauce");
        row.addColumnValue("GAUCE");
        row.addColumnValue("Town " + i*10);
        row.addColumnValue(i);
        row.addColumnValue(123451234512345.3);
        dSet.addDataRow(row);
    }

    dSet.flush();
    res.flush();
//    res.writeException("Native", "70000", "오류가 발생하였습니다.");
//    res.commit();
    res.commit("성공입니다");
    res.close();
} catch (Exception e) {
    logger.err.println(this, e);
    throw e;
} finally {
    loader.restoreService(service);
}
%>