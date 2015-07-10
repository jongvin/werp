<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
//     String in_emp_nm = req.getParameter("in_emp_nm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("sell_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("union_code",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("union_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("fax",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("union_members",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("union_div_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,120));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("code_name",GauceDataColumn.TB_STRING,20));
    String query = "  SELECT a.DEPT_CODE," + 
     "                       a.SELL_CODE," + 
     "                       a.UNION_CODE," + 
     "                       a.UNION_NAME," + 
     "                       substrb(a.ZIP_CODE,0,3) || '-' || substrb(a.zip_code,3,3) zip_code," + 
     "                       a.ADDR1 || a.addr2 addr," + 
     "                       a.FAX," + 
     "                       a.PHONE," + 
     "                       a.UNION_MEMBERS," + 
     "                       a.UNION_DIV_CODE," + 
     "                       a.REMARK," + 
     "                       b.LONG_NAME," + 
     "                       c.CODE_NAME        " +
     "                  FROM H_UNIN_LEDGER a," + 
     "                       H_CODE_DEPT b," + 
     "                       H_CODE_COMMON c  " +
     "                 WHERE a.SELL_CODE = c.CODE(+)  " +
     "                   AND c.code_div = '03'  " +
     "                   AND a.DEPT_CODE = b.DEPT_CODE  " +
     "              ORDER BY a.DEPT_CODE ASC," + 
     "                       a.SELL_CODE ASC," + 
     "                       a.UNION_CODE ASC ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>