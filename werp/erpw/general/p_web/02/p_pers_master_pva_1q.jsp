<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("pva_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("mpva_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("relation_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("mpv_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("mpv_no",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("handicap_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("handicap_level",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("ind_s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ind_e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("ind_level",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("pva_remark",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  p_pers_pva.resident_no ," + 
     "          p_pers_pva.pva_code ," + 
     "          p_pers_pva.mpva_code ," + 
     "          p_pers_pva.relation_code ," + 
     "          p_pers_pva.mpv_name ," + 
     "          p_pers_pva.mpv_no ," + 
     "          p_pers_pva.handicap_code ," + 
     "          p_pers_pva.handicap_level ," + 
     "          to_char(p_pers_pva.ind_s_date,'yyyy.mm.dd') ind_s_date ," + 
     "          to_char(p_pers_pva.ind_e_date,'yyyy.mm.dd') ind_e_date ," + 
     "          p_pers_pva.ind_level ," + 
     "          p_pers_pva.remark pva_remark   " +
     "  FROM p_pers_pva        " +
     "   where p_pers_pva.resident_no = '" + arg_resident_no   + "'    " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>