<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_text = req.getParameter("arg_text");
     String arg_gong_code = req.getParameter("arg_gong_code");
     String arg_tag = req.getParameter("arg_tag");
     String arg_class = req.getParameter("arg_class");
     arg_dept_code = '%' + arg_dept_code + '%';
     arg_gong_code = '%' + arg_gong_code + '%';
     arg_tag = '%' + arg_tag + '%';
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("approve_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("check_date",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("request_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("approve_dt",GauceDataColumn.TB_STRING,18));
     dSet.addDataColumn(new GauceDataColumn("order_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbcr_code",GauceDataColumn.TB_STRING,8));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,60));
     dSet.addDataColumn(new GauceDataColumn("ctrl_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("order_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("ebid_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("buy_rt",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("estimate_dt",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("open_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("open_dt",GauceDataColumn.TB_STRING,19));
     dSet.addDataColumn(new GauceDataColumn("open_per",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("vat_class",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("bef_order_number",GauceDataColumn.TB_DECIMAL,5,0));
     dSet.addDataColumn(new GauceDataColumn("re_est_cnt",GauceDataColumn.TB_DECIMAL,3,0));
     dSet.addDataColumn(new GauceDataColumn("temp_number",GauceDataColumn.TB_STRING,20));
     dSet.addDataColumn(new GauceDataColumn("cancel_yn",GauceDataColumn.TB_STRING,1));
     dSet.addDataColumn(new GauceDataColumn("long_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,1000));
    String query = "  SELECT a.dept_code,   " + 
     "         a.order_number,   " + 
     "         a.profession_wbs_code profession_wbs_code,   " + 
     "         b.profession_wbs_name profession_wbs_name," + 
     "         a.approve_class,   " + 
     "         to_char(a.check_date,'yyyy.mm.dd') check_date,   " + 
     "         to_char(a.request_dt,'yyyy.mm.dd') request_dt,   " + 
     "         to_char(a.approve_dt,'yyyy.mm.dd') approve_dt,   " + 
     "         a.order_name,   " + 
     "         a.sbcr_code,   " + 
     "         c.sbcr_name," + 
     "         NVL(d.ctrl_amt,0) ctrl_amt, " + 
     "         a.order_class, " + 
     "         a.ebid_yn, " +
     "         a.buy_rt, " +
     "         to_char(a.estimate_dt,'yyyy.mm.dd hh24:mi') estimate_dt ," +
     "         a.open_yn,to_char(a.open_dt,'yyyy.mm.dd hh24:mi:ss') open_dt, a.open_per ,a.vat_class," +
     "         a.bef_order_number," +
     "         a.re_est_cnt," +
     "         a.bef_order_number || '-' || a.re_est_cnt temp_number , " +
     "         a.cancel_yn, " +
     "         e.long_name, " +
     "         a.note " +
     "    FROM s_order_list a," + 
     "         s_profession_wbs b," + 
     "         s_sbcr c," + 
     "         s_estimate_list d," + 
     "         Z_CODE_DEPT e " +
     "   WHERE a.dept_code      = e.dept_code " +
     "     AND a.sbcr_code      = c.sbcr_code (+)" + 
     "     AND a.dept_code      = d.dept_code (+)" + 
     "     AND a.order_number   = d.order_number (+)" + 
     "     AND a.sbcr_code      = d.sbcr_code (+)" + 
     "     AND a.profession_wbs_code = b.profession_wbs_code " + 
     "     AND e.long_name like '" + arg_dept_code + "'  " + 
     "     AND a.profession_wbs_code like '" + arg_gong_code + "'  " + 
     "     AND ( a.approve_class =  '4'  " + 
     "       OR   a.approve_class = '5' )" + 
     "     AND a.dept_proj_tag = '" + arg_class + "'" +
     "     AND a.open_yn like '" + arg_tag + "'" +
      "     and " + arg_text + 
    "   ORDER BY a.estimate_dt desc,e.long_name asc,a.bef_order_number desc,a.re_est_cnt desc        ";
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>