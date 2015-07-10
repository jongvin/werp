<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%
ServiceLoader loader = new ServiceLoader(request, response);  
GauceService service = loader.newService();
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
DBProfile dbpro = context.getDBProfile();             // testdb의 정보 이용
Class.forName(dbpro.getDriver());                     // testdb의 driver정보 이용 
Connection conn = null;
conn = DriverManager.getConnection(dbpro.getURL(),dbpro.getUser(),dbpro.getPasswd());  // testdb정보(url,userid,passwor)를 이용하여 conn
Statement stmt = null;
stmt = conn.createStatement();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
try { 
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("english_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("const_start_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("const_end_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
    String query = "  SELECT  z_code_dept.dept_code ," + 
     "          z_code_dept.comp_code ," + 
     "          z_code_dept.long_name ," + 
     "          z_code_dept.short_name ," + 
     "          z_code_dept.english_name ," + 
     "          z_code_dept.dept_seq_key ," + 
     "          z_code_dept.dept_proj_tag ," + 
     "          z_code_dept.use_tag,  " + 
     "          to_char(z_code_dept.const_start_date,'yyyy.mm.dd')  const_start_date, " + 
     "          to_char(z_code_dept.const_end_date,'yyyy.mm.dd')  const_end_date," + 
     "          to_char(z_code_dept.chg_const_start_date,'yyyy.mm.dd') chg_const_start_date, " + 
     "          to_char(z_code_dept.chg_const_end_date,'yyyy.mm.dd') chg_const_end_date, " + 
     "          nvl(z_code_dept.const_term,0) const_term,  " + 
     "          nvl(z_code_dept.chg_const_term,0) chg_const_term,  " + 
     "          z_code_dept.process_code process_code  " + 
     "          FROM z_code_dept         ";
ResultSet rset = stmt.executeQuery(query);        // jdbc 로 execute
    dSet = rescopy.copydataset(rset, dSet);          // ResultSet 의 내용을 gaucedataset으로 move 
    stmt.close();
    dSet.flush();
    res.commit("성공적으로 마쳤습니다");
    res.close();   
} catch (Exception e) {
    String temp_err;
    temp_err = e.toString();
    if (temp_err.equals("java.lang.NullPointerException")) 
        res.writeException("Internet Line Error","0000","Line Information error: you must be re-login please");
    else
       res.writeException("Native","9999",e.toString());
    res.commit();
    res.close();
    if (stmt != null) {
       stmt.close();
    }
} 
  finally {
    if (conn != null) {
        try {
            conn.close();
        } catch (Exception e) { }
    }
    loader.restoreService(service);
}
%>