<%@ page session="true"  contentType="text/html;charset=EUC_KR" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
      String arg_name = req.getParameter("arg_name");
     arg_name = "%" + arg_name + "%";
//---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("address1",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("register_st",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT a.sbcr_code,   " + 
                   "         a.sbcr_name,   " + 
                   "         a.businessman_number," + 
                   "	  		  a.address1," + 
                   "         a.profession_wbs_code, " +
                   "         a.profession_wbs_name, " +
                   "         decode(a.register_chk,'4','정규',decode(a.register_chk,'5','임시','가')) register_st " +
                   "    FROM ( select a.sbcr_code, " +
                   "                  a.sbcr_name, " +
                   "                  a.businessman_number, " +
                   "                  a.address1, " +
                   "                  b.profession_wbs_code, " +
                   "                  b.profession_wbs_name, " +
                   "                  b.register_chk " +
                   "             from s_sbcr a,s_wbs_request b " +
                   "            where a.sbcr_code = b.sbcr_code " +
                   "              and a.sbcr_name like '" + arg_name + "'" +
                   "              and a.sbcr_class = '1' " +
                   "              and (b.register_chk = '4' or b.register_chk = '5' or b.register_chk = '6') " +
                   "            union all " +
                   "           select sbcr_code, " +
                   "                  sbcr_name, " +
                   "                  businessman_number, " +
                   "                  address1, " +
                   "                  '' profession_wbs_code, " +
                   "                  '' profession_wbs_name, " +
                   "                  '' register_chk " +
                   "             from s_sbcr  " +
                   "            where sbcr_name like '" + arg_name + "'" +
                   "              and sbcr_class = '2' ) a " +
                   "    order by a.sbcr_code asc " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>