<%@ page session="true" import="java.util.*,javax.sql.*,javax.naming.InitialContext, com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%
   
 ServiceLoader loader = new ServiceLoader(request, response);  
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
	  //String session_temp = new String(session.getAttribute("database_user").toString());
	  ic = new InitialContext();
	  ds = (DataSource)ic.lookup("jdbc/OracleDS");
     conn = ds.getConnection();
     stmt = conn.createStatement();
     GauceDataSet dSet = new GauceDataSet();
     res.enableFirstRow(dSet);


   // ���� ������ ���� �Ͻÿ� (�Ķ���� ������ŭ (������ //�� ��������)--
     String arg_user_id = req.getParameter("arg_user_id");
     String arg_password = req.getParameter("arg_password");
    // DBProfile dbpro = context.getDBProfile();             // testdb�� ���� �̿�
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("empno",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("user_id",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("password",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("deptcode",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("g_ipaddress",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sys_date",GauceDataColumn.TB_STRING,22));
     dSet.addDataColumn(new GauceDataColumn("slip_trans_cls",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("dept_chg_cls",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT a.empno empno,   " + 
     "         a.user_id user_id,   " + 
     "         a.password password,   " + 
     "         a.name name,   " + 
     "         a.dept_code deptcode,   " + 
     "         a.g_ipaddress g_ipaddress,   " + 
     "         b.long_name   long_name," +   
     "         b.short_name   short_name," +   
     "         to_char(sysdate,'yyyy.mm.dd hh24:mi:ss')  sys_date, " +  
     "         nvl(d.slip_trans_cls,'F') slip_trans_cls, " +  
     "         nvl(d.dept_chg_cls,'F') dept_chg_cls, " +  
     "         e.comp_code, " +  
     "         e.company_name comp_name   " +  
     "    FROM z_authority_user a,   " + 
     "         z_code_dept b, " + 
     "         (select a.empno empno,nvl(a.dept_code,a.dept_code) dept_code  " + 
     "            from z_authority_user a ) c,                             " +   
     "         t_empno_auth d,  " +   
     "         T_COMPANY e  " +   
     "    WHERE a.empno = c.empno and      " + 
     "          c.dept_code = b.dept_code(+) and " + 
     "          a.empno = d.empno(+) and " + 
     "          b.COMP_CODE = e.COMP_CODE(+) and " + 
     "          a.using_tag = 'Y' and " + 
     "          a.user_id = " + "'" + arg_user_id + "'" + "  and  " + 
     "          a.password = " + "'" + arg_password + "'" + "    " + 
     "                  ";
	ResultSet rset = stmt.executeQuery(query);        // jdbc �� execute
    dSet = rescopy.copydataset(rset, dSet);          // ResultSet �� ������ gaucedataset���� move 
	rset.close();
    stmt.close();

    //ȯ�漳�� ����
	GauceDataRow[] rows = dSet.getDataRows();
    int  rowCnt = dSet.getDataRowCnt();
    String str_g_ipaddress = "erpw/erpw";
    if (rowCnt > 0)  {
       int idx_g_ipaddress = dSet.indexOfColumn("g_ipaddress");
       str_g_ipaddress = rows[0].getString(idx_g_ipaddress);
       if ((str_g_ipaddress == null) || (str_g_ipaddress == " ")) { 
           str_g_ipaddress = "erpw/erpw";
       }
        
       String database_driver="";
		String database_url="";
		String database_user="";
		String database_password="";
		
		int index = str_g_ipaddress.indexOf('/');
		
		database_user = str_g_ipaddress.substring(0,index);
		database_password = str_g_ipaddress.substring(index + 1);

		database_user = database_user + '*' + database_password + '*' + database_url;

        //HttpSession session = request.getSession(true);
		session.setMaxInactiveInterval(24*60*60); 

		//session.removeAttribute("database_user");
        session.setAttribute("database_user",database_user);
		session.setAttribute("file_upload_dir", "E:\\werp_upload\\");
		//session.setAttribute("file_upload_dir", "C:\\bea\\user_projects\\domains\\cjdwld\\applications\\werp\\werp_upload\\");
		//session.putValue("database_user",database_user);


		// ȸ����� ������� ���� ����
        System.setProperty("cj.datasource_name", "jdbc/OracleDS");
        System.setProperty("cj.database_user", database_user);

		session.setAttribute("comp_code", rows[0].getString(dSet.indexOfColumn("comp_code")));
		session.setAttribute("comp_name", rows[0].getString(dSet.indexOfColumn("comp_name")));
        session.setAttribute("emp_no", rows[0].getString(dSet.indexOfColumn("empno")));
        session.setAttribute("user_id", rows[0].getString(dSet.indexOfColumn("user_id")));
        session.setAttribute("name", rows[0].getString(dSet.indexOfColumn("name")));
        session.setAttribute("dept_code", rows[0].getString(dSet.indexOfColumn("deptcode")));
        session.setAttribute("short_name", rows[0].getString(dSet.indexOfColumn("short_name")));
        session.setAttribute("long_name", rows[0].getString(dSet.indexOfColumn("long_name")));
        session.setAttribute("slip_trans_cls", rows[0].getString(dSet.indexOfColumn("slip_trans_cls")));
        session.setAttribute("dept_chg_cls", rows[0].getString(dSet.indexOfColumn("dept_chg_cls")));
		
        // ȸ����� ������� ���� ����

    }
   

    dSet.flush();
    res.commit("���������� ���ƽ��ϴ�");
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
} 
%>