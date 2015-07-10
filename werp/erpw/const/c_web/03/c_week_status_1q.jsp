<%@ page session="true" import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@
 include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_where = req.getParameter("arg_where");
     arg_where = arg_where.replace('!','+'); 
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("week_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("master_confirm",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("a_this",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("a_next",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("c_this",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("c_next",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("l_this",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("l_next",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("e_this",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("e_next",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("m_this",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("m_next",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("t_this",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("t_next",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("main_this",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("main_next",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("problem_this",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("problem_next",GauceDataColumn.TB_STRING,2000));
     dSet.addDataColumn(new GauceDataColumn("photo_addr",GauceDataColumn.TB_STRING,250));
     dSet.addDataColumn(new GauceDataColumn("ground_area",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("gross_floor_area_sum",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("floor",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("chg_const_start_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_end_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("chg_const_term",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("cdir",GauceDataColumn.TB_URL,255));
     dSet.addDataColumn(new GauceDataColumn("photo_name",GauceDataColumn.TB_STRING,250));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,100));
    String query = "  SELECT  b.dept_code ," + 
     "          to_char(a.week_date,'yyyy.mm.dd') week_date ," + 
     "          nvl(a.master_confirm,'X') master_confirm," + 
     "          a.a_this ," + 
     "          a.a_next ," + 
     "          a.c_this ," + 
     "          a.c_next ," + 
     "          a.l_this ," + 
     "          a.l_next ," + 
     "          a.e_this ," + 
     "          a.e_next ," + 
     "          a.m_this ," + 
     "          a.m_next ," + 
     "          a.t_this ," + 
     "          a.t_next ," + 
     "          a.main_this ," + 
     "          a.main_next ," + 
     "          a.problem_this ," + 
     "          a.problem_next ," + 
     "          a.photo_addr,    " + 
     "          b.ground_area,    " + 
     "          b.gross_floor_area_sum,    " + 
     "          b.floor,    " + 
     "         to_char(b.CONST_START_DATE,'YYYY.MM.DD')  const_start_date,   " + 
     "         to_char(b.CONST_END_DATE,'YYYY.MM.DD')    const_end_date,   " + 
     "         nvl(b.CONST_TERM,0) const_term,  " + 
     "         to_char(b.CHG_CONST_START_DATE,'YYYY.MM.DD') chg_const_start_date,   " + 
     "         to_char(b.CHG_CONST_END_DATE,'YYYY.MM.DD')   chg_const_end_date,   " + 
     "         nvl(B.CHG_CONST_TERM,0) chg_const_term,  " + 
     "         a.photo_addr cdir,  " + 
     "         a.photo_addr photo_name,  " + 
     "         b.long_name " + 
     "       FROM c_week_status a, " + 
     "           z_code_dept b " + 
     "      WHERE    " + 
     "  " + arg_where + " ";
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>