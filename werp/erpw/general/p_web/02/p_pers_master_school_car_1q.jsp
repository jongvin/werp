<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("spec_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("school_name",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("location",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("major_code",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("school_car_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("acq_div",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("enter_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("grad_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_school_yn",GauceDataColumn.TB_STRING,1));
    String query = "  SELECT  p_pers_school_car.resident_no ," + 
     "          p_pers_school_car.spec_no_seq ," + 
     "          p_pers_school_car.seq ," + 
     "          p_pers_school_car.school_name ," + 
     "          p_pers_school_car.location ," + 
     "          p_pers_school_car.major_code ," + 
     "          p_pers_school_car.school_car_code ," + 
     "          p_pers_school_car.acq_div ," + 
     "          to_char(p_pers_school_car.enter_date,'yyyy.mm.dd') enter_date," + 
     "          to_char(p_pers_school_car.grad_date,'yyyy.mm.dd') grad_date," + 
     "          p_pers_school_car.last_school_yn " +
     "    FROM p_pers_school_car                 " +
     "   where p_pers_school_car.resident_no = '" + arg_resident_no   + "'    " +
     "  ORDER BY p_pers_school_car.seq          ASC      ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>