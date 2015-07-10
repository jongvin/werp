<%@ page import="java.util.*,javax.sql.*,javax.naming.InitialContext"%>
<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%>
<% ServiceLoader loader = new ServiceLoader(request, response);
GauceService service = loader.newService();
GauceContext context = service.getContext(); 
Logger logger = context.getLogger();
GauceRequest req = service.getGauceRequest();
GauceResponse res = service.getGauceResponse(); 
InitialContext ic = null;
DataSource ds = null;
Connection conn = null;
Statement stmt = null;
			
try { 
	  String session_temp = new String(session.getAttribute("database_user").toString());
	  ic = new InitialContext();
	  ds = (DataSource)ic.lookup("jdbc/OracleDS");
     conn = ds.getConnection();
     stmt = conn.createStatement();
     //GauceDataSet dSet = new GauceDataSet();					   
     //res.enableFirstRow(dSet);

 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
 
 //---------------------------------------------------------- 																				    
     //dSet.addDataColumn(new GauceDataColumn("sender_id",GauceDataColumn.TB_STRING,20));
     //dSet.addDataColumn(new GauceDataColumn("tran_id",GauceDataColumn.TB_STRING,20));
     //dSet.addDataColumn(new GauceDataColumn("tran_phone",GauceDataColumn.TB_STRING,15));
     //dSet.addDataColumn(new GauceDataColumn("tran_callback",GauceDataColumn.TB_STRING,15));
     //dSet.addDataColumn(new GauceDataColumn("tran_msg",GauceDataColumn.TB_STRING,255));
    String query = "  SELECT " + 
     "             a.sender_id," + 
     "             a.tran_id," + 
     "             a.tran_phone," + 
     "             a.tran_callback," + 
     "             a.tran_msg " + 
     "     FROM erpw.h_sms_intf a ";

	 ResultSet rset = stmt.executeQuery(query);        // jdbc 로 execute
    //dSet = rescopy.copydataset(rset, dSet);          // ResultSet 의 내용을 gaucedataset으로 move 
    stmt.close();
    //dSet.flush();  조회된 데이타를 살려둠...
    //res.commit("성공적으로 마쳤습니다");
    //res.close();   

 
//ServiceLoader loader = new ServiceLoader(request, response);  
//GauceService service = loader.newService();    // testdb context 생성.
//GauceContext context = service.getContext(); 
//Logger logger = context.getLogger();
//GauceRequest req = service.getGauceRequest();
//GauceResponse res = service.getGauceResponse(); 
String database_driver,database_url,database_user,database_password;//session_temp;
database_driver = "com.microsoft.jdbc.sqlserver.SQLServerDriver";
//Connection conn = null;
PreparedStatement pstmt = null;

	  Class.forName(database_driver);                     // testdb의 driver정보 이용 
     conn = DriverManager.getConnection("jdbc:microsoft:sqlserver://192.168.1.5:1433;databasename=evada","gwuser","ezflow2000");  // testdb정보(url,userid,passwor)를 이용하여 conn
     conn.setAutoCommit(false);		  

	  //GauceDataSet dSet = req.getGauceDataSet("z_mail_to_1tr");  새로읽어올 필요 없음..
    gpstatement.gp_dataset = rset;
    int idx_sender_id = dSet.indexOfColumn("sender_id");
    int idx_tran_id = dSet.indexOfColumn("tran_id");
    int idx_tran_phone = dSet.indexOfColumn("tran_phone");
    int idx_tran_callback = dSet.indexOfColumn("tran_callback");
    int idx_tran_msg = dSet.indexOfColumn("tran_msg");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	//if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO smsuser.em_tran_worldro ( " + 
                    "sender_id," + 
                    "tran_id," + 
                    "tran_phone," + 
                    "tran_callback," + 
                    "tran_status," + 
                    "tran_date," + 
                    "tran_msg," + 
                    "tran_type )      ";
      sSql = sSql + " VALUES ( ?, ?, ?, ?,'1',getdate(), ?,'0') ";
      pstmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = pstmt;
      gpstatement.bindColumn(1, idx_sender_id);
      gpstatement.bindColumn(2, idx_tran_id);
      gpstatement.bindColumn(3, idx_tran_phone);
      gpstatement.bindColumn(4, idx_tran_callback);
      gpstatement.bindColumn(5, idx_tran_msg);
      pstmt.executeUpdate();
      pstmt.close();
 
		sSql = " INSERT INTO smsuser.em_tran ( " + 
                    "tran_id," + 
                    "tran_phone," + 
                    "tran_callback," + 
                    "tran_status," + 
                    "tran_date," + 
                    "tran_msg," + 
                    "tran_type )      ";
      sSql = sSql + " VALUES (?, ?, ?,'1',getdate(), ?,'0') ";
      pstmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = pstmt;
      gpstatement.bindColumn(1, idx_tran_id);
      gpstatement.bindColumn(2, idx_tran_phone);
      gpstatement.bindColumn(3, idx_tran_callback);
      gpstatement.bindColumn(4, idx_tran_msg);
      pstmt.executeUpdate();
      pstmt.close();
   //}
	//else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
   //}
	//else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
   //}
     }
     dSet.flush(); 
     //res.commit("성공적으로 마쳤습니다");
     //res.close();
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
