<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="conn_tr_pool.jsp"%><%
 // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--r
     String arg_cmd = req.getParameter("arg_cmd");
 //---------------------------------------------------------- 
	  GauceDataSet dSet = new GauceDataSet();
	  res.enableFirstRow(dSet);
     dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
     String query = arg_cmd ;
     String query_1 = arg_cmd.replace('!','+') ;  // !�� +�� �ٲ�. url������ +�� ������ �Ѱ��ټ� �������� 
        stmt = conn.prepareStatement(query_1);
        stmt.executeUpdate();
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