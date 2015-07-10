<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
	 String arg_sell_code = req.getParameter("arg_sell_code");
	 String arg_dongho     = req.getParameter("arg_dongho");
	 String arg_seq            = req.getParameter("arg_seq");
	 String arg_pyong        = req.getParameter("arg_pyong");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("dept_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("pyong",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("opt_name",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("opt_base",GauceDataColumn.TB_STRING,2));
     dSet.addDataColumn(new GauceDataColumn("opt_finish",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("opt_ref",GauceDataColumn.TB_STRING,2));
	 dSet.addDataColumn(new GauceDataColumn("amt_norm",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("amt_norm_vat",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("amt_prem",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("amt_prem_vat",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("vat",GauceDataColumn.TB_DECIMAL,13,0));
	 dSet.addDataColumn(new GauceDataColumn("norm_prem_tag",GauceDataColumn.TB_STRING,4));
     dSet.addDataColumn(new GauceDataColumn("note",GauceDataColumn.TB_STRING,50));
	 dSet.addDataColumn(new GauceDataColumn("selected",GauceDataColumn.TB_STRING,1));
	 
    String query = "select b.dept_code dept_code,  "+
	"        b.pyong pyong," + 
     "		 b.opt_name opt_name," + 
     "		 b.opt_base opt_base," + 
     "		 b.opt_finish opt_finish," + 
     "		 b.opt_ref opt_ref," + 
     "		 b.amt_norm amt_norm," + 
     "		 b.amt_norm_vat amt_norm_vat," + 
     "		 b.amt_prem amt_prem," + 
     "		 b.amt_prem_vat amt_prem_vat," + 
	 "       0 amt, "+
     "       0 vat, "+
	  "		 decode(s.norm_prem_tag, null, '01', s.norm_prem_tag) norm_prem_tag," + 
     "		 b.note note," + 
     "		 decode(s.dept_code, null, 'F', 'T') selected" + 
     "  from h_base_ontime_item b," + 
     "       h_sale_ontime_master s" + 
     " where b.dept_code = '"+arg_dept_code+"'"+ 
     "   and b.pyong     = '"+arg_pyong+"'"+ 
     "	and b.dept_code = s.dept_code(+)" + 
     "	and b.pyong     = s.pyong(+)" + 
     "	and b.opt_name  = s.opt_name(+)" + 
     "	and b.opt_base  = s.opt_base(+)" + 
     "	and b.opt_finish= s.opt_finish(+)" + 
     "	and b.opt_ref   = s.opt_ref(+)" + 
     "	and s.sell_code(+) = '"+arg_sell_code  +"'"+ 
     "	and s.dongho(+)    = '" +arg_dongho+"'"+ 
     "   and s.seq(+)       = '"+arg_seq+"'" +
	 " order by b.opt_name, b.opt_base, b.opt_finish, b.opt_ref" ;
%><%@ include file="../../../comm_function/conn_q_end.jsp"%>