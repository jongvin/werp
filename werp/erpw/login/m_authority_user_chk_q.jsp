<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_gauce_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_user_id = req.getParameter("arg_user_id");
     String arg_password = req.getParameter("arg_password");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("deptcode",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("g_ipaddress",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sys_date",GauceDataColumn.TB_STRING,22));
    String query = "  SELECT z_authority_user.empno empno,   " + 
     "         z_authority_user.user_id user_id,   " + 
     "         z_authority_user.password password,   " + 
     "         z_authority_user.name name,   " + 
     "         z_authority_user.dept_code deptcode,   " + 
     "         z_authority_user.g_ipaddress g_ipaddress,   " + 
     "         z_code_dept.long_name   short_name," +   
     "         to_char(sysdate,'yyyy.mm.dd hh24:mi:ss')  sys_date" +  
     "    FROM z_authority_user,   " + 
     "         z_code_dept  " + 
     "   WHERE ( z_authority_user.dept_code = z_code_dept.dept_code (+) ) and  " + 
     "         ( z_authority_user.user_id = " + "'" + arg_user_id + "'" + " ) and  " + 
     "         ( z_authority_user.password = " + "'" + arg_password + "'" + " )   " + 
     "                  ";
    ResultSet rset = stmt.executeQuery(query);
    dSet = rescopy.copydataset(rset, dSet);
    stmt.close();
    dSet.flush();
    res.commit("성공적으로 마쳤습니다");
    res.close();
} catch (Exception e) {
    res.writeException("Native","9999",e.toString());
    res.commit();
    res.close();
    if (stmt != null) {
       stmt.close();
    }
} finally {
    if (conn != null) {
        try {
            conn.close();
        } catch (Exception e) {}
    }
    loader.restoreService(service);
} %>