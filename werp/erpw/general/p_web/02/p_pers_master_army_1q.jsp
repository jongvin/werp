<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("end_army_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("ssn",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("kind_army_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("arm_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("class_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("cmss_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("discharge_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("enroll_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("discharge_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("s_enroll_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("s_discharge_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("mos_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("incompl_reason",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("reserve_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("rtd_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("assign_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("platoon_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("civil_defense_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("civildef_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("resource_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("reserve_forces_year",GauceDataColumn.TB_DECIMAL,3));     
    String query = "  SELECT  p_pers_army.resident_no ," + 
     "          p_pers_army.end_army_code ," + 
     "          p_pers_army.ssn ," + 
     "          p_pers_army.kind_army_code ," + 
     "          p_pers_army.arm_code ," + 
     "          p_pers_army.class_code ," + 
     "          p_pers_army.cmss_code ," + 
     "          p_pers_army.discharge_code ," + 
     "          to_char(p_pers_army.enroll_date,'yyyy.mm.dd') enroll_date ," + 
     "          to_char(p_pers_army.discharge_date,'yyyy.mm.dd') discharge_date ," + 
     "          to_char(p_pers_army.s_enroll_date,'yyyy.mm.dd')  s_enroll_date ," + 
     "          to_char(p_pers_army.s_discharge_date,'yyyy.mm.dd') s_discharge_date ," + 
     "          p_pers_army.mos_code ," + 
     "          p_pers_army.incompl_reason ," + 
     "          p_pers_army.reserve_code ," + 
     "          p_pers_army.rtd_code ," + 
     "          p_pers_army.assign_code ," + 
     "          p_pers_army.platoon_code ," + 
     "          to_char(p_pers_army.civil_defense_date,'yyyy.mm.dd') civil_defense_date ," + 
     "          p_pers_army.civildef_code ," + 
     "          p_pers_army.resource_code," +
     "			 p_pers_army.reserve_forces_year " +
     "	 FROM p_pers_army        " +
     "   where p_pers_army.resident_no = '" + arg_resident_no   + "'    " ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>