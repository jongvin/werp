<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_dept_string = req.getParameter("arg_dept_string");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("name_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.dept_code dept_code,decode(a.dept_code,'" + arg_dept_code + "'" + ",' ' || b.long_name,b.long_name) long_name,a.name_key name_key ,a.name name, " + 
     "       a.ssize ssize,a.unit unit, " + 
     "       a.price price,a.mat_price mat_price, " + 
     "       a.lab_price lab_price,a.equ_price equ_price, " + 
     "       a.exp_price exp_price,a.sub_price sub_price " + 
     "       from " + 
     "          (select dept_code, name_key,name,ssize,unit, decode(sum(qty),0,0,sum(nvl(amt,0)) / sum(qty))  price, " + 
     "				        decode(sum(qty),0,0,sum(nvl(mat_amt,0)) / sum(qty))  mat_price, " + 
     "				        decode(sum(qty),0,0,sum(nvl(lab_amt,0)) / sum(qty))  lab_price, " + 
     "				        decode(sum(qty),0,0,sum(nvl(equ_amt,0)) / sum(qty))  equ_price, " + 
     "				        decode(sum(qty),0,0,sum(nvl(exp_amt,0)) / sum(qty))  exp_price, " + 
     "				        decode(sum(qty),0,0,sum(nvl(sub_amt,0)) / sum(qty))  sub_price " + 
     "				   from y_chg_budget_detail " + 
     "				        where    (UNIT <> '식'  AND UNIT IS NOT NULL  OR UNIT <> 'LOT' ) " + 
     "				          AND    (qty != 0)" + 
     "                      AND    " + arg_dept_string  + "  " + 
     "				          GROUP BY dept_code,name_key,name,ssize,unit ORDER BY name_key ) a, z_code_dept b " + 
     "       where a.dept_code = b.dept_code      " + 
     "       order by name,ssize,unit,long_name       ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>