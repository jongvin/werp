<%@ page import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
    String arg_name = '%' + req.getParameter("arg_name") + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("sbcr_unq_num",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("businessman_number",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("corp_no",GauceDataColumn.TB_STRING,13));
     dSet.addDataColumn(new GauceDataColumn("establish_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("kind_bussinesstype",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("kinditem",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("zip_number1",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("address1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("tel_number1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("zip_number2",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("address2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("tel_number2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("rep_name2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("rep_email",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("rep_jumin",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rep_zip_number1",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("rep_address1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("rep_zip_number2",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("rep_address2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("rep_tel_number1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rep_tel_number2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rep_taste",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("rep_religious",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("rep_born_area",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("chrg_department",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chrg_grade",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chrg_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chrg_name2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("chrg_hp",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chrg_email",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("chrg_jumin",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chrg_zip_number1",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("chrg_address1",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("chrg_zip_number2",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("chrg_address2",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("chrg_tel_number2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("chrg_born_area",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("fax_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("iso_status",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("main_bank",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("depositor",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("acc_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("speciality",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("capital1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("property1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("debt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("capital_tot1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("c_grade1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("capital2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("property2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("debt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("capital_tot2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_amt2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit2",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("c_grade2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("capital3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("property3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("debt3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("capital_tot3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sale_amt3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profit3",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("c_grade3",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("input_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("input_name",GauceDataColumn.TB_STRING,30));
     dSet.addDataColumn(new GauceDataColumn("chg_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("chg_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("register_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("register_date",GauceDataColumn.TB_STRING,18));
    String query = "  SELECT  a.sbcr_unq_num ," + 
     					 "          a.sbcr_code ," + 
     					 "          a.sbcr_name ," + 
     					 "          a.businessman_number ," + 
     					 "          a.corp_no ," + 
     					 "          to_char(a.establish_date,'YYYY.MM.DD')  establish_date," + 
     					 "          a.kind_bussinesstype ," + 
     					 "          a.kinditem ," + 
     					 "          a.region_code ," + 
     					 "          a.zip_number1 ," + 
     					 "          a.address1 ," + 
     					 "          a.tel_number1 ," + 
     					 "          a.zip_number2 ," + 
     					 "          a.address2 ," + 
     					 "          a.tel_number2 ," + 
     					 "          a.rep_name1 ," + 
     					 "          a.rep_name2 ," + 
     					 "          a.rep_email ," + 
     					 "          a.rep_jumin ," + 
     					 "          a.rep_zip_number1 ," + 
     					 "          a.rep_address1 ," + 
     					 "          a.rep_zip_number2 ," + 
     					 "          a.rep_address2 ," + 
     					 "          a.rep_tel_number1 ," + 
     					 "          a.rep_tel_number2 ," + 
     					 "          a.rep_taste ," + 
     					 "          a.rep_religious ," + 
     					 "          a.rep_born_area ," + 
     					 "          a.chrg_department ," + 
     					 "          a.chrg_grade ," + 
     					 "          a.chrg_name1 ," + 
     					 "          a.chrg_name2 ," + 
     					 "          a.chrg_hp ," + 
     					 "          a.chrg_email ," + 
     					 "          a.chrg_jumin ," + 
     					 "          a.chrg_zip_number1 ," + 
     					 "          a.chrg_address1 ," + 
     					 "          a.chrg_zip_number2 ," + 
     					 "          a.chrg_address2 ," + 
     					 "          a.chrg_tel_number2 ," + 
     					 "          a.chrg_born_area ," + 
     					 "          a.fax_number ," + 
     					 "          a.iso_status ," + 
     					 "          a.main_bank ," + 
     					 "          a.depositor ," + 
     					 "          a.acc_number ," + 
     					 "          a.speciality ," + 
     					 "          a.capital1 ," + 
     					 "          a.property1 ," + 
     					 "          a.debt1 ," + 
     					 "          a.capital_tot1 ," + 
     					 "          a.sale_amt1 ," + 
     					 "          a.profit1 ," + 
     					 "          a.c_grade1 ," + 
     					 "          a.capital2 ," + 
     					 "          a.property2 ," + 
     					 "          a.debt2 ," + 
     					 "          a.capital_tot2 ," + 
     					 "          a.sale_amt2 ," + 
     					 "          a.profit2 ," + 
     					 "          a.c_grade2 ," + 
     					 "          a.capital3 ," + 
     					 "          a.property3 ," + 
     					 "          a.debt3 ," + 
     					 "          a.capital_tot3 ," + 
     					 "          a.sale_amt3 ," + 
     					 "          a.profit3 ," + 
     					 "          a.c_grade3 ," + 
     					 "          to_char(a.input_dt,'YYYY.MM.DD') input_dt ," + 
     					 "          a.input_name, " +
     					 "          a.chg_class , " +
     					 "          to_char(a.chg_date,'YYYY.MM.DD') chg_date, " +
     					 "          b.profession_wbs_code, " +
     					 "          b.register_chk, " +
     					 "          b.profession_wbs_name,to_char(b.register_date,'YYYY.MM.DD') register_date " +
     					 "     FROM s_req_sbcr  a," +
     					 "          s_req_wbs_request b " +
     					 "    WHERE a.sbcr_unq_num = b.sbcr_unq_num (+)" +
     					 "      AND a.sbcr_name like '" + arg_name + "'";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>