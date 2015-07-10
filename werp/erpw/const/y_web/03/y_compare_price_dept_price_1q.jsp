<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_name_key1 = req.getParameter("arg_name_key");
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_name_key2 = arg_name_key1.replace('!','+') ;  // !를 +로 바꿈. url에서는 +를 값으로 넘겨줄수 없슴으로  
     String arg_name_key3  = arg_name_key2.replace('^','#') ;  // ^를 #로 바꿈. url에서는 #를 값으로 넘겨줄수 없슴으로  
     String arg_name_key  = arg_name_key3.replace('|','%') ;  // ^를 #로 바꿈. url에서는 #를 값으로 넘겨줄수 없슴으로  
     String arg_dept_string = req.getParameter("arg_dept_string");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sort_tag",GauceDataColumn.TB_DECIMAL,1,0));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("name_key",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "			 select DECODE(A.dept_code," + "'" + arg_dept_code + "'" + ",MAX(1),MAX(2)) sort_tag, A.dept_code dept_code, " + 
     "                        B.long_name long_name ,A.name_key name_key," + 
     "				            sum(A.qty) qty,sum(nvl(A.amt,0)) amt,sum(NVL(A.amt,0)) / SUM(A.qty)  price," + 
     "				            sum(nvl(A.mat_amt,0)) / sum(A.qty)   mat_price, " + 
     "				            sum(nvl(A.lab_amt,0)) / sum(A.qty)  lab_price, " + 
     "				            sum(nvl(A.equ_amt,0)) / sum(A.qty)  equ_price, " + 
     "				            sum(nvl(A.exp_amt,0)) / sum(A.qty)  exp_price, " + 
     "				            sum(nvl(A.sub_amt,0)) / sum(A.qty)  sub_price " + 
     "				       from y_chg_budget_detail A, z_code_dept B " + 
     "				        where   a.name_key = '"+ arg_name_key + "' " + 
     "				          and   A.dept_code = B.dept_code" + 
     "				          AND   (A.UNIT <> '식'  AND A.UNIT IS NOT NULL   AND A.UNIT <> 'LOT') " + 
     "				          AND   (A.qty != 0)" + 
     "                      AND    " +  arg_dept_string + " " + 
     "  				          GROUP BY A.DEPT_CODE,B.long_name,A.name_key " + 
     "				          order by long_name    ";
//     "				          order by sort_tag,A.DEPT_CODE,A.name_key     ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>