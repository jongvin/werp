<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_dept_detail = req.getParameter("arg_dept_detail");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("detail_code",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("ssize",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("unit",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("bud_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("mat_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_qty",GauceDataColumn.TB_DECIMAL,18,3));
     dSet.addDataColumn(new GauceDataColumn("pyoung_avg",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "select a.dept_code," + 
     "       a.detail_code, " + 
     "       max(c.name) name, " + 
     "       max(c.ssize) ssize, " + 
     "       max(c.unit) unit, " + 
     "       max(decode(a.dept_code,'" + arg_dept_code + "','  ' || b.long_name,' ' || b.long_name)) long_name, " + 
     "       sum(a.bud_price) bud_price," + 
     "       sum(a.sub_price) sub_price," + 
     "       sum(a.mat_price) mat_price," + 
     "       sum(a.bud_amt) bud_amt," + 
     "       sum(a.bud_qty) bud_qty," + 
     "       sum(a.sub_amt) sub_amt," + 
     "       sum(a.sub_qty) sub_qty," + 
     "       sum(a.mat_amt) mat_amt," + 
     "       sum(a.mat_qty) mat_qty," + 
     "       sum(a.pyoung_avg) pyoung_avg " + 
     "       from (                   " + 
     "         select a.dept_code," + 
     "                a.detail_code detail_code, " + 
     "                a.name, " + 
     "                a.ssize, " + 
     "                a.unit, " + 
     "                a.bud_price, " +   
     "                a.bud_amt, " + 
     "                a.bud_qty, " + 
     "                a.sub_price," + 
     "                a.sub_amt," + 
     "                a.sub_qty," + 
     "                a.mat_price," + 
     "                a.mat_amt," + 
     "                a.mat_qty, " + 
     "                a.pyoung_avg " + 
     "        from  (select b.dept_code," + 
     "                b.detail_code detail_code, " + 
     "                max(b.name) name, " + 
     "                max(b.ssize) ssize, " + 
     "                max(b.unit) unit, " + 
     "                decode(sum(b.qty),0,0,trunc(SUM(b.amt) / SUM(b.qty),0))  bud_price, " +   
     "                SUM(b.amt) bud_amt, " + 
     "                SUM(b.qty) bud_qty, " + 
     "                0 sub_price," + 
     "                0 sub_amt," + 
     "                0 sub_qty," + 
     "                0 mat_price," + 
     "                0 mat_amt," + 
     "                0 mat_qty, " + 
     "                decode(sum(b.qty),0,0,decode(max(a.gross_floor_area_sum),0,0,trunc( (SUM(b.amt) / SUM(b.qty)) / max(a.gross_floor_area_sum),0))) pyoung_avg " + 
     "            from z_code_dept a,  " + 
     "                 y_chg_budget_detail b" + 
     "            where a.dept_code = b.dept_code " + 
     "              and b.qty <> 0 " + 
     "              and ( " + arg_dept_detail + " " +   
     "                   )" + 
     "             group by b.dept_code,b.detail_code     " + 
     "         union all" + 
     "         select a.dept_code," + 
     "                b.detail_code," + 
     "                ' ' name, " + 
     "                ' ' ssize, " + 
     "                ' ' unit, " + 
     "                0 bud_price," + 
     "                0 bud_amt," + 
     "                0 bud_qty," + 
     "                decode(sum(a.sub_qty),0,0,trunc(sum(a.sub_amt) / sum(a.sub_qty),0)) sub_price," + 
     "                sum(a.sub_amt) sub_amt," + 
     "                sum(a.sub_qty) sub_qty," + 
     "                0 mat_price," + 
     "                0 mat_amt," + 
     "                0 mat_qty, " + 
     "                0 pyoung_avg " + 
     "             from s_cn_detail a,       " + 
     "                 (" + 
     "                   select b.dept_code," + 
     "                          b.spec_unq_num," + 
     "                          b.detail_code, " + 
     "                          b.name, " + 
     "                          b.ssize, " + 
     "                          b.unit " + 
     "                      from " + 
     "                           y_chg_budget_detail b" + 
     "                      where ( " + arg_dept_detail + " " +   
     "                            )" + 
     "                  order by b.dept_code,b.spec_unq_num ) b" + 
     "              where a.dept_code = b.dept_code" + 
     "                and a.spec_unq_num = b.spec_unq_num" + 
     "                and a.sub_qty <> 0 " + 
     "             group by a.dept_code,b.detail_code        " + 
     "          union all             " + 
     "           select a.dept_code," + 
     "                  a.detail_code," + 
     "                  ' ' name, " + 
     "                  ' ' ssize, " + 
     "                  '  ' unit, " + 
     "                  0 bud_price," + 
     "                  0 bud_amt," + 
     "                  0 bud_qty," + 
     "                  0 sub_price," + 
     "                  0 sub_amt," + 
     "                  0 sub_qty," + 
     "                  decode(sum(a.qty),0,0,trunc(sum(a.amt) / sum(a.qty),0))  mat_price," + 
     "                  sum(a.amt)  mat_amt," + 
     "                  sum(a.qty)  mat_qty, " + 
     "                  0 pyoung_avg " + 
     "             from (" + 
     "                   select a.dept_code," + 
     "                          b.detail_code," + 
     "                          a.approym," + 
     "                          a.approseq," + 
     "                          a.unitprice," + 
     "                          a.amt," + 
     "                          a.qty," + 
     "                          b.mat_code," + 
     "                          b.name, " + 
     "                          b.ssize, " + 
     "                          b.unit, " + 
     "                          RANK() OVER (PARTITION BY a.dept_code,a.mtrcode " + 
     "                                             ORDER BY a.dept_code desc,a.mtrcode desc,a.approym desc , a.approseq desc ) rk_1" + 
     "                      from m_approval_detail a," + 
     "                           y_chg_budget_detail b " + 
     "                      where a.dept_code = b.dept_code " + 
     "                        and a.mtrcode = b.mat_code " + 
     "                        and  ( " + arg_dept_detail + " " +  
     "                             )" + 
     "                     ) a" + 
     "             where a.rk_1 = 1 " +   
     "               and a.qty <> 0 " + 
     "              group by a.dept_code,a.detail_code ) a order by a.dept_code,a.detail_code) a," + 
     "           z_code_dept b, " +   // detail코드의 명칭/규격/단위 구하기 
     "           ( select  a.detail_code detail_code,max(a.name) name,max(a.ssize) ssize,max(a.unit) unit " + 
     "               from y_chg_budget_detail a " + 
     "               where a.dept_code = '" + arg_dept_code + "' " + 
     "                 and a.chg_no_seq = (select max(chg_no_seq) " + 
     "                                       from y_chg_degree where dept_code = '" + arg_dept_code + "') " + 
     "               group by a.detail_code order by a.detail_code) c " + 
     "        where a.dept_code = b.dept_code " + 
     "          and a.detail_code = c.detail_code " + 
     "    group by a.dept_code,a.detail_code            " + 
     "                                    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>