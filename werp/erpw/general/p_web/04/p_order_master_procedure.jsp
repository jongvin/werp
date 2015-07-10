<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_emp_no = req.getParameter("arg_emp_no");
     String arg_spec_no_seq = req.getParameter("arg_spec_no_seq");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call p_order_master_procedure(?,?)}");
      stmt.setString(1,arg_emp_no);
      stmt.setString(2,arg_spec_no_seq);
    stmt.executeQuery();   // dSet);
    stmt.close();
    dSet.flush();
    res.commit("성공적으로 마쳤습니다");
    res.close();
} catch (Exception e) {
    res.writeException("Native","9999",e.toString());
    res.commit();
    res.close();
    if (conn != null) {
       conn.rollback();
    }
    if (stmt != null) {
       stmt.close();
    }
} finally {
    if (conn != null) {
        try {
            conn.commit();
            conn.close();
        } catch (Exception e) {}
    }
    loader.restoreService(service);
}
%>