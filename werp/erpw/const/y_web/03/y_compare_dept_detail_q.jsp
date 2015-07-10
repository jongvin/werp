<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("comp_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("home_foreign_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("gross_floor_area_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("py_cnt",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dong_cnt",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT a.dept_code, " + 
     "          a.comp_code ," +
     "          b.comp_name ," + 
     "       decode(a.dept_code,'" + arg_dept_code + "','  ' || a.long_name,' ' || a.long_name) long_name, " + 
     "          a.dept_proj_tag ," + 
     "          a.use_tag,  " + 
     "          a.process_code,  " + 
     "          a.home_foreign_tag,  " + 
     "          nvl(a.chg_const_term,0)  chg_const_term, " + 
     "          nvl(a.gross_floor_area_sum,0)  gross_floor_area_sum, " + 
     "          nvl(a.tot_cnt,0)  tot_cnt, " + 
     "          a.py_cnt, " + 
     "          a.dong_cnt, " + 
     "          to_char(a.chg_const_start_date,'yyyy.mm.dd') chg_const_start_date, " + 
     "          to_char(a.chg_const_end_date,'yyyy.mm.dd') chg_const_end_date " + 
     "     FROM z_code_dept a,  " +
     "          z_code_comp b,  " +
     "          ( select a.dept_code,a.cmp_dept_code " + 
     "                from y_cmp_dept_code a  " + 
     "                where a.dept_code = '" + arg_dept_code + "' " + 
     "            union all " + 
     "            select '" + arg_dept_code + "', " + " '" + arg_dept_code + "' " +   //자기현장을 추가
     "              from dual  ) c " +                  
     "    where  a.comp_code = b.comp_code(+)    " +  
     "      and  a.dept_code = c.cmp_dept_code    " + 
     "      and  a.dept_proj_tag = 'P'    " + 
     "  order by decode(a.dept_code,'" + arg_dept_code + "','  ' || a.long_name,' ' || a.long_name)    " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>