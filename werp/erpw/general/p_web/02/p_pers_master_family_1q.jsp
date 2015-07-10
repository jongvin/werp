<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("relation_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("family_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("family_resi_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("offical_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("school_car_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("official",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("together_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("family_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("surport_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("sex_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("family_birthday",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT p_pers_family.resident_no,   " + 
     "         p_pers_family.spec_no_seq,   " + 
     "         p_pers_family.seq,   " + 
     "         p_pers_family.relation_code,   " + 
     "         p_pers_family.family_name,   " + 
     "         p_pers_family.family_resi_no,   " + 
     "         p_pers_family.offical_name,   " + 
     "         p_pers_family.school_car_code,   " + 
     "         p_pers_family.official,   " + 
     "         p_pers_family.together_yn,   " + 
     "         p_pers_family.family_amt,   " + 
     "         p_pers_family.surport_yn,   " + 
     "         p_pers_family.sex_div,   " + 
     "         to_char(p_pers_family.family_birthday,'yyyy.mm.dd') family_birthday  " + 
     "    FROM p_pers_family   " + 
     "	where p_pers_family.resident_no = '" + arg_resident_no + "'  " +
     " order by  seq ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>