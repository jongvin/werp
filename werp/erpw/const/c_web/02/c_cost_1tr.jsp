<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file ="../../../comm_function/conn_tr_pool.jsp"%><%
     GauceDataSet dSet = req.getGauceDataSet("c_structure_1tr");
     gpstatement.gp_dataset = dSet;
   	int idx_dept_code = dSet.indexOfColumn("dept_code");
   	int idx_chg_no_seq = dSet.indexOfColumn("chg_no_seq");
   	int idx_ji_1 = dSet.indexOfColumn("ji_1");
   	int idx_jikwi_1 = dSet.indexOfColumn("jikwi_1");
   	int idx_name_1 = dSet.indexOfColumn("name_1");
   	int idx_buim_tag_1 = dSet.indexOfColumn("buim_tag_1");
   	int idx_input_date_1 = dSet.indexOfColumn("input_date_1");
   	int idx_ji_2 = dSet.indexOfColumn("ji_2");
   	int idx_jikwi_2 = dSet.indexOfColumn("jikwi_2");
   	int idx_name_2 = dSet.indexOfColumn("name_2");
   	int idx_buim_tag_2 = dSet.indexOfColumn("buim_tag_2");
   	int idx_input_date_2 = dSet.indexOfColumn("input_date_2");
   	int idx_ji_3 = dSet.indexOfColumn("ji_3");
   	int idx_jikwi_3 = dSet.indexOfColumn("jikwi_3");
   	int idx_name_3 = dSet.indexOfColumn("name_3");
   	int idx_buim_tag_3 = dSet.indexOfColumn("buim_tag_3");
   	int idx_input_date_3 = dSet.indexOfColumn("input_date_3");
   	int idx_ji_4 = dSet.indexOfColumn("ji_4");
   	int idx_jikwi_4 = dSet.indexOfColumn("jikwi_4");
   	int idx_name_4 = dSet.indexOfColumn("name_4");
   	int idx_buim_tag_4 = dSet.indexOfColumn("buim_tag_4");
   	int idx_input_date_4 = dSet.indexOfColumn("input_date_4");
   	int idx_ji_5 = dSet.indexOfColumn("ji_5");
   	int idx_jikwi_5 = dSet.indexOfColumn("jikwi_5");
   	int idx_name_5 = dSet.indexOfColumn("name_5");
   	int idx_buim_tag_5 = dSet.indexOfColumn("buim_tag_5");
   	int idx_input_date_5 = dSet.indexOfColumn("input_date_5");
   	int idx_ji_6 = dSet.indexOfColumn("ji_6");
   	int idx_jikwi_6 = dSet.indexOfColumn("jikwi_6");
   	int idx_name_6 = dSet.indexOfColumn("name_6");
   	int idx_buim_tag_6 = dSet.indexOfColumn("buim_tag_6");
   	int idx_input_date_6 = dSet.indexOfColumn("input_date_6");
   	int idx_ji_7 = dSet.indexOfColumn("ji_7");
   	int idx_jikwi_7 = dSet.indexOfColumn("jikwi_7");
   	int idx_name_7 = dSet.indexOfColumn("name_7");
   	int idx_buim_tag_7 = dSet.indexOfColumn("buim_tag_7");
   	int idx_input_date_7 = dSet.indexOfColumn("input_date_7");
   	int idx_ji_8 = dSet.indexOfColumn("ji_8");
   	int idx_jikwi_8 = dSet.indexOfColumn("jikwi_8");
   	int idx_name_8 = dSet.indexOfColumn("name_8");
   	int idx_buim_tag_8 = dSet.indexOfColumn("buim_tag_8");
   	int idx_input_date_8 = dSet.indexOfColumn("input_date_8");
   	int idx_ji_9 = dSet.indexOfColumn("ji_9");
   	int idx_jikwi_9 = dSet.indexOfColumn("jikwi_9");
   	int idx_name_9 = dSet.indexOfColumn("name_9");
   	int idx_buim_tag_9 = dSet.indexOfColumn("buim_tag_9");
   	int idx_input_date_9 = dSet.indexOfColumn("input_date_9");
   	int idx_ji_10 = dSet.indexOfColumn("ji_10");
   	int idx_jikwi_10 = dSet.indexOfColumn("jikwi_10");
   	int idx_name_10 = dSet.indexOfColumn("name_10");
   	int idx_buim_tag_10 = dSet.indexOfColumn("buim_tag_10");
   	int idx_input_date_10 = dSet.indexOfColumn("input_date_10");
   	int idx_ji_11 = dSet.indexOfColumn("ji_11");
   	int idx_jikwi_11 = dSet.indexOfColumn("jikwi_11");
   	int idx_name_11 = dSet.indexOfColumn("name_11");
   	int idx_buim_tag_11 = dSet.indexOfColumn("buim_tag_11");
   	int idx_input_date_11 = dSet.indexOfColumn("input_date_11");
   	int idx_ji_12 = dSet.indexOfColumn("ji_12");
   	int idx_jikwi_12 = dSet.indexOfColumn("jikwi_12");
   	int idx_name_12 = dSet.indexOfColumn("name_12");
   	int idx_buim_tag_12 = dSet.indexOfColumn("buim_tag_12");
   	int idx_input_date_12 = dSet.indexOfColumn("input_date_12");
   	int idx_ji_13 = dSet.indexOfColumn("ji_13");
   	int idx_jikwi_13 = dSet.indexOfColumn("jikwi_13");
   	int idx_name_13 = dSet.indexOfColumn("name_13");
   	int idx_buim_tag_13 = dSet.indexOfColumn("buim_tag_13");
   	int idx_input_date_13 = dSet.indexOfColumn("input_date_13");
   	int idx_ji_14 = dSet.indexOfColumn("ji_14");
   	int idx_jikwi_14 = dSet.indexOfColumn("jikwi_14");
   	int idx_name_14 = dSet.indexOfColumn("name_14");
   	int idx_buim_tag_14 = dSet.indexOfColumn("buim_tag_14");
   	int idx_input_date_14 = dSet.indexOfColumn("input_date_14");
   	int idx_ji_15 = dSet.indexOfColumn("ji_15");
   	int idx_jikwi_15 = dSet.indexOfColumn("jikwi_15");
   	int idx_name_15 = dSet.indexOfColumn("name_15");
   	int idx_buim_tag_15 = dSet.indexOfColumn("buim_tag_15");
   	int idx_input_date_15 = dSet.indexOfColumn("input_date_15");
   	int idx_ji_16 = dSet.indexOfColumn("ji_16");
   	int idx_jikwi_16 = dSet.indexOfColumn("jikwi_16");
   	int idx_name_16 = dSet.indexOfColumn("name_16");
   	int idx_buim_tag_16 = dSet.indexOfColumn("buim_tag_16");
   	int idx_input_date_16 = dSet.indexOfColumn("input_date_16");
   	int idx_ji_17 = dSet.indexOfColumn("ji_17");
   	int idx_jikwi_17 = dSet.indexOfColumn("jikwi_17");
   	int idx_name_17 = dSet.indexOfColumn("name_17");
   	int idx_buim_tag_17 = dSet.indexOfColumn("buim_tag_17");
   	int idx_input_date_17 = dSet.indexOfColumn("input_date_17");
   	int idx_ji_18 = dSet.indexOfColumn("ji_18");
   	int idx_jikwi_18 = dSet.indexOfColumn("jikwi_18");
   	int idx_name_18 = dSet.indexOfColumn("name_18");
   	int idx_buim_tag_18 = dSet.indexOfColumn("buim_tag_18");
   	int idx_input_date_18 = dSet.indexOfColumn("input_date_18");
   	int idx_ji_19 = dSet.indexOfColumn("ji_19");
   	int idx_jikwi_19 = dSet.indexOfColumn("jikwi_19");
   	int idx_buim_tag_19 = dSet.indexOfColumn("buim_tag_19");
   	int idx_name_19 = dSet.indexOfColumn("name_19");
   	int idx_input_date_19 = dSet.indexOfColumn("input_date_19");
   	int idx_ji_20 = dSet.indexOfColumn("ji_20");
   	int idx_jikwi_20 = dSet.indexOfColumn("jikwi_20");
   	int idx_name_20 = dSet.indexOfColumn("name_20");
   	int idx_buim_tag_20 = dSet.indexOfColumn("buim_tag_20");
   	int idx_input_date_20 = dSet.indexOfColumn("input_date_20");
   	int idx_ji_21 = dSet.indexOfColumn("ji_21");
   	int idx_jikwi_21 = dSet.indexOfColumn("jikwi_21");
   	int idx_name_21 = dSet.indexOfColumn("name_21");
   	int idx_buim_tag_21 = dSet.indexOfColumn("buim_tag_21");
   	int idx_input_date_21 = dSet.indexOfColumn("input_date_21");
   	int idx_ji_22 = dSet.indexOfColumn("ji_22");
   	int idx_jikwi_22 = dSet.indexOfColumn("jikwi_22");
   	int idx_name_22 = dSet.indexOfColumn("name_22");
   	int idx_buim_tag_22 = dSet.indexOfColumn("buim_tag_22");
   	int idx_input_date_22 = dSet.indexOfColumn("input_date_22");
   	int idx_ji_23 = dSet.indexOfColumn("ji_23");
   	int idx_jikwi_23 = dSet.indexOfColumn("jikwi_23");
   	int idx_name_23 = dSet.indexOfColumn("name_23");
   	int idx_buim_tag_23 = dSet.indexOfColumn("buim_tag_23");
   	int idx_input_date_23 = dSet.indexOfColumn("input_date_23");
   	int idx_ji_24 = dSet.indexOfColumn("ji_24");
   	int idx_jikwi_24 = dSet.indexOfColumn("jikwi_24");
   	int idx_name_24 = dSet.indexOfColumn("name_24");
   	int idx_buim_tag_24 = dSet.indexOfColumn("buim_tag_24");
   	int idx_input_date_24 = dSet.indexOfColumn("input_date_24");
   	int idx_ji_25 = dSet.indexOfColumn("ji_25");
   	int idx_jikwi_25 = dSet.indexOfColumn("jikwi_25");
   	int idx_name_25 = dSet.indexOfColumn("name_25");
   	int idx_buim_tag_25 = dSet.indexOfColumn("buim_tag_25");
   	int idx_input_date_25 = dSet.indexOfColumn("input_date_25");
   	int idx_ji_26 = dSet.indexOfColumn("ji_26");
   	int idx_jikwi_26 = dSet.indexOfColumn("jikwi_26");
   	int idx_name_26 = dSet.indexOfColumn("name_26");
   	int idx_buim_tag_26 = dSet.indexOfColumn("buim_tag_26");
   	int idx_input_date_26 = dSet.indexOfColumn("input_date_26");
   	int idx_ji_27 = dSet.indexOfColumn("ji_27");
   	int idx_jikwi_27 = dSet.indexOfColumn("jikwi_27");
   	int idx_name_27 = dSet.indexOfColumn("name_27");
   	int idx_buim_tag_27 = dSet.indexOfColumn("buim_tag_27");
   	int idx_input_date_27 = dSet.indexOfColumn("input_date_27");
   	int idx_ji_28 = dSet.indexOfColumn("ji_28");
   	int idx_jikwi_28 = dSet.indexOfColumn("jikwi_28");
   	int idx_name_28 = dSet.indexOfColumn("name_28");
   	int idx_buim_tag_28 = dSet.indexOfColumn("buim_tag_28");
   	int idx_input_date_28 = dSet.indexOfColumn("input_date_28");
   	int idx_ji_29 = dSet.indexOfColumn("ji_29");
   	int idx_jikwi_29 = dSet.indexOfColumn("jikwi_29");
   	int idx_name_29 = dSet.indexOfColumn("name_29");
   	int idx_buim_tag_29 = dSet.indexOfColumn("buim_tag_29");
   	int idx_input_date_29 = dSet.indexOfColumn("input_date_29");
   	int idx_ji_30 = dSet.indexOfColumn("ji_30");
   	int idx_jikwi_30 = dSet.indexOfColumn("jikwi_30");
   	int idx_name_30 = dSet.indexOfColumn("name_30");
   	int idx_buim_tag_30 = dSet.indexOfColumn("buim_tag_30");
   	int idx_input_date_30 = dSet.indexOfColumn("input_date_30");
   	int idx_ji_31 = dSet.indexOfColumn("ji_31");
   	int idx_jikwi_31 = dSet.indexOfColumn("jikwi_31");
   	int idx_name_31 = dSet.indexOfColumn("name_31");
   	int idx_buim_tag_31 = dSet.indexOfColumn("buim_tag_31");
   	int idx_input_date_31 = dSet.indexOfColumn("input_date_31");
   	int idx_ji_32 = dSet.indexOfColumn("ji_32");
   	int idx_jikwi_32 = dSet.indexOfColumn("jikwi_32");
   	int idx_name_32 = dSet.indexOfColumn("name_32");
   	int idx_buim_tag_32 = dSet.indexOfColumn("buim_tag_32");
   	int idx_input_date_32 = dSet.indexOfColumn("input_date_32");
   	int idx_ji_33 = dSet.indexOfColumn("ji_33");
   	int idx_jikwi_33 = dSet.indexOfColumn("jikwi_33");
   	int idx_name_33 = dSet.indexOfColumn("name_33");
   	int idx_buim_tag_33 = dSet.indexOfColumn("buim_tag_33");
   	int idx_input_date_33 = dSet.indexOfColumn("input_date_33");
   	int idx_ji_34 = dSet.indexOfColumn("ji_34");
   	int idx_jikwi_34 = dSet.indexOfColumn("jikwi_34");
   	int idx_name_34 = dSet.indexOfColumn("name_34");
   	int idx_buim_tag_34 = dSet.indexOfColumn("buim_tag_34");
   	int idx_input_date_34 = dSet.indexOfColumn("input_date_34");
   	int idx_ji_35 = dSet.indexOfColumn("ji_35");
   	int idx_jikwi_35 = dSet.indexOfColumn("jikwi_35");
   	int idx_name_35 = dSet.indexOfColumn("name_35");
   	int idx_buim_tag_35 = dSet.indexOfColumn("buim_tag_35");
   	int idx_input_date_35 = dSet.indexOfColumn("input_date_35");
   	int idx_ji_36 = dSet.indexOfColumn("ji_36");
   	int idx_jikwi_36 = dSet.indexOfColumn("jikwi_36");
   	int idx_name_36 = dSet.indexOfColumn("name_36");
   	int idx_buim_tag_36 = dSet.indexOfColumn("buim_tag_36");
   	int idx_input_date_36 = dSet.indexOfColumn("input_date_36");
   	int idx_ji_37 = dSet.indexOfColumn("ji_37");
   	int idx_jikwi_37 = dSet.indexOfColumn("jikwi_37");
   	int idx_name_37 = dSet.indexOfColumn("name_37");
   	int idx_buim_tag_37 = dSet.indexOfColumn("buim_tag_37");
   	int idx_input_date_37 = dSet.indexOfColumn("input_date_37");
   	int idx_ji_38 = dSet.indexOfColumn("ji_38");
   	int idx_jikwi_38 = dSet.indexOfColumn("jikwi_38");
   	int idx_name_38 = dSet.indexOfColumn("name_38");
   	int idx_buim_tag_38 = dSet.indexOfColumn("buim_tag_38");
   	int idx_input_date_38 = dSet.indexOfColumn("input_date_38");
   	int idx_ji_39 = dSet.indexOfColumn("ji_39");
   	int idx_jikwi_39 = dSet.indexOfColumn("jikwi_39");
   	int idx_name_39 = dSet.indexOfColumn("name_39");
   	int idx_buim_tag_39 = dSet.indexOfColumn("buim_tag_39");
   	int idx_input_date_39 = dSet.indexOfColumn("input_date_39");
   	int idx_ji_40 = dSet.indexOfColumn("ji_40");
   	int idx_jikwi_40 = dSet.indexOfColumn("jikwi_40");
   	int idx_name_40 = dSet.indexOfColumn("name_40");
   	int idx_buim_tag_40 = dSet.indexOfColumn("buim_tag_40");
   	int idx_input_date_40 = dSet.indexOfColumn("input_date_40");
    int  rowCnt = dSet.getDataRowCnt();
    for(int i=0; i< rowCnt; i++){
    	GauceDataRow rows = dSet.getDataRow(i);
    	gpstatement.gp_row = i;
	if(rows.getJobType() == GauceDataRow.TB_JOB_INSERT){
		String sSql = " INSERT INTO c_structure ( dept_code," + 
                    "chg_no_seq," + 
                    "ji_1," + 
                    "jikwi_1," + 
                    "name_1," + 
                    "buim_tag_1," + 
                    "input_date_1," + 
                    "ji_2," + 
                    "jikwi_2," + 
                    "name_2," + 
                    "buim_tag_2," + 
                    "input_date_2," + 
                    "ji_3," + 
                    "jikwi_3," + 
                    "name_3," + 
                    "buim_tag_3," + 
                    "input_date_3," + 
                    "ji_4," + 
                    "jikwi_4," + 
                    "name_4," + 
                    "buim_tag_4," + 
                    "input_date_4," + 
                    "ji_5," + 
                    "jikwi_5," + 
                    "name_5," + 
                    "buim_tag_5," + 
                    "input_date_5," + 
                    "ji_6," + 
                    "jikwi_6," + 
                    "name_6," + 
                    "buim_tag_6," + 
                    "input_date_6," + 
                    "ji_7," + 
                    "jikwi_7," + 
                    "name_7," + 
                    "buim_tag_7," + 
                    "input_date_7," + 
                    "ji_8," + 
                    "jikwi_8," + 
                    "name_8," + 
                    "buim_tag_8," + 
                    "input_date_8," + 
                    "ji_9," + 
                    "jikwi_9," + 
                    "name_9," + 
                    "buim_tag_9," + 
                    "input_date_9," + 
                    "ji_10," + 
                    "jikwi_10," + 
                    "name_10," + 
                    "buim_tag_10," + 
                    "input_date_10," + 
                    "ji_11," + 
                    "jikwi_11," + 
                    "name_11," + 
                    "buim_tag_11," + 
                    "input_date_11," + 
                    "ji_12," + 
                    "jikwi_12," + 
                    "name_12," + 
                    "buim_tag_12," + 
                    "input_date_12," + 
                    "ji_13," + 
                    "jikwi_13," + 
                    "name_13," + 
                    "buim_tag_13," + 
                    "input_date_13," + 
                    "ji_14," + 
                    "jikwi_14," + 
                    "name_14," + 
                    "buim_tag_14," + 
                    "input_date_14," + 
                    "ji_15," + 
                    "jikwi_15," + 
                    "name_15," + 
                    "buim_tag_15," + 
                    "input_date_15," + 
                    "ji_16," + 
                    "jikwi_16," + 
                    "name_16," + 
                    "buim_tag_16," + 
                    "input_date_16," + 
                    "ji_17," + 
                    "jikwi_17," + 
                    "name_17," + 
                    "buim_tag_17," + 
                    "input_date_17," + 
                    "ji_18," + 
                    "jikwi_18," + 
                    "name_18," + 
                    "buim_tag_18," + 
                    "input_date_18," + 
                    "ji_19," + 
                    "jikwi_19," + 
                    "buim_tag_19," + 
                    "name_19," + 
                    "input_date_19," + 
                    "ji_20," + 
                    "jikwi_20," + 
                    "name_20," + 
                    "buim_tag_20," + 
                    "input_date_20," + 
                    "ji_21," + 
                    "jikwi_21," + 
                    "name_21," + 
                    "buim_tag_21," + 
                    "input_date_21," + 
                    "ji_22," + 
                    "jikwi_22," + 
                    "name_22," + 
                    "buim_tag_22," + 
                    "input_date_22," + 
                    "ji_23," + 
                    "jikwi_23," + 
                    "name_23," + 
                    "buim_tag_23," + 
                    "input_date_23," + 
                    "ji_24," + 
                    "jikwi_24," + 
                    "name_24," + 
                    "buim_tag_24," + 
                    "input_date_24," + 
                    "ji_25," + 
                    "jikwi_25," + 
                    "name_25," + 
                    "buim_tag_25," + 
                    "input_date_25," + 
                    "ji_26," + 
                    "jikwi_26," + 
                    "name_26," + 
                    "buim_tag_26," + 
                    "input_date_26," + 
                    "ji_27," + 
                    "jikwi_27," + 
                    "name_27," + 
                    "buim_tag_27," + 
                    "input_date_27," + 
                    "ji_28," + 
                    "jikwi_28," + 
                    "name_28," + 
                    "buim_tag_28," + 
                    "input_date_28," + 
                    "ji_29," + 
                    "jikwi_29," + 
                    "name_29," + 
                    "buim_tag_29," + 
                    "input_date_29," + 
                    "ji_30," + 
                    "jikwi_30," + 
                    "name_30," + 
                    "buim_tag_30," + 
                    "input_date_30," + 
                    "ji_31," + 
                    "jikwi_31," + 
                    "name_31," + 
                    "buim_tag_31," + 
                    "input_date_31," + 
                    "ji_32," + 
                    "jikwi_32," + 
                    "name_32," + 
                    "buim_tag_32," + 
                    "input_date_32," + 
                    "ji_33," + 
                    "jikwi_33," + 
                    "name_33," + 
                    "buim_tag_33," + 
                    "input_date_33," + 
                    "ji_34," + 
                    "jikwi_34," + 
                    "name_34," + 
                    "buim_tag_34," + 
                    "input_date_34," + 
                    "ji_35," + 
                    "jikwi_35," + 
                    "name_35," + 
                    "buim_tag_35," + 
                    "input_date_35," + 
                    "ji_36," + 
                    "jikwi_36," + 
                    "name_36," + 
                    "buim_tag_36," + 
                    "input_date_36," + 
                    "ji_37," + 
                    "jikwi_37," + 
                    "name_37," + 
                    "buim_tag_37," + 
                    "input_date_37," + 
                    "ji_38," + 
                    "jikwi_38," + 
                    "name_38," + 
                    "buim_tag_38," + 
                    "input_date_38," + 
                    "ji_39," + 
                    "jikwi_39," + 
                    "name_39," + 
                    "buim_tag_39," + 
                    "input_date_39," + 
                    "ji_40," + 
                    "jikwi_40," + 
                    "name_40," + 
                    "buim_tag_40," + 
                    "input_date_40 )      ";
      sSql = sSql + " VALUES ( :1, :2, :3, :4, :5, :6, :7, :8, :9, :10, :11, :12, :13, :14, :15, :16, :17, :18, :19, :20, :21, :22, :23, :24, :25, :26, :27, :28, :29, :30, :31, :32, :33, :34, :35, :36, :37, :38, :39, :40, :41, :42, :43, :44, :45, :46, :47, :48, :49, :50, :51, :52, :53, :54, :55, :56, :57, :58, :59, :60, :61, :62, :63, :64, :65, :66, :67, :68, :69, :70, :71, :72, :73, :74, :75, :76, :77, :78, :79, :80, :81, :82, :83, :84, :85, :86, :87, :88, :89, :90, :91, :92, :93, :94, :95, :96, :97, :98, :99, :100, :101, :102, :103, :104, :105, :106, :107, :108, :109, :110, :111, :112, :113, :114, :115, :116, :117, :118, :119, :120, :121, :122, :123, :124, :125, :126, :127, :128, :129, :130, :131, :132, :133, :134, :135, :136, :137, :138, :139, :140, :141, :142, :143, :144, :145, :146, :147, :148, :149, :150, :151, :152, :153, :154, :155, :156, :157, :158, :159, :160, :161, :162, :163, :164, :165, :166, :167, :168, :169, :170, :171, :172, :173, :174, :175, :176, :177, :178, :179, :180, :181, :182, :183, :184, :185, :186, :187, :188, :189, :190, :191, :192, :193, :194, :195, :196, :197, :198, :199, :200, :201, :202 ) ";
      stmt = conn.prepareStatement(sSql);
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_ji_1);
      gpstatement.bindColumn(4, idx_jikwi_1);
      gpstatement.bindColumn(5, idx_name_1);
      gpstatement.bindColumn(6, idx_buim_tag_1);
      gpstatement.bindColumn(7, idx_input_date_1);
      gpstatement.bindColumn(8, idx_ji_2);
      gpstatement.bindColumn(9, idx_jikwi_2);
      gpstatement.bindColumn(10, idx_name_2);
      gpstatement.bindColumn(11, idx_buim_tag_2);
      gpstatement.bindColumn(12, idx_input_date_2);
      gpstatement.bindColumn(13, idx_ji_3);
      gpstatement.bindColumn(14, idx_jikwi_3);
      gpstatement.bindColumn(15, idx_name_3);
      gpstatement.bindColumn(16, idx_buim_tag_3);
      gpstatement.bindColumn(17, idx_input_date_3);
      gpstatement.bindColumn(18, idx_ji_4);
      gpstatement.bindColumn(19, idx_jikwi_4);
      gpstatement.bindColumn(20, idx_name_4);
      gpstatement.bindColumn(21, idx_buim_tag_4);
      gpstatement.bindColumn(22, idx_input_date_4);
      gpstatement.bindColumn(23, idx_ji_5);
      gpstatement.bindColumn(24, idx_jikwi_5);
      gpstatement.bindColumn(25, idx_name_5);
      gpstatement.bindColumn(26, idx_buim_tag_5);
      gpstatement.bindColumn(27, idx_input_date_5);
      gpstatement.bindColumn(28, idx_ji_6);
      gpstatement.bindColumn(29, idx_jikwi_6);
      gpstatement.bindColumn(30, idx_name_6);
      gpstatement.bindColumn(31, idx_buim_tag_6);
      gpstatement.bindColumn(32, idx_input_date_6);
      gpstatement.bindColumn(33, idx_ji_7);
      gpstatement.bindColumn(34, idx_jikwi_7);
      gpstatement.bindColumn(35, idx_name_7);
      gpstatement.bindColumn(36, idx_buim_tag_7);
      gpstatement.bindColumn(37, idx_input_date_7);
      gpstatement.bindColumn(38, idx_ji_8);
      gpstatement.bindColumn(39, idx_jikwi_8);
      gpstatement.bindColumn(40, idx_name_8);
      gpstatement.bindColumn(41, idx_buim_tag_8);
      gpstatement.bindColumn(42, idx_input_date_8);
      gpstatement.bindColumn(43, idx_ji_9);
      gpstatement.bindColumn(44, idx_jikwi_9);
      gpstatement.bindColumn(45, idx_name_9);
      gpstatement.bindColumn(46, idx_buim_tag_9);
      gpstatement.bindColumn(47, idx_input_date_9);
      gpstatement.bindColumn(48, idx_ji_10);
      gpstatement.bindColumn(49, idx_jikwi_10);
      gpstatement.bindColumn(50, idx_name_10);
      gpstatement.bindColumn(51, idx_buim_tag_10);
      gpstatement.bindColumn(52, idx_input_date_10);
      gpstatement.bindColumn(53, idx_ji_11);
      gpstatement.bindColumn(54, idx_jikwi_11);
      gpstatement.bindColumn(55, idx_name_11);
      gpstatement.bindColumn(56, idx_buim_tag_11);
      gpstatement.bindColumn(57, idx_input_date_11);
      gpstatement.bindColumn(58, idx_ji_12);
      gpstatement.bindColumn(59, idx_jikwi_12);
      gpstatement.bindColumn(60, idx_name_12);
      gpstatement.bindColumn(61, idx_buim_tag_12);
      gpstatement.bindColumn(62, idx_input_date_12);
      gpstatement.bindColumn(63, idx_ji_13);
      gpstatement.bindColumn(64, idx_jikwi_13);
      gpstatement.bindColumn(65, idx_name_13);
      gpstatement.bindColumn(66, idx_buim_tag_13);
      gpstatement.bindColumn(67, idx_input_date_13);
      gpstatement.bindColumn(68, idx_ji_14);
      gpstatement.bindColumn(69, idx_jikwi_14);
      gpstatement.bindColumn(70, idx_name_14);
      gpstatement.bindColumn(71, idx_buim_tag_14);
      gpstatement.bindColumn(72, idx_input_date_14);
      gpstatement.bindColumn(73, idx_ji_15);
      gpstatement.bindColumn(74, idx_jikwi_15);
      gpstatement.bindColumn(75, idx_name_15);
      gpstatement.bindColumn(76, idx_buim_tag_15);
      gpstatement.bindColumn(77, idx_input_date_15);
      gpstatement.bindColumn(78, idx_ji_16);
      gpstatement.bindColumn(79, idx_jikwi_16);
      gpstatement.bindColumn(80, idx_name_16);
      gpstatement.bindColumn(81, idx_buim_tag_16);
      gpstatement.bindColumn(82, idx_input_date_16);
      gpstatement.bindColumn(83, idx_ji_17);
      gpstatement.bindColumn(84, idx_jikwi_17);
      gpstatement.bindColumn(85, idx_name_17);
      gpstatement.bindColumn(86, idx_buim_tag_17);
      gpstatement.bindColumn(87, idx_input_date_17);
      gpstatement.bindColumn(88, idx_ji_18);
      gpstatement.bindColumn(89, idx_jikwi_18);
      gpstatement.bindColumn(90, idx_name_18);
      gpstatement.bindColumn(91, idx_buim_tag_18);
      gpstatement.bindColumn(92, idx_input_date_18);
      gpstatement.bindColumn(93, idx_ji_19);
      gpstatement.bindColumn(94, idx_jikwi_19);
      gpstatement.bindColumn(95, idx_buim_tag_19);
      gpstatement.bindColumn(96, idx_name_19);
      gpstatement.bindColumn(97, idx_input_date_19);
      gpstatement.bindColumn(98, idx_ji_20);
      gpstatement.bindColumn(99, idx_jikwi_20);
      gpstatement.bindColumn(100, idx_name_20);
      gpstatement.bindColumn(101, idx_buim_tag_20);
      gpstatement.bindColumn(102, idx_input_date_20);
      gpstatement.bindColumn(103, idx_ji_21);
      gpstatement.bindColumn(104, idx_jikwi_21);
      gpstatement.bindColumn(105, idx_name_21);
      gpstatement.bindColumn(106, idx_buim_tag_21);
      gpstatement.bindColumn(107, idx_input_date_21);
      gpstatement.bindColumn(108, idx_ji_22);
      gpstatement.bindColumn(109, idx_jikwi_22);
      gpstatement.bindColumn(110, idx_name_22);
      gpstatement.bindColumn(111, idx_buim_tag_22);
      gpstatement.bindColumn(112, idx_input_date_22);
      gpstatement.bindColumn(113, idx_ji_23);
      gpstatement.bindColumn(114, idx_jikwi_23);
      gpstatement.bindColumn(115, idx_name_23);
      gpstatement.bindColumn(116, idx_buim_tag_23);
      gpstatement.bindColumn(117, idx_input_date_23);
      gpstatement.bindColumn(118, idx_ji_24);
      gpstatement.bindColumn(119, idx_jikwi_24);
      gpstatement.bindColumn(120, idx_name_24);
      gpstatement.bindColumn(121, idx_buim_tag_24);
      gpstatement.bindColumn(122, idx_input_date_24);
      gpstatement.bindColumn(123, idx_ji_25);
      gpstatement.bindColumn(124, idx_jikwi_25);
      gpstatement.bindColumn(125, idx_name_25);
      gpstatement.bindColumn(126, idx_buim_tag_25);
      gpstatement.bindColumn(127, idx_input_date_25);
      gpstatement.bindColumn(128, idx_ji_26);
      gpstatement.bindColumn(129, idx_jikwi_26);
      gpstatement.bindColumn(130, idx_name_26);
      gpstatement.bindColumn(131, idx_buim_tag_26);
      gpstatement.bindColumn(132, idx_input_date_26);
      gpstatement.bindColumn(133, idx_ji_27);
      gpstatement.bindColumn(134, idx_jikwi_27);
      gpstatement.bindColumn(135, idx_name_27);
      gpstatement.bindColumn(136, idx_buim_tag_27);
      gpstatement.bindColumn(137, idx_input_date_27);
      gpstatement.bindColumn(138, idx_ji_28);
      gpstatement.bindColumn(139, idx_jikwi_28);
      gpstatement.bindColumn(140, idx_name_28);
      gpstatement.bindColumn(141, idx_buim_tag_28);
      gpstatement.bindColumn(142, idx_input_date_28);
      gpstatement.bindColumn(143, idx_ji_29);
      gpstatement.bindColumn(144, idx_jikwi_29);
      gpstatement.bindColumn(145, idx_name_29);
      gpstatement.bindColumn(146, idx_buim_tag_29);
      gpstatement.bindColumn(147, idx_input_date_29);
      gpstatement.bindColumn(148, idx_ji_30);
      gpstatement.bindColumn(149, idx_jikwi_30);
      gpstatement.bindColumn(150, idx_name_30);
      gpstatement.bindColumn(151, idx_buim_tag_30);
      gpstatement.bindColumn(152, idx_input_date_30);
      gpstatement.bindColumn(153, idx_ji_31);
      gpstatement.bindColumn(154, idx_jikwi_31);
      gpstatement.bindColumn(155, idx_name_31);
      gpstatement.bindColumn(156, idx_buim_tag_31);
      gpstatement.bindColumn(157, idx_input_date_31);
      gpstatement.bindColumn(158, idx_ji_32);
      gpstatement.bindColumn(159, idx_jikwi_32);
      gpstatement.bindColumn(160, idx_name_32);
      gpstatement.bindColumn(161, idx_buim_tag_32);
      gpstatement.bindColumn(162, idx_input_date_32);
      gpstatement.bindColumn(163, idx_ji_33);
      gpstatement.bindColumn(164, idx_jikwi_33);
      gpstatement.bindColumn(165, idx_name_33);
      gpstatement.bindColumn(166, idx_buim_tag_33);
      gpstatement.bindColumn(167, idx_input_date_33);
      gpstatement.bindColumn(168, idx_ji_34);
      gpstatement.bindColumn(169, idx_jikwi_34);
      gpstatement.bindColumn(170, idx_name_34);
      gpstatement.bindColumn(171, idx_buim_tag_34);
      gpstatement.bindColumn(172, idx_input_date_34);
      gpstatement.bindColumn(173, idx_ji_35);
      gpstatement.bindColumn(174, idx_jikwi_35);
      gpstatement.bindColumn(175, idx_name_35);
      gpstatement.bindColumn(176, idx_buim_tag_35);
      gpstatement.bindColumn(177, idx_input_date_35);
      gpstatement.bindColumn(178, idx_ji_36);
      gpstatement.bindColumn(179, idx_jikwi_36);
      gpstatement.bindColumn(180, idx_name_36);
      gpstatement.bindColumn(181, idx_buim_tag_36);
      gpstatement.bindColumn(182, idx_input_date_36);
      gpstatement.bindColumn(183, idx_ji_37);
      gpstatement.bindColumn(184, idx_jikwi_37);
      gpstatement.bindColumn(185, idx_name_37);
      gpstatement.bindColumn(186, idx_buim_tag_37);
      gpstatement.bindColumn(187, idx_input_date_37);
      gpstatement.bindColumn(188, idx_ji_38);
      gpstatement.bindColumn(189, idx_jikwi_38);
      gpstatement.bindColumn(190, idx_name_38);
      gpstatement.bindColumn(191, idx_buim_tag_38);
      gpstatement.bindColumn(192, idx_input_date_38);
      gpstatement.bindColumn(193, idx_ji_39);
      gpstatement.bindColumn(194, idx_jikwi_39);
      gpstatement.bindColumn(195, idx_name_39);
      gpstatement.bindColumn(196, idx_buim_tag_39);
      gpstatement.bindColumn(197, idx_input_date_39);
      gpstatement.bindColumn(198, idx_ji_40);
      gpstatement.bindColumn(199, idx_jikwi_40);
      gpstatement.bindColumn(200, idx_name_40);
      gpstatement.bindColumn(201, idx_buim_tag_40);
      gpstatement.bindColumn(202, idx_input_date_40);
      stmt.executeUpdate();
      stmt.close();
 
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_UPDATE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "update c_structure set " + 
                            "dept_code=?,  " + 
                            "chg_no_seq=?,  " + 
                            "ji_1=?,  " + 
                            "jikwi_1=?,  " + 
                            "name_1=?,  " + 
                            "buim_tag_1=?,  " + 
                            "input_date_1=?,  " + 
                            "ji_2=?,  " + 
                            "jikwi_2=?,  " + 
                            "name_2=?,  " + 
                            "buim_tag_2=?,  " + 
                            "input_date_2=?,  " + 
                            "ji_3=?,  " + 
                            "jikwi_3=?,  " + 
                            "name_3=?,  " + 
                            "buim_tag_3=?,  " + 
                            "input_date_3=?,  " + 
                            "ji_4=?,  " + 
                            "jikwi_4=?,  " + 
                            "name_4=?,  " + 
                            "buim_tag_4=?,  " + 
                            "input_date_4=?,  " + 
                            "ji_5=?,  " + 
                            "jikwi_5=?,  " + 
                            "name_5=?,  " + 
                            "buim_tag_5=?,  " + 
                            "input_date_5=?,  " + 
                            "ji_6=?,  " + 
                            "jikwi_6=?,  " + 
                            "name_6=?,  " + 
                            "buim_tag_6=?,  " + 
                            "input_date_6=?,  " + 
                            "ji_7=?,  " + 
                            "jikwi_7=?,  " + 
                            "name_7=?,  " + 
                            "buim_tag_7=?,  " + 
                            "input_date_7=?,  " + 
                            "ji_8=?,  " + 
                            "jikwi_8=?,  " + 
                            "name_8=?,  " + 
                            "buim_tag_8=?,  " + 
                            "input_date_8=?,  " + 
                            "ji_9=?,  " + 
                            "jikwi_9=?,  " + 
                            "name_9=?,  " + 
                            "buim_tag_9=?,  " + 
                            "input_date_9=?,  " + 
                            "ji_10=?,  " + 
                            "jikwi_10=?,  " + 
                            "name_10=?,  " + 
                            "buim_tag_10=?,  " + 
                            "input_date_10=?,  " + 
                            "ji_11=?,  " + 
                            "jikwi_11=?,  " + 
                            "name_11=?,  " + 
                            "buim_tag_11=?,  " + 
                            "input_date_11=?,  " + 
                            "ji_12=?,  " + 
                            "jikwi_12=?,  " + 
                            "name_12=?,  " + 
                            "buim_tag_12=?,  " + 
                            "input_date_12=?,  " + 
                            "ji_13=?,  " + 
                            "jikwi_13=?,  " + 
                            "name_13=?,  " + 
                            "buim_tag_13=?,  " + 
                            "input_date_13=?,  " + 
                            "ji_14=?,  " + 
                            "jikwi_14=?,  " + 
                            "name_14=?,  " + 
                            "buim_tag_14=?,  " + 
                            "input_date_14=?,  " + 
                            "ji_15=?,  " + 
                            "jikwi_15=?,  " + 
                            "name_15=?,  " + 
                            "buim_tag_15=?,  " + 
                            "input_date_15=?,  " + 
                            "ji_16=?,  " + 
                            "jikwi_16=?,  " + 
                            "name_16=?,  " + 
                            "buim_tag_16=?,  " + 
                            "input_date_16=?,  " + 
                            "ji_17=?,  " + 
                            "jikwi_17=?,  " + 
                            "name_17=?,  " + 
                            "buim_tag_17=?,  " + 
                            "input_date_17=?,  " + 
                            "ji_18=?,  " + 
                            "jikwi_18=?,  " + 
                            "name_18=?,  " + 
                            "buim_tag_18=?,  " + 
                            "input_date_18=?,  " + 
                            "ji_19=?,  " + 
                            "jikwi_19=?,  " + 
                            "buim_tag_19=?,  " + 
                            "name_19=?,  " + 
                            "input_date_19=?,  " + 
                            "ji_20=?,  " + 
                            "jikwi_20=?,  " + 
                            "name_20=?,  " + 
                            "buim_tag_20=?,  " + 
                            "input_date_20=?,  " + 
                            "ji_21=?,  " + 
                            "jikwi_21=?,  " + 
                            "name_21=?,  " + 
                            "buim_tag_21=?,  " + 
                            "input_date_21=?,  " + 
                            "ji_22=?,  " + 
                            "jikwi_22=?,  " + 
                            "name_22=?,  " + 
                            "buim_tag_22=?,  " + 
                            "input_date_22=?,  " + 
                            "ji_23=?,  " + 
                            "jikwi_23=?,  " + 
                            "name_23=?,  " + 
                            "buim_tag_23=?,  " + 
                            "input_date_23=?,  " + 
                            "ji_24=?,  " + 
                            "jikwi_24=?,  " + 
                            "name_24=?,  " + 
                            "buim_tag_24=?,  " + 
                            "input_date_24=?,  " + 
                            "ji_25=?,  " + 
                            "jikwi_25=?,  " + 
                            "name_25=?,  " + 
                            "buim_tag_25=?,  " + 
                            "input_date_25=?,  " + 
                            "ji_26=?,  " + 
                            "jikwi_26=?,  " + 
                            "name_26=?,  " + 
                            "buim_tag_26=?,  " + 
                            "input_date_26=?,  " + 
                            "ji_27=?,  " + 
                            "jikwi_27=?,  " + 
                            "name_27=?,  " + 
                            "buim_tag_27=?,  " + 
                            "input_date_27=?,  " + 
                            "ji_28=?,  " + 
                            "jikwi_28=?,  " + 
                            "name_28=?,  " + 
                            "buim_tag_28=?,  " + 
                            "input_date_28=?,  " + 
                            "ji_29=?,  " + 
                            "jikwi_29=?,  " + 
                            "name_29=?,  " + 
                            "buim_tag_29=?,  " + 
                            "input_date_29=?,  " + 
                            "ji_30=?,  " + 
                            "jikwi_30=?,  " + 
                            "name_30=?,  " + 
                            "buim_tag_30=?,  " + 
                            "input_date_30=?,  " + 
                            "ji_31=?,  " + 
                            "jikwi_31=?,  " + 
                            "name_31=?,  " + 
                            "buim_tag_31=?,  " + 
                            "input_date_31=?,  " + 
                            "ji_32=?,  " + 
                            "jikwi_32=?,  " + 
                            "name_32=?,  " + 
                            "buim_tag_32=?,  " + 
                            "input_date_32=?,  " + 
                            "ji_33=?,  " + 
                            "jikwi_33=?,  " + 
                            "name_33=?,  " + 
                            "buim_tag_33=?,  " + 
                            "input_date_33=?,  " + 
                            "ji_34=?,  " + 
                            "jikwi_34=?,  " + 
                            "name_34=?,  " + 
                            "buim_tag_34=?,  " + 
                            "input_date_34=?,  " + 
                            "ji_35=?,  " + 
                            "jikwi_35=?,  " + 
                            "name_35=?,  " + 
                            "buim_tag_35=?,  " + 
                            "input_date_35=?,  " + 
                            "ji_36=?,  " + 
                            "jikwi_36=?,  " + 
                            "name_36=?,  " + 
                            "buim_tag_36=?,  " + 
                            "input_date_36=?,  " + 
                            "ji_37=?,  " + 
                            "jikwi_37=?,  " + 
                            "name_37=?,  " + 
                            "buim_tag_37=?,  " + 
                            "input_date_37=?,  " + 
                            "ji_38=?,  " + 
                            "jikwi_38=?,  " + 
                            "name_38=?,  " + 
                            "buim_tag_38=?,  " + 
                            "input_date_38=?,  " + 
                            "ji_39=?,  " + 
                            "jikwi_39=?,  " + 
                            "name_39=?,  " + 
                            "buim_tag_39=?,  " + 
                            "input_date_39=?,  " + 
                            "ji_40=?,  " + 
                            "jikwi_40=?,  " + 
                            "name_40=?,  " + 
                            "buim_tag_40=?,  " + 
                            "input_date_40=?  where dept_code=? and chg_no_seq=? ";  
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      gpstatement.bindColumn(3, idx_ji_1);
      gpstatement.bindColumn(4, idx_jikwi_1);
      gpstatement.bindColumn(5, idx_name_1);
      gpstatement.bindColumn(6, idx_buim_tag_1);
      gpstatement.bindColumn(7, idx_input_date_1);
      gpstatement.bindColumn(8, idx_ji_2);
      gpstatement.bindColumn(9, idx_jikwi_2);
      gpstatement.bindColumn(10, idx_name_2);
      gpstatement.bindColumn(11, idx_buim_tag_2);
      gpstatement.bindColumn(12, idx_input_date_2);
      gpstatement.bindColumn(13, idx_ji_3);
      gpstatement.bindColumn(14, idx_jikwi_3);
      gpstatement.bindColumn(15, idx_name_3);
      gpstatement.bindColumn(16, idx_buim_tag_3);
      gpstatement.bindColumn(17, idx_input_date_3);
      gpstatement.bindColumn(18, idx_ji_4);
      gpstatement.bindColumn(19, idx_jikwi_4);
      gpstatement.bindColumn(20, idx_name_4);
      gpstatement.bindColumn(21, idx_buim_tag_4);
      gpstatement.bindColumn(22, idx_input_date_4);
      gpstatement.bindColumn(23, idx_ji_5);
      gpstatement.bindColumn(24, idx_jikwi_5);
      gpstatement.bindColumn(25, idx_name_5);
      gpstatement.bindColumn(26, idx_buim_tag_5);
      gpstatement.bindColumn(27, idx_input_date_5);
      gpstatement.bindColumn(28, idx_ji_6);
      gpstatement.bindColumn(29, idx_jikwi_6);
      gpstatement.bindColumn(30, idx_name_6);
      gpstatement.bindColumn(31, idx_buim_tag_6);
      gpstatement.bindColumn(32, idx_input_date_6);
      gpstatement.bindColumn(33, idx_ji_7);
      gpstatement.bindColumn(34, idx_jikwi_7);
      gpstatement.bindColumn(35, idx_name_7);
      gpstatement.bindColumn(36, idx_buim_tag_7);
      gpstatement.bindColumn(37, idx_input_date_7);
      gpstatement.bindColumn(38, idx_ji_8);
      gpstatement.bindColumn(39, idx_jikwi_8);
      gpstatement.bindColumn(40, idx_name_8);
      gpstatement.bindColumn(41, idx_buim_tag_8);
      gpstatement.bindColumn(42, idx_input_date_8);
      gpstatement.bindColumn(43, idx_ji_9);
      gpstatement.bindColumn(44, idx_jikwi_9);
      gpstatement.bindColumn(45, idx_name_9);
      gpstatement.bindColumn(46, idx_buim_tag_9);
      gpstatement.bindColumn(47, idx_input_date_9);
      gpstatement.bindColumn(48, idx_ji_10);
      gpstatement.bindColumn(49, idx_jikwi_10);
      gpstatement.bindColumn(50, idx_name_10);
      gpstatement.bindColumn(51, idx_buim_tag_10);
      gpstatement.bindColumn(52, idx_input_date_10);
      gpstatement.bindColumn(53, idx_ji_11);
      gpstatement.bindColumn(54, idx_jikwi_11);
      gpstatement.bindColumn(55, idx_name_11);
      gpstatement.bindColumn(56, idx_buim_tag_11);
      gpstatement.bindColumn(57, idx_input_date_11);
      gpstatement.bindColumn(58, idx_ji_12);
      gpstatement.bindColumn(59, idx_jikwi_12);
      gpstatement.bindColumn(60, idx_name_12);
      gpstatement.bindColumn(61, idx_buim_tag_12);
      gpstatement.bindColumn(62, idx_input_date_12);
      gpstatement.bindColumn(63, idx_ji_13);
      gpstatement.bindColumn(64, idx_jikwi_13);
      gpstatement.bindColumn(65, idx_name_13);
      gpstatement.bindColumn(66, idx_buim_tag_13);
      gpstatement.bindColumn(67, idx_input_date_13);
      gpstatement.bindColumn(68, idx_ji_14);
      gpstatement.bindColumn(69, idx_jikwi_14);
      gpstatement.bindColumn(70, idx_name_14);
      gpstatement.bindColumn(71, idx_buim_tag_14);
      gpstatement.bindColumn(72, idx_input_date_14);
      gpstatement.bindColumn(73, idx_ji_15);
      gpstatement.bindColumn(74, idx_jikwi_15);
      gpstatement.bindColumn(75, idx_name_15);
      gpstatement.bindColumn(76, idx_buim_tag_15);
      gpstatement.bindColumn(77, idx_input_date_15);
      gpstatement.bindColumn(78, idx_ji_16);
      gpstatement.bindColumn(79, idx_jikwi_16);
      gpstatement.bindColumn(80, idx_name_16);
      gpstatement.bindColumn(81, idx_buim_tag_16);
      gpstatement.bindColumn(82, idx_input_date_16);
      gpstatement.bindColumn(83, idx_ji_17);
      gpstatement.bindColumn(84, idx_jikwi_17);
      gpstatement.bindColumn(85, idx_name_17);
      gpstatement.bindColumn(86, idx_buim_tag_17);
      gpstatement.bindColumn(87, idx_input_date_17);
      gpstatement.bindColumn(88, idx_ji_18);
      gpstatement.bindColumn(89, idx_jikwi_18);
      gpstatement.bindColumn(90, idx_name_18);
      gpstatement.bindColumn(91, idx_buim_tag_18);
      gpstatement.bindColumn(92, idx_input_date_18);
      gpstatement.bindColumn(93, idx_ji_19);
      gpstatement.bindColumn(94, idx_jikwi_19);
      gpstatement.bindColumn(95, idx_buim_tag_19);
      gpstatement.bindColumn(96, idx_name_19);
      gpstatement.bindColumn(97, idx_input_date_19);
      gpstatement.bindColumn(98, idx_ji_20);
      gpstatement.bindColumn(99, idx_jikwi_20);
      gpstatement.bindColumn(100, idx_name_20);
      gpstatement.bindColumn(101, idx_buim_tag_20);
      gpstatement.bindColumn(102, idx_input_date_20);
      gpstatement.bindColumn(103, idx_ji_21);
      gpstatement.bindColumn(104, idx_jikwi_21);
      gpstatement.bindColumn(105, idx_name_21);
      gpstatement.bindColumn(106, idx_buim_tag_21);
      gpstatement.bindColumn(107, idx_input_date_21);
      gpstatement.bindColumn(108, idx_ji_22);
      gpstatement.bindColumn(109, idx_jikwi_22);
      gpstatement.bindColumn(110, idx_name_22);
      gpstatement.bindColumn(111, idx_buim_tag_22);
      gpstatement.bindColumn(112, idx_input_date_22);
      gpstatement.bindColumn(113, idx_ji_23);
      gpstatement.bindColumn(114, idx_jikwi_23);
      gpstatement.bindColumn(115, idx_name_23);
      gpstatement.bindColumn(116, idx_buim_tag_23);
      gpstatement.bindColumn(117, idx_input_date_23);
      gpstatement.bindColumn(118, idx_ji_24);
      gpstatement.bindColumn(119, idx_jikwi_24);
      gpstatement.bindColumn(120, idx_name_24);
      gpstatement.bindColumn(121, idx_buim_tag_24);
      gpstatement.bindColumn(122, idx_input_date_24);
      gpstatement.bindColumn(123, idx_ji_25);
      gpstatement.bindColumn(124, idx_jikwi_25);
      gpstatement.bindColumn(125, idx_name_25);
      gpstatement.bindColumn(126, idx_buim_tag_25);
      gpstatement.bindColumn(127, idx_input_date_25);
      gpstatement.bindColumn(128, idx_ji_26);
      gpstatement.bindColumn(129, idx_jikwi_26);
      gpstatement.bindColumn(130, idx_name_26);
      gpstatement.bindColumn(131, idx_buim_tag_26);
      gpstatement.bindColumn(132, idx_input_date_26);
      gpstatement.bindColumn(133, idx_ji_27);
      gpstatement.bindColumn(134, idx_jikwi_27);
      gpstatement.bindColumn(135, idx_name_27);
      gpstatement.bindColumn(136, idx_buim_tag_27);
      gpstatement.bindColumn(137, idx_input_date_27);
      gpstatement.bindColumn(138, idx_ji_28);
      gpstatement.bindColumn(139, idx_jikwi_28);
      gpstatement.bindColumn(140, idx_name_28);
      gpstatement.bindColumn(141, idx_buim_tag_28);
      gpstatement.bindColumn(142, idx_input_date_28);
      gpstatement.bindColumn(143, idx_ji_29);
      gpstatement.bindColumn(144, idx_jikwi_29);
      gpstatement.bindColumn(145, idx_name_29);
      gpstatement.bindColumn(146, idx_buim_tag_29);
      gpstatement.bindColumn(147, idx_input_date_29);
      gpstatement.bindColumn(148, idx_ji_30);
      gpstatement.bindColumn(149, idx_jikwi_30);
      gpstatement.bindColumn(150, idx_name_30);
      gpstatement.bindColumn(151, idx_buim_tag_30);
      gpstatement.bindColumn(152, idx_input_date_30);
      gpstatement.bindColumn(153, idx_ji_31);
      gpstatement.bindColumn(154, idx_jikwi_31);
      gpstatement.bindColumn(155, idx_name_31);
      gpstatement.bindColumn(156, idx_buim_tag_31);
      gpstatement.bindColumn(157, idx_input_date_31);
      gpstatement.bindColumn(158, idx_ji_32);
      gpstatement.bindColumn(159, idx_jikwi_32);
      gpstatement.bindColumn(160, idx_name_32);
      gpstatement.bindColumn(161, idx_buim_tag_32);
      gpstatement.bindColumn(162, idx_input_date_32);
      gpstatement.bindColumn(163, idx_ji_33);
      gpstatement.bindColumn(164, idx_jikwi_33);
      gpstatement.bindColumn(165, idx_name_33);
      gpstatement.bindColumn(166, idx_buim_tag_33);
      gpstatement.bindColumn(167, idx_input_date_33);
      gpstatement.bindColumn(168, idx_ji_34);
      gpstatement.bindColumn(169, idx_jikwi_34);
      gpstatement.bindColumn(170, idx_name_34);
      gpstatement.bindColumn(171, idx_buim_tag_34);
      gpstatement.bindColumn(172, idx_input_date_34);
      gpstatement.bindColumn(173, idx_ji_35);
      gpstatement.bindColumn(174, idx_jikwi_35);
      gpstatement.bindColumn(175, idx_name_35);
      gpstatement.bindColumn(176, idx_buim_tag_35);
      gpstatement.bindColumn(177, idx_input_date_35);
      gpstatement.bindColumn(178, idx_ji_36);
      gpstatement.bindColumn(179, idx_jikwi_36);
      gpstatement.bindColumn(180, idx_name_36);
      gpstatement.bindColumn(181, idx_buim_tag_36);
      gpstatement.bindColumn(182, idx_input_date_36);
      gpstatement.bindColumn(183, idx_ji_37);
      gpstatement.bindColumn(184, idx_jikwi_37);
      gpstatement.bindColumn(185, idx_name_37);
      gpstatement.bindColumn(186, idx_buim_tag_37);
      gpstatement.bindColumn(187, idx_input_date_37);
      gpstatement.bindColumn(188, idx_ji_38);
      gpstatement.bindColumn(189, idx_jikwi_38);
      gpstatement.bindColumn(190, idx_name_38);
      gpstatement.bindColumn(191, idx_buim_tag_38);
      gpstatement.bindColumn(192, idx_input_date_38);
      gpstatement.bindColumn(193, idx_ji_39);
      gpstatement.bindColumn(194, idx_jikwi_39);
      gpstatement.bindColumn(195, idx_name_39);
      gpstatement.bindColumn(196, idx_buim_tag_39);
      gpstatement.bindColumn(197, idx_input_date_39);
      gpstatement.bindColumn(198, idx_ji_40);
      gpstatement.bindColumn(199, idx_jikwi_40);
      gpstatement.bindColumn(200, idx_name_40);
      gpstatement.bindColumn(201, idx_buim_tag_40);
      gpstatement.bindColumn(202, idx_input_date_40);
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(203, idx_dept_code);
      gpstatement.bindColumn(204, idx_chg_no_seq);
      stmt.executeUpdate();
      stmt.close();
   }else if(rows.getJobType() ==  GauceDataRow.TB_JOB_DELETE){
 /* 다음 문장은 반드시 수정하시요 (where 아래의 변수 갯수만큼 */ 
      String sSql = "delete from c_structure where dept_code=? and chg_no_seq=?"; 
      stmt = conn.prepareStatement(sSql); 
      gpstatement.gp_stmt = stmt;
 /* 다음 문장은 반드시 수정하시요(변수갯수 만큼) */ 
      gpstatement.bindColumn(1, idx_dept_code);
      gpstatement.bindColumn(2, idx_chg_no_seq);
      stmt.executeUpdate();
      stmt.close();
    }
     }
 %><%@ include file="../../../comm_function/conn_tr_end.jsp"%>