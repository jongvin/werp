<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_start_date = req.getParameter("arg_start_date");
     String arg_end_date = req.getParameter("arg_end_date");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("count_1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("no_1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("count_2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("no_2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("count_3",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("no_3",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("count_4",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("no_4",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("count_5",GauceDataColumn.TB_STRING,50));         
     dSet.addDataColumn(new GauceDataColumn("no_5",GauceDataColumn.TB_STRING,50));  
     dSet.addDataColumn(new GauceDataColumn("count_all",GauceDataColumn.TB_STRING,50));  
     dSet.addDataColumn(new GauceDataColumn("no_all",GauceDataColumn.TB_STRING,50));  
    String query = "select code.name, " +
            "              a1.count_1, " +
            "              a1.no_1, " +
            "              b1.count_2, " +
            "              b1.no_2, " +
            "              c1.count_3, " +
            "              c1.no_3, " +
            "              d1.count_4, " +
            "              d1.no_4, " +
            "              e1.count_5, " + 
            "              e1.no_5, " +
            "              ch.count_all, " +
            "              ch.no_all " +
            "         from (select proc_code, " +
            "                      code_wbs, " +
            "                      count(code_wbs) count_1, " +
            "                      (select count(code_wbs) " +
            "                         from a_as_req_master " +
            "                        where proc_code = '1' and " +
            "                              res_comp_date is null and " +
            "                              code_wbs = a.code_wbs and " +
            "                              req_date >= '" + arg_start_date + "' and " +
            "                              req_date <= '" + arg_end_date + "' " +
            "                        group by proc_code, code_wbs) no_1 " +
  		      "                 from a_as_req_master a " +
			   "                where proc_code = '1' and " +
			   "                      req_date >= '" + arg_start_date + "' and " +
			   "                      req_date <= '" + arg_end_date + "' " +
 			   "                group by proc_code, code_wbs) a1, " +
			   
			   "               (select proc_code, " +
			   "                        code_wbs, " +
			   "                        count(code_wbs) count_2, " +
			   "                        (select count(code_wbs) " +
			   "                           from a_as_req_master " +
			   "                          where proc_code = '2' and " +
			   "                                res_comp_date is null and " +
			   "                                code_wbs = b.code_wbs and " +
			   "                                req_date >= '" + arg_start_date + "' and " +
            "                                req_date <= '" + arg_end_date + "' " +
			   "                          group by proc_code, code_wbs) no_2 " +
  		      "                   from a_as_req_master b " +
			   "                  where proc_code = '2' and " +
			   "                        req_date >= '" + arg_start_date + "' and " +
			   "                        req_date <= '" + arg_end_date + "' " +
 			   "                  group by proc_code, code_wbs) b1, " +
 			   
			   "                  (select proc_code, " +
			   "                          code_wbs, " +
			   "                          count(code_wbs) count_3, " +
			   "                          (select count(code_wbs) " +
			   "                             from a_as_req_master " +
			   "                            where proc_code = '3' and " +
			   "                                  res_comp_date is null and " +
			   "                                  code_wbs = c.code_wbs and " +
			   "                                  req_date >= '" + arg_start_date + "' and " +
            "                                  req_date <= '" + arg_end_date + "' " +
			   "                            group by proc_code, code_wbs) no_3 " +
  		      "                     from a_as_req_master c " +
			   "                    where proc_code = '3' and " +
			   "                          req_date >= '" + arg_start_date + "' and " +
			   "                          req_date <= '" + arg_end_date + "' " +
 			   "                    group by proc_code, code_wbs) c1, " +
			   "                   (select proc_code, " +
			   "                            code_wbs, " +
			   "                            count(code_wbs) count_4, " +
			   "                            (select count(code_wbs) " +
			   "                               from a_as_req_master " +
			   "                              where proc_code = '4' and " +
			   "                                    res_comp_date is null and " +
			   "                                    code_wbs = d.code_wbs and " +
			   "                                    req_date >= '" + arg_start_date + "' and " +
            "                                    req_date <= '" + arg_end_date + "' " +
			   "                              group by proc_code, code_wbs) no_4 " +
  		      "                       from a_as_req_master d " +
			   "                      where proc_code = '4' and " +
			   "                            req_date >= '" + arg_start_date + "' and " +
			   "                            req_date <= '" + arg_end_date + "' " +
 			   "                      group by proc_code, code_wbs) d1, " +
			   
			   "                     (select proc_code, " +
			   "                             code_wbs, " +
			   "                             count(code_wbs) count_5, " +
			   "                             (select count(code_wbs) " +
			   "                                from a_as_req_master " +
			   "                               where proc_code = '5' and " +
			   "                                     res_comp_date is null and " +
			   "                                     code_wbs = e.code_wbs and " +
			   "                                     req_date >= '" + arg_start_date + "' and " +
            "                                     req_date <= '" + arg_end_date + "' " +
			   "                               group by proc_code, code_wbs) no_5 " +
  		      "                        from a_as_req_master e " +
			   "                       where proc_code = '5' and " +
			   "                             req_date >= '" + arg_start_date + "' and " +
			   "                             req_date <= '" + arg_end_date + "' " +
 			   "                       group by proc_code, code_wbs) e1, " +
			   "                     (select code_wbs, " +
			   "                             count(code_wbs) count_all, " +
			   "                             (select count(code_wbs) " +
			   "                                from a_as_req_master " +
			   "                               where res_comp_date is null and " +
			   "                                     code_wbs = aa.code_wbs and " +
			   "                                     req_date >= '" + arg_start_date + "' and " +
            "                                     req_date <= '" + arg_end_date + "' " +
			   "                               group by code_wbs) no_all " +
  		      "                        from a_as_req_master aa " +
  		      "                       where req_date >= '" + arg_start_date + "' and " +
			   "                             req_date <= '" + arg_end_date + "' " +
 			   "                        group by code_wbs) ch, " +
			   
			   "                     a_as_comm_code code " +
			   
            "               where code.code = a1.code_wbs(+) and " +
  		      "                     code.code = b1.code_wbs(+) and " +
			   "                     code.code = c1.code_wbs(+) and " +
			   "                     code.code = d1.code_wbs(+) and " +
			   "                     code.code = e1.code_wbs(+) and " +
			   "                     code.code = ch.code_wbs(+) and " +
			   "                     code.class = '2'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>