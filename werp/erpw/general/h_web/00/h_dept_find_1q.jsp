<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_name = req.getParameter("arg_dept_name");
     String arg_dept_code = req.getParameter("arg_dept_code");
     arg_dept_name = "%" + arg_dept_name + "%";
     arg_dept_code = "%" + arg_dept_code + "%";
     
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("zipcode",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("proj_addr1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_tel",GauceDataColumn.TB_STRING,12));
    String query = "  SELECT  dept_code ," + 
     "                        long_name ," + 
     "                        dept_proj_tag ," + 
     "                        use_tag,  " + 
     "                        process_code,  " + 
     "                        zipcode,  " + 
     "                        proj_addr1,  " + 
     "                        proj_addr2,  " + 
     "                        proj_tel " +
     "                   FROM z_code_dept  " + 
     "                  WHERE ( long_name like " + "'" + arg_dept_name + "'" + 
     "                     or   dept_code like " + "'" + arg_dept_code + "'" + " )  " +
     "                    and  dept_proj_tag = 'P'      " + 
     "                    and dept_code not in ( select dept_code from h_code_dept) " +
     "               order by dept_code asc     " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>