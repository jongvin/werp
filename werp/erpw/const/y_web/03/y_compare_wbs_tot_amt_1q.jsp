<%@ page session="true" contentType="text/html;charset=EUC_KR"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code_tag = req.getParameter("arg_dept_code_tag");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_pyoung = req.getParameter("arg_pyoung");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("avg1",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  " + 
    "    SELECT a.dept_code,                                         " + 
     "       decode(a.dept_code,'" + arg_dept_code_tag + "','  ' || b.long_name,' ' || b.long_name) long_name, " + 
    "           a.wbs_code,                                          " + 
    "           a.direct_class,                                      " + 
    "           decode(substr(a.direct_class,2,1),'1',a.name,        " + 
    "                 decode(a.direct_class,'12','직접공사비계',     " + 
    "                 decode(a.direct_class,'22','간접공사비계',     " + 
    "                 decode(a.direct_class,'23','순공사비계',       " + 
    "                 decode(a.direct_class,'32','기타공사비',       " + 
    "                 decode(a.direct_class,'92','총 합 계'          " + 
    "                 )))))) name,                                        " + 
    "           a.amt,                                               " + 
    "           trunc(a.amt / " + arg_pyoung + ",0) avg1                           " + 
    "        FROM (                                                  " + 
    "              SELECT a.dept_code,                               " + 
    "                     substr(a.wbs_code,1,1) wbs_code,           " + 
    "                     a.direct_class || '1' direct_class,        " + 
    "                     b.name name,sum(a.amt) amt                 " + 
    "                  FROM y_budget_parent a,                       " + 
    "                       y_wbs_code b                             " + 
    "                 WHERE a.dept_code = '" + arg_dept_code + "'                    " + 
    "                   and a.invest_class = 'Y'                     " + 
    "                   and substr(a.wbs_code,1,1) = b.wbs_code      " + 
    "                 group by a.dept_code,substr(a.wbs_code,1,1),a.direct_class || '1',b.name " + 
    "              union all                                                  " + 
    "              SELECT a.dept_code,                                        " + 
    "                     '  ',                                               " + 
    "                     a.direct_class || '2' ,                             " + 
    "                     '  ',sum(a.amt)                                     " + 
    "                  FROM y_budget_parent a                                 " + 
    "                 WHERE a.dept_code = '" + arg_dept_code + "'                             " + 
    "                   and a.invest_class = 'Y'                              " + 
    "                 group by a.dept_code,a.direct_class || '2'              " + 
    "              union all                                                  " + 
    "              SELECT a.dept_code,                                        " + 
    "                     '  ',                                               " + 
    "                     '23' ,                                              " + 
    "                     '  ',sum(a.amt)                                     " + 
    "                  FROM y_budget_parent a                                 " + 
    "                 WHERE a.dept_code = '" + arg_dept_code + "'                             " + 
    "                   and a.invest_class = 'Y'                              " + 
    "                   and (a.direct_class = '1' or a.direct_class = '2')    " + 
    "                 group by a.dept_code                                    " + 
    "              union all                                                  " + 
    "              SELECT a.dept_code,                                        " + 
    "                     '  ',                                               " + 
    "                     '92' ,                                              " + 
    "                     '  ',sum(a.amt)                                     " + 
    "                  FROM y_budget_parent a                                 " + 
    "                 WHERE a.dept_code = '" + arg_dept_code + "'                             " + 
    "                   and a.invest_class = 'Y'                              " + 
    "                 group by a.dept_code                                    " + 
    "                  ) a,                                                   " + 
    "              z_code_dept b                                              " + 
    "        where  a.dept_code = b.dept_code                                 " + 
    "        order by a.direct_class,a.wbs_code                               ";

%><%@ include file="../../../comm_function/conn_q_end.jsp"%>