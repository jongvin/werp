<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%>
ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
GauceContext context = service.getContext();
Logger logger = context.getLogger();
GauceDBConnection conn = null;
try {
     conn = service.getDBConnection();GauceStatement stmt = null;
     GauceRequest req = service.getGauceRequest();
     GauceResponse res = service.getGauceResponse();
 // 다음 문장은 수정 하시요 --------------------------------- 
     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
     dSet.addDataColumn(new GauceDataColumn("no1",GauceDataColumn.TB_DECIMAL,10,0));
     dSet.addDataColumn(new GauceDataColumn("level1",GauceDataColumn.TB_DECIMAL,1,0));
     dSet.addDataColumn(new GauceDataColumn("level_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("menu_name",GauceDataColumn.TB_STRING,80));
     dSet.addDataColumn(new GauceDataColumn("type",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("security",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  test_menu_tree.no1 ," + 
     "          test_menu_tree.level1 ," + 
     "          test_menu_tree.level_code ," + 
     "          test_menu_tree.menu_name ," + 
     "          test_menu_tree.type ," + 
     "          test_menu_tree.addr ," + 
     "          test_menu_tree.security     FROM test_menu_tree   ORDER BY test_menu_tree.no1          ASC      ";
    stmt = conn.getGauceStatement(query);
    stmt.executeQuery(dSet);
    stmt.close();
    dSet.flush();
    res.commit("성공적으로 마쳤습니다");
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
