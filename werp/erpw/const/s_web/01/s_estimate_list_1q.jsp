<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_order_number = req.getParameter("arg_order_number");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("recommender_department",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("recommender_grade",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("recommender_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("pr_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("est_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("register_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("noentry_chk",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("noentry_recommen",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("noentry_merit",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("noentry_defect",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("noentry_recommender_note",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("noentry_note",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("noentry_yn_note",GauceDataColumn.TB_STRING,200));
     dSet.addDataColumn(new GauceDataColumn("est_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("select_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("charge_name",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("cn_limit_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,100));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("tel_number1",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("email",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("re_est_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("est_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("re_est_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("injung_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("recommender_reson",GauceDataColumn.TB_STRING,200));
    String query = "  SELECT a.dept_code dept_code,   " + 
     "         a.order_number order_number,   " + 
     "         a.sbcr_code sbcr_code,   " + 
     "         a.recommender_department recommender_department,   " + 
     "         a.recommender_grade recommender_grade,   " + 
     "         a.recommender_name recommender_name,   " + 
     "         decode(a.pr_yn,'Y','T','F') pr_yn,   " + 
     "         decode(a.est_yn,'Y','T','F') est_yn,   " + 
     "         a.register_chk register_chk," + 
     "         a.noentry_chk noentry_chk," + 
     "         a.noentry_recommen noentry_recommen,   " + 
     "         a.noentry_merit noentry_merit,   " + 
     "         a.noentry_defect noentry_defect,   " + 
     "         a.noentry_recommender_note noentry_recommender_note,   " + 
     "         a.noentry_note noentry_note,   " + 
     "         a.noentry_yn_note noentry_yn_note,   " + 
     "         a.est_amt est_amt,   " + 
     "         a.ctrl_amt ctrl_amt,   " + 
     "         decode(a.select_yn,'Y','T','F') select_yn,   " + 
     "         a.charge_name charge_name,   " + 
     "         a.profession_wbs_code profession_wbs_code,   " + 
     "         a.cn_limit_amt cn_limit_amt,   " + 
     "         a.note note," + 
     "         b.sbcr_name sbcr_name," + 
     "         b.rep_name1 rep_name1," + 
     "         b.tel_number1 tel_number1," + 
     "         b.rep_email email," + 
     "         c.profession_wbs_name profession_wbs_name, " + 
     "         a.re_est_yn, to_char(a.est_dt,'YYYY.MM.DD') est_dt, to_char(a.re_est_dt,'YYYY.MM.DD') re_est_dt, " +
     "         a.injung_yn, d.recommender_reson " +
     "    FROM s_estimate_list  a," + 
     "         s_sbcr b," + 
     "         s_profession_wbs c," + 
     "         s_wbs_request d " +
     "   WHERE ( a.sbcr_code = d.sbcr_code ) AND " +
     "         ( a.profession_wbs_code = d.profession_wbs_code ) AND " +
     "         ( a.profession_wbs_code = c.profession_wbs_code ) AND" + 
     "         ( a.sbcr_code           = b.sbcr_code ) AND" + 
     "         ( a.dept_code = " + "'" + arg_dept_code + "'" + " ) AND  " + 
     "         ( a.order_number = " + arg_order_number + " )   " + 
     " ORDER BY dept_code ASC,   " + 
     "         order_number ASC,   " + 
     "         sbcr_code ASC        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>