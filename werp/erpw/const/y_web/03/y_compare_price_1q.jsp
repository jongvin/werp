<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_dept_string = req.getParameter("arg_dept_string");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("a_name_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("a_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("a_ssize",GauceDataColumn.TB_STRING,24));
     dSet.addDataColumn(new GauceDataColumn("a_unit",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("a_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("a_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_b_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_b_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_equ_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("a_sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("b_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_equ_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("b_sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("compare_1",GauceDataColumn.TB_STRING,9));
     dSet.addDataColumn(new GauceDataColumn("min_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("max_price",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select A.name_key a_name_key,A.name a_name,A.ssize a_ssize,A.unit a_unit, " + 
     "            A.qty a_qty," + 
     "            A.amt a_amt," + 
     "            nvl(A.price,0)  a_price," + 
     "            DECODE(B.name_key,NULL,nvl(A.price,0),nvl(B.price,0)) b_price," + 
     "             nvl(A.price,0)  - DECODE(B.name_key,NULL,nvl(A.price,0),nvl(B.price,0)) a_b_price," + 
     "            DECODE(B.name_key,NULL,0,(nvl(A.amt,0) -  nvl(A.qty,0) * nvl(B.price,0)))  a_b_amt," + 
     "            nvl(A.mat_price,0) a_mat_price, " + 
     "            nvl(A.lab_price,0) a_lab_price," + 
     "            nvl(A.equ_price,0) a_equ_price, " + 
     "            nvl(A.exp_price,0) a_exp_price, " + 
     "            nvl(A.sub_price,0) a_sub_price, " + 
     "            nvl(B.qty,0) b_qty, nvl(B.amt,0) b_amt," + 
     "            nvl(B.mat_price,0) b_mat_price, " + 
     "            nvl(B.lab_price,0) b_lab_price, " + 
     "            nvl(B.equ_price,0) b_equ_price, " + 
     "            nvl(B.exp_price,0) b_exp_price, " + 
     "            nvl(B.sub_price,0) b_sub_price," + 
     "            DECODE(B.name_key,NULL,'no match','') compare_1,  " + 
     "            nvl(B.min_price,0) min_price," + 
     "            nvl(B.max_price,0) max_price " + 
     "      FROM " + 
     "				(select name_key,name,ssize,unit,sum(qty) qty,sum(amt) amt, decode(sum(qty),0,0,sum(nvl(amt,0)) / sum(qty))  price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(mat_amt,0)) / sum(qty))  mat_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(lab_amt,0)) / sum(qty))  lab_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(equ_amt,0)) / sum(qty))  equ_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(exp_amt,0)) / sum(qty))  exp_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(sub_amt,0)) / sum(qty))  sub_price " + 
     "				       from y_chg_budget_detail " + 
     "				          where (dept_code = '" + arg_dept_code + "' " + 
     "				                  and chg_no_seq = " + 
     "				                        (select max(chg_no_seq) from y_chg_degree where dept_code = '" + arg_dept_code + "') ) " + 
     "				          AND   (UNIT <> '식'  AND UNIT IS NOT NULL   AND UNIT <> 'LOT' ) " + 
     "				          AND   (qty != 0) " +  
     "				          GROUP BY name_key,name,ssize,unit ORDER BY name_key ) A," + 
     "				 (select name_key,sum(qty) qty,sum(amt) amt,decode(sum(qty),0,0,sum(nvl(amt,0)) / sum(qty)) price, " + 
     "				            min(price) min_price, max(price) max_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(mat_amt,0)) / sum(qty))  mat_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(lab_amt,0)) / sum(qty))  lab_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(equ_amt,0)) / sum(qty))  equ_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(exp_amt,0)) / sum(qty))  exp_price, " + 
     "				            decode(sum(qty),0,0,sum(nvl(sub_amt,0)) / sum(qty))  sub_price " + 
     "				       from y_chg_budget_detail " + 
     "				        where    (UNIT <> '식'  AND UNIT IS NOT NULL  OR UNIT <> 'LOT' ) " + 
     "				          AND    (qty != 0)" + 
     "                      AND    " + arg_dept_string  + "  " + 
     "				          GROUP BY name_key ORDER BY name_key) B " + 
     "	  WHERE A.name_key = B.name_key (+)      "; 
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>