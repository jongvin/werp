<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("birthday",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("lunar_solar",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("religion_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("hobby_code",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("talent",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("married_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("married_ann_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("born_area",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("householder",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("householder_relation",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("householder_job",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("born_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("born_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("born_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("born_addr2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("resi_zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("resi_addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("resi_addr2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("zip_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("addr1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("addr2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("house_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cell_phone",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("fax",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("e_mail",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("homepage",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("sex_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT  resident_no," +
     "          to_char(p_pers_address.birthday,'yyyy.mm.dd') birthday ," + 
     "          p_pers_address.lunar_solar ," + 
     "          p_pers_address.religion_code ," + 
     "          p_pers_address.hobby_code ," + 
     "          p_pers_address.talent ," + 
     "          p_pers_address.married_yn ," + 
     "          to_char(p_pers_address.married_ann_date,'yyyy.mm.dd') married_ann_date ," + 
     "          p_pers_address.born_area ," + 
     "          p_pers_address.householder ," + 
     "          p_pers_address.householder_relation ," + 
     "          p_pers_address.householder_job ," + 
     "          p_pers_address.born_code ," + 
     "          p_pers_address.born_zip_code ," + 
     "          p_pers_address.born_addr1 ," + 
     "          p_pers_address.born_addr2 ," + 
     "          p_pers_address.zip_code ," + 
     "          p_pers_address.addr1 ," + 
     "          p_pers_address.addr2 ," + 
     "          p_pers_address.resi_zip_code ," + 
     "          p_pers_address.resi_addr1 ," + 
     "          p_pers_address.resi_addr2 ," + 
     "          p_pers_address.house_phone ," + 
     "          p_pers_address.fax ," + 
     "          p_pers_address.cell_phone ," + 
     "          p_pers_address.e_mail ," + 
     "          p_pers_address.homepage ," + 
     "          p_pers_address.sex_div ," + 
     "          p_pers_address.remark     FROM p_pers_address        " +
     "   where p_pers_address.resident_no = '" + arg_resident_no   + "'    ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>