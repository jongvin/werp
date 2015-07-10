<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%
ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
GauceContext context = service.getContext();
Logger logger = context.getLogger();
GauceDBConnection conn = null;
    
try {
    conn = service.getDBConnection();
    GauceRequest req = service.getGauceRequest();
    GauceResponse res = service.getGauceResponse();

    GauceDataSet dSet = new GauceDataSet();
    res.enableFirstRow(dSet);
    
    dSet.addDataColumn(new GauceDataColumn("empno", GauceDataColumn.TB_INT));
    dSet.addDataColumn(new GauceDataColumn("ename", GauceDataColumn.TB_STRING, 30));
    dSet.addDataColumn(new GauceDataColumn("job", GauceDataColumn.TB_STRING));
    dSet.addDataColumn(new GauceDataColumn("mgr", GauceDataColumn.TB_INT));
    dSet.addDataColumn(new GauceDataColumn("sal", GauceDataColumn.TB_INT));
    dSet.addDataColumn(new GauceDataColumn("comm", GauceDataColumn.TB_INT));
    dSet.addDataColumn(new GauceDataColumn("deptno", GauceDataColumn.TB_INT));
    
    String query =  "select empno, ename, job, mgr, sal, comm, deptno from emp";
    GauceStatement stmt = conn.getGauceStatement(query);
    stmt.executeQuery(dSet);
    dSet.flush();
    res.commit("Terminated successfully!");
    res.close();
} catch (Exception e) {
    logger.err.println(this, e);
    throw e;
} finally {
    if (conn != null) {
        try {
            conn.close();
        } catch (Exception e) {}
    }
    loader.restoreService(service);
}
%>