<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.net.*,java.sql.*,java.util.*"%><%
ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
GauceContext context = service.getContext();
String database_driver,database_url,database_user,database_password,session_temp;
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse();
try {
	  session_temp = new String(session.getAttribute("database_user").toString());
     int index = session_temp.indexOf('*');
     database_user = session_temp.substring(0,index);
     session_temp =  session_temp.substring(index + 1);
     index = session_temp.indexOf('*');
     database_password = session_temp.substring(0,index);
    GauceDataSet dSet = new GauceDataSet();
    res.enableFirstRow(dSet);
    dSet.addDataColumn(new GauceDataColumn("ip_addr", GauceDataColumn.TB_STRING, 30));
    dSet.addDataColumn(new GauceDataColumn("start_time", GauceDataColumn.TB_STRING, 30));
    dSet.addDataColumn(new GauceDataColumn("database_user", GauceDataColumn.TB_STRING, 30));
    dSet.addDataColumn(new GauceDataColumn("database_password", GauceDataColumn.TB_STRING, 30));

        GauceDataRow row = dSet.newDataRow();
//          String addr;
          String addr = request.getRemoteAddr();
//        SimpleDateFormat sdf = new SimpleDateFormat ( "yyyy/MM/dd hh:mi:ss a" );
//        String startTime = sdf.format ( new Date ());
//        addr = " ";
        row.addColumnValue(addr);
        row.addColumnValue(" ");
        row.addColumnValue(database_user);
        row.addColumnValue(database_password);
        dSet.addDataRow(row);
    dSet.flush();
    res.flush();
    res.commit();
    //res.commit("성공적으로  작업이 끝났습니다.");
    res.close();
} catch (Exception e) {
    res.writeException("Native","9999",e.toString());
    res.commit();
    res.close();
} finally {
    loader.restoreService(service);
}
%>