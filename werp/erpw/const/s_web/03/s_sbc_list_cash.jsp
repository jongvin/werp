<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*,hash.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
String ls_str ="";
     String arg_dir = req.getParameter("arg_dir");
     arg_dir = arg_dir.replace('@','/'); 

     dSet.addDataColumn(new GauceDataColumn("hash_return",GauceDataColumn.TB_STRING,2000));
     HashReturn HashR = new hash.HashReturn();

     ls_str = HashR.getHashFile(arg_dir);

     String query = "  SELECT 'A0101' hash_return   " + 
                    "         from dual   ";
     ResultSet rset = stmt.executeQuery(query);
     dSet = rescopy.copydataset(rset, dSet);
     GauceDataRow[] rows = dSet.getDataRows();
     int idx_hash_return = dSet.indexOfColumn("hash_return"); 
     rows[0].setString(idx_hash_return,ls_str);
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
}%>