<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="../../../comm_function/conn_procedure_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_last_date = req.getParameter("arg_last_date");
     String arg_to_copy = req.getParameter("arg_to_copy");
     String arg_1_mon = req.getParameter("arg_1_mon");
 //---------------------------------------------------------- 
      dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
      stmt = conn.prepareCall("{call sp_p_to_po_calculate(?,?,?,?)}");
      stmt.setString(1,arg_start_date);
      stmt.setString(2,arg_last_date);
      stmt.setString(3,arg_to_copy);
      stmt.setString(4,arg_1_mon);
    stmt.executeQuery();   // dSet);
    stmt.close();
    dSet.flush();
    res.commit("���������� ���ƽ��ϴ�");
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