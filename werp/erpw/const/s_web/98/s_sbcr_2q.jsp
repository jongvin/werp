<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("treatkind_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("treatkind_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("selection_tag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("key_profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("treatkind_license_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("license_issue_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("region_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("cn_grade1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cn_grade_total1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cn_limit_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cn_grade2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cn_grade_total2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cn_limit_amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cn_grade3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cn_grade_total3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cn_limit_amt3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT  a.sbcr_code ," + 
                   "          a.treatkind_code ," + 
                   "          b.treatkind_name ," + 
                   "          a.selection_tag ," + 
                   "          a.profession_wbs_code ," + 
                   "          a.profession_wbs_code  key_profession_wbs_code," + 
                   "          a.profession_wbs_name ," + 
                   "          a.treatkind_license_number ," + 
                   "          to_char(a.license_issue_date,'YYYY.MM.DD') license_issue_date ," + 
                   "          a.region_code ," + 
                   "          c.name  region_name, " +
                   "          a.cn_grade1 ," + 
                   "          a.cn_grade_total1 ," + 
                   "          a.cn_limit_amt1 ," + 
                   "          a.cn_grade2 ," + 
                   "          a.cn_grade_total2 ," + 
                   "          a.cn_limit_amt2 ," + 
                   "          a.cn_grade3 ," + 
                   "          a.cn_grade_total3 ," + 
                   "          a.cn_limit_amt3 , " +
                   "          a.seq " +
                   "     FROM s_license_status a, " +
                   "          s_code_treatkind b, " +
                   "          y_region_code c " +
                   "    WHERE a.sbcr_code = '" + arg_sbcr_code + "'" + 
                   "      and a.treatkind_code = b.treatkind_code (+) " +
                   "      and a.region_code = c.region_code (+) " +
                   " ORDER BY a.treatkind_code          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>