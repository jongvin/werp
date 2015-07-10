<%    ResultSet rset = stmt.executeQuery(query);        // jdbc 로 execute
    dSet = rescopy.copydataset(rset, dSet);          // ResultSet 의 내용을 gaucedataset으로 move 
	 	rset.close();
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
    xfilter.end(xfilter_flag);
    loader.restoreService(service);
} 

%>