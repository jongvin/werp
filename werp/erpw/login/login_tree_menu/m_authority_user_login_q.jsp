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
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_user_id = req.getParameter("arg_user_id");
 //---------------------------------------------------------- 
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("deptcode",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT z_authority_user.empno empno,   " + 
     "         z_authority_user.user_id user_id,   " + 
     "         z_authority_user.password password,   " + 
     "         z_authority_user.name name,   " + 
     "         z_authority_user.dept_code deptcode,   " + 
     "         z_code_dept.short_name   short_name" + 
     "    FROM z_authority_user,   " + 
     "         z_code_dept  " + 
     "   WHERE ( z_authority_user.dept_code = z_code_dept.dept_code ) and  " + 
     "         ( ( z_authority_user.user_id = " + "'" + arg_user_id + "'" + " )   " + 
     "         )         ";
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
