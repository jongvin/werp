<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="/erpw/comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--
     String arg_user_id = req.getParameter("arg_user_id");
     String arg_password = req.getParameter("arg_password");
     DBProfile dbpro = context.getDBProfile();             // testdb의 정보 이용
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("deptcode",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("g_ipaddress",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("sys_date",GauceDataColumn.TB_STRING,22));
    String query = "  SELECT a.empno empno,   " + 
     "         a.user_id user_id,   " + 
     "         a.password password,   " + 
     "         a.name name,   " + 
     "         a.dept_code deptcode,   " + 
     "         a.g_ipaddress g_ipaddress,   " + 
     "         b.long_name   short_name," +   
     "         to_char(sysdate,'yyyy.mm.dd hh24:mi:ss')  sys_date" +  
     "    FROM z_authority_user a,   " + 
     "         z_code_dept b, " + 
     "         (select a.empno empno,nvl(b.dept_code,a.dept_code) dept_code  " + 
     "            from z_authority_user a,                                  " + 
     "                 p_pers_master b                                      " + 
     "            where a.empno = b.emp_no (+)) c                             " +   
     "    WHERE a.empno = c.empno and      " + 
     "          c.dept_code = b.dept_code(+) and " + 
     "          a.using_tag = 'Y' and " + 
     "          a.user_id = " + "'" + arg_user_id + "'" + "  and  " + 
     "          a.password = " + "'" + arg_password + "'" + "    " + 
     "                  ";
    ResultSet rset = stmt.executeQuery(query);
    dSet = rescopy.copydataset(rset, dSet);
    stmt.close();

    int pass_sw = 1;
    GauceDataRow[] rows = dSet.getDataRows();
    int  rowCnt = dSet.getDataRowCnt();
    String str_g_ipaddress = "erpw/erpw";
    if (rowCnt > 0)  {
       int idx_g_ipaddress = dSet.indexOfColumn("g_ipaddress");
       str_g_ipaddress = rows[0].getString(idx_g_ipaddress);
       if ((str_g_ipaddress == null) || (str_g_ipaddress == " ")) { 
           str_g_ipaddress = "erpw/erpw";
       }
    }
    else {
       pass_sw = 0;
    }
//    dbpro = context.getDBProfile();             // testdb의 정보 이용

    String database_driver="";
    String database_url="";
    String database_user="";
    String database_password="";

    if (pass_sw == 1) {
       database_driver = dbpro.getDriver();
       database_url = dbpro.getURL();
    }
    int index = str_g_ipaddress.indexOf('/');
    
    database_user = str_g_ipaddress.substring(0,index);
    database_password = str_g_ipaddress.substring(index + 1);

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