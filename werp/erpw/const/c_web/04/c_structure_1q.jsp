<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_chg_no_seq = req.getParameter("arg_chg_no_seq");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("chg_no_seq",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ji_1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_1",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_1",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_2",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_2",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_2",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_2",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_3",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_3",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_3",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_3",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_3",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_4",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_4",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_4",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_4",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_4",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_5",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_5",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_5",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_5",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_5",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_6",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_6",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_6",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_6",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_6",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_7",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_7",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_7",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_7",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_7",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_8",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_8",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_8",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_8",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_8",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_9",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_9",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_9",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_9",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_9",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_10",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_10",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_10",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_10",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_10",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_11",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_11",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_11",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_11",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_11",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_12",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_12",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_12",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_12",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_12",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_13",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_13",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_13",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_13",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_13",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_14",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_14",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_14",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_14",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_14",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_15",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_15",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_15",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_15",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_15",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_16",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_16",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_16",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_16",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_16",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_17",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_17",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_17",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_17",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_17",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_18",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_18",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_18",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_18",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_18",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_19",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_19",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_19",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("name_19",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("input_date_19",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_20",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_20",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_20",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_20",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_20",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_21",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_21",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_21",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_21",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_21",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_22",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_22",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_22",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_22",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_22",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_23",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_23",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_23",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_23",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_23",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_24",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_24",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_24",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_24",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_24",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_25",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_25",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_25",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_25",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_25",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_26",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_26",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_26",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_26",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_26",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_27",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_27",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_27",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_27",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_27",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_28",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_28",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_28",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_28",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_28",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_29",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_29",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_29",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_29",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_29",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_30",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_30",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_30",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_30",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_30",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_31",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_31",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_31",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_31",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_31",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_32",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_32",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_32",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_32",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_32",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_33",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_33",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_33",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_33",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_33",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_34",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_34",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_34",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_34",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_34",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_35",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_35",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_35",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_35",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_35",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_36",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_36",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_36",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_36",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_36",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_37",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_37",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_37",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_37",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_37",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_38",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_38",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_38",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_38",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_38",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_39",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_39",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_39",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_39",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_39",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("ji_40",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("jikwi_40",GauceDataColumn.TB_STRING,16));
     dSet.addDataColumn(new GauceDataColumn("name_40",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("buim_tag_40",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("input_date_40",GauceDataColumn.TB_STRING,10));
    String query = "  SELECT a.dept_code,   " + 
     "        a.chg_no_seq,   " + 
     "        a.ji_1,   " + 
     "        a.jikwi_1,   " + 
     "        a.name_1,   " + 
     "        a.buim_tag_1,   " + 
     "        to_char(a.input_date_1,'yyyy.mm.dd') input_date_1,   " + 
     "        a.ji_2,   " + 
     "        a.jikwi_2,   " + 
     "        a.name_2,   " + 
     "        a.buim_tag_2,   " + 
     "        to_char(a.input_date_2,'yyyy.mm.dd') input_date_2,   " + 
     "        a.ji_3,   " + 
     "        a.jikwi_3,   " + 
     "        a.name_3,   " + 
     "        a.buim_tag_3,   " + 
     "        to_char(a.input_date_3,'yyyy.mm.dd') input_date_3,   " + 
     "        a.ji_4,   " + 
     "        a.jikwi_4,   " + 
     "        a.name_4,   " + 
     "        a.buim_tag_4,   " + 
     "        to_char(a.input_date_4,'yyyy.mm.dd') input_date_4,   " + 
     "        a.ji_5,   " + 
     "        a.jikwi_5,   " + 
     "        a.name_5,   " + 
     "        a.buim_tag_5,   " + 
     "        to_char(a.input_date_5,'yyyy.mm.dd') input_date_5,   " + 
     "        a.ji_6,   " + 
     "        a.jikwi_6,   " + 
     "        a.name_6,   " + 
     "        a.buim_tag_6,   " + 
     "        to_char(a.input_date_6,'yyyy.mm.dd') input_date_6,   " + 
     "        a.ji_7,   " + 
     "        a.jikwi_7,   " + 
     "        a.name_7,   " + 
     "        a.buim_tag_7,   " + 
     "        to_char(a.input_date_7,'yyyy.mm.dd') input_date_7,   " + 
     "        a.ji_8,   " + 
     "        a.jikwi_8,   " + 
     "        a.name_8,   " + 
     "        a.buim_tag_8,   " + 
     "        to_char(a.input_date_8,'yyyy.mm.dd') input_date_8,   " + 
     "        a.ji_9,   " + 
     "        a.jikwi_9,   " + 
     "        a.name_9,   " + 
     "        a.buim_tag_9,   " + 
     "        to_char(a.input_date_9,'yyyy.mm.dd') input_date_9,   " + 
     "        a.ji_10,   " + 
     "        a.jikwi_10,   " + 
     "        a.name_10,   " + 
     "        a.buim_tag_10,   " + 
     "        to_char(a.input_date_10,'yyyy.mm.dd') input_date_10,   " + 
     "        a.ji_11,   " + 
     "        a.jikwi_11,   " + 
     "        a.name_11,   " + 
     "        a.buim_tag_11,   " + 
     "        to_char(a.input_date_11,'yyyy.mm.dd') input_date_11,   " + 
     "        a.ji_12,   " + 
     "        a.jikwi_12,   " + 
     "        a.name_12,   " + 
     "        a.buim_tag_12,   " + 
     "        to_char(a.input_date_12,'yyyy.mm.dd') input_date_12,   " + 
     "        a.ji_13,   " + 
     "        a.jikwi_13,   " + 
     "        a.name_13,   " + 
     "        a.buim_tag_13,   " + 
     "        to_char(a.input_date_13,'yyyy.mm.dd') input_date_13,   " + 
     "        a.ji_14,   " + 
     "        a.jikwi_14,   " + 
     "        a.name_14,   " + 
     "        a.buim_tag_14,   " + 
     "        to_char(a.input_date_14,'yyyy.mm.dd') input_date_14,   " + 
     "        a.ji_15,   " + 
     "        a.jikwi_15,   " + 
     "        a.name_15,   " + 
     "        a.buim_tag_15,   " + 
     "        to_char(a.input_date_15,'yyyy.mm.dd') input_date_15,   " + 
     "        a.ji_16,   " + 
     "        a.jikwi_16,   " + 
     "        a.name_16,   " + 
     "        a.buim_tag_16,   " + 
     "        to_char(a.input_date_16,'yyyy.mm.dd') input_date_16,   " + 
     "        a.ji_17,   " + 
     "        a.jikwi_17,   " + 
     "        a.name_17,   " + 
     "        a.buim_tag_17,   " + 
     "        to_char(a.input_date_17,'yyyy.mm.dd') input_date_17,   " + 
     "        a.ji_18,   " + 
     "        a.jikwi_18,   " + 
     "        a.name_18,   " + 
     "        a.buim_tag_18,   " + 
     "        to_char(a.input_date_18,'yyyy.mm.dd') input_date_18,   " + 
     "        a.ji_19,   " + 
     "        a.jikwi_19,   " + 
     "        a.buim_tag_19,   " + 
     "        a.name_19,   " + 
     "        to_char(a.input_date_19,'yyyy.mm.dd') input_date_19,   " + 
     "        a.ji_20,   " + 
     "        a.jikwi_20,   " + 
     "        a.name_20,   " + 
     "        a.buim_tag_20,   " + 
     "        to_char(a.input_date_20,'yyyy.mm.dd') input_date_20,   " + 
     "        a.ji_21,   " + 
     "        a.jikwi_21,   " + 
     "        a.name_21,   " + 
     "        a.buim_tag_21,   " + 
     "        to_char(a.input_date_21,'yyyy.mm.dd') input_date_21,   " + 
     "        a.ji_22,   " + 
     "        a.jikwi_22,   " + 
     "        a.name_22,   " + 
     "        a.buim_tag_22,   " + 
     "        to_char(a.input_date_22,'yyyy.mm.dd') input_date_22,   " + 
     "        a.ji_23,   " + 
     "        a.jikwi_23,   " + 
     "        a.name_23,   " + 
     "        a.buim_tag_23,   " + 
     "        to_char(a.input_date_23,'yyyy.mm.dd') input_date_23,   " + 
     "        a.ji_24,   " + 
     "        a.jikwi_24,   " + 
     "        a.name_24,   " + 
     "        a.buim_tag_24,   " + 
     "        to_char(a.input_date_24,'yyyy.mm.dd') input_date_24,   " + 
     "        a.ji_25,   " + 
     "        a.jikwi_25,   " + 
     "        a.name_25,   " + 
     "        a.buim_tag_25,   " + 
     "        to_char(a.input_date_25,'yyyy.mm.dd') input_date_25,   " + 
     "        a.ji_26,   " + 
     "        a.jikwi_26,   " + 
     "        a.name_26,   " + 
     "        a.buim_tag_26,   " + 
     "        to_char(a.input_date_26,'yyyy.mm.dd') input_date_26,   " + 
     "        a.ji_27,   " + 
     "        a.jikwi_27,   " + 
     "        a.name_27,   " + 
     "        a.buim_tag_27,   " + 
     "        to_char(a.input_date_27,'yyyy.mm.dd') input_date_27,   " + 
     "        a.ji_28,   " + 
     "        a.jikwi_28,   " + 
     "        a.name_28,   " + 
     "        a.buim_tag_28,   " + 
     "        to_char(a.input_date_28,'yyyy.mm.dd') input_date_28,   " + 
     "        a.ji_29,   " + 
     "        a.jikwi_29,   " + 
     "        a.name_29,   " + 
     "        a.buim_tag_29,   " + 
     "        to_char(a.input_date_29,'yyyy.mm.dd') input_date_29,   " + 
     "        a.ji_30,   " + 
     "        a.jikwi_30,   " + 
     "        a.name_30,   " + 
     "        a.buim_tag_30,   " + 
     "        to_char(a.input_date_30,'yyyy.mm.dd') input_date_30,   " + 
     "        a.ji_31,   " + 
     "        a.jikwi_31,   " + 
     "        a.name_31,   " + 
     "        a.buim_tag_31,   " + 
     "        to_char(a.input_date_31,'yyyy.mm.dd') input_date_31,   " + 
     "        a.ji_32,   " + 
     "        a.jikwi_32,   " + 
     "        a.name_32,   " + 
     "        a.buim_tag_32,   " + 
     "        to_char(a.input_date_32,'yyyy.mm.dd') input_date_32,   " + 
     "        a.ji_33,   " + 
     "        a.jikwi_33,   " + 
     "        a.name_33,   " + 
     "        a.buim_tag_33,   " + 
     "        to_char(a.input_date_33,'yyyy.mm.dd') input_date_33,   " + 
     "        a.ji_34,   " + 
     "        a.jikwi_34,   " + 
     "        a.name_34,   " + 
     "        a.buim_tag_34,   " + 
     "        to_char(a.input_date_34,'yyyy.mm.dd') input_date_34,   " + 
     "        a.ji_35,   " + 
     "        a.jikwi_35,   " + 
     "        a.name_35,   " + 
     "        a.buim_tag_35,   " + 
     "        to_char(a.input_date_35,'yyyy.mm.dd') input_date_35,   " + 
     "        a.ji_36,   " + 
     "        a.jikwi_36,   " + 
     "        a.name_36,   " + 
     "        a.buim_tag_36,   " + 
     "        to_char(a.input_date_36,'yyyy.mm.dd') input_date_36,   " + 
     "        a.ji_37,   " + 
     "        a.jikwi_37,   " + 
     "        a.name_37,   " + 
     "        a.buim_tag_37,   " + 
     "        to_char(a.input_date_37,'yyyy.mm.dd') input_date_37,   " + 
     "        a.ji_38,   " + 
     "        a.jikwi_38,   " + 
     "        a.name_38,   " + 
     "        a.buim_tag_38,   " + 
     "        to_char(a.input_date_38,'yyyy.mm.dd') input_date_38,   " + 
     "        a.ji_39,   " + 
     "        a.jikwi_39,   " + 
     "        a.name_39,   " + 
     "        a.buim_tag_39,   " + 
     "        to_char(a.input_date_39,'yyyy.mm.dd') input_date_39,   " + 
     "        a.ji_40,   " + 
     "        a.jikwi_40,   " + 
     "        a.name_40,   " + 
     "        a.buim_tag_40,   " + 
     "        to_char(a.input_date_40,'yyyy.mm.dd') input_date_40    " + 
     "    FROM c_structure a " + 
     "   WHERE (a.dept_code = '" + arg_dept_code + "' ) AND  " + 
     "         (a.chg_no_seq = " + arg_chg_no_seq + ")   " + 
     "                 ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>