<%     dSet.flush(); 
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