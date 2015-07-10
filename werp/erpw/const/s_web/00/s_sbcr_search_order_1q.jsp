<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_sbcr_name = req.getParameter("arg_sbcr_name");
     String arg_sbcr_code = req.getParameter("arg_sbcr_code");
     String arg_wbs_code = req.getParameter("arg_wbs_code");
     String ls_wbs_code = arg_wbs_code;
     
     arg_sbcr_name = "%" + arg_sbcr_name + "%";
     arg_sbcr_code = "%" + arg_sbcr_code + "%";
     arg_wbs_code = "%" + arg_wbs_code + "%";

 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("register_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("tel_number1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("temp_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("recommender_reson",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  a.sbcr_code sbcr_code," + 
                   "          a.sbcr_name sbcr_name," + 
                   "          a.businessman_number, " +
                   "          b.register_chk," + 
                   "          a.rep_name1 rep_name1," + 
                   "          a.tel_number1 tel_number1," + 
                   "          b.profession_wbs_code profession_wbs_code," + 
                   "          c.profession_wbs_name  profession_wbs_name,  " +
                   "          'F' temp_chk, b.recommender_reson " +
                   "     FROM s_profession_wbs c," + 
                   "          (select a.sbcr_code,a.profession_wbs_code,a.register_chk,a.use_tag,b.decision ,a.recommender_reson" + 
                   "              from  s_wbs_request a, " +
                   "                    s_wbs_request_etc b " + 
                   "              where a.sbcr_code = b.sbcr_code (+) " + 
                   "                and a.profession_wbs_code = b.profession_wbs_code (+) ) b, " + 
                   "          s_sbcr  a   " +
                   "    WHERE ( a.sbcr_code = b.sbcr_code (+) " +
                   "      and   b.profession_wbs_code like '" + arg_wbs_code + "')" +
                   "      and b.profession_wbs_code = c.profession_wbs_code    " + 
                   "      and (b.decision <> '부도' or b.decision is null) ";
    if (ls_wbs_code.equals("A060") || ls_wbs_code.equals("C020") || ls_wbs_code.equals("E020") || ls_wbs_code.equals("J300")                     
                                   || ls_wbs_code.equals("J340") || ls_wbs_code.equals("M050") || ls_wbs_code.equals("T040") )
           query = query +   "      and b.register_chk in ( '1','2','3','4','5','6','7','8','9') ";
    else                              
           query = query +   "      and b.register_chk in ( '1','2','3','4','5','6','7','8','9') ";
    query = query + 
                   "      and b.use_tag = 'Y' " +
                   "      and a.use_tag = 'Y' " +
                   "      and ( a.sbcr_name like " + "'" + arg_sbcr_name + "'" + 
                   "       or   a.sbcr_code like " + "'" + arg_sbcr_code  + "'" + " )" + 
                   " ORDER BY a.sbcr_name         ASC      ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>