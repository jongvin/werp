<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("guarantee_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantor_name1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rrn1",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("property_tax1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("zip_code1",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr1_1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("addr2_1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("relation1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("guarantor_name2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rrn2",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("property_tax2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("zip_code2",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr1_2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("addr2_2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("relation2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("insu_s_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("insu_e_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("insu_comp_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("insurence_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("compensation_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("securities_no1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("securities_no2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  p_pers_guarantee.resident_no ," + 
     "          p_pers_guarantee.guarantee_div ," + 
     "          to_char(p_pers_guarantee.s_date,'yyyy.mm.dd') s_date ," + 
     "          to_char(p_pers_guarantee.e_date,'yyyy.mm.dd') e_date ," + 
     "          p_pers_guarantee.guarantor_name1 ," + 
     "          p_pers_guarantee.rrn1 ," + 
     "          p_pers_guarantee.property_tax1 ," + 
     "          p_pers_guarantee.zip_code1 ," + 
     "          p_pers_guarantee.addr1_1 ," + 
     "          p_pers_guarantee.addr2_1 ," + 
     "          p_pers_guarantee.relation1 ," + 
     "          p_pers_guarantee.guarantor_name2 ," + 
     "          p_pers_guarantee.rrn2 ," + 
     "          p_pers_guarantee.property_tax2 ," + 
     "          p_pers_guarantee.zip_code2 ," + 
     "          p_pers_guarantee.addr1_2 ," + 
     "          p_pers_guarantee.addr2_2 ," + 
     "          p_pers_guarantee.relation2 ," + 
     "          to_char(p_pers_guarantee.insu_s_date) insu_s_date," + 
     "          to_char(p_pers_guarantee.insu_e_date) insu_e_date," + 
     "          p_pers_guarantee.insu_comp_code ," + 
     "          p_pers_guarantee.insurence_amt ," + 
     "          p_pers_guarantee.compensation_amt ," + 
     "          p_pers_guarantee.securities_no1 ," + 
     "          p_pers_guarantee.securities_no2 ," + 
     "          p_pers_guarantee.remark    " +
     " FROM p_pers_guarantee        " +
     "   where p_pers_guarantee.resident_no = '" + arg_resident_no   + "'    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>