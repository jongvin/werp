<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_division = req.getParameter("arg_division");
     String arg_detail_code = req.getParameter("arg_detail_code");
     String arg_mat_code = req.getParameter("arg_mat_code");
     String arg_where = req.getParameter("arg_where");
     arg_where = arg_where.replace('@','%') ; 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("gross_floor_area_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("bud_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_price",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("mat_price",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  " + 
                   "  select a.dept_code,                                                         " + 
                   "         max(a.comp_code) comp_code ,                                         " + 
                   "         max(b.comp_name) comp_name ,                                         " + 
                   "         max(a.long_name) long_name ,                                         " + 
                   "         max(a.dept_proj_tag) dept_proj_tag,                                  " + 
                   "         max(a.use_tag) use_tag,                                              " + 
                   "         max(a.process_code) process_code,                                    " + 
                   "         max(a.region_code) region_code ,                                     " + 
                   "         max(nvl(a.chg_const_term,0))  chg_const_term,                        " + 
                   "         max(nvl(a.gross_floor_area_sum,0))  gross_floor_area_sum,            " + 
                   "         max(nvl(a.tot_cnt,0))  tot_cnt,                                      " + 
                   "         sum(c.bud_price) bud_price,                                          " + 
                   "         sum(c.sub_price) sub_price,                                          " + 
                   "         sum(c.mat_price)  mat_price                                          " + 
                   "      from (                                                                  " + 
                   "              select  a.dept_code,                                            " + 
                   "                      decode(sum(a.qty),0,0,trunc(SUM(a.amt) / SUM(a.qty),0)) bud_price,             " + 
                   "                      0 sub_price,                                            " + 
                   "                      0 mat_price                                             " + 
                   "                from                                                          " + 
                   "                    (                                                         " + 
                   "                        select b.dept_code,b.spec_unq_num,b.amt,b.qty         " + 
                   "                         from (                                               " + 
                   "                                select dept_code,max(chg_no_seq) chg_no_seq   " + 
                   "                                  from y_chg_degree                           " + 
                   "                                  group by dept_code) a,                      " + 
                   "                         y_chg_budget_detail b,                               " + 
                   "                         y_chg_budget_parent c                                " + 
                   "                       where a.dept_code = b.dept_code                        " + 
                   "                         and a.chg_no_seq = b.chg_no_seq                      " + 
                   "                         and b.dept_code = c.dept_code                        " + 
                   "                         and b.chg_no_seq = c.chg_no_seq                      " + 
                   "                         and b.spec_no_seq = c.spec_no_seq                    " + 
                   "                         and c.division like '" + arg_division + "%'          " + 
                   "                         and b.detail_code = '" + arg_detail_code + "'        " + 
                   "                    ) a                                                       " + 
                   "                 group by a.dept_code                                         " + 
                   "             union all                                                        " + 
                   "              select  a.dept_code,                                            " + 
                   "                      0 ,                                                     " + 
                   "                      decode(sum(b.sub_qty),0,0,trunc(sum(b.sub_amt) / sum(b.sub_qty),0)) sub_price,     " + 
                   "                      0                                                       " + 
                   "                from                                                          " + 
                   "                    (                                                         " + 
                   "                        select b.dept_code,b.spec_unq_num,b.amt,b.qty         " + 
                   "                         from (                                               " + 
                   "                                select dept_code,max(chg_no_seq) chg_no_seq   " + 
                   "                                  from y_chg_degree                           " + 
                   "                                  group by dept_code) a,                      " + 
                   "                         y_chg_budget_detail b,                               " + 
                   "                         y_chg_budget_parent c                                " + 
                   "                       where a.dept_code = b.dept_code                        " + 
                   "                         and a.chg_no_seq = b.chg_no_seq                      " + 
                   "                         and b.dept_code = c.dept_code                        " + 
                   "                         and b.chg_no_seq = c.chg_no_seq                      " + 
                   "                         and b.spec_no_seq = c.spec_no_seq                    " + 
                   "                         and c.division like '" + arg_division + "%'          " + 
                   "                         and b.detail_code = '" + arg_detail_code + "'        " + 
                   "                    ) a,                                                      " + 
                   "                    s_cn_detail b                                             " + 
                   "                 where a.dept_code = b.dept_code                              " + 
                   "                   and a.spec_unq_num = b.spec_unq_num                        " + 
                   "                   and b.sub_qty <> 0                                         " + 
                   "                 group by a.dept_code                                         " + 
                   "             union all                                                        " + 
                   "              select  a.dept_code,                                            " + 
                   "                      0,                                                      " + 
                   "                      0,                                                      " + 
                   "                      decode(sum(a.qty),0,0,trunc(sum(a.amt) / sum(a.qty),0))  mat_price             " + 
                   "                 from                                                         " + 
                   "                    (                                                         " + 
                   "                      select a.dept_code,                                     " + 
                   "                             a.amt,                                           " + 
                   "                             a.qty,                                           " + 
                   "                             RANK() OVER (PARTITION BY a.dept_code            " + 
                   "                                          ORDER BY a.dept_code desc,a.approym desc , " + 
                   "                                                   a.approseq desc, a.chg_cnt,a.approval_unq_num ) rk_1 " + 
                   "                         from m_approval_detail a,                                       " + 
                   "                             (                                                           " + 
                   "                               select b.dept_code,max(b.mat_code) mat_code               " + 
                   "                                from (                                                   " + 
                   "                                       select dept_code,max(chg_no_seq) chg_no_seq       " + 
                   "                                         from y_chg_degree                               " + 
                   "                                         group by dept_code) a,                          " + 
                   "                                y_chg_budget_detail b                                    " + 
                   "                              where a.dept_code = b.dept_code                            " + 
                   "                                and a.chg_no_seq = b.chg_no_seq                          " + 
                   "                                and b.mat_code = '" + arg_mat_code + "'                  " + 
                   "                              group by b.dept_code                                       " + 
                   "                             ) b                                                         " + 
                   "                         where a.dept_code = b.dept_code                                 " + 
                   "                           and a.mtrcode = b.mat_code                                    " + 
                   "                           and a.amt <> 0                                                " + 
                   "                    )  a                                                                 " + 
                   "                where a.rk_1 = 1                                                         " + 
                   "                group by a.dept_code                                                     " + 
                   "           ) c,                                                                          " + 
                   "           z_code_dept a,                                                                " + 
                   "           z_code_comp b                                                                 " + 
                   "     where c.dept_code = a.dept_code                                                     " + 
                   "       and a.comp_code = b.comp_code                                                     " + 
                   "       and (a.process_code  <> '04' " +
                   "            or a.process_code is null)  " +
                   "     " + arg_where + "                                                                   " +    
                   "     group by a.dept_code                                                                " + 
                   "     order by max(a.long_name)                                                           ";
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>