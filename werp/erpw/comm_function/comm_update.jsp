<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file ="conn_tr_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_cmd = req.getParameter("arg_cmd");
 //---------------------------------------------------------- 
	  GauceDataSet dSet = new GauceDataSet();
	  res.enableFirstRow(dSet);
     dSet.addDataColumn(new GauceDataColumn("sqlcode",GauceDataColumn.TB_DECIMAL,18,0));
     String query = arg_cmd ;
     String query_1 = arg_cmd.replace('!','+') ;  // !를 +로 바꿈. url에서는 +를 값으로 넘겨줄수 없슴으로 
        stmt = conn.prepareStatement(query_1);
        stmt.executeUpdate();
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