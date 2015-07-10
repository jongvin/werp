<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("comp_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("short_name",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("english_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("dept_seq_key",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dept_level_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("high_dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("dept_proj_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("use_tag",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("home_foreign_tag",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("region_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("process_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("zipcode",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("proj_addr1",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_addr2",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_tel",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("main_pos",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("main_charge",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("proj_pos",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("proj_charge",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("contract_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_contract_date1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("last_degree",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("receive_code",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("owner",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("designer",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("supervisor",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("const_class",GauceDataColumn.TB_STRING,150));
     dSet.addDataColumn(new GauceDataColumn("constkind_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("const_tag",GauceDataColumn.TB_STRING,3));
     dSet.addDataColumn(new GauceDataColumn("const_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("tax_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("free_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("cnt_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_amt1",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("exe_rate1",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("work_rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("guarantee_fault1",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("guarantee_fault2",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("area_pyung",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ground_area",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("build_area",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("gross_floor_area_sum",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("remark",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("floor",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("py_cnt",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("tot_cnt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("dong_cnt",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("region_code",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("area_pyung_m",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ground_area_m",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("build_area_m",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("gross_floor_area_sum_m",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ground_floor_area",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("ground_floor_area_m",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("building_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("volunetric_ratio",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("building_use",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("complete_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("vattag",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("test_exeamt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("goal_const_st",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("goal_const_ed",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("goal_const_term",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("class_tag",GauceDataColumn.TB_DECIMAL,18,0));
	 dSet.addDataColumn(new GauceDataColumn("delay_rate",GauceDataColumn.TB_DECIMAL,5,2));
    String query = "  SELECT a.DEPT_CODE,   " + 
     "         a.COMP_CODE,   " + 
     "         a.LONG_NAME,   " + 
     "         a.SHORT_NAME,   " + 
     "         a.ENGLISH_NAME,   " + 
     "         a.DEPT_SEQ_KEY,   " + 
     "         a.DEPT_LEVEL_CODE,   " + 
     "         a.HIGH_DEPT_CODE,   " + 
     "         a.DEPT_PROJ_TAG,   " + 
     "         a.USE_TAG,   " + 
     "         a.HOME_FOREIGN_TAG,   " + 
     "         b.name   region_name, " +
     "         a.PROJ_NAME,   " + 
     "         a.PROCESS_CODE,   " + 
     "         a.ZIPCODE,   " + 
     "         a.PROJ_ADDR1,   " + 
     "         a.PROJ_ADDR2,   " + 
     "         a.PROJ_TEL,   " + 
     "         a.MAIN_POS,   " + 
     "         a.MAIN_CHARGE,   " + 
     "         a.PROJ_POS,   " + 
     "         a.PROJ_CHARGE,   " + 
     "         to_char(a.CONTRACT_DATE,'YYYY.MM.DD')   CONTRACT_DATE," + 
     "         to_char(a.CHG_CONTRACT_DATE1,'YYYY.MM.DD') CHG_CONTRACT_DATE1,   " + 
     "         nvl(a.LAST_DEGREE,0)  LAST_DEGREE, " + 
     "         a.RECEIVE_CODE,   " + 
     "         a.OWNER,   " + 
     "         a.DESIGNER,   " + 
     "         a.SUPERVISOR,   " + 
     "         a.CONST_CLASS,   " + 
     "         a.CONSTKIND_TAG,   " + 
     "         a.CONST_TAG,   " + 
     "         nvl(a.CONST_RATE,0)  CONST_RATE,  " + 
     "         nvl(a.TAX_RATE,0)  TAX_RATE, " + 
     "         nvl(a.FREE_RATE,0)  FREE_RATE, " + 
     "         nvl(a.CNT_AMT1,0)   CNT_AMT1," + 
     "         nvl(a.EXE_AMT1,0)   EXE_AMT1," + 
     "         nvl(a.EXE_RATE1,0)  EXE_RATE1, " + 
     "         nvl(a.WORK_RATE,0)  WORK_RATE, " + 
     "         to_char(a.CONST_START_DATE,'YYYY.MM.DD')  CONST_START_DATE,   " + 
     "         to_char(a.CONST_END_DATE,'YYYY.MM.DD')    CONST_END_DATE,   " + 
     "         nvl(a.CONST_TERM,0) CONST_TERM,  " + 
     "         to_char(a.CHG_CONST_START_DATE,'YYYY.MM.DD') CHG_CONST_START_DATE,   " + 
     "         to_char(a.CHG_CONST_END_DATE,'YYYY.MM.DD')   CHG_CONST_END_DATE,   " + 
     "         nvl(a.CHG_CONST_TERM,0) CHG_CONST_TERM,  " + 
     "         to_char(a.GUARANTEE_FAULT1,'YYYY.MM.DD')  GUARANTEE_FAULT1, " + 
     "         to_char(a.GUARANTEE_FAULT2,'YYYY.MM.DD')  GUARANTEE_FAULT2,   " + 
     "         nvl(a.AREA_PYUNG,0) AREA_PYUNG,  " + 
     "         nvl(a.GROUND_AREA,0) GROUND_AREA,  " + 
     "         nvl(a.BUILD_AREA,0)  BUILD_AREA, " + 
     "         nvl(a.GROSS_FLOOR_AREA_SUM,0) GROSS_FLOOR_AREA_SUM,  " + 
     "         a.REMARK,  " + 
     "         a.floor, " +
     "         a.py_cnt, " +
     "         a.tot_cnt, " +
     "         a.dong_cnt, " +
     "         a.region_code,  " +
     "         nvl(a.area_pyung_m,0) area_pyung_m,  " + 
     "         nvl(a.ground_area_m,0) ground_area_m,  " + 
     "         nvl(a.build_area_m,0) build_area_m,  " + 
     "         nvl(a.gross_floor_area_sum_m,0) gross_floor_area_sum_m,  " + 
     "         nvl(a.ground_floor_area,0) ground_floor_area,  " + 
     "         nvl(a.ground_floor_area_m,0) ground_floor_area_m,  " + 
     "         nvl(a.building_ratio,0)  building_ratio, " + 
     "         nvl(a.volunetric_ratio,0)  volunetric_ratio, " + 
     "         a.building_use,  " + 
     "         to_char(a.complete_date,'YYYY.MM.DD')   complete_date," + 
     "         a.vattag, " +
     "         nvl(a.test_exeamt,0)   test_exeamt," + 
     "         to_char(a.goal_const_st,'YYYY.MM.DD') goal_const_st,   " + 
     "         to_char(a.goal_const_ed,'YYYY.MM.DD')   goal_const_ed,   " + 
     "         nvl(a.goal_const_term,0) goal_const_term,  " + 
     "         a.class_tag, " +
	 "         a.delay_rate " +
     "    FROM Z_CODE_DEPT a , " + 
     "         Y_REGION_CODE b " +
     "   WHERE a.region_code = b.region_code (+) and " +
     "         a.DEPT_CODE = " + "'" + arg_dept_code  + "'";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>