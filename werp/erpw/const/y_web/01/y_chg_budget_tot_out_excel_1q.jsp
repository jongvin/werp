<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
     String arg_parent_sum_code = req.getParameter("arg_parent_sum_code");
     arg_parent_sum_code = arg_parent_sum_code + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("parent_name",GauceDataColumn.TB_STRING,4000));
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("llevel",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("parent_sum_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("direct_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cnt_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("cnt_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cnt_exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("lab_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exp_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("equ_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tag",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("page_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sysdate",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,28));
     dSet.addDataColumn(new GauceDataColumn("mat_code",GauceDataColumn.TB_STRING,28));
    String query = "         select     z_code_dept.long_name, " + 
     "     		         F_PARENT_NAME(a.dept_code,a.sum_code,a.llevel) parent_name, " + 
     "     		         a.dept_code, " + 
     "     		         a.chg_no_seq, " + 
     "     		         a.spec_no_seq, " + 
     "     	            a.no_seq,  " + 
     "     	            a.llevel, " + 
     "     		         a.sum_code, " + 
     "     		         a.parent_sum_code," + 
     "					 a.direct_class," + 
     "     		         a.name, " + 
     "     		         a.ssize, " + 
     "     		         a.unit, " + 
     "     		         a.cnt_qty, " + 
     "     		         a.cnt_price, " + 
     "     		         a.cnt_amt, " + 
     "     		         a.cnt_mat_price, " + 
     "     		         a.cnt_mat_amt, " + 
     "     		         a.cnt_lab_price, " + 
     "     		         a.cnt_lab_amt, " + 
     "     		         a.cnt_exp_price, " + 
     "     		         a.cnt_exp_amt, " + 
     "     		         a.qty, " + 
     "     		         a.price, " + 
     "     		         a.amt, " + 
     "     		         a.mat_price, " + 
     "     		         a.mat_amt, " + 
     "     		         a.lab_price, " + 
     "     		         a.lab_amt, " + 
     "     		         a.exp_price, " + 
     "     		         a.exp_amt," + 
     "     		         a.equ_price,     " + 
     "     		         a.equ_amt, " + 
     "     		         a.sub_price,   " + 
     "     		         a.sub_amt,  " + 
     "     		         a.tag, " + 
     "                  0 page_num   , " + 
     "                    sysdate," + 
     "                  a.detail_code," + 
     "                  a.mat_code  " + 
     "                 from   " + 
     "                   ( SELECT  y_chg_budget_parent.dept_code, " + 
     "     					         y_chg_budget_parent.chg_no_seq, " + 
     "     					         y_chg_budget_parent.spec_no_seq, " + 
     "                             y_chg_budget_parent.no_seq * 100000  no_seq, " + 
     "                             to_number(y_chg_budget_parent.llevel) llevel, " + 
     "     					         y_chg_budget_parent.sum_code, " + 
     "     					         y_chg_budget_parent.parent_sum_code," + 
     "								 y_chg_budget_parent.direct_class direct_class," + 
     "     					         y_chg_budget_parent.name, " + 
     "     					         y_chg_budget_parent.ssize, " + 
     "     					         y_chg_budget_parent.unit, " + 
     "     					         0 cnt_qty, " + 
     "     					         0 cnt_price, " + 
     "     					         y_chg_budget_parent.cnt_amt, " + 
     "     					         0 cnt_mat_price, " + 
     "     					         y_chg_budget_parent.cnt_mat_amt, " + 
     "     					         0 cnt_lab_price, " + 
     "     					         y_chg_budget_parent.cnt_lab_amt, " + 
     "     					         0 cnt_exp_price, " + 
     "     					         y_chg_budget_parent.cnt_exp_amt, " + 
     "     					         0 qty, " + 
     "     					         0 price, " + 
     "     					         y_chg_budget_parent.amt, " + 
     "     					         0 mat_price, " + 
     "     					         y_chg_budget_parent.mat_amt, " + 
     "     					         0 lab_price, " + 
     "     					         y_chg_budget_parent.lab_amt, " + 
     "     					         0 exp_price, " + 
     "     					         y_chg_budget_parent.exp_amt, " + 
     "     					         0 equ_price, " + 
     "     					         y_chg_budget_parent.equ_amt, " + 
     "     					         0 sub_price, " + 
     "     					         y_chg_budget_parent.sub_amt, " + 
     "     					         1 tag," + 
     "                           '                            ' detail_code," + 
     "                           '                            ' mat_code     " + 
     "                       FROM y_chg_budget_parent      " + 
     "                       WHERE (y_chg_budget_parent.dept_code =  '" + arg_dept_code + "' and     " + 
     "                              y_chg_budget_parent.chg_no_seq =  " + arg_chg_no_seq + "    and " + 
     "                              y_chg_budget_parent.parent_sum_code like  '" + arg_parent_sum_code + "' and" + 
     "                               llevel > 1 )    " + 
     "                    union all  " + 
     "     					 SELECT  y_chg_budget_detail.dept_code, " + 
     "     					         y_chg_budget_detail.chg_no_seq, " + 
     "     					         y_chg_budget_detail.spec_no_seq, " + 
     "                             y_chg_budget_parent.no_seq  * 100000 + y_chg_budget_detail.no_seq no_seq, " + 
     "                             to_number(y_chg_budget_parent.llevel) + 1 llevel, " + 
     "     					         y_chg_budget_parent.sum_code, " + 
     "     					         y_chg_budget_parent.sum_code," + 
     "								 ' ' direct_class, " + 
     "     					         y_chg_budget_detail.name, " + 
     "     					         y_chg_budget_detail.ssize, " + 
     "     					         y_chg_budget_detail.unit, " + 
     "     					         y_chg_budget_detail.cnt_qty, " + 
     "     					         y_chg_budget_detail.cnt_price, " + 
     "     					         y_chg_budget_detail.cnt_amt, " + 
     "     					         y_chg_budget_detail.cnt_mat_price, " + 
     "     					         y_chg_budget_detail.cnt_mat_amt, " + 
     "     					         y_chg_budget_detail.cnt_lab_price, " + 
     "     					         y_chg_budget_detail.cnt_lab_amt, " + 
     "     					         y_chg_budget_detail.cnt_exp_price, " + 
     "     					         y_chg_budget_detail.cnt_exp_amt, " + 
     "     					         y_chg_budget_detail.qty, " + 
     "     					         y_chg_budget_detail.price, " + 
     "     					         y_chg_budget_detail.amt, " + 
     "     					         y_chg_budget_detail.mat_price, " + 
     "     					         y_chg_budget_detail.mat_amt, " + 
     "     					         y_chg_budget_detail.lab_price, " + 
     "     					         y_chg_budget_detail.lab_amt, " + 
     "     					         y_chg_budget_detail.exp_price, " + 
     "     					         y_chg_budget_detail.exp_amt, " + 
     "     					         y_chg_budget_detail.equ_price, " + 
     "     					         y_chg_budget_detail.equ_amt, " + 
     "     					         y_chg_budget_detail.sub_price, " + 
     "     					         y_chg_budget_detail.sub_amt, " + 
     "     					         2 tag,    " + 
     "     					         y_chg_budget_detail.detail_code, " + 
     "     					         y_chg_budget_detail.mat_code" + 
     "                     FROM y_chg_budget_detail,    " + 
     "                         y_chg_budget_parent   " + 
     "                     WHERE ( y_chg_budget_parent.dept_code = y_chg_budget_detail.dept_code ) and    " + 
     "                           ( y_chg_budget_parent.chg_no_seq = y_chg_budget_detail.chg_no_seq ) and    " + 
     "                           ( y_chg_budget_parent.spec_no_seq = y_chg_budget_detail.spec_no_seq ) and    " + 
     "                           (  y_chg_budget_parent.sum_code like  '" + arg_parent_sum_code + "') and" + 
     "                           ( ( y_chg_budget_detail.dept_code =   '" + arg_dept_code + "') and    " + 
     "                             ( y_chg_budget_detail.chg_no_seq =  " + arg_chg_no_seq + ")   " + 
     "                            )  ) A, " + 
     "                 z_code_dept " + 
     "                  where z_code_dept.dept_code = a.dept_code  " + 
     "            order by  a.no_seq     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>