<%@ page session="true" contentType="text/html;charset=EUC_KR"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code_tag = req.getParameter("arg_dept_code_tag");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_pyoung = req.getParameter("arg_pyoung");
     String arg_wbs_mast = req.getParameter("arg_wbs_mast");
     String arg_division = req.getParameter("arg_division");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("avg1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_tag",GauceDataColumn.TB_STRING,1));
    String query = "  " + 
    "    SELECT a.dept_code,                                         " + 
     "       decode(a.dept_code,'" + arg_dept_code_tag + "','  ' || b.long_name,' ' || b.long_name) long_name, " + 
    "           a.wbs_code,                                          " + 
    "           decode(a.wbs_code,'zzz','합   계',c.name) name,                                              " + 
    "           a.amt,                                               " + 
    "           trunc(a.amt / " + arg_pyoung + ",0) avg1,                           " + 
    "           a.tot_tag                           " + 
    "        FROM (                                                  " + 
    "              SELECT a.dept_code,                               " + 
    "                     '1' tot_tag,           " + 
    "                     substr(a.wbs_code,1,3) wbs_code,           " + 
    "                     sum(a.amt) amt                 " + 
    "                  FROM y_budget_parent a                       " + 
    "                 WHERE a.dept_code = '" + arg_dept_code + "'    " + 
    "                   and a.invest_class = 'Y'                     " + 
    "                   and substr(a.wbs_code,1,1) = '" + arg_wbs_mast + "'      " + 
    "                   and a.division like '" + arg_division + "%' " + 
    "                 group by a.dept_code,substr(a.wbs_code,1,3) " + 
    "              union all        " + 
    "              SELECT a.dept_code,                               " + 
    "                     '2' tot_tag,           " + 
    "                     'zzz' wbs_code,           " + 
    "                     sum(a.amt) amt                 " + 
    "                  FROM y_budget_parent a                       " + 
    "                 WHERE a.dept_code = '" + arg_dept_code + "'    " + 
    "                   and a.invest_class = 'Y'                     " + 
    "                   and substr(a.wbs_code,1,1) = '" + arg_wbs_mast + "'      " + 
    "                   and a.division like '" + arg_division + "%' " + 
    "                 group by a.dept_code  " + 
    "                                              ) a, " + 
    "              z_code_dept b,                                              " + 
    "              y_wbs_code c                                              " + 
    "        where  a.dept_code = b.dept_code                                 " + 
    "          and  a.wbs_code = c.wbs_code (+)    " + 
    "        order by a.wbs_code ";

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>