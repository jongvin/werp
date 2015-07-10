<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_division = req.getParameter("arg_division");
     String arg_detail_code = req.getParameter("arg_detail_code");
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
    String query = "  SELECT  a.dept_code ," + 
     "          a.comp_code ," +
     "          b.comp_name ," + 
     "          a.long_name ," + 
     "          a.dept_proj_tag ," + 
     "          a.use_tag,  " + 
     "          a.process_code,  " + 
     "          a.region_code,  " + 
     "          nvl(a.chg_const_term,0)  chg_const_term, " + 
     "          nvl(a.gross_floor_area_sum,0)  gross_floor_area_sum, " + 
     "          nvl(a.tot_cnt,0)  tot_cnt " + 
     "     FROM z_code_dept a,  " +
     "          z_code_comp b,  " +
      "          ( select a.dept_code,count(*) tot_cnt                                " + 
      "                           from  y_chg_budget_detail a,y_chg_budget_parent b,  " + 
      "                               (select dept_code, max(chg_no_seq) chg_no_seq   " + 
      "                                    from y_chg_degree                          " + 
      "                                    group by dept_code) c                      " + 
      "                       where a.dept_code = c.dept_code                         " + 
      "                         and a.chg_no_seq = c.chg_no_seq                       " + 
      "                         and a.dept_code = b.dept_code                         " + 
      "                         and a.chg_no_seq = b.chg_no_seq                       " + 
      "                         and a.spec_no_seq = b.spec_no_seq                     " + 
      "                         and a.detail_code = '" + arg_detail_code + "'         " + 
      "                         and b.division  like  '" + arg_division + "%'               " + 
      "                       group by a.dept_code ) c                                " +      
      "    where  a.comp_code = b.comp_code (+)   "; 
       if (arg_detail_code.equals("xxx")) {
       	   query = query + " and a.dept_code = c.dept_code (+) ";
       }
       else {
       	   query = query + 
                  "       and  a.dept_code = c.dept_code    " + 
                  "       and  c.tot_cnt > 0     ";
       }
       query = query +            
                  "       and  a.dept_proj_tag = 'P'    " + 
                "         " + arg_where + "  " + 
     "         order by   a.long_name      " ;
%><%@ 
include file="../comm_function/conn_q_end.jsp"%>