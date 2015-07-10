<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="comm_function/conn_gauce_q_pool.jsp"%><%  
      String arg_user_id = req.getParameter("arg_user_id");
     String arg_password = req.getParameter("arg_password");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("user_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("vender_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("gubun",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("comp_user_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,50));
    String query = "  SELECT  z_webuser_code.user_code ," + 
     "          z_webuser_code.password ," + 
     "          z_webuser_code.sbcr_code ," + 
     "          z_webuser_code.vender_code ," + 
     "          z_webuser_code.businessman_number ," + 
     "          z_webuser_code.gubun ," + 
     "          z_webuser_code.note ," + 
     "          user_code comp_user_code,  " + 
     "          z_webuser_code.sbcr_name  " + 
     "    FROM z_webuser_code   " +   
     "      WHERE   " +   
     "             z_webuser_code.user_code = '" + arg_user_id + "'  and " +   
     "             z_webuser_code.password = " + "'" + arg_password + "'" + "    " + 
     "      ORDER BY z_webuser_code.user_code           ASC      ";
    ResultSet rset = stmt.executeQuery(query);
    dSet = rescopy.copydataset(rset, dSet);
    stmt.close();

   int pass_sw = 1;
    GauceDataRow[] rows = dSet.getDataRows();
    int  rowCnt = dSet.getDataRowCnt();
    if (rowCnt > 0)  {
       pass_sw = 1;
    }
    else
       pass_sw = 0;

//    context = service.getContext();
//    dbpro = context.getDBProfile();             // testdb의 정보 이용
    String database_driver="";
    String database_url="";
    String database_user="";
    String database_password="";
    if (pass_sw == 1) {
       database_driver = dbpro.getDriver();
       database_url = dbpro.getURL();
    }
    database_user = dbpro.getUser();
    database_password = dbpro.getPasswd();
    session.setMaxInactiveInterval(24*60*60);  // 세션 라이프 시간 설정 브라우져 종료까지
    if (pass_sw == 1) {
       database_user = database_user + '*' + database_password + '*' + database_url;
       session.setAttribute("database_user",database_user);
//       session.setAttribute("database_driver",database_driver);
//       session.setAttribute("database_url",database_url);
    }
//    session.setAttribute("database_user",database_user);
//    session.setAttribute("database_password",database_password);
    dSet.flush();
    res.commit("성공적으로 마쳤습니다");
    res.close();
} catch (Exception e) {
    res.writeException("Native","9999",e.toString());
    res.commit();
    res.close();
    if (stmt != null) {
       stmt.close();
    }
} finally {
    if (conn != null) {
        try {
            conn.close();
        } catch (Exception e) {}
    }
    loader.restoreService(service);
} %>