<%@ page session="true"  import="com.gauce.*,com.gauce.io.*,com.gauce.common.*,com.gauce.log.*,com.gauce.db.*,java.sql.*"%><%@ 
include file="../../../comm_function/conn_q_pool.jsp"%><%
 // 다음 문장은 수정 하시요 (파라메터 갯수만큼 (없으면 //로 막으세요)--r
     String arg_dept_code = req.getParameter("arg_dept_code");
     String arg_yymm = req.getParameter("arg_yymm");
 //---------------------------------------------------------- 
     dSet.addDataColumn(new GauceDataColumn("wbs_code",GauceDataColumn.TB_STRING,7));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_code",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("profession_wbs_name",GauceDataColumn.TB_STRING,50));
     dSet.addDataColumn(new GauceDataColumn("order_number",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbcr_name",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("rep_name1",GauceDataColumn.TB_STRING,10));
     dSet.addDataColumn(new GauceDataColumn("exe_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sub_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("sbc_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tot_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("rate",GauceDataColumn.TB_DECIMAL,18,2));
     dSet.addDataColumn(new GauceDataColumn("mod_amt",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("tm_prgs",GauceDataColumn.TB_DECIMAL,18,0));
     dSet.addDataColumn(new GauceDataColumn("text",GauceDataColumn.TB_STRING,40));
     dSet.addDataColumn(new GauceDataColumn("sbc_name",GauceDataColumn.TB_STRING,40));
    String query = " select substr(b.profession_wbs_code,1,1) wbs_code,                          						" +	
			"						 b.profession_wbs_code,                                                       " +
			"						 c.profession_wbs_name,                                                       " +
			"						 a.order_number,                                                              " +
			"						 d.SBCR_name,                                                                 " +
			"						 d.rep_name1,                                                                 " +
			"						 e.exe_amt,                                                                   " +
			"						 f.sub_amt amt,                                                               " +
			"						 e.sub_amt sub_amt,                                                               " +
			"						 nvl(a.sbc_amt, 0) - nvl(a.vat,0) sbc_amt,                                                           " +
			"						 g.tot_prgs,                                                                  " +
			"						 decode(e.sub_amt,0,0,((g.tot_prgs)/e.sub_amt)*100) rate,                     " +
			"						 nvl(e.sub_amt,0) - nvl(g.tot_prgs,0) mod_amt,                                " +
			"						 h.tm_prgs,                                                                  " +
			"						 ' ' text,                                                                    " +
         "                  a.sbc_name " + 
			"			from s_cn_list a,                                                                      " +
			"			     s_order_list b,                                                                   " +
			"				  s_profession_wbs c,                                                               " +
			"				  s_sbcr d,                                                                         " +
			"				  s_cn_parent e,                                                                    " +
			"				  s_order_parent f,                                                                 " +
			"				  (select a.dept_code, a.order_number, 															" +		
			"                 a.pre_prgs+a.pre_prgs_notax+pre_purchase_vat +a.tm_prgs+a.tm_prgs_notax+tm_purchase_vat tot_prgs         " +
			"					  from s_pay a,                                                                  " +
			"					  (select max(a.dept_code) dept_code,                                            " +
			"								 max(a.order_number) order_number,                                      " +
			"								 max(a.yymm) yymm,                                                      " +
			"							    max(a.seq) seq                                                         " +
			"							from s_pay a                                                               " +
			"							where a.dept_code 	 = '" + arg_dept_code + "'                            " +
			"							  and a.yymm          <= '" + arg_yymm + "'                                " +
			"							group by a.order_number ) b                                                " +
			"						where a.dept_code = b.dept_code                                               " +
			"						  and a.order_number = b.order_number                                         " +
			"						  and a.yymm         = b.yymm                                                 " +
			"						  and a.seq				= b.seq ) g,                                             " +
			"				  ( select dept_code, order_number, 																" +
			"				  			sum(nvl(tm_prgs,0)+nvl(tm_prgs_notax,0)+nvl(tm_purchase_vat,0)) tm_prgs    " +
			"						from s_pay                                                                    " +
			"					 where dept_code = '" + arg_dept_code + "'                                       " +
			"						and yymm = '" + arg_yymm + "'                                                 " +
			"					 group by dept_code, order_number ) h                                            " +
			"			where a.dept_code 	 = b.dept_code(+)                                                 " +
			"			and	a.order_number  = b.order_number(+)                                              " +
			"			and   b.profession_wbs_code = c.profession_wbs_code                                    " +
			"			and	a.sbcr_code				 = d.sbcr_code(+)                                           " +
			"			and	a.dept_code				 = e.dept_code(+)                                           " +
			"			and	a.ORDER_NUMBER			 = e.order_number(+)                                        " +
			"			and	e.llevel = 1                                                                     " +
			"			and	a.dept_code				 = f.dept_code(+)                                           " +
			"			and	a.ORDER_NUMBER			 = f.order_number(+)                                        " +
			"			and	f.llevel = 1                                                                     " +
			"			and	a.dept_code				 = g.dept_code(+)                                           " +
			"			and	a.ORDER_NUMBER			 = g.order_number(+)                                        " +
			"			and	a.dept_code				 = h.dept_code(+)                                           " +
			"			and	a.ORDER_NUMBER			 = h.order_number(+)                                        " +
			"			and   a.dept_code   			 = '" + arg_dept_code + "'                                  " +
			"			order by substr(b.profession_wbs_code,1,1), b.profession_wbs_code                      " ;
%><%@ 
include file="../../../comm_function/conn_q_end.jsp"%>