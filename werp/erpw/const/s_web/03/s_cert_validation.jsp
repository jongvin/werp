<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*,org.tempuri.*,javax.xml.rpc.holders.StringHolder"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
String ls_str ="";
     String arg_bonsa = req.getParameter("arg_bonsa");

		StringHolder  callCertValidationResult = new StringHolder() ;
		StringHolder rtnValidateResult = new StringHolder();

     dSet.addDataColumn(new GauceDataColumn("cert_return",GauceDataColumn.TB_STRING,3000));
		
		EVCSPLocator loc = new EVCSPLocator();
		EVCSPSoap port = loc.getEVCSPSoap();
	
		port.callCertValidation(arg_bonsa, 2, callCertValidationResult, rtnValidateResult);
		
     String query = "  SELECT 'A0101' cert_return   " + 
                    "         from dual   ";

     ResultSet rset = stmt.executeQuery(query);
     dSet = rescopy.copydataset(rset, dSet);
     GauceDataRow[] rows = dSet.getDataRows();
     
     int idx_cert_return = dSet.indexOfColumn("cert_return"); 
     rows[0].setString(idx_cert_return,callCertValidationResult.value);

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