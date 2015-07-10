<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_resident_no = req.getParameter("arg_resident_no");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("resident_no",GauceDataColumn.TB_STRING,14));
     dSet.addDataColumn(new GauceDataColumn("medical_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("height",GauceDataColumn.TB_DECIMAL,6,2));
     dSet.addDataColumn(new GauceDataColumn("weight",GauceDataColumn.TB_DECIMAL,6,2));
     dSet.addDataColumn(new GauceDataColumn("sick_career",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sight_l",GauceDataColumn.TB_DECIMAL,2,1));
     dSet.addDataColumn(new GauceDataColumn("sight_r",GauceDataColumn.TB_DECIMAL,2,1));
     dSet.addDataColumn(new GauceDataColumn("blind_code",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("hearing_l",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("hearing_r",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("blood",GauceDataColumn.TB_STRING,6));
     dSet.addDataColumn(new GauceDataColumn("status",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("blood_pressure_h",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("blood_pressure_l",GauceDataColumn.TB_DECIMAL,18,0));
    String query = "  SELECT a.resident_no,   " + 
     "         to_char(a.medical_date,'yyyy.mm.dd') medical_date,   " + 
     "         a.height,   " + 
     "         a.weight,   " + 
     "         a.sick_career,   " + 
     "         a.sight_l,   " + 
     "         a.sight_r,   " + 
     "         a.blind_code,   " + 
     "         a.hearing_l,   " + 
     "         a.hearing_r,   " + 
     "         a.blood,   " + 
     "         a.status,   " + 
     "         a.blood_pressure_h,   " + 
     "         a.blood_pressure_l  " + 
     "    FROM p_pers_body   a" + 
     "   where a.resident_no = '" + arg_resident_no + "'     ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>